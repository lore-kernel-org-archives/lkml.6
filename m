Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB5CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:11:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DB992173B
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 08:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547107860;
	bh=GrTivaENARUmTuwXxPdTcRI+5XpAoc77BRam4JOTEyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pZU5P89pzODGNfLdi7tTKkINaSmljopiqFqoRRN7UAME2Z/RkBngO6INlOaL/0+jm
	 tuaB6Nnqj3pDlX9yM9ozGRqtohbRcSLsIzvSIT+wD1twRm3O4jtjkcNm1AykYfCFKm
	 rIWjNwfiJzMHuE82FHo8v1PDloy7uELTx8Uvp8xY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727702AbfAJIK7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 03:10:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:46012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbfAJIK7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 03:10:59 -0500
Received: from guoren-Inspiron-7460 (23.83.240.247.16clouds.com [23.83.240.247])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F5CF206B7;
        Thu, 10 Jan 2019 08:10:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547107858;
        bh=GrTivaENARUmTuwXxPdTcRI+5XpAoc77BRam4JOTEyE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tf1s1YmryW/sA9WzjHLaEXtkfG6MsgLrae7d2GUCTdQ3pGxR16U/jbf9sB29p165+
         y2a6Sngd0rldxfoWKBGvocVrCUwlH40EsghZfSijpSNnnAhktEABxOcvsskx+0GRHZ
         S8u684og//uLpJHAjJ/aW9P3iebPzrFFR/dK0Pwo=
Date:   Thu, 10 Jan 2019 16:10:52 +0800
From:   Guo Ren <guoren@kernel.org>
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [GIT PULL] csky fixup for linux-5.0-rc1
Message-ID: <20190110081052.GB13262@guoren-Inspiron-7460>
References: <1547045397-24388-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547045397-24388-1-git-send-email-guoren@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry Linus,

This pull-request is wrong on the patch:
"csky: fixup module relocation error with 807 & 860".
diff --git a/arch/csky/kernel/module.c b/arch/csky/kernel/module.c
-       uint16_t location_tmp = (uint16_t *)location;
+       uint16_t *location_tmp = (uint16_t *)location;

Please drop it if possible and I'll send another [GIT PULL].

Best Regards
 Guo Ren

On Wed, Jan 09, 2019 at 10:49:57PM +0800, guoren@kernel.org wrote:
> The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:
> 
>   Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)
> 
> are available in the git repository at:
> 
>   git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc1
> 
> for you to fetch changes up to 56752b21755aef598709d143684cb363db98a7d2:
> 
>   irqchip/csky: fixup handle_irq_perbit break irq (2019-01-09 00:18:46 +0800)
> 
> ----------------------------------------------------------------
> arch/csky patches for 5.0-rc1
> 
> Here is some fixup patches for 5.0-rc1:
> 
>  - fixup compile error with pte_alloc
>  - fixup handle_irq_perbit break irq flow
>  - fixup CACHEV1 store instruction fast retire
>  - fixup module relocation error with 807 & 860
>  - add csky kernel features
> 
> ----------------------------------------------------------------
> Guo Ren (5):
>       Documentation/features: Add csky kernel features
>       csky: fixup relocation error with 807 & 860
>       csky: fixup CACHEV1 store instruction fast retire
>       csky: fixup compile error with pte_alloc
>       irqchip/csky: fixup handle_irq_perbit break irq
> 
>  .../features/core/cBPF-JIT/arch-support.txt        |  1 +
>  .../features/core/eBPF-JIT/arch-support.txt        |  1 +
>  .../core/generic-idle-thread/arch-support.txt      |  1 +
>  .../features/core/jump-labels/arch-support.txt     |  1 +
>  .../features/core/tracehook/arch-support.txt       |  1 +
>  .../features/debug/KASAN/arch-support.txt          |  1 +
>  .../debug/gcov-profile-all/arch-support.txt        |  1 +
>  Documentation/features/debug/kgdb/arch-support.txt |  1 +
>  .../debug/kprobes-on-ftrace/arch-support.txt       |  1 +
>  .../features/debug/kprobes/arch-support.txt        |  1 +
>  .../features/debug/kretprobes/arch-support.txt     |  1 +
>  .../features/debug/optprobes/arch-support.txt      |  1 +
>  .../features/debug/stackprotector/arch-support.txt |  1 +
>  .../features/debug/uprobes/arch-support.txt        |  1 +
>  .../debug/user-ret-profiler/arch-support.txt       |  1 +
>  .../features/io/dma-contiguous/arch-support.txt    |  1 +
>  .../locking/cmpxchg-local/arch-support.txt         |  1 +
>  .../features/locking/lockdep/arch-support.txt      |  1 +
>  .../locking/queued-rwlocks/arch-support.txt        |  1 +
>  .../locking/queued-spinlocks/arch-support.txt      |  1 +
>  .../locking/rwsem-optimized/arch-support.txt       |  1 +
>  .../features/perf/kprobes-event/arch-support.txt   |  1 +
>  .../features/perf/perf-regs/arch-support.txt       |  1 +
>  .../features/perf/perf-stackdump/arch-support.txt  |  1 +
>  .../sched/membarrier-sync-core/arch-support.txt    |  1 +
>  .../features/sched/numa-balancing/arch-support.txt |  1 +
>  .../seccomp/seccomp-filter/arch-support.txt        |  1 +
>  .../time/arch-tick-broadcast/arch-support.txt      |  1 +
>  .../features/time/clockevents/arch-support.txt     |  1 +
>  .../time/context-tracking/arch-support.txt         |  1 +
>  .../features/time/irq-time-acct/arch-support.txt   |  1 +
>  .../time/modern-timekeeping/arch-support.txt       |  1 +
>  .../features/time/virt-cpuacct/arch-support.txt    |  1 +
>  .../features/vm/ELF-ASLR/arch-support.txt          |  1 +
>  .../features/vm/PG_uncached/arch-support.txt       |  1 +
>  Documentation/features/vm/THP/arch-support.txt     |  1 +
>  Documentation/features/vm/TLB/arch-support.txt     |  1 +
>  .../features/vm/huge-vmap/arch-support.txt         |  1 +
>  .../features/vm/ioremap_prot/arch-support.txt      |  1 +
>  .../features/vm/numa-memblock/arch-support.txt     |  1 +
>  .../features/vm/pte_special/arch-support.txt       |  1 +
>  arch/csky/include/asm/io.h                         | 25 +++++++
>  arch/csky/include/asm/pgalloc.h                    | 43 +++++-------
>  arch/csky/kernel/module.c                          | 38 ++++++-----
>  drivers/irqchip/irq-csky-apb-intc.c                | 77 ++++++++++++----------
>  45 files changed, 148 insertions(+), 76 deletions(-)
