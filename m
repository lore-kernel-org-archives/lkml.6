Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 929AFC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5599420685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="M8myfnWb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZgtinLok"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5599420685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404789AbeKVRNK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:13:10 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:43869 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732955AbeKVRNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:13:07 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 57745221E3;
        Thu, 22 Nov 2018 01:35:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 01:35:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=azn5uNQHddCE5
        FHZ2kqZWh+UcafNuwJEvUPkjsC4iRE=; b=M8myfnWbWQugZ1WmTrMCY/SzanRhf
        PUXF/53djSe/olX+yptg32bUTDxm/+TBgX6FXCT79QX8A9Hm412TxeOomPwnr/MW
        CZekZ87NsnMtIengteQEzPKTu9GRT5hFeJhqDMGS8loV8KbVCh6q3FE/J65Yq37X
        yb14rFMwBNKMbnVUbQu6ajnC+LU7zpaU5DzUeUrr8DGnfHnwWtha0AQOfcrAsfh6
        VyMWCD3Gpbu5CKz43vOIS6edNMkEPcA+qkVxABp2Gl6BTIBXAxHEhQALWi04m9iJ
        pNYBKYRIaZytW6kI7x/J3iylftNJREWz4shu24F7/g562wzUoHa/uLzrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=azn5uNQHddCE5FHZ2kqZWh+UcafNuwJEvUPkjsC4iRE=; b=ZgtinLok
        dve+xIKW/qQNvv7YyGCB9Oahq1psRfvldX6bjMW4CKHcZkhd6F+YSKwTD8Nt22Hw
        9CVkaTTXb39yuvGqiqyesROtbwWxH2mZrMdYuVWKS0q1VYPqj5MwNIo8TWdYhDq5
        /pip0/wYkALQqOC9R6cssDbpHGx5UfiFqfP02GheRVagl150FInaf0BFJ65enjfa
        hWmso8n6cZ8zxihpWxf7C0nuRDqEkXyDeNuqgykMf9lAa9tlLsKeMR2MpSmb23S3
        I6RHQz3makDXXM8HCotAUh9vfE8gZ+UHSTlgYI+Kb/iEdR1tOUijpitcaajJQw7V
        PSB89ocis+qMuQ==
X-ME-Sender: <xms:HE72W0FCCHvq7TMmgslHBRR2CVZ2UoM1s3VAdnnmH3YDA0QM5Yl-qw>
X-ME-Proxy: <xmx:HE72W7rYi5VNkEesgcjfrcSwwb-RJXPryfUNLoH7TUlEWC-Cf7FZTw>
    <xmx:HE72W0rEQ-kj2wjarNBWVMwXI1c5YK1ITrZgFo35xXsEvLxmpIoqRQ>
    <xmx:HE72WwenE4RN0rFy2pkQ60DMOiulyXll5bxKytP2ElKQsKjiG_0x4Q>
    <xmx:HE72W7R9VBZqkGaNP7GORs2gTgQbcAWsmc44A-dGz_G3hnk2gUiMsQ>
    <xmx:HE72W0dUelfmG9wmqapfWxYF8ag5GFxRItfMeqV8g6citOqDSoqdiA>
    <xmx:HE72W1JlwQyYRv0jYxX6XP6xOPU3ZG7bETWc1mO78MqW4kNAqdMYjA>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 80697102DE;
        Thu, 22 Nov 2018 01:35:05 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 6/8] HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice
Date:   Thu, 22 Nov 2018 16:34:07 +1000
Message-Id: <20181122063409.15816-7-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Harry Cutts <hcutts@chromium.org>

Signed-off-by: Harry Cutts <hcutts@chromium.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Unmodified, same as the reverted 3fe1d6bbcd1

 drivers/hid/hid-logitech-hidpp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 22b37a3844d1..146feedd9a2f 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3088,13 +3088,11 @@ static void hidpp_remove(struct hid_device *hdev)
 
 static const struct hid_device_id hidpp_devices[] = {
 	{ /* wireless touchpad */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4011),
+	  LDJ_DEVICE(0x4011),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT |
 			 HIDPP_QUIRK_WTP_PHYSICAL_BUTTONS },
 	{ /* wireless touchpad T650 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4101),
+	  LDJ_DEVICE(0x4101),
 	  .driver_data = HIDPP_QUIRK_CLASS_WTP | HIDPP_QUIRK_DELAYED_INIT },
 	{ /* wireless touchpad T651 */
 	  HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_LOGITECH,
@@ -3105,16 +3103,13 @@ static const struct hid_device_id hidpp_devices[] = {
 		USB_VENDOR_ID_LOGITECH, 0x402d),
 	  .driver_data = HIDPP_QUIRK_DELAYED_INIT | HIDPP_QUIRK_CLASS_M560 },
 	{ /* Keyboard logitech K400 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4024),
+	  LDJ_DEVICE(0x4024),
 	  .driver_data = HIDPP_QUIRK_CLASS_K400 },
 	{ /* Solar Keyboard Logitech K750 */
-	  HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, 0x4002),
+	  LDJ_DEVICE(0x4002),
 	  .driver_data = HIDPP_QUIRK_CLASS_K750 },
 
-	{ HID_DEVICE(BUS_USB, HID_GROUP_LOGITECH_DJ_DEVICE,
-		USB_VENDOR_ID_LOGITECH, HID_ANY_ID)},
+	{ LDJ_DEVICE(HID_ANY_ID) },
 
 	{ HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_LOGITECH_G920_WHEEL),
 		.driver_data = HIDPP_QUIRK_CLASS_G920 | HIDPP_QUIRK_FORCE_OUTPUT_REPORTS},
-- 
2.19.1

