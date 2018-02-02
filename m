Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751970AbeBBDzy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:55:54 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:46534 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751644AbeBBDzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:08 -0500
X-Google-Smtp-Source: AH8x226LDzJkDQYWyySFH9nJk3CmjDqfcxan4eiUSlD9j0X4VwFGT+9q9D9zWDgJcbkt7BbP0NdexQ==
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
Subject: [PATCH v2 03/15] MIPS: memblock: Reserve initrd memory in memblock
Date: Fri,  2 Feb 2018 06:54:46 +0300
Message-Id: <20180202035458.30456-4-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no reserve_bootmem() method in the nobootmem interface,
so we need to replace it with memblock-specific one.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index f502cd702fa7..a015cee353be 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -330,7 +330,7 @@ static void __init finalize_initrd(void)
 
 	maybe_bswap_initrd();
 
-	reserve_bootmem(__pa(initrd_start), size, BOOTMEM_DEFAULT);
+	memblock_reserve(__pa(initrd_start), size);
 	initrd_below_start_ok = 1;
 
 	pr_info("Initial ramdisk at: 0x%lx (%lu bytes)\n",
-- 
2.12.0
