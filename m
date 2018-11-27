Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639A2C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05F6F21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 20:58:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWY9r7Qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F6F21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbeK1H51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 02:57:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:52680 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbeK1H50 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 02:57:26 -0500
Received: by mail-wm1-f67.google.com with SMTP id r11-v6so412886wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Nov 2018 12:58:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZT6KHyVeH1ZlCcLiLBLBWzKMokzn1AsoCDJFYthvj00=;
        b=BWY9r7Qx85hLbS7lxsQpqP4/reHNYrPec3jXgNvCkAh+33ao4ohY2jF6gl33KsGMKI
         8xElyXoiE4QDSaVajwFNlC/FuT1t6x8vXJ+IYnmbw7jka4sZtb8jHci5tpsiseq2To3S
         LI9HzNRIat3E6AUtbSoNwiTajRQe9tw+vNTRD6kQqCSZGmvzPaZ9lO7ykHNlke2Zf/sU
         aGYf4ljIZyqzrx8PQAXYzJwHGpd2e1S7r3JIHfPwvqgcmYy/NV/kaxu/PsGUfRkHcvZE
         0AsBreYiMNj1KxoauybHktrPw2KMrvQmsUjOcxrv0iIrYSIwVBylEt2DRSjGCvNPThF8
         mzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZT6KHyVeH1ZlCcLiLBLBWzKMokzn1AsoCDJFYthvj00=;
        b=oWWUfQsQE8QXC4IGq/WaYKVcZvnPpsWGy5+abgiP9ShQlz9qA0m1G8jn9aeTfJAcHC
         nUe/wnZleJtdcvTz+keXUFDrjRk2DwNYaNF3hHhRUI1REcWtgaGiBEfovXvlhqVOm9L+
         jRKZztKGXdz0x7kWiVDzoYisDBaoCD4kl5RQSRf6MiGv/zSRr4PLQ3ssdbIc54ArEeq9
         K+6P9U55Q9nNyFLMyjA68jVOHG136nmblRE6hSLt8YGy8hFDb+k87tnzU6gfJ6m2h8iD
         5gTIikIBFqs3bgGPppEm+QybzF/9M0yIYgJwOz1zBGcqAjVy/ogAjCQmF9LjOxybrwVG
         6i/w==
X-Gm-Message-State: AA+aEWZXjsydA6f9jIhwCprHywANvfUDlEFZIjfK6phkglJvlhTq/lAv
        o6WGStiW0SDGZAxZD3PgQtlS4Jl58h+E7g==
X-Google-Smtp-Source: AFSGD/Xuzy9VHjqmqTd+4txgeW4WUgy92456jQ20EMLPF3kH7Izm7Nobsyy+h3IaLzdjm516cLPaZQ==
X-Received: by 2002:a1c:a017:: with SMTP id j23mr429806wme.40.1543352295498;
        Tue, 27 Nov 2018 12:58:15 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id 185sm244018wmx.41.2018.11.27.12.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Nov 2018 12:58:14 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     Cristian Sicilia <sicilia.cristian@gmail.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: emxx_udc: Align parameter with parenthesis
Date:   Tue, 27 Nov 2018 21:57:16 +0100
Message-Id: <1543352237-1978-2-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1543352237-1978-1-git-send-email-sicilia.cristian@gmail.com>
References: <1543274351-25762-3-git-send-email-sicilia.cristian@gmail.com>
 <1543352237-1978-1-git-send-email-sicilia.cristian@gmail.com>
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

