Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3804ECDE32
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97CDD2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 21:02:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FDINLSN0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97CDD2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbeJRE75 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 00:59:57 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36388 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727082AbeJRE75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 00:59:57 -0400
Received: by mail-wm1-f68.google.com with SMTP id a8-v6so3588844wmf.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Oct 2018 14:02:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=aicaiNJMkuA9Rzz8bWtQREiVnn2V50LluzWfPczsSW4=;
        b=FDINLSN0IRfmlB5Dk3ZeeTrHdxVcbe9Ia6dA9C0qiOx8vdhcwzgXNee3VY1ep7Hi0T
         UQiVdMNklGEQuzAX9q2tkpnV5aiiwLI6nDLQmI25ctcyQLh5R3uxsBuvsaOtBEhjF92k
         KBYPc/4Znd7nq/5et+ctl3NuNicX2TafpjDK6Lsq/Fa3KqcJlLSCYcPkHIE97SEQzL8U
         MYoHpOBW1N7owUCYxQkp9iKXecJI0IOlAwmL+VsDgHuMoFyshtzuU7n44Gk81qNWht5W
         2+uSjPLUdklk2RFwoVq6Kh7GrlOfU0V3hATuvdEPe5pLEE06Moz6M7WUQEeUPGOhCVfe
         2blA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=aicaiNJMkuA9Rzz8bWtQREiVnn2V50LluzWfPczsSW4=;
        b=gjQc9t/SWcqvEJY4rHTeh5vD4zG2bSzkt5dLsixXKniVW9gNmAYmtSN5R/zNzm2b9Z
         x6+ij+3vNW0Xv2pZyv8xI7bmwRiVAtbPHJUTNg1KIHPjAQ6Ipsvw9UUEyjvfJJIC98km
         y0JeQe9aX/BmvJyKYb7K9k5s5yYP/JpLGnCLBMzEiYmT1Sl49S3XiPRUyzEv/Gj+Fbmi
         BDls1QDsB0RCacPcOdzBhWDF1Auuz7TOnLv0juQu0J6Z3kBPUHDfePqH28MfgedU7KXA
         2P03pct1ES4BdW3Fzz1Pa2M5BpmCp7XRG7EmFl6akUEXuvdwkDvMv4oHIFPT/3EtOkXL
         t5bA==
X-Gm-Message-State: ABuFfoivQ4qv/KKnat/n3zlI1fAiVN31gU9bm1RHnYe+0uhiS9G3mOMq
        bWwz+BYM1w0tEwNfUL+ExWI=
X-Google-Smtp-Source: ACcGV60aGdH63VW6PblkJehXuwTzGBgtq4h1xwW9/gvNa4cxsrkSR8vGsOH1abzM5Pha7m/djp2V0Q==
X-Received: by 2002:a1c:3403:: with SMTP id b3-v6mr4430876wma.108.1539810146082;
        Wed, 17 Oct 2018 14:02:26 -0700 (PDT)
Received: from osboxes.localdomain (bzq-109-65-231-165.red.bezeqint.net. [109.65.231.165])
        by smtp.googlemail.com with ESMTPSA id 143-v6sm4874348wmv.6.2018.10.17.14.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Oct 2018 14:02:25 -0700 (PDT)
From:   Carmeli Tamir <carmeli.tamir@gmail.com>
To:     gregkh@linuxfoundation.org, dan.carpenter@oracle.com,
        chrisadr@gentoo.org
Cc:     carmeli.tamir@gmail.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] staging: emxx_udc: Added missing le16_to_cpu conversions
Date:   Wed, 17 Oct 2018 17:02:19 -0400
Message-Id: <1539810139-11920-1-git-send-email-carmeli.tamir@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed sparse tool warnings due to missing convesion from 
le16 to cpu endienness.

