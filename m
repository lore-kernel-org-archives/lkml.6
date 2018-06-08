Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id hPYkDPGIGlupDgAAmS7hNA
	; Fri, 08 Jun 2018 13:47:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 08734607E4; Fri,  8 Jun 2018 13:47:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 5DB4B602FC;
	Fri,  8 Jun 2018 13:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5DB4B602FC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeFHNrh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 09:47:37 -0400
Received: from www62.your-server.de ([213.133.104.62]:60817 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751524AbeFHNrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 09:47:35 -0400
Received: from [178.197.248.12] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fRHjp-0003Um-AO; Fri, 08 Jun 2018 15:47:33 +0200
Subject: Re: WARNING in do_dentry_open
To: Dmitry Vyukov <dvyukov@google.com>,
        syzbot <syzbot+2e7fcab0f56fdbb330b8@syzkaller.appspotmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        netdev <netdev@vger.kernel.org>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>
References: <000000000000bd54dd056e212189@google.com>
 <CACT4Y+b+6XrNfHmZSBitOKqVHYaq-aOgMDnHhp3vKEVs117iJA@mail.gmail.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <92b8621b-cf57-5fe9-23d1-e06b83ee0c78@iogearbox.net>
Date: Fri, 8 Jun 2018 15:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <CACT4Y+b+6XrNfHmZSBitOKqVHYaq-aOgMDnHhp3vKEVs117iJA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24643/Fri Jun  8 06:37:57 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/08/2018 03:34 PM, Dmitry Vyukov wrote:
> On Fri, Jun 8, 2018 at 3:11 PM, syzbot
> <syzbot+2e7fcab0f56fdbb330b8@syzkaller.appspotmail.com> wrote:
>> Hello,
>>
>> syzbot found the following crash on:
>>
>> HEAD commit:    68abbe729567 Merge branch 'akpm' (patches from Andrew)
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=130146af800000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e5a4673d4582131c
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2e7fcab0f56fdbb330b8
>> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
>> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=1591756f800000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=152236af800000
> 
> Looking at the reproducer this seems to be related to bpf.
> +bpf maintainers

Indeed, thanks! Already working on a fix right now.
