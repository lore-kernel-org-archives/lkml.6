Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BA91C433F4
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB91E20661
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 23:22:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB91E20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727497AbeH3DVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 23:21:30 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41026 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727149AbeH3DVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 23:21:30 -0400
Received: from akpm3.svl.corp.google.com (unknown [104.133.8.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4D50025A;
        Wed, 29 Aug 2018 23:22:14 +0000 (UTC)
Date:   Wed, 29 Aug 2018 16:22:13 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jia He <hejianet@gmail.com>
Cc:     broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au,
        linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: mmotm 2018-08-23-17-26 uploaded
Message-Id: <20180829162213.fa1c7c54c801a036e64bacd2@linux-foundation.org>
In-Reply-To: <049c3fa9-f888-6a2d-413b-872992b269f9@gmail.com>
References: <20180824002731.XMNCl%akpm@linux-foundation.org>
        <049c3fa9-f888-6a2d-413b-872992b269f9@gmail.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Aug 2018 12:20:46 +0800 Jia He <hejianet@gmail.com> wrote:

> Hi Andrew
> FYI,I watched a lockdep warning based on your mmotm master branch[1]

Thanks.  We'll need help from ARM peeps on this please.

> [    6.692731] ------------[ cut here ]------------
> [    6.696391] DEBUG_LOCKS_WARN_ON(!current->hardirqs_enabled)
> [    6.696404] WARNING: CPU: 3 PID: 320 at kernel/locking/lockdep.c:3845
> check_flags.part.38+0x9c/0x16c
> [    6.711082] Modules linked in:
> [    6.714101] CPU: 3 PID: 320 Comm: modprobe Not tainted 4.18.0-rc4-mm1+ #56
> [    6.720956] Hardware name: WIWYNN HXT REP-1 System H001-00001-0/HXT REP-1
> CRB, BIOS 0ACJA530 03/20/2018
> [    6.730332] pstate: 60400085 (nZCv daIf +PAN -UAO)
> [    6.735106] pc : check_flags.part.38+0x9c/0x16c
> [    6.739619] lr : check_flags.part.38+0x9c/0x16c
> [    6.744133] sp : ffff80178536fbf0
> [    6.747432] x29: ffff80178536fbf0 x28: ffff8017905a1b00
> [    6.752727] x27: 0000000000000002 x26: 0000000000000000
> [    6.758022] x25: ffff000008abeb14 x24: 0000000000000000
> [    6.763317] x23: 0000000000000001 x22: 0000000000000001
> [    6.768612] x21: 0000000000000001 x20: 0000000000000000
> [    6.773908] x19: ffff00000a041000 x18: 0000000000000000
> [    6.779202] x17: 0000000000000000 x16: 0000000000000000
> [    6.784498] x15: 0000000000000000 x14: 0000000000000000
> [    6.789793] x13: ffff000008d6b190 x12: 752ce9eb60de3f00
> [    6.795088] x11: ffff80178536f7f0 x10: ffff80178536f7f0
> [    6.800383] x9 : 00000000ffffffd0 x8 : 0000000000000000
> [    6.805678] x7 : ffff00000816fe48 x6 : ffff801794ba62b8
> [    6.810973] x5 : 0000000000000000 x4 : 0000000000000000
> [    6.816269] x3 : ffffffffffffffff x2 : ffff0000091ed988
> [    6.821564] x1 : 752ce9eb60de3f00 x0 : 752ce9eb60de3f00
> [    6.826859] Call trace:
> [    6.829290]  check_flags.part.38+0x9c/0x16c
> [    6.833457]  lock_acquire+0x12c/0x280
> [    6.837104]  down_read_trylock+0x78/0x98
> [    6.841011]  do_page_fault+0x150/0x480
> [    6.844742]  do_translation_fault+0x74/0x80
> [    6.848909]  do_mem_abort+0x60/0x108
> [    6.852467]  el0_da+0x24/0x28
> [    6.855418] irq event stamp: 250
> [    6.858633] hardirqs last  enabled at (249): [<ffff00000830e518>]
> mem_cgroup_commit_charge+0x9c/0x13c
> [    6.867833] hardirqs last disabled at (250): [<ffff000008095f40>]
> el0_svc_handler+0xc4/0x16c
> [    6.876252] softirqs last  enabled at (242): [<ffff000008081c48>]
> __do_softirq+0x2f8/0x554
> [    6.884501] softirqs last disabled at (229): [<ffff0000080f1bec>]
> irq_exit+0x180/0x194
> [    6.892399] ---[ end trace b45768f94a7b7d9f ]---
> [    6.896998] possible reason: unannotated irqs-on.
> [    6.901685] irq event stamp: 250
> [    6.904898] hardirqs last  enabled at (249): [<ffff00000830e518>]
> mem_cgroup_commit_charge+0x9c/0x13c
> [    6.914100] hardirqs last disabled at (250): [<ffff000008095f40>]
> el0_svc_handler+0xc4/0x16c
> [    6.922519] softirqs last  enabled at (242): [<ffff000008081c48>]
> __do_softirq+0x2f8/0x554
> [    6.930766] softirqs last disabled at (229): [<ffff0000080f1bec>]
> irq_exit+0x180/0x194
> [    7.023827] Initialise system trusted keyrings
> [    7.027414] workingset: timestamp_bits=45 max_order=25 bucket_order=0

Lockdep says current->hardirqs_enabled is false and that is indeed an
error.  arch/arm64/kernel/entry.S:el0_da does enable_daif which might
be an attempt to enable hardirqs, but how does that get propagated into
lockdep's ->hardirqs_enabled?  By calling
local_irq_enable()->trace_hardirqs_on(), but that's C, not assembler.

And what changed to cause this?

I dunno anything.  Help!

> I thought the root cause might be at [2] which seems not in your branch yet.
> 
> [1] http://git.cmpxchg.org/cgit.cgi/linux-mmotm.git
> [2]
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit?id=efd112

I agree, that doesn't look like the culprit.  But something may well
have gone wrong in "the recent conversion of the syscall entry/exit
code to C".

>
> ...
>
