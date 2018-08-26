Return-Path: <SRS0=U0Lc=LJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E256C433F5
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:03:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A942208DA
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Aug 2018 09:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCdoPlOD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A942208DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbeHZMpA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Aug 2018 08:45:00 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36861 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbeHZMo7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Aug 2018 08:44:59 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so6382528pfo.3
        for <linux-kernel@vger.kernel.org>; Sun, 26 Aug 2018 02:03:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=pg14ZlzEQoNOErv//mZr8+MOMBoTH9KIpT2VW0oBX/s=;
        b=ZCdoPlODc9p/hk4fIA3WdPqZMDwWyxFKXEzbeXRxGb8Svm6hiDu16NwF6qTxBREv77
         ckDFYzpKxqdVaO66VQkIhGcqye69VWlwt695HJbgy/65W+G+A9UgeG/AXe24r8VJ/SnO
         86FPbpKV7wtaOSFX2UQP+xYcdrHgh4tGZzA0sowPjvci50aQO5tD73F4jJ50Em+gufLW
         A5bBQKR2eYV9WOyoQfyGEKaLHqMdV5sXo/TBmALecWem0ClDu43XSR9e/dSJr4VRCtx5
         WBXeBKjl+9BtkkPcUVnVoY+CmX1t5vtt46jOW/rlfjWmSEvezJzf/iHUx9Yn71YWrkbm
         TNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=pg14ZlzEQoNOErv//mZr8+MOMBoTH9KIpT2VW0oBX/s=;
        b=iGR7mcpAAW5HR/2YTXk8KHYQ0Cg0n+iCUfnlKbsv/Pgv8ZIzanGMJMNg2gK5CgDpOK
         HTttftPSJ/eE6+2TLU1ARKg/1ABSwfKbT6QVMRv1sQHUWO/w0vlXj/wTGLUzCsLTyLF1
         sOQ/u5DxhfHt1sriy5QSOCqWyRufwSJXWqlpBmlDocIgLznq+dxqnAMP4h0hnSSm+nCK
         +Y3+7U6PnsJr4fZsr9udMUvFz8q8iMqwGavWtwcO4iWczvsJolJUKehsGkNXxY5f4JGR
         AIxuWY+MLnPVW3RwsWLNyNFlQ1E1WSBlXfDd0bUkgb4mIrYSKVRqc3JaM+c6Qp2yU12F
         7l4A==
X-Gm-Message-State: APzg51DD2HxRRA9JCXioXgoLKfsKcZ09XyAU3CSDe7wn5Zvk0rX67tL4
        nnjXQeWFhBsm+w9NTecPFa22rDeX+Xw=
X-Google-Smtp-Source: ANB0VdaXmeMHxe3oPC9cQQ1PkuG6Vx0KSkPTMiEohO9oyToHAY1UbdU26TZFwMTxJwPnRhmhL17ZNQ==
X-Received: by 2002:a63:ca09:: with SMTP id n9-v6mr8046738pgi.287.1535274182681;
        Sun, 26 Aug 2018 02:03:02 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id g7-v6sm14895093pfi.175.2018.08.26.02.02.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 02:03:01 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
