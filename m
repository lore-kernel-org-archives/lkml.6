Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A600EC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:19:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39D5E20C01
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 23:19:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJEtjGmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39D5E20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727592AbeK0KP2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 05:15:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52664 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbeK0KP2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 05:15:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id r11-v6so19887232wmb.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Nov 2018 15:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZT6KHyVeH1ZlCcLiLBLBWzKMokzn1AsoCDJFYthvj00=;
        b=iJEtjGmM3focO09JLlDu1wt9YjYE61fsSJr20SBEV4+WM9vIrdaKZ6mZzUw33RQyPN
         sUmUTabkUvsJuyDt1N8KYb8pJhFTf54QX1j6M1R26PZcj4wsWyJcU+ZyKmpQHAfPMlrv
         fHESJ7HR3obXfAdPumRwdgC8reJr3LSXHz1hQtQN952zX9MfBGXQIVvfJLLtut/2Nxp9
         RPfBIAlQKvftQJQy0L4eFDN7ouiLR2NdWBraTdnkiTsU2ulShUBDsdF5Qa2qRDY0X7eE
         SnKHHxb5T6/Y9bfIT/4DVIZ3S43wdwOHUYHpZFkiI5mdBy5CyfH/ajv9dX8wSt8R7fxp
         aLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZT6KHyVeH1ZlCcLiLBLBWzKMokzn1AsoCDJFYthvj00=;
        b=AdUJMMmHNk8Mv7HwhzyczsyiGu6jE23gNuCRarUKRnQTifK45g77qesJgYNaTyhLR/
         MChr5FsO08S0vY+s+Qe6WhGFF7UreRXNYOs20Q6T2bhYW9ebrw1QPGWwj6Sw14Tl5KQX
         Bb5QoZV1ZxiGHoJUJcdo2cWT9xT9/3RvVwo6GfFvYM6l6ZxQkWhuWNBl0kCWh+BDNkAV
         VIzHQ0kvTIjp7fygw97+CRa3haoV/8lHrqwdsJGdNJelS4jAVfD2ftvCn5ggzo9IjCE0
         DkloUvjmPyZ83ZN4RdUmoPm8nJUKJ4RVpqimrFf1L6ZKfwIZ0y5nssZX93Q2lDfN6nRG
         3G+w==
X-Gm-Message-State: AA+aEWbK2ecHby4xOe/TJipbZTwZhLBIk6ekso3NZg8BiW6K70QOXjkS
        OnPUoyEXWBP65DTh87gI+4s=
X-Google-Smtp-Source: AFSGD/WmIY9+lYUwIP4zP1RmwRI6cj3GdHRB1bZ//BoeObpOCCtxjVqnnMFwggeMEoMZSGNBvqGqAw==
X-Received: by 2002:a1c:e1d5:: with SMTP id y204mr25151360wmg.65.1543274380735;
        Mon, 26 Nov 2018 15:19:40 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id h62sm1066469wmf.11.2018.11.26.15.19.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 15:19:40 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: emxx_udc: Align parameter with parenthesis
Date:   Tue, 27 Nov 2018 00:19:08 +0100
Message-Id: <1543274351-25762-2-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543274351-25762-1-git-send-email-sicilia.cristian@gmail.com>
References: <1543274351-25762-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align parameters with parenthesis and removed
open parenthesis at the end of line.


Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 270 ++++++++++++++----------------------
 1 file changed, 107 insertions(+), 163 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index bf7c5da..ebc622f 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -163,11 +163,9 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
 
 /*-------------------------------------------------------------------------*/
 /* Initialization usb_request */
