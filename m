Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0306C3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 940182145D
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 15:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 940182145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752667AbeGDPUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 11:20:21 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:47980 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752145AbeGDPUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 11:20:20 -0400
Received: from hsi-kbw-5-158-153-52.hsi19.kabel-badenwuerttemberg.de ([5.158.153.52] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1fajZq-0001ER-JN; Wed, 04 Jul 2018 17:20:18 +0200
Date:   Wed, 4 Jul 2018 17:20:18 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     syzbot <syzbot+7f73a81393d3b3777fb0@syzkaller.appspotmail.com>
cc:     linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Subject: Re: KASAN: use-after-scope Read in __hrtimer_run_queues
In-Reply-To: <000000000000ebc8e405702ddd18@google.com>
Message-ID: <alpine.DEB.2.21.1807041718070.1752@nanos.tec.linutronix.de>
References: <000000000000ebc8e405702ddd18@google.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Jul 2018, syzbot wrote:

> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    2bdea157b999 Merge branch 'sctp-fully-support-for-dscp-and..
> git tree:       bpf-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=14339f42400000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f62553dc846b0692
> dashboard link: https://syzkaller.appspot.com/bug?extid=7f73a81393d3b3777fb0
> compiler:       gcc (GCC) 8.0.1 20180413 (experimental)
> 
> Unfortunately, I don't have any reproducer for this crash yet.
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7f73a81393d3b3777fb0@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-scope in lookup_object lib/debugobjects.c:157 [inline]
> BUG: KASAN: use-after-scope in debug_object_deactivate+0x425/0x450
> lib/debugobjects.c:540
> Read of size 8 at addr ffff88019d1a5ec0 by task syz-executor3/13445

I don't see how lib/debugobjects.c:157 would be a valid use after scope
issue. The one in line 540 makes no sense either.

Thanks,

	tglx


