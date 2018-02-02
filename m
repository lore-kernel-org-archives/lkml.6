Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeBBD5O (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:57:14 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:36723 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeBBDzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:55:19 -0500
X-Google-Smtp-Source: AH8x227fKZvE6PQGWbdqwwwadhRdoifscUaI1NYnp7zVTFy/bGKye1oylFfXt01tOhNJ7HwCpYJmnA==
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
Subject: [PATCH v2 11/15] MIPS: memblock: Perform early low memory test
Date: Fri,  2 Feb 2018 06:54:54 +0300
Message-Id: <20180202035458.30456-12-fancer.lancer@gmail.com>
X-Mailer: git-send-email 2.12.0
In-Reply-To: <20180202035458.30456-1-fancer.lancer@gmail.com>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180202035458.30456-1-fancer.lancer@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Low memory can be tested at this point, since all the
reservations have just been finished without much of
additional allocations.

Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
---
 arch/mips/kernel/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index 531a1471a2a4..a0eac8160750 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -850,6 +850,8 @@ static void __init arch_mem_init(char **cmdline_p)
 	memblock_allow_resize();
 
 	memblock_dump_all();
+
+	early_memtest(PFN_PHYS(min_low_pfn), PFN_PHYS(max_low_pfn));
 }
 
 static void __init resource_init(void)
-- 
2.12.0
