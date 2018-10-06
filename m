Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EF7C64EB8
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:13:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E874208E7
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 07:13:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n37DWALO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E874208E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbeJFOQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 10:16:03 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46970 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727117AbeJFOQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 10:16:03 -0400
Received: by mail-wr1-f66.google.com with SMTP id a2-v6so8524732wrc.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 00:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=hVtQVYxvjAsc4YlGCITMtb0dT+81d2xdeq3ooGj27Rw=;
        b=n37DWALOG9L+Z3Ycs+xsGYhJX+mtuLJ+/7VrS+KWaufurEzf84W1R5YMMseDxOiaSN
         RPd2jbJd+mlnUcKRTSKzC3czDxFJHEdLLv604D2EX4tqicpAHhJE39FBHq0vOe7OaC4A
         Ki9fCuCCuHEoSKhTqXOBxO6NIfsCNhgtqiNPRQdzBjksIMQN8Mii2xK0KjD82ZxyImXH
         t0onVrY83SN1D8cpHqiVfeRD+R6SYFM0acy+2Y1vZ5XWHYOhZUEfpQrA2CWiWHxID7lu
         A1JOsuyrGKxHAUxsvmq3CiijRJH7zTkOG23A5lIfBMhLxTvUIwy/lcepWVNKu1h0hlWF
         fs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hVtQVYxvjAsc4YlGCITMtb0dT+81d2xdeq3ooGj27Rw=;
        b=I80XnBR/LyDUcGq8fhK4EegmbIoT7RWvO4kiPD2CTZ3/oaPfzIC2lC274vuXO4zpkk
         kGd5Fgi81LVHgB6ehOIx4YNsplMkI/pEzsv0qVPkQqz1Cabm6kXiRNq8v1IkPHCjhBId
         uDyGVOMejYBR2JHR5WSuUfNEEdsPOotz89eNcJhH2y92odE5hFHLd01Df1+1XAfvT5ek
         t5szqQvTCWM42iSmznLgfvicaghesXHmHXZujzBUcAOgWwTIHTJW6xHD21y1UPAYS3nP
         vGW8mRtYdoKqDVgXkMwzW+GZrPHOweb4YSMBisaQQlHEqbBJG2Ggtc1ZICWc1cxeCcIZ
         bEew==
X-Gm-Message-State: ABuFfoi5oEt4Fzs/xFrvs4Y5EMPdF1QNf74Y4qiVh0/IDsJVn4TtMJ2I
        rsLAsSsbEcE+dfGsTL6fbSU52fGGHkU=
X-Google-Smtp-Source: ACcGV633arS6Sz+kexDNPaiapdh5AhyTbjAkcVBc7KkFPf1pz6lqR7G40WpvFl0deOgAcS5mv9PPeg==
X-Received: by 2002:adf:94c2:: with SMTP id 60-v6mr10163435wrr.247.1538810027054;
        Sat, 06 Oct 2018 00:13:47 -0700 (PDT)
Received: from osboxes.localdomain (bzq-109-65-231-165.red.bezeqint.net. [109.65.231.165])
        by smtp.googlemail.com with ESMTPSA id b5-v6sm5877200wrs.62.2018.10.06.00.13.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 06 Oct 2018 00:13:46 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     gregkh@linuxfoundation.org, chrisadr@gentoo.org,
        dan.carpenter@oracle.com
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        carmeli.tamir@gmail.com
Subject: [PATCH] STAGING/EMXX_UDC: Fixed all meaningful sparse errors.
Date:   Sat,  6 Oct 2018 03:13:39 -0400
Message-Id: <1538810019-98403-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed all meaningful sparse errors: 
1. Added static to udc_controller 
2. Added mising __iomem modifier to handle p_regs 
3. Added missing le16_to_cpu

Signed-off-by: Tamir Carmeli <carmeli.tamir@gmail.com>
---

 drivers/staging/emxx_udc/emxx_udc.c | 69 +++++++++++++++++++------------------
 drivers/staging/emxx_udc/emxx_udc.h |  2 +-
 3 files changed, 38 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3e51476..83eb430 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -56,25 +56,25 @@ static void _nbu2ss_fifo_flush(struct nbu2ss_udc *, struct nbu2ss_ep *);
 
 /*===========================================================================*/
 /* Global */
-struct nbu2ss_udc udc_controller;
+static struct nbu2ss_udc udc_controller;
 
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
 
