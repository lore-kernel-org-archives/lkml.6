Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE658C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB7232089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 23:46:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uHbVOOHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB7232089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730854AbeKQKBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 17 Nov 2018 05:01:04 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55323 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729498AbeKQKBD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Nov 2018 05:01:03 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so163627wmc.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 15:46:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WqdAi7m1SIo/lwRwHeLqNIFNRP+8zzyV+OQG/IfZ60s=;
        b=uHbVOOHPIdH931ZsK0LxaDE7qTCLFDKJURJw6F54p3iTZAeBwGI6X1/YZjZX0r8a7q
         z4O4tipzpUG7H6Ya4YB79/hOCYvbiO9kQaves6eRJLz26f0eFH461pGciIHOVo6HVKn/
         sV1eOMcZmDu0wF66TOxyoEc4U8I3xC4YodKiaOUOAno3khGYE9nVVWjb5q7PgyFVRZXA
         4RV/WORwxrhfO+VCJpnR0n8CtlMlJoYvQnJVsVu5A5ibampZmHSp96p+RjLiWRZ1GyJz
         gNIzg0zb/XeltiF+eYI2y9gImQg1VtCqNPEdshI+cSIht+RW1JcwOyY69TzeFytvN79X
         GUxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WqdAi7m1SIo/lwRwHeLqNIFNRP+8zzyV+OQG/IfZ60s=;
        b=dgFtIYcY507QiIC1xqK5n6X05Otyug5nqS89MZfITIXZQgLw4fu8DmL+CG6NBxz1nK
         8ZSQ5r+mtA0cgyj2gCIPt0rD6Is4RaSCZExKPxwoztg9wb0JxnRVEsSaSjBLCzJrj9ju
         /g1MqRhWtHiEMBRAep4DqEZN7lSNz9zzgDEShbyPE1+en8ei6GR0dcBbqB2qKLBM+Irx
         WBklrfvH0RxOq0uAQBh7VzYW2lp5LzOSQG8uVyX0wuYltv/KJi2oHGmu4ILWU2WhU7SA
         btXmTy0hUIZrlicNLohf3FgpEgPfIFv+BGof6BxZgj25gRExw8gE21X5s15lJ7Q3CmCu
         RoTQ==
X-Gm-Message-State: AGRZ1gLTw/QSLwCAUCpyti/vIfRgU147J2eSI1XL7Nf1GnTr+2YkCU59
        fO6tMc4vztseN9KtjclzDdg=
X-Google-Smtp-Source: AJdET5cZQsEml7if58uvQ8uB5mDbHXfu3F4sis96ek4JFx+XCJhkMesxmBnpv0Noh3+A8UxGMiE2og==
X-Received: by 2002:a1c:9710:: with SMTP id z16-v6mr189120wmd.60.1542411994628;
        Fri, 16 Nov 2018 15:46:34 -0800 (PST)
Received: from localhost (host102-98-dynamic.181-80-r.retail.telecomitalia.it. [80.181.98.102])
        by smtp.gmail.com with ESMTPSA id q2sm11748210wru.56.2018.11.16.15.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Nov 2018 15:46:34 -0800 (PST)
From:   Cristian Sicilia <sicilia.cristian@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Carmeli Tamir <carmeli.tamir@gmail.com>,
        Cristian Sicilia <sicilia.cristian@gmail.com>,
        Christopher Diaz Riveros <chrisadr@gentoo.org>,
        Arkadiusz Lis <areklis909@gmail.com>,
        Nathan Chancellor <natechancellor@gmail.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] staging: emxx_udc: Split line and fix eol parenthesis
Date:   Sat, 17 Nov 2018 00:46:06 +0100
Message-Id: <1542411969-26570-2-git-send-email-sicilia.cristian@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1542411969-26570-1-git-send-email-sicilia.cristian@gmail.com>
References: <1542411969-26570-1-git-send-email-sicilia.cristian@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some parenthesis opened at end of line.

Signed-off-by: Cristian Sicilia <sicilia.cristian@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 73 ++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index bf7c5da..26bd77c 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -108,20 +108,20 @@ static void _nbu2ss_dump_register(struct nbu2ss_udc *udc)
 
 	dev_dbg(&udc->dev, "\n-USB REG-\n");
 	for (i = 0x0 ; i < USB_BASE_SIZE ; i += 16) {
-		reg_data =   _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i));
+		reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
+					i));
 		dev_dbg(&udc->dev, "USB%04x =%08x", i, (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 4));
+		reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
+					i + 4));
 		dev_dbg(&udc->dev, " %08x", (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 8));
