Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755068AbeDTNdB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 09:33:01 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:40918 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754871AbeDTNc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 09:32:59 -0400
X-Google-Smtp-Source: AIpwx48nh9UwJGY6P7yX7wGOJuePBhbU29DCMQN9hXHK7xc7RSMXTDV2I3V3h0NJYnhBwzLuGhJliA==
From: Greentime Hu <green.hu@gmail.com>
X-Google-Original-From: Greentime Hu <greentime@andestech.com>
To: linux-kernel@vger.kernel.org, arnd@arndb.de, greentime@andestech.com,
        green.hu@gmail.com, private@roeck-us.net, hch@infradead.org,
        vincentc@andestech.com, nickhu@andestech.com
Subject: [PATCH v2 0/9] nds32: fix allmodconfig build
Date: Fri, 20 Apr 2018 21:31:06 +0800
Message-Id: <cover.1524229035.git.greentime@andestech.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  This patchset is used to fix the allmodconfig building errors.

Changes in v2:
 - To fix the endian mismatch issue.
 - Use EXPORT_SYMBOL(save_stack_trace) like other architectures.

Greentime Hu (9):
  nds32: lib: To use generic lib instead of libgcc to prevent the symbol
        undefined issue.
  nds32: Fix building error when CONFIG_FREEZE is enabled.
  nds32: Fix building error of crypto/xor.c by adding xor.h
  nds32: Fix drivers/gpu/drm/udl/udl_fb.c building error by defining
    PAGE_SHARED
  nds32: Fix xfs_buf built failed by export invalidate_kernel_vmap_range
    and flush_kernel_vmap_range
  nds32: Fix the symbols undefined issue by exporting them.
  nds32: Fix the unknown type u8 issue.
  nds32: Fix build failed because arch_trace_hardirqs_off is changed to 
       trace_hardirqs_off.
  nds32: Fix the allmodconfig build. To make sure
    CONFIG_CPU_LITTLE_ENDIAN     is default y

 arch/nds32/Kconfig                  |  7 +++++++
 arch/nds32/Kconfig.cpu              |  5 +++--
 arch/nds32/Makefile                 |  7 ++++---
 arch/nds32/include/asm/Kbuild       |  2 ++
 arch/nds32/include/asm/cacheflush.h |  2 ++
 arch/nds32/include/asm/io.h         |  2 ++
 arch/nds32/include/asm/page.h       |  3 +++
 arch/nds32/include/asm/pgtable.h    |  1 +
 arch/nds32/kernel/ex-entry.S        |  2 +-
 arch/nds32/kernel/stacktrace.c      |  2 ++
 arch/nds32/lib/copy_page.S          |  3 +++
 arch/nds32/mm/cacheflush.c          | 40 +++++++++++++++++++++++++++++++++++++
 arch/nds32/mm/init.c                |  1 +
 13 files changed, 71 insertions(+), 6 deletions(-)

-- 
1.9.5
