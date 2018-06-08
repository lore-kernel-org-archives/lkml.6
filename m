Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id Y0/IMsVRGluDEgAAmS7hNA
	; Fri, 08 Jun 2018 09:54:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 565226089E; Fri,  8 Jun 2018 09:54:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 714E2605A5;
	Fri,  8 Jun 2018 09:54:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 714E2605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=iogearbox.net
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753026AbeFHJyU (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 05:54:20 -0400
Received: from www62.your-server.de ([213.133.104.62]:39495 "EHLO
        www62.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752152AbeFHJyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 05:54:18 -0400
Received: from [178.197.248.12] (helo=linux.home)
        by www62.your-server.de with esmtpsa (TLSv1.2:DHE-RSA-AES256-SHA:256)
        (Exim 4.85_2)
        (envelope-from <daniel@iogearbox.net>)
        id 1fRE64-0008WE-5p; Fri, 08 Jun 2018 11:54:16 +0200
Subject: Re: KASAN: slab-out-of-bounds Read in skb_ensure_writable
To: syzbot <syzbot+e5190cb881d8660fb1a3@syzkaller.appspotmail.com>,
        ast@kernel.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000b7be6e056dc547e8@google.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <47029528-5c56-61a4-9d86-33f1e7ad14d4@iogearbox.net>
Date: Fri, 8 Jun 2018 11:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <000000000000b7be6e056dc547e8@google.com>
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
> console output: https://syzkaller.appspot.com/x/log.txt?x=14956af7800000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=968b0b23c7854c0b
> dashboard link: https://syzkaller.appspot.com/bug?extid=e5190cb881d8660fb1a3
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> syzkaller repro:https://syzkaller.appspot.com/x/repro.syz?x=123d9d7b800000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100329d7800000

#syz fix: bpf: reject passing modified ctx to helper functions
