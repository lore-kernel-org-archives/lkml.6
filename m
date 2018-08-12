Return-Path: <SRS0=4YaO=K3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 647BEC46464
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 07:23:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01F3221A13
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Aug 2018 07:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NLZDeLKv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01F3221A13
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbeHLKA1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Aug 2018 06:00:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45996 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726878AbeHLKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Aug 2018 06:00:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id f12-v6so11552903wrv.12;
        Sun, 12 Aug 2018 00:23:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=jYD6hV3xoV61Z3MCUK2DiFEmekjkoUQWITavtw8XJb8=;
        b=NLZDeLKvs1QgRFE89BlC1tTZcov9otbrhZRA0aR4gGNNb59Nv18aP3d22xjakNpAB2
         ZM7GH5bz7qZbVIF6VikOR3E7PkQ+qBF4j7IezHKGE2s+QcpxbKd6mEUskRkjq9rY5uLF
         SWLr7b+t75YvY/swoGsCCVb2rHtUNYcSQ/5NOhLcoTyqaV/dh2mS3UhfwrPUY1y34fTw
         /oL2iexTBKO5mf27jALbBULAxBdSe9VAxCjPEl/jbGC23nJ7CVEEmSgDbnu1fMLsSawC
         rP5qEkF8HVWg49+8q/Hn4dgvewJIoYpIMZyJ2ag3rEchiEo6tesyFXvGOlwwMKV1cfbP
         5eWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jYD6hV3xoV61Z3MCUK2DiFEmekjkoUQWITavtw8XJb8=;
        b=rXa+5tA5EKFhLS/JgHjLjR2PnxDLxuBAyuTzNtx0EE1ROMX4nDesyPh8KpMYGMckfz
         HXxdHxDuW3D784UvMW63K/QvtVjCiD8U4o98jCJvgpCOF9vKB3l8lD/JmXfAoD03lFa9
         GBfRAcOivKBJKElkf/TFyrt/xGX14OTDdcddAOq2s6DR0BqufJHI/tQvUqyED2JhBNYY
         HY5UdaGTTVzz7w4mjdbI6HSVJhS4WQxhhT9J0rp5o3KIbnlgcnt4EeUtKsErECuI9yIj
         giigeJ0MXIAX6Tz/UcnOwB+B5bkM7j+olrK1YMb11ILVXdtwzlkmwyK2yiLXsfJZlzSb
         XvkQ==
X-Gm-Message-State: AOUpUlFG9hFWSy9NT/sJOEO+QpKImKTEJ7LapJ1IjuvTAJ2wfHC1sY5f
        XUIa0NCbextELNi6oo4qgbE=
X-Google-Smtp-Source: AA+uWPxt20Cgqt7VupJHVrsLstlm0pS5t3hMbDIL3v61+LIdlTCOCC4Pv6Lc9r25oqC24yyfX7bWdA==
X-Received: by 2002:adf:e3c5:: with SMTP id k5-v6mr7814569wrm.94.1534058601197;
        Sun, 12 Aug 2018 00:23:21 -0700 (PDT)
Received: from localhost.localdomain (94-155-67-89.ip.btc-net.bg. [94.155.67.89])
        by smtp.gmail.com with ESMTPSA id e12-v6sm11331783wru.89.2018.08.12.00.23.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Aug 2018 00:23:20 -0700 (PDT)
From:   Iliya Iliev <iliyailiev3592@gmail.com>
To:     mchehab@kernel.org
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Iliya Iliev <iliyailiev3592@gmail.com>
Subject: [PATCH] drivers: media: pci: b2c2: Fix errors due to unappropriate coding style.
Date:   Sun, 12 Aug 2018 10:23:11 +0300
Message-Id: <20180812072311.29776-1-iliyailiev3592@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix error due to assignment in conditional expression.
Fix errors due to absence of empty spaces separators after commas in
function calls.
Fix errors due to lines longer than 80 characters.

Signed-off-by: Iliya Iliev <iliyailiev3592@gmail.com>
---
 drivers/media/pci/b2c2/flexcop-dma.c | 70 +++++++++++++++-------------
 1 file changed, 37 insertions(+), 33 deletions(-)

diff --git a/drivers/media/pci/b2c2/flexcop-dma.c b/drivers/media/pci/b2c2/flexcop-dma.c
index f07610a1646d..ba45b378d739 100644
--- a/drivers/media/pci/b2c2/flexcop-dma.c
+++ b/drivers/media/pci/b2c2/flexcop-dma.c
@@ -17,7 +17,8 @@ int flexcop_dma_allocate(struct pci_dev *pdev,
 		return -EINVAL;
 	}
 
