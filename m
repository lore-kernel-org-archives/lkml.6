Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932075AbeE3Qlr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 12:41:47 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:40634 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753022AbeE3Qlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 12:41:46 -0400
Message-Id: <cover.1527697995.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH 0/8] Remove unneccessary included headers
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed, 30 May 2018 16:41:43 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The purpose of this serie is to limit the number of includes to
only the necessary ones in order to reduce the number of files
recompiled everytime a header file is modified.

This is the start of the work, please provide feedback if any so
that I don't go in the wrong direction.

Christophe Leroy (8):
  powerpc: remove kdump.h from page.h
  powerpc: remove unneeded inclusions of cpu_has_feature.h
  powerpc: remove superflous inclusions of asm-compat.h
  powerpc: remove superflous inclusions of asm/feature-fixups.h
  powerpc: remove superflous inclusions of asm/fixmap.h
  powerpc: declare set_breakpoint() static
  powerpc/book3s: Remove PPC_PIN_SIZE
  powerpc: fix includes in asm/processor.h

 arch/powerpc/include/asm/book3s/32/pgtable.h |  5 -----
 arch/powerpc/include/asm/cacheflush.h        |  1 -
 arch/powerpc/include/asm/cputable.h          |  2 --
 arch/powerpc/include/asm/cputime.h           |  1 -
 arch/powerpc/include/asm/dbell.h             |  1 -
 arch/powerpc/include/asm/debug.h             |  1 -
 arch/powerpc/include/asm/dt_cpu_ftrs.h       |  3 ---
 arch/powerpc/include/asm/feature-fixups.h    |  2 ++
 arch/powerpc/include/asm/firmware.h          |  1 -
 arch/powerpc/include/asm/fixmap.h            |  2 --
 arch/powerpc/include/asm/hw_breakpoint.h     |  1 +
 arch/powerpc/include/asm/mmu.h               |  1 -
 arch/powerpc/include/asm/nohash/32/pgtable.h |  2 +-
 arch/powerpc/include/asm/page.h              |  1 -
 arch/powerpc/include/asm/ppc-opcode.h        |  1 -
 arch/powerpc/include/asm/processor.h         |  5 ++---
 arch/powerpc/include/asm/reg.h               |  1 +
 arch/powerpc/kernel/head_8xx.S               |  1 -
 arch/powerpc/kernel/process.c                | 14 +++++++-------
 arch/powerpc/kernel/setup_32.c               |  1 +
 arch/powerpc/kernel/vdso.c                   |  1 -
 arch/powerpc/mm/dump_hashpagetable.c         |  1 -
 arch/powerpc/sysdev/cpm_common.c             |  1 -
 23 files changed, 15 insertions(+), 35 deletions(-)

-- 
2.13.3
