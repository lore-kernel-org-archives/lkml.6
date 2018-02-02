Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752064AbeBBD52 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:57:28 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:36978 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751824AbeBBDzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:18 -0500
X-Google-Smtp-Source: AH8x224ff+sexjgCGF2eXy6/Jk5xfMO/xXC8Wiar7bNMIRLkYPTidSGaCqypZUQOE0Ll0GpYYEQ/dA==
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
Subject: [PATCH v2 10/15] MIPS: memblock: Allow memblock regions resize
Date: Fri,  2 Feb 2018 06:54:53 +0300
Message-Id: <20180202035458.30456-11-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When all the main reservations are done the memblock regions
can be dynamically resized. Additionally it would be useful to have
memblock regions dumped on debug at this point.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 158a52c17e29..531a1471a2a4 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -846,6 +846,10 @@ static void __init arch_mem_init(char **cmdline_p)
 	plat_swiotlb_setup();
 
 	dma_contiguous_reserve(PFN_PHYS(max_low_pfn));
+
+	memblock_allow_resize();
+
+	memblock_dump_all();
 }
 
 static void __init resource_init(void)
-- 
2.12.0
