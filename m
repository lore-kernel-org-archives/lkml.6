Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id J95LKJFPHlspRwAAmS7hNA
	; Mon, 11 Jun 2018 10:31:45 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 9791D607BB; Mon, 11 Jun 2018 10:31:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0E83B60385;
	Mon, 11 Jun 2018 10:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E83B60385
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932802AbeFKKbm (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 06:31:42 -0400
Received: from www62.your-server.de ([213.133.104.62]:55252 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932526AbeFKKbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 06:31:41 -0400
Received: from [188.63.75.139] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fSK6r-0005j8-Gx; Mon, 11 Jun 2018 12:31:37 +0200
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_skb_change_proto
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+d2d729bdde65dee3eae6@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        LKML <linux-kernel@vger.kernel.org>,
        netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
References: <000000000000c64842056e4b4326@google.com>
 <76483220-226b-bf3c-d529-ea839d6624c6@iogearbox.net>
 <CACT4Y+boO990R6a9kGtx-UZpZPeB2bwhgvyUjPvEFOpbzxJKrg@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <170ef50b-6895-d7fa-a9ae-80915741971b@iogearbox.net>
Date: Mon, 11 Jun 2018 12:31:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+boO990R6a9kGtx-UZpZPeB2bwhgvyUjPvEFOpbzxJKrg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24652/Mon Jun 11 06:34:15 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/11/2018 11:52 AM, Dmitry Vyukov wrote:
> On Mon, Jun 11, 2018 at 11:42 AM, Daniel Borkmann <daniel@iogearbox.net> wrote:
>> On 06/10/2018 05:27 PM, syzbot wrote:
>>> Hello,
>>>
>>> syzbot found the following crash on:
>>>
>>> HEAD commit:    a16afaf7928b Merge tag 'for-v4.18' of git://git.kernel.org..
>>> git tree:       upstream
>>> console output: https://syzkaller.appspot.com/x/log.txt?x=1338f6bf800000
>>> kernel config:  https://syzkaller.appspot.com/x/.config?x=314f2150f36c16ca
>>> dashboard link: https://syzkaller.appspot.com/bug?extid=d2d729bdde65dee3eae6
>>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1173381f800000
>>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171f90cf800000
>>>
>>> IMPORTANT: if you fix the bug, please add the following tag to the commit:
>>> Reported-by: syzbot+d2d729bdde65dee3eae6@syzkaller.appspotmail.com
>>
>> #syz fix: bpf: reject passing modified ctx to helper functions
> 
> On a related note, it seems that it still can unwind past
> bpf_skb_change_proto. I think the "net.core.bpf_jit_kallsyms = 1"
> sysctl should have been reached syzbot by the time of crash. Are you
> sure that's the only thing requires? We are using frame pointer
> unwinder just in case.

Nah, I know what happened; just sent a PR fix for syzkaller.

Thanks,
Daniel
