Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id CVoFFjlSGluKFQAAmS7hNA
	; Fri, 08 Jun 2018 09:54:01 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 49952607A4; Fri,  8 Jun 2018 09:54:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D90D960275;
	Fri,  8 Jun 2018 09:54:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D90D960275
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752985AbeFHJx6 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:53:58 -0400
Received: from www62.your-server.de ([213.133.104.62]:39453 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751523AbeFHJx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:53:57 -0400
Received: from [178.197.248.12] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fRE5i-0008Uz-BD; Fri, 08 Jun 2018 11:53:54 +0200
Subject: Re: KASAN: slab-out-of-bounds Read in bpf_csum_update
To: syzbot <syzbot+efae31b384d5badbd620@syzkaller.appspotmail.com>,
        ast@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000b2a7ea056dc54779@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <3b5752b9-8a84-f053-93db-49ddcf4f02e7@iogearbox.net>
Date: Fri, 8 Jun 2018 11:53:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000b2a7ea056dc54779@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.99.3/24643/Fri Jun  8 06:37:57 2018)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2018 01:36 AM, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    0512e0134582 Merge tag 'xfs-4.17-fixes-3' of git://git.ker..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17eb2d7b800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
> dashboard link: https://syzkaller.appspot.com/bug?extid=efae31b384d5badbd620
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=162c6def800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fe3db7800000

#syz fix: bpf: reject passing modified ctx to helper functions
