Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753096AbeE1D1G (ORCPT <rfc822;w@1wt.eu>);
        Sun, 27 May 2018 23:27:06 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38501 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752981AbeE1D1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 May 2018 23:27:03 -0400
X-Google-Smtp-Source: AB8JxZqcQcAx5rFDoHI6WOLn0MP5CrRKCoXeTrIS1bvefCyN5ZuraHuJ9sCSUZRfX1Ird1sR61+kTA==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: greentime@andestech.com, linux-kernel@vger.kernel.org, arnd@arndb.de,
        torvalds@linux-foundation.org
Cc: green.hu@gmail.com
Subject: [GIT PULL] nds32 fixes for 4.17
Date: Mon, 28 May 2018 11:26:39 +0800
Message-Id: <cover.1527477138.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  Linux 4.17-rc6 (2018-05-20 15:31:38 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git tags/nds32-for-linus-4.17-fixes

for you to fetch changes up to a30e7d1e37e8acc37c25420d93af218166cca3ae:

  nds32: Fix compiler warning, Wstringop-overflow, in vdso.c (2018-05-23 13:26:22 +0800)

----------------------------------------------------------------
nds32 patches for 4.17

Here is the nds32 patch set based on 4.17-rc6.
Contained in here are the bug fixes and building error fixes for nds32.

These are the LTP20170427 testing results. hackbench01 may fail sometimes.
We are still investigating this issue.

Total Tests: 1902
Total Skipped Tests: 593
Total Failures: 420
Kernel Version: 4.17.0-rc6-00018-ga30e7d1e37e8
Machine Architecture: nds32

Total Tests: 1902
Total Skipped Tests: 593
Total Failures: 419
Kernel Version: 4.17.0-rc5-00018-g27288975a735
Machine Architecture: nds32

Signed-off-by: Greentime Hu <greentime@andestech.com>

----------------------------------------------------------------
Greentime Hu (12):
      nds32: lib: To use generic lib instead of libgcc to prevent the symbol undefined issue.
      nds32: Fix building error when CONFIG_FREEZE is enabled.
      nds32: Fix building error of crypto/xor.c by adding xor.h
      nds32: Fix drivers/gpu/drm/udl/udl_fb.c building error by defining PAGE_SHARED
      nds32: Fix xfs_buf built failed by export invalidate_kernel_vmap_range and flush_kernel_vmap_range
      nds32: Fix the symbols undefined issue by exporting them.
      nds32: Fix the unknown type u8 issue.
      nds32: Fix build failed because arch_trace_hardirqs_off is changed to trace_hardirqs_off.
      nds32: Fix the allmodconfig build. To make sure CONFIG_CPU_LITTLE_ENDIAN is default y
      nds32: Fix the virtual address may map too much range by tlbop issue.
      nds32: To refine readability of INT_MASK_INITAIAL_VAL
      nds32: To fix a cache inconsistency issue by setting correct cacheability of NTC

Nickhu (2):
      nds32: Renaming the file for unaligned access
      nds32: Fix the unaligned access handler

Vincent Chen (4):
      nds32: Correct flush_dcache_page function
      nds32: Flush the cache of the page at vmaddr instead of kaddr in flush_anon_page
      nds32: Disable local irq before calling cpu_dcache_wb_page in copy_user_highpage
      nds32: Fix compiler warning, Wstringop-overflow, in vdso.c

 arch/nds32/Kconfig                  |  7 +++++++
 arch/nds32/Kconfig.cpu              |  5 +++--
 arch/nds32/Makefile                 |  7 ++++---
 arch/nds32/include/asm/Kbuild       |  2 ++
 arch/nds32/include/asm/bitfield.h   |  3 ++-
 arch/nds32/include/asm/cacheflush.h |  2 ++
 arch/nds32/include/asm/io.h         |  2 ++
 arch/nds32/include/asm/page.h       |  3 +++
 arch/nds32/include/asm/pgtable.h    |  1 +
 arch/nds32/kernel/ex-entry.S        |  2 +-
 arch/nds32/kernel/head.S            | 28 +++++++++++++++++++++++-----
 arch/nds32/kernel/setup.c           |  3 +++
 arch/nds32/kernel/stacktrace.c      |  2 ++
 arch/nds32/kernel/vdso.c            | 10 +++++-----
 arch/nds32/lib/copy_page.S          |  3 +++
 arch/nds32/mm/alignment.c           |  9 ++++++---
 arch/nds32/mm/cacheflush.c          | 74 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------
 arch/nds32/mm/init.c                |  1 +
 18 files changed, 130 insertions(+), 34 deletions(-)