X-Google-Original-From: Jia He <jia.he@hxt-semitech.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH] irqchip/gic-v3-its: add allocation max order limitation for lpi_id_bits
Date:   Sun, 26 Aug 2018 17:00:51 +0800
Message-Id: <1535274051-2418-1-git-send-email-jia.he@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a WARN_ON when my QDF2400 server boots up (pagesize is 4k)
============begin===============
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: Distributor has no Range Selector support
[    0.000000] GICv3: VLPI support, no direct LPI support
[    0.000000] ACPI: SRAT not present
[    0.000000] ITS [mem 0xff7efe0000-0xff7effffff]
[    0.000000] ITS@0x000000ff7efe0000: Using ITS number 0
[    0.000000] GIC: enabling workaround for ITS: QDF2400 erratum 0065
[    0.000000] ITS@0x000000ff7efe0000: allocated 524288 Devices
@179f000000 (indirect, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000ff7efe0000: allocated 8192 Interrupt
Collections @179f930000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] ITS@0x000000ff7efe0000: allocated 65536 Virtual CPUs
@179f980000 (flat, esz 8, psz 64K, shr 1)
[    0.000000] WARNING: CPU: 0 PID: 0 at mm/page_alloc.c:4066
__alloc_pages_nodemask+0x2d8/0x1188
[    0.000000] Modules linked in:
[    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.18.0+ #66
[    0.000000] pstate: 20000085 (nzCv daIf -PAN -UAO)
[    0.000000] pc : __alloc_pages_nodemask+0x2d8/0x1188
[    0.000000] lr : __alloc_pages_nodemask+0x134/0x1188
[    0.000000] sp : ffff0000091b3a30
[    0.000000] x29: ffff0000091b3a30 x28: 0000000000000000
[    0.000000] x27: ffff00000a045000 x26: 0000000000000000
[    0.000000] x25: 0000000000000000 x24: ffff0000091c1000
[    0.000000] x23: ffff0000091b3b98 x22: 000000000000000c
[    0.000000] x21: ffff0000082dc130 x20: 0000000000000001
[    0.000000] x19: 0000000000000000 x18: 000000000000003f
[    0.000000] x17: 0000000000000000 x16: 0000000000000000
[    0.000000] x15: ffffffffffffffff x14: 202c74616c662820
[    0.000000] x13: ffff000009c5f9e0 x12: 0000000000000077
[    0.000000] x11: 0000000000000078 x10: 0000000097110f47
[    0.000000] x9 : 0000000000000000 x8 : 00000000009fff3f
[    0.000000] x7 : 000000000000002b x6 : 000000000000000c
[    0.000000] x5 : 0000000000000001 x4 : 0000000000000000
[    0.000000] x3 : ffff000008fd1000 x2 : ffff000008fd1000
[    0.000000] x1 : ffff0000091c1000 x0 : 0000000000000000
[    0.000000] Call trace:
[    0.000000]  __alloc_pages_nodemask+0x2d8/0x1188
[    0.000000]  alloc_pages_current+0x8c/0xd8
[    0.000000]  its_allocate_prop_table+0x5c/0xb8
[    0.000000]  its_init+0x220/0x3c0
[    0.000000]  gic_init_bases+0x250/0x380
[    0.000000]  gic_acpi_init+0x16c/0x2a4
[    0.000000]  acpi_match_madt+0x50/0x88
[    0.000000]  acpi_table_parse_entries_array+0x180/0x204
[    0.000000]  acpi_table_parse_entries+0x60/0x84
[    0.000000]  acpi_table_parse_madt+0x40/0x4c
[    0.000000]  __acpi_probe_device_table+0x94/0xe8
[    0.000000]  irqchip_init+0x38/0x40
[    0.000000]  init_IRQ+0x70/0x9c
[    0.000000]  start_kernel+0x310/0x4c0
[    0.000000] irq event stamp: 0
[    0.000000] hardirqs last  enabled at (0): [<0000000000000000>]
(null)
[    0.000000] hardirqs last disabled at (0): [<0000000000000000>]
(null)
[    0.000000] softirqs last  enabled at (0): [<0000000000000000>]
(null)
[    0.000000] softirqs last disabled at (0): [<0000000000000000>]
(null)
[    0.000000] ---[ end trace 943781056d97862b ]---
============end============

In its_alloc_lpi_tables, lpi_id_bits is 24, without this patch,
its_allocate_prop_table will try to allocate 16M(order 12 if
pagesize=4k). Thus it causes the WARN_ON.

This patch fixes it by limiting the lpi_id_bits.

Signed-off-by: Jia He <jia.he@hxt-semitech.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 316a575..79e6993 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1624,8 +1624,11 @@ static void its_free_prop_table(struct page *prop_page)
 static int __init its_alloc_lpi_tables(void)
 {
 	phys_addr_t paddr;
+	u32 max_bits;	 /*max order limitation in alloc_page*/
 
-	lpi_id_bits = GICD_TYPER_ID_BITS(gic_rdists->gicd_typer);
+	max_bits = PAGE_SHIFT + MAX_ORDER - 1;
+	lpi_id_bits = min_t(u32, max_bits,
+			GICD_TYPER_ID_BITS(gic_rdists->gicd_typer));
 	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
 	if (!gic_rdists->prop_page) {
 		pr_err("Failed to allocate PROPBASE\n");
-- 
1.8.3.1

