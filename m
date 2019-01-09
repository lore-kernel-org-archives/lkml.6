Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1E9C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68D0C206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 14:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547045410;
	bh=PMUQ6qz2Jhzo81BRNxDJFOmVNDUaKlLT8EVlJLe5HsA=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=eIS594Xo7Vl5K2583JppgVpG4ViRB0yhy2Go6CLXtU1/YtcbhjI9o/Vk2wFnSF6Ov
	 H2O6GjiMInym/kg2d5qWQF7QIhggV7LYPlkm5WE+EUsfhBEJe7OCDYu3i9WaX1vVHe
	 993uIy8w0Pa48B/a1wfpLry98RwO5wzE86wvFIXk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732062AbfAIOuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 09:50:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:50022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731828AbfAIOuG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 09:50:06 -0500
Received: from localhost.localdomain (unknown [218.0.237.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFAB5206BA;
        Wed,  9 Jan 2019 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547045405;
        bh=PMUQ6qz2Jhzo81BRNxDJFOmVNDUaKlLT8EVlJLe5HsA=;
        h=From:To:Cc:Subject:Date:From;
        b=j3C4sUK+9U2NFd526B1do1of9bdQ+pSYJ7v7pfe4SEt8hSvUtLQ/KbjHg3xy04yBI
         25MdO9l9YZgz28MqxSiOzEmd8gQIFRWoQVlt/esAqXXUxMcLLuQiOc8J6PWx0NIDDs
         41livkTEKzzwVee7x8HpG1mwg8UoIR221+P7MTKM=
From:   guoren@kernel.org
To:     torvalds@linux-foundation.org
Cc:     arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, guoren@kernel.org
Subject: [GIT PULL] csky fixup for linux-5.0-rc1
Date:   Wed,  9 Jan 2019 22:49:57 +0800
Message-Id: <1547045397-24388-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit bfeffd155283772bbe78c6a05dec7c0128ee500c:

  Linux 5.0-rc1 (2019-01-06 17:08:20 -0800)

are available in the git repository at:

  git@github.com:c-sky/csky-linux.git tags/csky-for-linus-5.0-rc1

for you to fetch changes up to 56752b21755aef598709d143684cb363db98a7d2:

  irqchip/csky: fixup handle_irq_perbit break irq (2019-01-09 00:18:46 +0800)

----------------------------------------------------------------
arch/csky patches for 5.0-rc1

Here is some fixup patches for 5.0-rc1:

 - fixup compile error with pte_alloc
 - fixup handle_irq_perbit break irq flow
 - fixup CACHEV1 store instruction fast retire
 - fixup module relocation error with 807 & 860
 - add csky kernel features

----------------------------------------------------------------
Guo Ren (5):
      Documentation/features: Add csky kernel features
      csky: fixup relocation error with 807 & 860
      csky: fixup CACHEV1 store instruction fast retire
      csky: fixup compile error with pte_alloc
      irqchip/csky: fixup handle_irq_perbit break irq

 .../features/core/cBPF-JIT/arch-support.txt        |  1 +
 .../features/core/eBPF-JIT/arch-support.txt        |  1 +
 .../core/generic-idle-thread/arch-support.txt      |  1 +
 .../features/core/jump-labels/arch-support.txt     |  1 +
 .../features/core/tracehook/arch-support.txt       |  1 +
 .../features/debug/KASAN/arch-support.txt          |  1 +
 .../debug/gcov-profile-all/arch-support.txt        |  1 +
 Documentation/features/debug/kgdb/arch-support.txt |  1 +
 .../debug/kprobes-on-ftrace/arch-support.txt       |  1 +
 .../features/debug/kprobes/arch-support.txt        |  1 +
 .../features/debug/kretprobes/arch-support.txt     |  1 +
 .../features/debug/optprobes/arch-support.txt      |  1 +
 .../features/debug/stackprotector/arch-support.txt |  1 +
 .../features/debug/uprobes/arch-support.txt        |  1 +
 .../debug/user-ret-profiler/arch-support.txt       |  1 +
 .../features/io/dma-contiguous/arch-support.txt    |  1 +
 .../locking/cmpxchg-local/arch-support.txt         |  1 +
 .../features/locking/lockdep/arch-support.txt      |  1 +
 .../locking/queued-rwlocks/arch-support.txt        |  1 +
 .../locking/queued-spinlocks/arch-support.txt      |  1 +
 .../locking/rwsem-optimized/arch-support.txt       |  1 +
 .../features/perf/kprobes-event/arch-support.txt   |  1 +
 .../features/perf/perf-regs/arch-support.txt       |  1 +
 .../features/perf/perf-stackdump/arch-support.txt  |  1 +
 .../sched/membarrier-sync-core/arch-support.txt    |  1 +
 .../features/sched/numa-balancing/arch-support.txt |  1 +
 .../seccomp/seccomp-filter/arch-support.txt        |  1 +
 .../time/arch-tick-broadcast/arch-support.txt      |  1 +
 .../features/time/clockevents/arch-support.txt     |  1 +
 .../time/context-tracking/arch-support.txt         |  1 +
 .../features/time/irq-time-acct/arch-support.txt   |  1 +
 .../time/modern-timekeeping/arch-support.txt       |  1 +
 .../features/time/virt-cpuacct/arch-support.txt    |  1 +
 .../features/vm/ELF-ASLR/arch-support.txt          |  1 +
 .../features/vm/PG_uncached/arch-support.txt       |  1 +
 Documentation/features/vm/THP/arch-support.txt     |  1 +
 Documentation/features/vm/TLB/arch-support.txt     |  1 +
 .../features/vm/huge-vmap/arch-support.txt         |  1 +
 .../features/vm/ioremap_prot/arch-support.txt      |  1 +
 .../features/vm/numa-memblock/arch-support.txt     |  1 +
 .../features/vm/pte_special/arch-support.txt       |  1 +
 arch/csky/include/asm/io.h                         | 25 +++++++
 arch/csky/include/asm/pgalloc.h                    | 43 +++++-------
 arch/csky/kernel/module.c                          | 38 ++++++-----
 drivers/irqchip/irq-csky-apb-intc.c                | 77 ++++++++++++----------
 45 files changed, 148 insertions(+), 76 deletions(-)
