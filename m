Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AA3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:54:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F605208B6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 04:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qMkVooE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F605208B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbeH1In4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 04:43:56 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34811 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbeH1In4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 04:43:56 -0400
Received: by mail-pf1-f196.google.com with SMTP id k19-v6so193691pfi.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 21:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=zIl2o+k6vII8FDDquTRaYgmX7AiM/Y2Yr/GGH3FJwuE=;
        b=qMkVooE1qBLxSbRfC2rkI72FG/41/SoZs3QA8aCJke5ovHNuag7VLSZPLrLcj9e1DG
         sgyeBkN3yYeNdqCoM4+7+3K9b1QPpRgjahzuvRzGj9cejDW6Xy4PNoYWwnzA4rkQ0iru
         mFV+CeaSZF1+KVwUr77qFsvahi5v8bmEKi1KPmwiNUaTUhP4Lv3SBZ1sCOx/04yp3sJm
         7Intp0DHJI8zebwpq6eEZExbce26imut/vW5Mwq/UiHxEG4unB59fM0RXGcww9nctVE6
         vuMbp99suSHNhA+F5PazCuRbkl+kYi97mFddHbWviB2Dw4xCTO8i7GD2T2PZ6VLcop1c
         B0UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zIl2o+k6vII8FDDquTRaYgmX7AiM/Y2Yr/GGH3FJwuE=;
        b=FhOBINqI9eMGewNLIlXT4m3YGdLZApWvGM9pnSwRw8i2qwUkjVkdcPAPfoF6UPoJ47
         lxn1Qh9zDyjOH668ytEIrzT6a3B1tU00eKoI9v1PhKpxDNgEFagvFequIBQLwQzaV6Vv
         DquBUoJ4Hm5v4IsHBlc9AXurneFZLd/yl5RTD81iL9adPzY3o3IUIWjYu1dVT0CIPCZf
         TAG1aF+IwdyPrBYT5zspH1CFKcRUvR0J5yB8Unb4sSe3Uc92ATuAw+wTOO64vGSseTY+
         s70v/1MJNamI4CJqYBrvt3GahdNzuOsCroOmzt86R+hDZMxHHmBPz0Gzr7rrfcTAY7rE
         7XuQ==
X-Gm-Message-State: APzg51ApxTIW29Zli+8EgJ5viCVRwk5EUAkxRRxC55zxUhnxKYkxv4kP
        ES39N4biDRVpgic4ICcbUiw=
X-Google-Smtp-Source: ANB0VdZcCEa/xByQigOjKY5bqqjm7gnddJBKbSwLe6MyobEbWuvBORyhRHYwv2LoWxTcuhkf4c/s+Q==
X-Received: by 2002:a63:5b1b:: with SMTP id p27-v6mr3524932pgb.322.1535432045655;
        Mon, 27 Aug 2018 21:54:05 -0700 (PDT)
Received: from ct7host.localdomain ([38.106.11.25])
        by smtp.gmail.com with ESMTPSA id x65-v6sm13472pfk.140.2018.08.27.21.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 21:54:04 -0700 (PDT)
From:   Jia He <hejianet@gmail.com>
X-Google-Original-From: Jia He <jia.he@hxt-semitech.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        hejianet@gmail.com, Jia He <jia.he@hxt-semitech.com>
Subject: [PATCH] irqchip/gic-v3-its: cap lpi_id_bits to reduce memory footprint
Date:   Tue, 28 Aug 2018 12:53:26 +0800
Message-Id: <1535432006-2304-1-git-send-email-jia.he@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs"),
it removes the cap for lpi_id_bits. But it will cause more pointless
memory footprint.

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

In its_alloc_lpi_tables, lpi_id_bits is 24 in QDF2400. Then
its_allocate_prop_table will try to allocate 16M(order 12 if
pagesize=4k). Thus it causes the WARN_ON.

As said by Marc,
Capping lpi_id_bits at 16 (which is what we had before) is plenty,
will save a some memory, and gives some margin before we need to push
it up again.

This patch re-caps the lpi_id_bits.

Fixes: fe8e93504ce8 ("irqchip/gic-v3-its: Use full range of LPIs")
Signed-off-by: Jia He <jia.he@hxt-semitech.com>
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
---
 drivers/irqchip/irq-gic-v3-its.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 316a575..c2df341 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1439,6 +1439,7 @@ static int its_irq_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
  * The consequence of the above is that allocation is cost is low, but
  * freeing is expensive. We assumes that freeing rarely occurs.
  */
+#define ITS_MAX_LPI_NRBITS	16 /* 64K LPIs */
 
 static DEFINE_MUTEX(lpi_range_lock);
 static LIST_HEAD(lpi_range_list);
@@ -1625,7 +1626,8 @@ static int __init its_alloc_lpi_tables(void)
 {
 	phys_addr_t paddr;
 
-	lpi_id_bits = GICD_TYPER_ID_BITS(gic_rdists->gicd_typer);
+	lpi_id_bits = min_t(u32, GICD_TYPER_ID_BITS(gic_rdists->gicd_typer),
+				ITS_MAX_LPI_NRBITS);
 	gic_rdists->prop_page = its_allocate_prop_table(GFP_NOWAIT);
 	if (!gic_rdists->prop_page) {
 		pr_err("Failed to allocate PROPBASE\n");
-- 
1.8.3.1