+		reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
+					i + 8));
 		dev_dbg(&udc->dev, " %08x", (int)reg_data);
 
-		reg_data =  _nbu2ss_readl(
-			(u32 *)IO_ADDRESS(USB_BASE_ADDRESS + i + 12));
+		reg_data = _nbu2ss_readl((u32 *)IO_ADDRESS(USB_BASE_ADDRESS +
+					i + 12));
 		dev_dbg(&udc->dev, " %08x\n", (int)reg_data);
 	}
 
@@ -473,22 +473,23 @@ static void _nbu2ss_dma_map_single(
 		if (req->unaligned) {
 			req->req.dma = ep->phys_buf;
 		} else {
-			req->req.dma = dma_map_single(
-				udc->gadget.dev.parent,
-				req->req.buf,
-				req->req.length,
-				(direct == USB_DIR_IN)
-				? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+			req->req.dma =
+				dma_map_single(udc->gadget.dev.parent,
+					       req->req.buf,
+					       req->req.length,
+					       (direct == USB_DIR_IN) ?
+						DMA_TO_DEVICE :
+						DMA_FROM_DEVICE);
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
+						   (direct == USB_DIR_IN)
+						    ? DMA_TO_DEVICE :
+						    DMA_FROM_DEVICE);
 
 		req->mapped = 0;
 	}
@@ -975,8 +976,8 @@ static int _nbu2ss_epn_out_transfer(
 
 	/*-------------------------------------------------------------*/
 	/* Receive Length */
-	i_recv_length
-		= _nbu2ss_readl(&preg->EP_REGS[num].EP_LEN_DCNT) & EPN_LDATA;
+	i_recv_length =
+		_nbu2ss_readl(&preg->EP_REGS[num].EP_LEN_DCNT) & EPN_LDATA;
 
 	if (i_recv_length != 0) {
 		result = _nbu2ss_epn_out_data(udc, ep, req, i_recv_length);
@@ -1115,10 +1116,9 @@ static int _nbu2ss_epn_in_pio(
 		i_word_length = length / sizeof(u32);
 		if (i_word_length > 0) {
 			for (i = 0; i < i_word_length; i++) {
-				_nbu2ss_writel(
-					&preg->EP_REGS[ep->epnum - 1].EP_WRITE
-					, p_buf_32->dw
-				);
+				_nbu2ss_writel(&preg->EP_REGS[ep->epnum -
+							      1].EP_WRITE,
+					       p_buf_32->dw);
 
 				p_buf_32++;
 			}
@@ -1472,13 +1472,11 @@ static inline int _nbu2ss_req_feature(struct nbu2ss_udc *udc, bool bset)
 		if (0x0000 == (wIndex & 0xFF70)) {
 			if (selector == USB_ENDPOINT_HALT) {
 				ep_adrs = wIndex & 0xFF;
-				if (!bset) {
-					_nbu2ss_endpoint_toggle_reset(
-						udc, ep_adrs);
-				}
+				if (!bset)
+					_nbu2ss_endpoint_toggle_reset(udc,
+								      ep_adrs);
 
-				_nbu2ss_set_endpoint_stall(
-					udc, ep_adrs, bset);
+				_nbu2ss_set_endpoint_stall(udc, ep_adrs, bset);
 
 				result = 0;
 			}
@@ -1524,8 +1522,8 @@ static void _nbu2ss_epn_set_stall(
 		for (limit_cnt = 0
 			; limit_cnt < IN_DATA_EMPTY_COUNT
 			; limit_cnt++) {
-			regdata = _nbu2ss_readl(
-				&preg->EP_REGS[ep->epnum - 1].EP_STATUS);
+			regdata = _nbu2ss_readl(&preg->EP_REGS[ep->epnum -
+							       1].EP_STATUS);
 
 			if ((regdata & EPN_IN_DATA) == 0)
 				break;
@@ -2666,9 +2664,10 @@ static int nbu2ss_ep_queue(
 
 	if (req->unaligned) {
 		if (!ep->virt_buf)
-			ep->virt_buf = dma_alloc_coherent(
-				NULL, PAGE_SIZE,
-				&ep->phys_buf, GFP_ATOMIC | GFP_DMA);
+			ep->virt_buf = dma_alloc_coherent(NULL,
+							  PAGE_SIZE,
+							  &ep->phys_buf,
+							  GFP_ATOMIC | GFP_DMA);
 		if (ep->epnum > 0)  {
 			if (ep->direct == USB_DIR_IN)
 				memcpy(ep->virt_buf, req->req.buf,
-- 
2.7.4

