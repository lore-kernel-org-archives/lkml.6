Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F79CC43610
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E0C20685
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 06:35:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="m0y4JKEj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iT4KQqEI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56E0C20685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404802AbeKVRNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 12:13:11 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46935 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404781AbeKVRNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 12:13:10 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 630F3220FD;
        Thu, 22 Nov 2018 01:35:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 22 Nov 2018 01:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=EWHkzfmgSCYPL
        ri429kutk56OLeJAwOmh3GF9c3Ry9g=; b=m0y4JKEjAMCYGRKioZFwH1ksbwJl2
        KYSgneedMNDdfOl0JEWaAtyVMuUx6qYgaeFwzuCtoUoABZ47IiIE4MFQgUz+qHZT
        B96fa/JTme+TBK8ghuzCM5QwQQfMHk8VcQyR68Y+bBGgrhxO1HwFoMP7WKMAFeSS
        h8c2FAlCAimPvPWUUjkOXR/5YH8HakOSdnmuVeHJGcwcF1IVfPReWwHfHm5E3I4Q
        sqZzJiNdNV1z6g9F+ZvuYakjNds0oJ4nU9DZRvVMAux9PD9PgYzWo66rGktCjGnr
        HODeF0HVk9BGG8BZi4OofmhNsF3VJAE3Mwk+2QpKrEGH40zU690Mx6F6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=EWHkzfmgSCYPLri429kutk56OLeJAwOmh3GF9c3Ry9g=; b=iT4KQqEI
        RI49wtzuUlj9oxOiiCgBirUeybjeiSY+JItg2dINqnB3gQVnZxSxYHEh/7RgauUs
        wdditi/pNSpK+YgEymSEGJVn14iZT1xQkw69NvPNu6QjasOc5c2ynfLsmrta06OD
        wFUQKAsB4jFjyCAJQHQmMT9ZwXEKTJtVTTGqBXCq38ApLacQ3L7okGUbtlj2M58D
        aKaM/mTMGfwKv9cDUtpx6l7sQatd5HoUMPW9uWSPemYCig3Fm6RlZ+Ewiqosqfw8
        bD+CfC2fs/x+cuik7qRkwrDqjys3cvaWAS5tNLZBAkpwpfXsAtDf1IBrnVHo4Ps/
        5+/MJz1qo38rug==
X-ME-Sender: <xms:H072W-uhgtOzjpD4sfhBpFh0lKFj6eD3-10aj5SQd5R3t_kVyj_S3w>
X-ME-Proxy: <xmx:H072W4lDip7KxUbor1ls4j4PQ40FqKcFruJPn8ByoUuoAVedpW_EYA>
    <xmx:H072W_58Yjlit_1nPAjZ1eFDNM2CzjUXQYa1BKXNL9H4j4hFbYPlyg>
    <xmx:H072W7whwq7tto42ZL7gUyqdbMnJRSbEd0CWe-ewP_YSxu2DaYVvkw>
    <xmx:H072WwLXbZ3Ciw5Gd-9tCE7Jm4_MKHJsPGKlaKr22wM1WcwOXdj9nA>
    <xmx:H072W0GBMU5CPCpuSRacwnDF_3jzeXn1KgWyUbvf_sheLuzZ0Ke-GA>
    <xmx:H072W3-_sUAFD6Rh2nmICW3qhbYFLuwQ1GqwblE4bgy_rNd_NhR84Q>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8156C102DE;
        Thu, 22 Nov 2018 01:35:08 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 7/8] HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
Date:   Thu, 22 Nov 2018 16:34:08 +1000
Message-Id: <20181122063409.15816-8-peter.hutterer@who-t.net>
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

"Scrolling acceleration" is a bit of a misnomer: it doesn't deal with
acceleration at all. However, that's the name used in Logitech's spec,
so I used it here.

Signed-off-by: Harry Cutts <hcutts@chromium.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Unmodified, same as the reverted 051dc9b0

 drivers/hid/hid-logitech-hidpp.c | 47 +++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 146feedd9a2f..67ca587aecfa 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -400,32 +400,53 @@ static void hidpp_prefix_name(char **name, int name_length)
 #define HIDPP_SET_LONG_REGISTER				0x82
 #define HIDPP_GET_LONG_REGISTER				0x83
 
-#define HIDPP_REG_GENERAL				0x00
-
-static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+/**
+ * hidpp10_set_register_bit() - Sets a single bit in a HID++ 1.0 register.
+ * @hidpp_dev: the device to set the register on.
+ * @register_address: the address of the register to modify.
+ * @byte: the byte of the register to modify. Should be less than 3.
+ * Return: 0 if successful, otherwise a negative error code.
+ */
+static int hidpp10_set_register_bit(struct hidpp_device *hidpp_dev,
+	u8 register_address, u8 byte, u8 bit)
 {
 	struct hidpp_report response;
 	int ret;
 	u8 params[3] = { 0 };
 
 	ret = hidpp_send_rap_command_sync(hidpp_dev,
-					REPORT_ID_HIDPP_SHORT,
-					HIDPP_GET_REGISTER,
-					HIDPP_REG_GENERAL,
-					NULL, 0, &response);
+					  REPORT_ID_HIDPP_SHORT,
+					  HIDPP_GET_REGISTER,
+					  register_address,
+					  NULL, 0, &response);
 	if (ret)
 		return ret;
 
 	memcpy(params, response.rap.params, 3);
 
-	/* Set the battery bit */
-	params[0] |= BIT(4);
+	params[byte] |= BIT(bit);
 
 	return hidpp_send_rap_command_sync(hidpp_dev,
-					REPORT_ID_HIDPP_SHORT,
-					HIDPP_SET_REGISTER,
-					HIDPP_REG_GENERAL,
-					params, 3, &response);
+					   REPORT_ID_HIDPP_SHORT,
+					   HIDPP_SET_REGISTER,
+					   register_address,
+					   params, 3, &response);
+}
+
+
+#define HIDPP_REG_GENERAL				0x00
+
+static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+{
+	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_GENERAL, 0, 4);
+}
+
+#define HIDPP_REG_FEATURES				0x01
+
+/* On HID++ 1.0 devices, high-res scroll was called "scrolling acceleration". */
+static int hidpp10_enable_scrolling_acceleration(struct hidpp_device *hidpp_dev)
+{
+	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_FEATURES, 0, 6);
 }
 
 #define HIDPP_REG_BATTERY_STATUS			0x07
-- 
2.19.1