@@ -135,6 +135,7 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
 {
 	u8		recipient;
 	u16		selector;
+	u16		wIndex;
 	u32		test_mode;
 	struct usb_ctrlrequest	*p_ctrl;
 	struct nbu2ss_udc *udc;
@@ -149,10 +150,11 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
 			/*-------------------------------------------------*/
 			/* SET_FEATURE */
 			recipient = (u8)(p_ctrl->bRequestType & USB_RECIP_MASK);
-			selector  = p_ctrl->wValue;
+			selector  = le16_to_cpu(p_ctrl->wValue);
 			if ((recipient == USB_RECIP_DEVICE) &&
 			    (selector == USB_DEVICE_TEST_MODE)) {
-				test_mode = (u32)(p_ctrl->wIndex >> 8);
+				wIndex = le16_to_cpu(p_ctrl->wIndex);
+				test_mode = (u32)(wIndex >> 8);
 				_nbu2ss_set_test_mode(udc, test_mode);
 			}
 		}
@@ -184,7 +186,7 @@ static u32 _nbu2ss_get_begin_ram_address(struct nbu2ss_udc *udc)
 	u32		num, buf_type;
 	u32		data, last_ram_adr, use_ram_size;
 
-	struct ep_regs *p_ep_regs;
+	struct ep_regs __iomem *p_ep_regs;
 
 	last_ram_adr = (D_RAM_SIZE_CTRL / sizeof(u32)) * 2;
 	use_ram_size = 0;
