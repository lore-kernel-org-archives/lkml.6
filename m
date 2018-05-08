Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbeEHO75 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:59:57 -0400
Received: from ozlabs.org ([203.11.71.1]:34845 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932679AbeEHO74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:59:56 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxram@us.ibm.com
Cc: mingo@redhat.com, linuxppc-dev@ozlabs.org, linux-mm@kvack.org,
        x86@kernel.org, linux-kernel@vger.kernel.org, dave.hansen@intel.com
Subject: [PATCH 0/8] mm, x86, powerpc: Consolidate pkey code
Date: Wed,  9 May 2018 00:59:40 +1000
Message-Id: <20180508145948.9492-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a rework of Ram's series, which broke the build on both arches at
various points due to the differing header dependencies.

The actual pkey changes are basically the same, this just has some rework to
get the headers cleaned up a bit beforehand.

If no one objects I'll ask Stephen to put these in a topic branch in
linux-next, and I or someone else can merge them for 4.18.

cheers


Ram's original:
  http://patchwork.ozlabs.org/patch/909066/
  http://patchwork.ozlabs.org/patch/909067/
  http://patchwork.ozlabs.org/patch/909068/



Michael Ellerman (5):
  mm/pkeys: Remove include of asm/mmu_context.h from pkeys.h
  mm/pkeys, powerpc, x86: Provide an empty vma_pkey() in linux/pkeys.h
  x86/pkeys: Move vma_pkey() into asm/pkeys.h
  x86/pkeys: Add arch_pkeys_enabled()
  mm/pkeys: Add an empty arch_pkeys_enabled()

Ram Pai (3):
  mm, powerpc, x86: define VM_PKEY_BITx bits if CONFIG_ARCH_HAS_PKEYS is
    enabled
  mm, powerpc, x86: introduce an additional vma bit for powerpc pkey
  mm/pkeys, x86, powerpc: Display pkey in smaps if arch supports pkeys

 arch/powerpc/include/asm/mmu_context.h |  5 -----
 arch/powerpc/include/asm/pkeys.h       |  2 ++
 arch/x86/include/asm/mmu_context.h     | 15 ---------------
 arch/x86/include/asm/pkeys.h           | 13 +++++++++++++
 arch/x86/kernel/setup.c                |  8 --------
 fs/proc/task_mmu.c                     | 13 +++++++------
 include/linux/mm.h                     | 12 +++++++-----
 include/linux/pkeys.h                  | 13 +++++++++++--
 8 files changed, 40 insertions(+), 41 deletions(-)

-- 
2.14.1