-static void _nbu2ss_create_ep0_packet(
-	struct nbu2ss_udc *udc,
-	void *p_buf,
-	unsigned length
-)
+static void _nbu2ss_create_ep0_packet(struct nbu2ss_udc *udc,
+				      void *p_buf,
+				      unsigned int length)
 {
 	udc->ep0_req.req.buf		= p_buf;
 	udc->ep0_req.req.length		= length;
@@ -419,12 +417,8 @@ static void _nbu2ss_ep_dma_abort(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 /* Start IN Transfer */
-static void _nbu2ss_ep_in_end(
-	struct nbu2ss_udc *udc,
-	u32 epnum,
-	u32 data32,
-	u32 length
-)
+static void _nbu2ss_ep_in_end(struct nbu2ss_udc *udc, u32 epnum, u32 data32,
+			      u32 length)
 {
 	u32		data;
 	u32		num;
@@ -462,45 +456,41 @@ static void _nbu2ss_ep_in_end(
 
 #ifdef USE_DMA
 /*-------------------------------------------------------------------------*/
-static void _nbu2ss_dma_map_single(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u8		direct
-)
+static void _nbu2ss_dma_map_single(struct nbu2ss_udc *udc,
+				   struct nbu2ss_ep *ep,
+				   struct nbu2ss_req *req,
+				   u8 direct)
 {
 	if (req->req.dma == DMA_ADDR_INVALID) {
 		if (req->unaligned) {
 			req->req.dma = ep->phys_buf;
 		} else {
-			req->req.dma = dma_map_single(
-				udc->gadget.dev.parent,
-				req->req.buf,
-				req->req.length,
-				(direct == USB_DIR_IN)
-				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			req->req.dma = dma_map_single(udc->gadget.dev.parent,
+						      req->req.buf,
+						      req->req.length,
+						      (direct == USB_DIR_IN) ?
+							DMA_TO_DEVICE :
+							DMA_FROM_DEVICE);
 		}
 		req->mapped = 1;
 	} else {
 		if (!req->unaligned)
-			dma_sync_single_for_device(
-				udc->gadget.dev.parent,
-				req->req.dma,
-				req->req.length,
-				(direct == USB_DIR_IN)
-				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			dma_sync_single_for_device(udc->gadget.dev.parent,
+						   req->req.dma,
+						   req->req.length,
+						   (direct == USB_DIR_IN) ?
+							DMA_TO_DEVICE :
+							DMA_FROM_DEVICE);
 
 		req->mapped = 0;
 	}
 }
 
 /*-------------------------------------------------------------------------*/
-static void _nbu2ss_dma_unmap_single(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u8		direct
-)
+static void _nbu2ss_dma_unmap_single(struct nbu2ss_udc *udc,
+				     struct nbu2ss_ep *ep,
+				     struct nbu2ss_req *req,
+				     u8 direct)
 {
 	u8		data[4];
 	u8		*p;
@@ -671,10 +661,8 @@ static int EP0_receive_NULL(struct nbu2ss_udc *udc, bool pid_flag)
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_ep0_in_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_req *req
-)
+static int _nbu2ss_ep0_in_transfer(struct nbu2ss_udc *udc,
+				   struct nbu2ss_req *req)
 {
 	u8		*p_buffer;			/* IN Data Buffer */
 	u32		data;
@@ -728,10 +716,8 @@ static int _nbu2ss_ep0_in_transfer(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_ep0_out_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_req *req
-)
+static int _nbu2ss_ep0_out_transfer(struct nbu2ss_udc *udc,
+				    struct nbu2ss_req *req)
 {
 	u8		*p_buffer;
 	u32		i_remain_size;
@@ -805,12 +791,8 @@ static int _nbu2ss_ep0_out_transfer(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_out_dma(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_req *req,
-	u32		num,
-	u32		length
-)
+static int _nbu2ss_out_dma(struct nbu2ss_udc *udc, struct nbu2ss_req *req,
+			   u32 num, u32 length)
 {
 	dma_addr_t	p_buffer;
 	u32		mpkt;
@@ -868,12 +850,10 @@ static int _nbu2ss_out_dma(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_out_pio(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		length
-)
+static int _nbu2ss_epn_out_pio(struct nbu2ss_udc *udc,
+			       struct nbu2ss_ep *ep,
+			       struct nbu2ss_req *req,
+			       u32 length)
 {
 	u8		*p_buffer;
 	u32		i;
@@ -927,12 +907,10 @@ static int _nbu2ss_epn_out_pio(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_out_data(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		data_size
-)
+static int _nbu2ss_epn_out_data(struct nbu2ss_udc *udc,
+				struct nbu2ss_ep *ep,
+				struct nbu2ss_req *req,
+				u32 data_size)
 {
 	u32		num;
 	u32		i_buf_size;
@@ -957,11 +935,9 @@ static int _nbu2ss_epn_out_data(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_out_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req
-)
+static int _nbu2ss_epn_out_transfer(struct nbu2ss_udc *udc,
+				    struct nbu2ss_ep *ep,
+				    struct nbu2ss_req *req)
 {
 	u32		num;
 	u32		i_recv_length;
@@ -975,8 +951,8 @@ static int _nbu2ss_epn_out_transfer(
 
 	/*-------------------------------------------------------------*/
 	/* Receive Length */
-	i_recv_length
-		= _nbu2ss_readl(&preg->EP_REGS[num].EP_LEN_DCNT) & EPN_LDATA;
+	i_recv_length =
+		_nbu2ss_readl(&preg->EP_REGS[num].EP_LEN_DCNT) & EPN_LDATA;
 
 	if (i_recv_length != 0) {
 		result = _nbu2ss_epn_out_data(udc, ep, req, i_recv_length);
@@ -1013,13 +989,11 @@ static int _nbu2ss_epn_out_transfer(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_in_dma(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		num,
-	u32		length
-)
+static int _nbu2ss_in_dma(struct nbu2ss_udc *udc,
+			  struct nbu2ss_ep *ep,
+			  struct nbu2ss_req *req,
+			  u32 num,
+			  u32 length)
 {
 	dma_addr_t	p_buffer;
 	u32		mpkt;		/* MaxPacketSize */
@@ -1089,12 +1063,10 @@ static int _nbu2ss_in_dma(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_in_pio(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		length
-)
+static int _nbu2ss_epn_in_pio(struct nbu2ss_udc *udc,
+			      struct nbu2ss_ep *ep,
+			      struct nbu2ss_req *req,
+			      u32 length)
 {
 	u8		*p_buffer;
 	u32		i;
@@ -1142,12 +1114,10 @@ static int _nbu2ss_epn_in_pio(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_in_data(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	u32		data_size
-)
+static int _nbu2ss_epn_in_data(struct nbu2ss_udc *udc,
+			       struct nbu2ss_ep *ep,
+			       struct nbu2ss_req *req,
+			       u32 data_size)
 {
 	u32		num;
 	int		nret = 1;
@@ -1169,11 +1139,9 @@ static int _nbu2ss_epn_in_data(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_epn_in_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req
-)
+static int _nbu2ss_epn_in_transfer(struct nbu2ss_udc *udc,
+				   struct nbu2ss_ep *ep,
+				   struct nbu2ss_req *req)
 {
 	u32		num;
 	u32		i_buf_size;
@@ -1210,11 +1178,10 @@ static int _nbu2ss_epn_in_transfer(
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_start_transfer(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	bool	bflag)
+static int _nbu2ss_start_transfer(struct nbu2ss_udc *udc,
+				  struct nbu2ss_ep *ep,
+				  struct nbu2ss_req *req,
+				  bool bflag)
 {
 	int		nret = -EINVAL;
 
@@ -1289,9 +1256,7 @@ static void _nbu2ss_restert_transfer(struct nbu2ss_ep *ep)
 
 /*-------------------------------------------------------------------------*/
 /*	Endpoint Toggle Reset */
-static void _nbu2ss_endpoint_toggle_reset(
-	struct nbu2ss_udc *udc,
-	u8 ep_adrs)
+static void _nbu2ss_endpoint_toggle_reset(struct nbu2ss_udc *udc, u8 ep_adrs)
 {
 	u8		num;
 	u32		data;
@@ -1311,10 +1276,8 @@ static void _nbu2ss_endpoint_toggle_reset(
 
 /*-------------------------------------------------------------------------*/
 /*	Endpoint STALL set */
-static void _nbu2ss_set_endpoint_stall(
-	struct nbu2ss_udc *udc,
-	u8 ep_adrs,
-	bool bstall)
+static void _nbu2ss_set_endpoint_stall(struct nbu2ss_udc *udc,
+				       u8 ep_adrs, bool bstall)
 {
 	u8		num, epnum;
 	u32		data;
@@ -1389,11 +1352,9 @@ static void _nbu2ss_set_test_mode(struct nbu2ss_udc *udc, u32 mode)
 }
 
 /*-------------------------------------------------------------------------*/
-static int _nbu2ss_set_feature_device(
-	struct nbu2ss_udc *udc,
-	u16 selector,
-	u16 wIndex
-)
+static int _nbu2ss_set_feature_device(struct nbu2ss_udc *udc,
+				      u16 selector,
+				      u16 wIndex)
 {
 	int	result = -EOPNOTSUPP;
 
@@ -1473,12 +1434,11 @@ static inline int _nbu2ss_req_feature(struct nbu2ss_udc *udc, bool bset)
 			if (selector == USB_ENDPOINT_HALT) {
 				ep_adrs = wIndex & 0xFF;
 				if (!bset) {
-					_nbu2ss_endpoint_toggle_reset(
-						udc, ep_adrs);
+					_nbu2ss_endpoint_toggle_reset(udc,
+								      ep_adrs);
 				}
 
-				_nbu2ss_set_endpoint_stall(
-					udc, ep_adrs, bset);
+				_nbu2ss_set_endpoint_stall(udc, ep_adrs, bset);
 
 				result = 0;
 			}
@@ -1509,10 +1469,7 @@ static inline enum usb_device_speed _nbu2ss_get_speed(struct nbu2ss_udc *udc)
 }
 
 /*-------------------------------------------------------------------------*/
-static void _nbu2ss_epn_set_stall(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep
-)
+static void _nbu2ss_epn_set_stall(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 {
 	u8	ep_adrs;
 	u32	regdata;
@@ -1884,10 +1841,9 @@ static inline void _nbu2ss_ep0_int(struct nbu2ss_udc *udc)
 }
 
 /*-------------------------------------------------------------------------*/
-static void _nbu2ss_ep_done(
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req,
-	int status)
+static void _nbu2ss_ep_done(struct nbu2ss_ep *ep,
+			    struct nbu2ss_req *req,
+			    int status)
 {
 	struct nbu2ss_udc *udc = ep->udc;
 
@@ -1918,10 +1874,9 @@ static void _nbu2ss_ep_done(
 }
 
 /*-------------------------------------------------------------------------*/
-static inline void _nbu2ss_epn_in_int(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req)
+static inline void _nbu2ss_epn_in_int(struct nbu2ss_udc *udc,
+				      struct nbu2ss_ep *ep,
+				      struct nbu2ss_req *req)
 {
 	int	result = 0;
 	u32	status;
@@ -1962,10 +1917,9 @@ static inline void _nbu2ss_epn_in_int(
 }
 
 /*-------------------------------------------------------------------------*/
-static inline void _nbu2ss_epn_out_int(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req)
+static inline void _nbu2ss_epn_out_int(struct nbu2ss_udc *udc,
+				       struct nbu2ss_ep *ep,
+				       struct nbu2ss_req *req)
 {
 	int	result;
 
@@ -1975,10 +1929,9 @@ static inline void _nbu2ss_epn_out_int(
 }
 
 /*-------------------------------------------------------------------------*/
-static inline void _nbu2ss_epn_in_dma_int(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req)
+static inline void _nbu2ss_epn_in_dma_int(struct nbu2ss_udc *udc,
+					  struct nbu2ss_ep *ep,
+					  struct nbu2ss_req *req)
 {
 	u32		mpkt;
 	u32		size;
@@ -2012,10 +1965,9 @@ static inline void _nbu2ss_epn_in_dma_int(
 }
 
 /*-------------------------------------------------------------------------*/
-static inline void _nbu2ss_epn_out_dma_int(
-	struct nbu2ss_udc *udc,
-	struct nbu2ss_ep *ep,
-	struct nbu2ss_req *req)
+static inline void _nbu2ss_epn_out_dma_int(struct nbu2ss_udc *udc,
+					   struct nbu2ss_ep *ep,
+					   struct nbu2ss_req *req)
 {
 	int		i;
 	u32		num;
@@ -2480,9 +2432,8 @@ static irqreturn_t _nbu2ss_udc_irq(int irq, void *_udc)
 
 /*-------------------------------------------------------------------------*/
 /* usb_ep_ops */
-static int nbu2ss_ep_enable(
-	struct usb_ep *_ep,
-	const struct usb_endpoint_descriptor *desc)
+static int nbu2ss_ep_enable(struct usb_ep *_ep,
+			    const struct usb_endpoint_descriptor *desc)
 {
 	u8		ep_type;
 	unsigned long	flags;
@@ -2570,9 +2521,8 @@ static int nbu2ss_ep_disable(struct usb_ep *_ep)
 }
 
 /*-------------------------------------------------------------------------*/
-static struct usb_request *nbu2ss_ep_alloc_request(
-	struct usb_ep *ep,
-	gfp_t gfp_flags)
+static struct usb_request *nbu2ss_ep_alloc_request(struct usb_ep *ep,
+						   gfp_t gfp_flags)
 {
 	struct nbu2ss_req *req;
 
@@ -2589,9 +2539,8 @@ static struct usb_request *nbu2ss_ep_alloc_request(
 }
 
 /*-------------------------------------------------------------------------*/
-static void nbu2ss_ep_free_request(
-	struct usb_ep *_ep,
-	struct usb_request *_req)
+static void nbu2ss_ep_free_request(struct usb_ep *_ep,
+				   struct usb_request *_req)
 {
 	struct nbu2ss_req *req;
 
@@ -2603,10 +2552,8 @@ static void nbu2ss_ep_free_request(
 }
 
 /*-------------------------------------------------------------------------*/
-static int nbu2ss_ep_queue(
-	struct usb_ep *_ep,
-	struct usb_request *_req,
-	gfp_t gfp_flags)
+static int nbu2ss_ep_queue(struct usb_ep *_ep, struct usb_request *_req,
+			   gfp_t gfp_flags)
 {
 	struct nbu2ss_req	*req;
 	struct nbu2ss_ep	*ep;
@@ -2666,9 +2613,9 @@ static int nbu2ss_ep_queue(
 
 	if (req->unaligned) {
 		if (!ep->virt_buf)
-			ep->virt_buf = dma_alloc_coherent(
-				NULL, PAGE_SIZE,
-				&ep->phys_buf, GFP_ATOMIC | GFP_DMA);
+			ep->virt_buf = dma_alloc_coherent(NULL, PAGE_SIZE,
+							  &ep->phys_buf,
+							  GFP_ATOMIC | GFP_DMA);
 		if (ep->epnum > 0)  {
 			if (ep->direct == USB_DIR_IN)
 				memcpy(ep->virt_buf, req->req.buf,
@@ -2710,9 +2657,8 @@ static int nbu2ss_ep_queue(
 }
 
 /*-------------------------------------------------------------------------*/
-static int nbu2ss_ep_dequeue(
-	struct usb_ep *_ep,
-	struct usb_request *_req)
+static int nbu2ss_ep_dequeue(struct usb_ep *_ep,
+			     struct usb_request *_req)
 {
 	struct nbu2ss_req	*req;
 	struct nbu2ss_ep	*ep;
@@ -3023,10 +2969,9 @@ static int nbu2ss_gad_pullup(struct usb_gadget *pgadget, int is_on)
 }
 
 /*-------------------------------------------------------------------------*/
-static int nbu2ss_gad_ioctl(
-	struct usb_gadget *pgadget,
-	unsigned int code,
-	unsigned long param)
+static int nbu2ss_gad_ioctl(struct usb_gadget *pgadget,
+			    unsigned int code,
+			    unsigned long param)
 {
 	return 0;
 }
@@ -3115,9 +3060,8 @@ static void nbu2ss_drv_ep_init(struct nbu2ss_udc *udc)
 
 /*-------------------------------------------------------------------------*/
 /* platform_driver */
-static int nbu2ss_drv_contest_init(
-	struct platform_device *pdev,
-	struct nbu2ss_udc *udc)
+static int nbu2ss_drv_contest_init(struct platform_device *pdev,
+				   struct nbu2ss_udc *udc)
 {
 	spin_lock_init(&udc->lock);
 	udc->dev = &pdev->dev;
-- 
2.7.4

