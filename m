Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5F7AC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77A8322360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 05:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A8322360
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731580AbeKNPhO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 10:37:14 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:35571 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeKNPhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 10:37:14 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gMnpl-0007ue-EO; Wed, 14 Nov 2018 05:35:25 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     jikos@kernel.org, benjamin.tissoires@redhat.com
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: multitouch: Add pointstick support for Cirque Touchpad
Date:   Wed, 14 Nov 2018 05:35:20 +0000
Message-Id: <20181114053520.7229-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cirque Touchpad/Pointstick combo is similar to Alps devices, it requires
MT_CLS_WIN_8_DUAL to expose its pointstick as a mouse.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/hid-ids.h        | 3 +++
 drivers/hid/hid-multitouch.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c0d668944dbe..9f59a0a1500b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -275,6 +275,9 @@
 
 #define USB_VENDOR_ID_CIDC		0x1677
 
+#define I2C_VENDOR_ID_CIRQUE		0x0488
+#define I2C_PRODUCT_ID_CIRQUE_121F	0x121F
+
 #define USB_VENDOR_ID_CJTOUCH		0x24b8
 #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020	0x0020
 #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040	0x0040
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f7c6de2b6730..dca0a3a90fb8 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1814,6 +1814,12 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
 			USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
 
+	/* Cirque devices */
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			I2C_VENDOR_ID_CIRQUE,
+			I2C_PRODUCT_ID_CIRQUE_121F) },
+
 	/* CJTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
-- 
2.17.1

