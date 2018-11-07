Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB435C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7249520818
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 20:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QMySEWRa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7249520818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeKHGQx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 01:16:53 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36630 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727239AbeKHGQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 01:16:52 -0500
Received: by mail-wr1-f65.google.com with SMTP id z13-v6so16489352wrs.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 12:44:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=PPHu2cuWqaQ4UGNsV5wgdsnUaJifCNeGtC7EVKbzhzE=;
        b=QMySEWRaA81W6bMldJGliyG0Ir6cS/hAs/M8+r0/jzPUgc/ufml0qIBX1qoOsSUW8w
         flx/9qMERxGfnGOd6dO8rTBIAWyI0yYKmJkfxTyQvTj4TQjo3I+HS8cCuwa0kEjk+1o8
         OTt1XyuG+XLH4IAGjlGxb6Lj+CWpNe6pudfrtZJLm6mz9Cfc0FJzWYWb9aNGnjw5pfby
         1r80xiiHbkuUJCEZxuoi1rh4trZyNlRp2375p4yepWpBKUGI76lB+RTa1qhz2lx5bHjt
         yK2XK/9E/ai4Zx9yWJT7Hvty0DNybDpAag+A4yJ1duMl9g3gRklQ0jn5ssYxkMElgGAF
         2bwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=PPHu2cuWqaQ4UGNsV5wgdsnUaJifCNeGtC7EVKbzhzE=;
        b=cx/GSlTQq50MGriTsS+BydLwOCAN6Zh5TfgYXP6J8sL9HzqrsiB1ibh8fux91LlxpG
         k6dVA+GmnxLF0aEEnF71zYURYVYkdeTn++Rj1uxS77edfdQuPGZJZCaLkBZtt79pLgX5
         iSLQNNS8YDDBUEzR42T3Dp7A57JmzR/wMeii4qB5G/ARWiIOR2s5DlM2grkV6Nn/fKg2
         SkiV9KNTvV8gQgbgRLgpla297JQXpjgd42Kfcf8uounoo3RGOKyt+LzgFHZLgw0bRaE1
         Oh8QU1lEUEpd6u9vlGz/f0vTrqKTTt9Q7wuz8JSPy0QXh1krVmi154OCVRtGZqccM3oH
         /+Kw==
X-Gm-Message-State: AGRZ1gK0jufVxqJv1duXEz41+Nm2dOT+3V5Uv5qeyatcSz/4YnCQ7TYv
        f0YcNhopHnkguRaGT5PCE7o=
X-Google-Smtp-Source: AJdET5d6C9BSrDp8K51nLiSwc3vJC8FFZ3VTLiavdNGhjSCW186UxM2z1KectpYidix2vRS8xDV8Mw==
X-Received: by 2002:a05:6000:10c4:: with SMTP id b4mr1665018wrx.135.1541623486112;
        Wed, 07 Nov 2018 12:44:46 -0800 (PST)
Received: from osboxes.localdomain (bzq-79-178-252-231.red.bezeqint.net. [79.178.252.231])
        by smtp.googlemail.com with ESMTPSA id y2-v6sm3578764wrh.53.2018.11.07.12.44.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Nov 2018 12:44:45 -0800 (PST)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     carmeli.tamir@gmail.com, gregkh@linuxfoundation.org,
        natechancellor@gmail.com, chrisadr@gentoo.org,
        areklis909@gmail.com, dan.carpenter@oracle.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: emxx_udc: Added missing le16_to_cpu conversions
Date:   Wed,  7 Nov 2018 15:44:24 -0500
Message-Id: <1541623464-49041-4-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541623464-49041-1-git-send-email-carmeli.tamir@gmail.com>
References: <1541623464-49041-1-git-send-email-carmeli.tamir@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed sparse tool warnings due to missing convesion from
le16 to cpu endienness. 

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 3504277..bf7c5da 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
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
@@ -1449,8 +1451,8 @@ static inline int _nbu2ss_req_feature(struct nbu2ss_udc *udc, bool bset)
 {
 	u8	recipient = (u8)(udc->ctrl.bRequestType & USB_RECIP_MASK);
 	u8	direction = (u8)(udc->ctrl.bRequestType & USB_DIR_IN);
-	u16	selector  = udc->ctrl.wValue;
-	u16	wIndex    = udc->ctrl.wIndex;
+	u16	selector  = le16_to_cpu(udc->ctrl.wValue);
+	u16	wIndex    = le16_to_cpu(udc->ctrl.wIndex);
 	u8	ep_adrs;
 	int	result = -EOPNOTSUPP;
 
@@ -1549,8 +1551,8 @@ static int std_req_get_status(struct nbu2ss_udc *udc)
 	if ((udc->ctrl.wValue != 0x0000) || (direction != USB_DIR_IN))
 		return result;
 
-	length = min_t(u16, udc->ctrl.wLength, sizeof(status_data));
-
+	length =
+		min_t(u16, le16_to_cpu(udc->ctrl.wLength), sizeof(status_data));
 	switch (recipient) {
 	case USB_RECIP_DEVICE:
 		if (udc->ctrl.wIndex == 0x0000) {
@@ -1565,8 +1567,8 @@ static int std_req_get_status(struct nbu2ss_udc *udc)
 		break;
 
 	case USB_RECIP_ENDPOINT:
-		if (0x0000 == (udc->ctrl.wIndex & 0xFF70)) {
-			ep_adrs = (u8)(udc->ctrl.wIndex & 0xFF);
+		if (0x0000 == (le16_to_cpu(udc->ctrl.wIndex) & 0xFF70)) {
+			ep_adrs = (u8)(le16_to_cpu(udc->ctrl.wIndex) & 0xFF);
 			result = _nbu2ss_get_ep_stall(udc, ep_adrs);
 
 			if (result > 0)
@@ -1606,7 +1608,7 @@ static int std_req_set_feature(struct nbu2ss_udc *udc)
 static int std_req_set_address(struct nbu2ss_udc *udc)
 {
 	int		result = 0;
-	u32		wValue = udc->ctrl.wValue;
+	u32		wValue = le16_to_cpu(udc->ctrl.wValue);
 
 	if ((udc->ctrl.bRequestType != 0x00)	||
 	    (udc->ctrl.wIndex != 0x0000)	||
@@ -1628,7 +1630,7 @@ static int std_req_set_address(struct nbu2ss_udc *udc)
 /*-------------------------------------------------------------------------*/
 static int std_req_set_configuration(struct nbu2ss_udc *udc)
 {
-	u32 config_value = (u32)(udc->ctrl.wValue & 0x00ff);
+	u32 config_value = (u32)(le16_to_cpu(udc->ctrl.wValue) & 0x00ff);
 
 	if ((udc->ctrl.wIndex != 0x0000)	||
 	    (udc->ctrl.wLength != 0x0000)	||
-- 
2.7.4

