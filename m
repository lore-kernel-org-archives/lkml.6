Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA2CC6786F
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:59:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A95020657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 19:59:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qyCpcLJA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A95020657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727759AbeKBFEF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:04:05 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38931 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727583AbeKBFEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:04:05 -0400
Received: by mail-wr1-f65.google.com with SMTP id r10-v6so21270750wrv.6
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 12:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=883KBKcqu8vYPh6CQKhMUh8ikdecUtHmXX3JSIBJph4=;
        b=qyCpcLJALKEzxNRUtskcsMReRejw9fQsMB9zrtWQwu6jHKxVnNs3XRMFEwO8Nlm3ns
         Oo8NeXbgq8YQJguhqMGOsQzS4dwMaL1sFVzqYK8/eypTeHfszVJxwBTaHgZfByZkIwRK
         6y/n+gHNdDb2o7o08bmlwGQgaKHwAIHUbz790a1gKcR475X2OnTP9JZg0VXe0Yw3yCFo
         wb91JdebtdZlUVP9yLNj1hnzUTA9LkpjxEUVSb5GWXgkgZIlGhVH70Ehywro1pwfT+kS
         z6lkrBjbAbdPrwwNUZw+s8SdiWA5g6VyklhxXl7I1BY2HBsLdLpDk+oPUCgRVcm76VdC
         rJsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=883KBKcqu8vYPh6CQKhMUh8ikdecUtHmXX3JSIBJph4=;
        b=ujGbxrDPbcrB1iGt1q2I2ZVuOHYVrVeOkowa51GxekwdNyGqzI3j42y0w11nYzYZiU
         yH44JXrF+wKbDb1hbAp4wpq4D5NsHYrKM6scIgccH2eB2HPFwT62s8oGMPjTfL0cqYNI
         xfMuNDoZFCmN/FxzugHgx8NIy7Jvi3lq0nUTvQbqKUJ4gEGOWNGKjpb03kmWwfk8ABul
         JZEaov29awVJ5EngJCKix2QUqP7/PILn+jdC3xL0eLOKlMTy0ateAuQz9hMU5keB/Rhq
         b7cW++ZJNzxl8uHBjZcWf0m19PZlEPoUQ1+i9Q/SwpepDGrabti/JZvSwhj10BcH51Kx
         uKIA==
X-Gm-Message-State: AGRZ1gL8TySzVZ98r8fj2EOn43a/d8VsKfrvhtwU/A6m/sBJACmLxLln
        XY/9rQQOTTdaj3J7tbKYaq0=
X-Google-Smtp-Source: AJdET5cbHfmnuuJU6y0usQIXsUUeCP8psWMdQ3rxT5KXi0FMbXpECDRnc1zWLl2XXwhXUwLb8IaADQ==
X-Received: by 2002:a5d:6050:: with SMTP id j16-v6mr7597017wrt.301.1541102378778;
        Thu, 01 Nov 2018 12:59:38 -0700 (PDT)
Received: from osboxes.localdomain (bzq-79-178-252-231.red.bezeqint.net. [79.178.252.231])
        by smtp.googlemail.com with ESMTPSA id i7-v6sm37907952wmd.41.2018.11.01.12.59.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 12:59:37 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     areklis909@gmail.com, natechancellor@gmail.com,
        dan.carpenter@oracle.com, chrisadr@gentoo.org,
        Carmeli Tamir <carmeli.tamir@gmail.com>
Subject: [PATCH 2/3] staging: emxx_udc: Added missing __iomem modifier to handle p_regs
Date:   Thu,  1 Nov 2018 15:59:30 -0400
Message-Id: <1541102370-51522-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since in nbu2ss_drv_probe() p_regs is assigned from mmio_base, which is 
marked as __iomem, p_regs also should be market with __iomem.
Previously posted without any feedback, now updated according to master.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 44 ++++++++++++++++++-------------------
 drivers/staging/emxx_udc/emxx_udc.h |  2 +-
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 94a4327..344fe80 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -60,21 +60,21 @@ static struct nbu2ss_udc udc_controller;
 
 /*-------------------------------------------------------------------------*/
 /* Read */
-static inline u32 _nbu2ss_readl(void *address)
+static inline u32 _nbu2ss_readl(void __iomem *address)
 {
 	return __raw_readl(address);
 }
 
 /*-------------------------------------------------------------------------*/
 /* Write */
-static inline void _nbu2ss_writel(void *address, u32 udata)
+static inline void _nbu2ss_writel(void __iomem *address, u32 udata)
 {
 	__raw_writel(udata, address);
 }
 
 /*-------------------------------------------------------------------------*/
 /* Set Bit */