@@ -377,7 +379,7 @@ static void _nbu2ss_ep_dma_exit(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 {
 	u32		num;
 	u32		data;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem	*preg = udc->p_regs;
 
 	if (udc->vbus_active == 0)
 		return;		/* VBUS OFF */
@@ -408,7 +410,7 @@ static void _nbu2ss_ep_dma_exit(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 /* Abort DMA */
 static void _nbu2ss_ep_dma_abort(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 {
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	_nbu2ss_bitclr(&preg->EP_DCR[ep->epnum - 1].EP_DCR1, DCR1_EPN_REQEN);
 	mdelay(DMA_DISABLE_TIME);	/* DCR1_EPN_REQEN Clear */
@@ -426,7 +428,7 @@ static void _nbu2ss_ep_in_end(
 {
 	u32		data;
 	u32		num;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (length >= sizeof(u32))
 		return;
@@ -817,7 +819,7 @@ static int _nbu2ss_out_dma(
 	u32		burst = 1;
 	u32		data;
 	int		result = -EINVAL;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem	*preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
@@ -880,7 +882,7 @@ static int _nbu2ss_epn_out_pio(
 	union usb_reg_access	temp_32;
 	union usb_reg_access	*p_buf_32;
 	int		result = 0;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem	*preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
@@ -964,7 +966,7 @@ static int _nbu2ss_epn_out_transfer(
 	u32		num;
 	u32		i_recv_length;
 	int		result = 1;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs	__iomem *preg = udc->p_regs;
 
 	if (ep->epnum == 0)
 		return -EINVAL;
@@ -1026,7 +1028,7 @@ static int _nbu2ss_in_dma(
 	u32		i_write_length;
 	u32		data;
 	int		result = -EINVAL;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs	__iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
@@ -1101,7 +1103,7 @@ static int _nbu2ss_epn_in_pio(
 	union usb_reg_access	temp_32;
 	union usb_reg_access	*p_buf_32 = NULL;
 	int		result = 0;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs	__iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return 1;		/* DMA is forwarded */
@@ -1317,7 +1319,7 @@ static void _nbu2ss_set_endpoint_stall(
 	u8		num, epnum;
 	u32		data;
 	struct nbu2ss_ep *ep;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs	__iomem *preg = udc->p_regs;
 
 	if ((ep_adrs == 0) || (ep_adrs == 0x80)) {
 		if (bstall) {
@@ -1380,7 +1382,7 @@ static struct usb_device_descriptor device_desc = {
 	.bMaxPacketSize0      = 64,
 	.idVendor             = cpu_to_le16(0x0409),
 	.idProduct            = cpu_to_le16(0xfff0),
-	.bcdDevice            = 0xffff,
+	.bcdDevice            = cpu_to_le16(0xffff),
 	.iManufacturer        = 0x00,
 	.iProduct             = 0x00,
 	.iSerialNumber        = 0x00,
@@ -1440,7 +1442,7 @@ static int _nbu2ss_get_ep_stall(struct nbu2ss_udc *udc, u8 ep_adrs)
 {
 	u8		epnum;
 	u32		data = 0, bit_data;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs	__iomem *preg = udc->p_regs;
 
 	epnum = ep_adrs & ~USB_ENDPOINT_DIR_MASK;
 	if (epnum == 0) {
@@ -1468,8 +1470,8 @@ static inline int _nbu2ss_req_feature(struct nbu2ss_udc *udc, bool bset)
 {
 	u8	recipient = (u8)(udc->ctrl.bRequestType & USB_RECIP_MASK);
 	u8	direction = (u8)(udc->ctrl.bRequestType & USB_DIR_IN);
-	u16	selector  = udc->ctrl.wValue;
-	u16	wIndex    = udc->ctrl.wIndex;
+	u16	selector  = le16_to_cpu(udc->ctrl.wValue);
+	u16	wIndex    = le16_to_cpu(udc->ctrl.wIndex);
 	u8	ep_adrs;
 	int	result = -EOPNOTSUPP;
 
@@ -1535,7 +1537,7 @@ static void _nbu2ss_epn_set_stall(
 	u32	regdata;
 	int	limit_cnt = 0;
 
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs	__iomem *preg = udc->p_regs;
 
 	if (ep->direct == USB_DIR_IN) {
 		for (limit_cnt = 0
@@ -1568,7 +1570,8 @@ static int std_req_get_status(struct nbu2ss_udc *udc)
 	if ((udc->ctrl.wValue != 0x0000) || (direction != USB_DIR_IN))
 		return result;
 
-	length = min_t(u16, udc->ctrl.wLength, sizeof(status_data));
+	length =
+		min_t(u16, le16_to_cpu(udc->ctrl.wLength), sizeof(status_data));
 
 	switch (recipient) {
 	case USB_RECIP_DEVICE:
@@ -1584,8 +1587,8 @@ static int std_req_get_status(struct nbu2ss_udc *udc)
 		break;
 
 	case USB_RECIP_ENDPOINT:
-		if (0x0000 == (udc->ctrl.wIndex & 0xFF70)) {
-			ep_adrs = (u8)(udc->ctrl.wIndex & 0xFF);
+		if (0x0000 == (le16_to_cpu(udc->ctrl.wIndex) & 0xFF70)) {
+			ep_adrs = (u8)(le16_to_cpu(udc->ctrl.wIndex) & 0xFF);
 			result = _nbu2ss_get_ep_stall(udc, ep_adrs);
 
 			if (result > 0)
@@ -1625,7 +1628,7 @@ static int std_req_set_feature(struct nbu2ss_udc *udc)
 static int std_req_set_address(struct nbu2ss_udc *udc)
 {
 	int		result = 0;
-	u32		wValue = udc->ctrl.wValue;
+	u32		wValue = le16_to_cpu(udc->ctrl.wValue);
 
 	if ((udc->ctrl.bRequestType != 0x00)	||
 	    (udc->ctrl.wIndex != 0x0000)	||
@@ -1647,7 +1650,7 @@ static int std_req_set_address(struct nbu2ss_udc *udc)
 /*-------------------------------------------------------------------------*/
 static int std_req_set_configuration(struct nbu2ss_udc *udc)
 {
-	u32 config_value = (u32)(udc->ctrl.wValue & 0x00ff);
+	u32 config_value = (u32)(le16_to_cpu(udc->ctrl.wValue) & 0x00ff);
 
 	if ((udc->ctrl.wIndex != 0x0000)	||
 	    (udc->ctrl.wLength != 0x0000)	||
@@ -1943,7 +1946,7 @@ static inline void _nbu2ss_epn_in_int(
 	int	result = 0;
 	u32	status;
 
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs	__iomem *preg = udc->p_regs;
 
 	if (req->dma_flag)
 		return;		/* DMA is forwarded */
@@ -2038,7 +2041,7 @@ static inline void _nbu2ss_epn_out_dma_int(
 	u32		num;
 	u32		dmacnt, ep_dmacnt;
 	u32		mpkt;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs	__iomem  *preg = udc->p_regs;
 
 	num = ep->epnum - 1;
 
@@ -2214,7 +2217,7 @@ static int _nbu2ss_pullup(struct nbu2ss_udc *udc, int is_on)
 /*-------------------------------------------------------------------------*/
 static void _nbu2ss_fifo_flush(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 {
-	struct fc_regs	*p = udc->p_regs;
+	struct fc_regs __iomem	*p = udc->p_regs;
 
 	if (udc->vbus_active == 0)
 		return;
@@ -2432,7 +2435,7 @@ static irqreturn_t _nbu2ss_udc_irq(int irq, void *_udc)
 	u32	epnum, int_bit;
 
 	struct nbu2ss_udc	*udc = (struct nbu2ss_udc *)_udc;
-	struct fc_regs	*preg = udc->p_regs;
+	struct fc_regs __iomem *preg = udc->p_regs;
 
 	if (gpio_get_value(VBUS_VALUE) == 0) {
 		_nbu2ss_writel(&preg->USB_INT_STA, ~USB_INT_STA_RW);
@@ -2831,7 +2834,7 @@ static int nbu2ss_ep_fifo_status(struct usb_ep *_ep)
 	struct nbu2ss_ep	*ep;
 	struct nbu2ss_udc	*udc;
 	unsigned long		flags;
-	struct fc_regs		*preg;
+	struct fc_regs __iomem *preg;
 
 	if (!_ep) {
 		pr_err("%s, bad param\n", __func__);
@@ -3216,7 +3219,7 @@ static int nbu2ss_drv_probe(struct platform_device *pdev)
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

