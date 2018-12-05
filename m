Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B758C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC93C2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="gn5eGRno";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UvPqHrpm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC93C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeLEAnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:43:13 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60697 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbeLEAnL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:43:11 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id EFE7EEF3;
        Tue,  4 Dec 2018 19:43:09 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Dec 2018 19:43:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=k0wpaOF+B4pJS
        qXa2tG5vClg3F+LRFCjDb4ghPCqbbY=; b=gn5eGRnoSGNLJ57Ek4X53SfBDtGku
        qf5Omy7o6wyJOZTvBce8Tt0Sm9Hylbj5/XCSFQwQZwbNNajuqIYfmmjB2fhDiRSC
        fSOnrWAfmFRpwobPVQYdbzh215RXl4tPTRHpD+iC5RSii/6BwL8kFlkJ1e7tso3w
        1BSa880POVHiF1ewRzgn20gJukFtd7ka7sAw80oR3ZhPNOTIDOPG8eB4s/lURRXz
        HKlgOQHkXEYo4iqH3OK69JZk3vm3XTvAxUs72XzmMvs5kbRtKTVY2vewXOIzglbR
        vQw7aYHRC9sGT4/+EuYNni9eRCWYNyUkN1G09TJXbl8p9Ic2n/650BZsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=k0wpaOF+B4pJSqXa2tG5vClg3F+LRFCjDb4ghPCqbbY=; b=UvPqHrpm
        rv5W2RO1CoWUY+Q4x0wPg3JUR9hsEMAdQ488bFJlPUKgXEPkg85lZJoPlStksU0D
        Ya7dkKWOMurO3iPGMrU+pLr2iHHyulcKdvclX3Q0VPrSeBMU58DFcpZMfjm1ixuL
        L3dqOJnvu7g8dcXRoVb7Yfw0pl9rXWgYjyQB6xKd+0GxMVl8UMkbYi6LqH9XinGb
        jGITQc5/a8IzICpMB1hZIc1sEJjKMFgt5c+bNVY7Pg7nPeFpjpjE6u2igccph7gV
        BX1xCLg7XwDmAsuHESUA1IQcHWIzBWY7MpnRmDq8AxawRNiQJBAMU0yUDsPTDDu/
        TwUbdQXzcjFYSw==
X-ME-Sender: <xms:HR8HXPZJ3L968PQjNYWZoyiUFSa1lf5Vr3MbXHN8XrZlWUDHVBuOtw>
X-ME-Proxy: <xmx:HR8HXGI_ha1bP8ZtIPCk_5YzZleX8VlwniTTpm8-n1QnpfGGJF_fWw>
    <xmx:HR8HXMesTV9X8c4AQfxZCyTL5bHNwlZWMmHt-i9T1TviaP8kLcj5VA>
    <xmx:HR8HXM9cZw2VVU-t9c7J6qI5LeUga0VvcA9TQ494eIdfYz4N-r5mDQ>
    <xmx:HR8HXPs2ixPcGHRgp1Na3F2cGXLqJHcjXtK_vMt5W_Sqc0uHqSpbTQ>
    <xmx:HR8HXGeA08A8PwS95n89JcmArbdQh0yAvSIpohcd5KwgDvSenzjoSA>
    <xmx:HR8HXMATFdByerJeOXPUAOaeGk2QutAMqkC0OZGfRuVmepBQyNJAgw>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8EC8AE49CB;
        Tue,  4 Dec 2018 19:43:06 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 6/8] HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
Date:   Wed,  5 Dec 2018 10:42:26 +1000
Message-Id: <20181205004228.10714-7-peter.hutterer@who-t.net>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181205004228.10714-1-peter.hutterer@who-t.net>
References: <20181205004228.10714-1-peter.hutterer@who-t.net>
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
Unchanged since v1

 drivers/hid/hid-logitech-hidpp.c | 47 +++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 22b37a3844d1..95ba9db6e613 100644
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
2.19.2