-static inline void _nbu2ss_bitset(void *address, u32 udata)
+static inline void _nbu2ss_bitset(void __iomem *address, u32 udata)
 {
 	u32	reg_dt = __raw_readl(address) | (udata);
 
@@ -83,7 +83,7 @@ static inline void _nbu2ss_bitset(void *address, u32 udata)
 
 /*-------------------------------------------------------------------------*/
 /* Clear Bit */
-static inline void _nbu2ss_bitclr(void *address, u32 udata)
+static inline void _nbu2ss_bitclr(void __iomem *address, u32 udata)
 {
 	u32	reg_dt = __raw_readl(address) & ~(udata);
 
@@ -184,7 +184,7 @@ static u32 _nbu2ss_get_begin_ram_address(struct nbu2ss_udc *udc)
 	u32		num, buf_type;
 	u32		data, last_ram_adr, use_ram_size;
 
-	struct ep_regs *p_ep_regs;
+	struct ep_regs __iomem *p_ep_regs;
 
 	last_ram_adr = (D_RAM_SIZE_CTRL / sizeof(u32)) * 2;
 	use_ram_size = 0;
@@ -377,7 +377,7 @@ static void _nbu2ss_ep_dma_exit(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 {
 	u32		num;
 	u32		data;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (udc->vbus_active == 0)
 		return;		/* VBUS OFF */
@@ -408,7 +408,7 @@ static void _nbu2ss_ep_dma_exit(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 /* Abort DMA */
 static void _nbu2ss_ep_dma_abort(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 {
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	_nbu2ss_bitclr(&preg->EP_DCR[ep->epnum - 1].EP_DCR1, DCR1_EPN_REQEN);
 	mdelay(DMA_DISABLE_TIME);	/* DCR1_EPN_REQEN Clear */
@@ -426,7 +426,7 @@ static void _nbu2ss_ep_in_end(
 {
 	u32		data;
 	u32		num;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (length >= sizeof(u32))
 		return;
@@ -817,7 +817,7 @@ static int _nbu2ss_out_dma(
 	u32		burst = 1;
 	u32		data;
 	int		result = -EINVAL;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
@@ -880,7 +880,7 @@ static int _nbu2ss_epn_out_pio(
 	union usb_reg_access	temp_32;
 	union usb_reg_access	*p_buf_32;
 	int		result = 0;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
@@ -964,7 +964,7 @@ static int _nbu2ss_epn_out_transfer(
 	u32		num;
 	u32		i_recv_length;
 	int		result = 1;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (ep->epnum == 0)
 		return -EINVAL;
@@ -1026,7 +1026,7 @@ static int _nbu2ss_in_dma(
 	u32		i_write_length;
 	u32		data;
 	int		result = -EINVAL;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
@@ -1101,7 +1101,7 @@ static int _nbu2ss_epn_in_pio(
 	union usb_reg_access	temp_32;
 	union usb_reg_access	*p_buf_32 = NULL;
 	int		result = 0;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
@@ -1317,7 +1317,7 @@ static void _nbu2ss_set_endpoint_stall(
 	u8		num, epnum;
 	u32		data;
 	struct nbu2ss_ep *ep;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if ((ep_adrs == 0) || (ep_adrs == 0x80)) {
 		if (bstall) {
@@ -1440,7 +1440,7 @@ static int _nbu2ss_get_ep_stall(struct nbu2ss_udc *udc, u8 ep_adrs)
 {
 	u8		epnum;
 	u32		data = 0, bit_data;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	epnum = ep_adrs & ~USB_ENDPOINT_DIR_MASK;
 	if (epnum == 0) {
@@ -1535,7 +1535,7 @@ static void _nbu2ss_epn_set_stall(
 	u32	regdata;
 	int	limit_cnt = 0;
 
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (ep->direct == USB_DIR_IN) {
 		for (limit_cnt = 0
@@ -1943,7 +1943,7 @@ static inline void _nbu2ss_epn_in_int(
 	int	result = 0;
 	u32	status;
 
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return;		/* DMA is forwarded */
@@ -2038,7 +2038,7 @@ static inline void _nbu2ss_epn_out_dma_int(
 	u32		num;
 	u32		dmacnt, ep_dmacnt;
 	u32		mpkt;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	num = ep->epnum - 1;
 
@@ -2214,7 +2214,7 @@ static int _nbu2ss_pullup(struct nbu2ss_udc *udc, int is_on)
 /*-------------------------------------------------------------------------*/
 static void _nbu2ss_fifo_flush(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 {
-	struct fc_regs	*p = udc->p_regs;
+	struct fc_regs __iomem *p = udc->p_regs;
 
 	if (udc->vbus_active == 0)
 		return;
@@ -2432,7 +2432,7 @@ static irqreturn_t _nbu2ss_udc_irq(int irq, void *_udc)
 	u32	epnum, int_bit;
 
 	struct nbu2ss_udc	*udc = (struct nbu2ss_udc *)_udc;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (gpio_get_value(VBUS_VALUE) == 0) {
 		_nbu2ss_writel(&preg->USB_INT_STA, ~USB_INT_STA_RW);
@@ -2831,7 +2831,7 @@ static int nbu2ss_ep_fifo_status(struct usb_ep *_ep)
 	struct nbu2ss_ep	*ep;
 	struct nbu2ss_udc	*udc;
 	unsigned long		flags;
-	struct fc_regs		*preg;
+	struct fc_regs	__iomem *preg;
 
 	if (!_ep) {
 		pr_err("%s, bad param\n", __func__);
@@ -3216,7 +3216,7 @@ static int nbu2ss_drv_probe(struct platform_device *pdev)
 				  0, driver_name, udc);
 
 	/* IO Memory */
-	udc->p_regs = (struct fc_regs *)mmio_base;
+	udc->p_regs = (struct fc_regs __iomem *)mmio_base;
 
 	/* USB Function Controller Interrupt */
 	if (status != 0) {
diff --git a/drivers/staging/emxx_udc/emxx_udc.h b/drivers/staging/emxx_udc/emxx_udc.h
index 8337e38c..e28a74d 100644
--- a/drivers/staging/emxx_udc/emxx_udc.h
+++ b/drivers/staging/emxx_udc/emxx_udc.h
@@ -582,7 +582,7 @@ struct nbu2ss_udc {
 
 	u32		curr_config;	/* Current Configuration Number */
 
-	struct fc_regs		*p_regs;
+	struct fc_regs __iomem *p_regs;
 };
 
 /* USB register access structure */
-- 
2.7.4

