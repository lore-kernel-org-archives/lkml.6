Return-Path: <SRS0=Fmhj=NM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880C3C0044C
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536D220657
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Nov 2018 20:00:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rKZuolnj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 536D220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbeKBFE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 01:04:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37369 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbeKBFE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 01:04:26 -0400
Received: by mail-wr1-f68.google.com with SMTP id z3-v6so2416128wru.4
        for <linux-kernel@vger.kernel.org>; Thu, 01 Nov 2018 13:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rMVJh6bR6geAlSbO0BhKCSshyBQEALavCUkKl/fWNN0=;
        b=rKZuolnjXGy9HbWr4MzMmW+u3QfXWWFmcTiEENN0oSIUQYWL2IHAtY+34CvQL6GfFN
         MY/+qlzFUiAXtY3W6Xdl/5W9ul8oCRzVIzYvHGLK0peF98OqUFpvKKBePgtWnx6XssCP
         DFWYuEOafq6EoJpwErlcaaTHf7diifw7sbcS9cg80WS0bcmxEkS/VItaFhAoDe5E0+7Q
         6hKLA/kaFBm/IyDaKLxmujRaDTAjn9bKkPPfYceysLGI1WY4duCnB4eYjDxG4nOJnQuA
         p7LRmzUhjv2bSE/kzO2ZwPJOdP/1WEqeoO3to36G1fUqoLUrSvwX+8HCZvBEMeBwomfk
         p/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rMVJh6bR6geAlSbO0BhKCSshyBQEALavCUkKl/fWNN0=;
        b=GFGu+3ByglQHH0dRwbzMx/0Oehqc3j/q8YfyStC4PGndaYjwoP/0voh7lGdArd0imL
         ZV7ppUI9eREsbLpAds0EcHv7fGMvydSU5Q9F+tfVs/HGtTzN9HchrkOTb/XTXLX2OC3W
         AkVZJLtmJW7lUQPTT4i3zW5txPNcIU8ticFgWIwVGSs9tDuEzZ6w9gGNPAHzNlB3j8lF
         5H0W+7BCRGlWsgW4H8tUguws7D/uhUzbjKuneua6V5TL0W1i0v7Lz+gSusB9Dkkadjme
         /pT5DNihHZ0hzWVwwuY0mulHgrjz4BBB4vB8oG/dx/RZiDX9IQu4Mz/iSOfakQfKXTth
         iX9Q==
X-Gm-Message-State: AGRZ1gK0k8jiTEZJOICtEZ5K701IJRGtPjuIxKZL6APb51e9iYFuLov6
        lxfdK4YyEqdp+sqLgfW1v+w=
X-Google-Smtp-Source: AJdET5cTbizhKmnNEviLG/N6TNNLXtly0YxvhZpWnXiEjOuSWcU2HFW4aAqmt/GdmaaP2uv9GG8Xlg==
X-Received: by 2002:adf:9d1f:: with SMTP id k31-v6mr8211076wre.18.1541102399508;
        Thu, 01 Nov 2018 12:59:59 -0700 (PDT)
Received: from osboxes.localdomain (bzq-79-178-252-231.red.bezeqint.net. [79.178.252.231])
        by smtp.googlemail.com with ESMTPSA id d6-v6sm30658355wro.72.2018.11.01.12.59.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Nov 2018 12:59:58 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Cc:     areklis909@gmail.com, natechancellor@gmail.com,
        dan.carpenter@oracle.com, chrisadr@gentoo.org,
        Carmeli Tamir <carmeli.tamir@gmail.com>
Subject: [PATCH 3/3] Added missing le16_to_cpu conversions
Date:   Thu,  1 Nov 2018 15:59:50 -0400
Message-Id: <1541102390-51571-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed sparse tool warnings due to missing convesion from 
le16 to cpu endienness. Previously posted without any feedback,
now updated according to master.

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