-	if ((tcpu = pci_alloc_consistent(pdev, size, &tdma)) != NULL) {
+	tcpu = pci_alloc_consistent(pdev, size, &tdma);
+	if (tcpu != NULL) {
 		dma->pdev = pdev;
 		dma->cpu_addr0 = tcpu;
 		dma->dma_addr0 = tdma;
@@ -34,7 +35,7 @@ void flexcop_dma_free(struct flexcop_dma *dma)
 {
 	pci_free_consistent(dma->pdev, dma->size*2,
 			dma->cpu_addr0, dma->dma_addr0);
-	memset(dma,0,sizeof(struct flexcop_dma));
+	memset(dma, 0, sizeof(struct flexcop_dma));
 }
 EXPORT_SYMBOL(flexcop_dma_free);
 
@@ -42,23 +43,24 @@ int flexcop_dma_config(struct flexcop_device *fc,
 		struct flexcop_dma *dma,
 		flexcop_dma_index_t dma_idx)
 {
-	flexcop_ibi_value v0x0,v0x4,v0xc;
-	v0x0.raw = v0x4.raw = v0xc.raw = 0;
+	flexcop_ibi_value v0x0, v0x4, v0xc;
 
+	v0x0.raw = v0x4.raw = v0xc.raw = 0;
 	v0x0.dma_0x0.dma_address0 = dma->dma_addr0 >> 2;
 	v0xc.dma_0xc.dma_address1 = dma->dma_addr1 >> 2;
 	v0x4.dma_0x4_write.dma_addr_size = dma->size / 4;
 
 	if ((dma_idx & FC_DMA_1) == dma_idx) {
-		fc->write_ibi_reg(fc,dma1_000,v0x0);
-		fc->write_ibi_reg(fc,dma1_004,v0x4);
-		fc->write_ibi_reg(fc,dma1_00c,v0xc);
+		fc->write_ibi_reg(fc, dma1_000, v0x0);
+		fc->write_ibi_reg(fc, dma1_004, v0x4);
+		fc->write_ibi_reg(fc, dma1_00c, v0xc);
 	} else if ((dma_idx & FC_DMA_2) == dma_idx) {
-		fc->write_ibi_reg(fc,dma2_010,v0x0);
-		fc->write_ibi_reg(fc,dma2_014,v0x4);
-		fc->write_ibi_reg(fc,dma2_01c,v0xc);
+		fc->write_ibi_reg(fc, dma2_010, v0x0);
+		fc->write_ibi_reg(fc, dma2_014, v0x4);
+		fc->write_ibi_reg(fc, dma2_01c, v0xc);
 	} else {
-		err("either DMA1 or DMA2 can be configured within one flexcop_dma_config call.");
+		err("either DMA1 or DMA2 can be configured within one %s call.",
+			__func__);
 		return -EINVAL;
 	}
 
@@ -72,8 +74,8 @@ int flexcop_dma_xfer_control(struct flexcop_device *fc,
 		flexcop_dma_addr_index_t index,
 		int onoff)
 {
-	flexcop_ibi_value v0x0,v0xc;
-	flexcop_ibi_register r0x0,r0xc;
+	flexcop_ibi_value v0x0, v0xc;
+	flexcop_ibi_register r0x0, r0xc;
 
 	if ((dma_idx & FC_DMA_1) == dma_idx) {
 		r0x0 = dma1_000;
@@ -82,15 +84,16 @@ int flexcop_dma_xfer_control(struct flexcop_device *fc,
 		r0x0 = dma2_010;
 		r0xc = dma2_01c;
 	} else {
-		err("either transfer DMA1 or DMA2 can be started within one flexcop_dma_xfer_control call.");
+		err("transfer DMA1 or DMA2 can be started within one %s call.",
+			__func__);
 		return -EINVAL;
 	}
 
-	v0x0 = fc->read_ibi_reg(fc,r0x0);
-	v0xc = fc->read_ibi_reg(fc,r0xc);
+	v0x0 = fc->read_ibi_reg(fc, r0x0);
+	v0xc = fc->read_ibi_reg(fc, r0xc);
 
-	deb_rdump("reg: %03x: %x\n",r0x0,v0x0.raw);
-	deb_rdump("reg: %03x: %x\n",r0xc,v0xc.raw);
+	deb_rdump("reg: %03x: %x\n", r0x0, v0x0.raw);
+	deb_rdump("reg: %03x: %x\n", r0xc, v0xc.raw);
 
 	if (index & FC_DMA_SUBADDR_0)
 		v0x0.dma_0x0.dma_0start = onoff;
@@ -98,11 +101,11 @@ int flexcop_dma_xfer_control(struct flexcop_device *fc,
 	if (index & FC_DMA_SUBADDR_1)
 		v0xc.dma_0xc.dma_1start = onoff;
 
-	fc->write_ibi_reg(fc,r0x0,v0x0);
-	fc->write_ibi_reg(fc,r0xc,v0xc);
+	fc->write_ibi_reg(fc, r0x0, v0x0);
+	fc->write_ibi_reg(fc, r0xc, v0xc);
 
-	deb_rdump("reg: %03x: %x\n",r0x0,v0x0.raw);
-	deb_rdump("reg: %03x: %x\n",r0xc,v0xc.raw);
+	deb_rdump("reg: %03x: %x\n", r0x0, v0x0.raw);
+	deb_rdump("reg: %03x: %x\n", r0xc, v0xc.raw);
 	return 0;
 }
 EXPORT_SYMBOL(flexcop_dma_xfer_control);
@@ -112,10 +115,11 @@ static int flexcop_dma_remap(struct flexcop_device *fc,
 		int onoff)
 {
 	flexcop_ibi_register r = (dma_idx & FC_DMA_1) ? dma1_00c : dma2_01c;
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,r);
-	deb_info("%s\n",__func__);
+	flexcop_ibi_value v = fc->read_ibi_reg(fc, r);
+
+	deb_info("%s\n", __func__);
 	v.dma_0xc.remap_enable = onoff;
-	fc->write_ibi_reg(fc,r,v);
+	fc->write_ibi_reg(fc, r, v);
 	return 0;
 }
 
@@ -123,7 +127,7 @@ int flexcop_dma_control_size_irq(struct flexcop_device *fc,
 		flexcop_dma_index_t no,
 		int onoff)
 {
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,ctrl_208);
+	flexcop_ibi_value v = fc->read_ibi_reg(fc, ctrl_208);
 
 	if (no & FC_DMA_1)
 		v.ctrl_208.DMA1_IRQ_Enable_sig = onoff;
@@ -131,7 +135,7 @@ int flexcop_dma_control_size_irq(struct flexcop_device *fc,
 	if (no & FC_DMA_2)
 		v.ctrl_208.DMA2_IRQ_Enable_sig = onoff;
 
-	fc->write_ibi_reg(fc,ctrl_208,v);
+	fc->write_ibi_reg(fc, ctrl_208, v);
 	return 0;
 }
 EXPORT_SYMBOL(flexcop_dma_control_size_irq);
@@ -140,7 +144,7 @@ int flexcop_dma_control_timer_irq(struct flexcop_device *fc,
 		flexcop_dma_index_t no,
 		int onoff)
 {
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,ctrl_208);
+	flexcop_ibi_value v = fc->read_ibi_reg(fc, ctrl_208);
 
 	if (no & FC_DMA_1)
 		v.ctrl_208.DMA1_Timer_Enable_sig = onoff;
@@ -148,7 +152,7 @@ int flexcop_dma_control_timer_irq(struct flexcop_device *fc,
 	if (no & FC_DMA_2)
 		v.ctrl_208.DMA2_Timer_Enable_sig = onoff;
 
-	fc->write_ibi_reg(fc,ctrl_208,v);
+	fc->write_ibi_reg(fc, ctrl_208, v);
 	return 0;
 }
 EXPORT_SYMBOL(flexcop_dma_control_timer_irq);
@@ -158,13 +162,13 @@ int flexcop_dma_config_timer(struct flexcop_device *fc,
 		flexcop_dma_index_t dma_idx, u8 cycles)
 {
 	flexcop_ibi_register r = (dma_idx & FC_DMA_1) ? dma1_004 : dma2_014;
-	flexcop_ibi_value v = fc->read_ibi_reg(fc,r);
+	flexcop_ibi_value v = fc->read_ibi_reg(fc, r);
 
-	flexcop_dma_remap(fc,dma_idx,0);
+	flexcop_dma_remap(fc, dma_idx, 0);
 
-	deb_info("%s\n",__func__);
+	deb_info("%s\n", __func__);
 	v.dma_0x4_write.dmatimer = cycles;
-	fc->write_ibi_reg(fc,r,v);
+	fc->write_ibi_reg(fc, r, v);
 	return 0;
 }
 EXPORT_SYMBOL(flexcop_dma_config_timer);
-- 
2.17.1

