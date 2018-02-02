Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752018AbeBBD4Z (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:56:25 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35540 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751880AbeBBDzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:24 -0500
X-Google-Smtp-Source: AH8x227lJPeuEPfMvXmUkS/Ar8GBEWS9TbUqMgJFmg9JNPgrlpcpB2U8roCt15N/lXokzM4ADlrYVA==
From: Serge Semin <fancer.lancer@gmail.com>
To: ralf@linux-mips.org, miodrag.dinic@mips.com, jhogan@kernel.org,
        goran.ferenc@mips.com, david.daney@cavium.com,
        paul.gortmaker@windriver.com, paul.burton@mips.com,
        alex.belits@cavium.com, Steven.Hill@cavium.com
Cc: alexander.sverdlin@nokia.com, matt.redfearn@mips.com, kumba@gentoo.org,
        marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Serge Semin <fancer.lancer@gmail.com>
Subject: [PATCH v2 15/15] MIPS: memblock: Deactivate bootmem allocator
Date: Fri,  2 Feb 2018 06:54:58 +0300
Message-Id: <20180202035458.30456-16-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Memblock allocator can be successfully used from now for early
memory management

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 350a990fc719..434f756e03e9 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,7 +4,6 @@ config MIPS
 	default y
 	select ARCH_BINFMT_ELF_STATE
 	select ARCH_CLOCKSOURCE_DATA
-	select ARCH_DISCARD_MEMBLOCK
 	select ARCH_HAS_ELF_RANDOMIZE
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_MIGHT_HAVE_PC_PARPORT
@@ -57,6 +56,7 @@ config MIPS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select HAVE_KPROBES
 	select HAVE_KRETPROBES
+	select NO_BOOTMEM
 	select HAVE_MEMBLOCK
 	select HAVE_MEMBLOCK_NODE_MAP
 	select HAVE_MOD_ARCH_SPECIFIC
-- 
2.12.0