Signed-off-by: Carmeli Tamir <carmeli.tamir@gmail.com>
---
 drivers/staging/emxx_udc/emxx_udc.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index 344fe80..03df1bc 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -135,6 +135,7 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
 {
 	u8		recipient;
 	u16		selector;
+	u16             wIndex;
 	u32		test_mode;
 	struct usb_ctrlrequest	*p_ctrl;
 	struct nbu2ss_udc *udc;
@@ -149,10 +150,12 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
 			/*-------------------------------------------------*/
 			/* SET_FEATURE */
 			recipient = (u8)(p_ctrl->bRequestType & USB_RECIP_MASK);
-			selector  = p_ctrl->wValue;
+			selector  = le16_to_cpu(p_ctrl->wValue);
 			if ((recipient == USB_RECIP_DEVICE) &&
 			    (selector == USB_DEVICE_TEST_MODE)) {
 				test_mode = (u32)(p_ctrl->wIndex >> 8);
+				wIndex = le16_to_cpu(p_ctrl->wIndex);
+				test_mode = (u32)(wIndex >> 8);
 				_nbu2ss_set_test_mode(udc, test_mode);
 			}
 		}
@@ -1380,7 +1383,7 @@ static struct usb_device_descriptor device_desc = {
 	.bMaxPacketSize0      = 64,
 	.idVendor             = cpu_to_le16(0x0409),
 	.idProduct            = cpu_to_le16(0xfff0),
-	.bcdDevice            = 0xffff,
+	.bcdDevice            = cpu_to_le16(0xffff),
 	.iManufacturer        = 0x00,
 	.iProduct             = 0x00,
 	.iSerialNumber        = 0x00,
@@ -1468,8 +1471,8 @@ static inline int _nbu2ss_req_feature(struct nbu2ss_udc *udc, bool bset)
 {
 	u8	recipient = (u8)(udc->ctrl.bRequestType & USB_RECIP_MASK);
 	u8	direction = (u8)(udc->ctrl.bRequestType & USB_DIR_IN);
-	u16	selector  = udc->ctrl.wValue;
-	u16	wIndex    = udc->ctrl.wIndex;
+	u16	selector  = le16_to_cpu(udc->ctrl.wValue);
+	u16	wIndex    = le16_to_cpu(udc->ctrl.wIndex);
 	u8	ep_adrs;
 	int	result = -EOPNOTSUPP;
 
@@ -1568,7 +1571,8 @@ static int std_req_get_status(struct nbu2ss_udc *udc)
 	if ((udc->ctrl.wValue != 0x0000) || (direction != USB_DIR_IN))
 		return result;
 
-	length = min_t(u16, udc->ctrl.wLength, sizeof(status_data));
+	length =
+		min_t(u16, le16_to_cpu(udc->ctrl.wLength), sizeof(status_data));
 
 	switch (recipient) {
 	case USB_RECIP_DEVICE:
@@ -1584,8 +1588,8 @@ static int std_req_get_status(struct nbu2ss_udc *udc)
 		break;
 
 	case USB_RECIP_ENDPOINT:
-		if (0x0000 == (udc->ctrl.wIndex & 0xFF70)) {
-			ep_adrs = (u8)(udc->ctrl.wIndex & 0xFF);
+		if (0x0000 == (le16_to_cpu(udc->ctrl.wIndex) & 0xFF70)) {
+			ep_adrs = (u8)(le16_to_cpu(udc->ctrl.wIndex) & 0xFF);
 			result = _nbu2ss_get_ep_stall(udc, ep_adrs);
 
 			if (result > 0)
@@ -1625,7 +1629,7 @@ static int std_req_set_feature(struct nbu2ss_udc *udc)
 static int std_req_set_address(struct nbu2ss_udc *udc)
 {
 	int		result = 0;
-	u32		wValue = udc->ctrl.wValue;
+	u32		wValue = le16_to_cpu(udc->ctrl.wValue);
 
 	if ((udc->ctrl.bRequestType != 0x00)	||
 	    (udc->ctrl.wIndex != 0x0000)	||
@@ -1647,7 +1651,7 @@ static int std_req_set_address(struct nbu2ss_udc *udc)
 /*-------------------------------------------------------------------------*/
 static int std_req_set_configuration(struct nbu2ss_udc *udc)
 {
-	u32 config_value = (u32)(udc->ctrl.wValue & 0x00ff);
+	u32 config_value = (u32)(le16_to_cpu(udc->ctrl.wValue) & 0x00ff);
 
 	if ((udc->ctrl.wIndex != 0x0000)	||
 	    (udc->ctrl.wLength != 0x0000)	||
-- 
2.7.4

