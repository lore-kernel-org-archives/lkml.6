Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB93C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A462C2081C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 00:43:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=who-t.net header.i=@who-t.net header.b="jGBZTkUF";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="X22RKtVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A462C2081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=who-t.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbeLEAnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 19:43:20 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:35421 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726828AbeLEAnR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 19:43:17 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8B469F68;
        Tue,  4 Dec 2018 19:43:16 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Tue, 04 Dec 2018 19:43:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=who-t.net; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=+YYg4uhf70OKm
        hFN9YmF5qswdQNugSbQgP5G4iECx7w=; b=jGBZTkUFbPJjpqmu1uf3+b+lVh8t0
        DOfS1UlliUU4l6svAlh9jI9EhOHi8z7E33mUO2+kAQ9AhJZVMQk2je2Gd/ki4LSS
        XracmWJIjGRg3b0swpHzh7veWYt/76uxOB3T4M6ixZNY+hw5JsX9+3P5KN/sxGSY
        ixe0SNtXHdZe7WYkuj37ePJp7tjbRd02O1QBJRgrXQuklQZ+QJ8DkArrYKA0yUAU
        rU8mubymI17LEy3IA9MJR0+jhU3lgcqGSc4fS5aSd0mFV91wZfKlXRC2pR24Kthd
        lpKAqx/Jj8fYKgTFBFIuQEzHC9oMskudCMzelyjPmxjvM5hU0gnHH/Qdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=+YYg4uhf70OKmhFN9YmF5qswdQNugSbQgP5G4iECx7w=; b=X22RKtVP
        S6/BujsaqUEaQ1blfKhSKFZQu3dSjNSzmb3NQuiebg+Ack9FYNCV9u3LgHnGlydj
        8P8f/rtNmhjUyhhPEj+lWqOvOuBLEe5a9kTnH3m+mNOSZZCGmpekM1OgaBt3O3dR
        JBP5jCSzM9w4I8y2lK/iJ/2P6r1GoHIRroqJ3jSb90U9juV3zj2zy5qd0mSEwb6i
        zQCUTo8CINkmPp0TUeqIPBPsDmaoqzVt3ApOuOwr204mCMnpnixv4nxuwfS23nsO
        EVk3eiF19b12NTNxWRVlFK8zmVv6iPzeeQDAki4bVfq092yn0JzSEN2S1X+bNj+q
        qUXW4wXCGXEGjg==
X-ME-Sender: <xms:Ix8HXDPBalGcm7UxeI8uyVvjWMLu9Ew86omy4XMHrC4FLQaqj3NIuw>
X-ME-Proxy: <xmx:Ix8HXEh3CbrR_YNmyEEApcjyAjHr82GvMZSLbwyB9MpeslThwu4JNw>
    <xmx:Ix8HXNNv21GC9YqwEpfS1aLuhOuoRTAFnM0TEGI3AyuHC2p4ln7cDw>
    <xmx:Ix8HXN53RDlOuJDkUE13ABAd92IEh1BenD1R7iK43cFkXoFTYf9tlQ>
    <xmx:Ix8HXD37RtRMMkXsyooxI1bS7l9JiqhlSDhalYZdBns5Cd03czhGgw>
    <xmx:Ix8HXGayxUdSPS6zaMX5S8WaewJl0DLxjF6x_iS3JGion4MGawjfig>
    <xmx:JB8HXAL7a6iNhcI4zfKmIo_RzAjlKjHz-IbUxe258YLwfroFzB5MUw>
Received: from jelly.home.gateway (167-179-166-29.a7b3a6.bne.nbn.aussiebb.net [167.179.166.29])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0A49DE4925;
        Tue,  4 Dec 2018 19:43:12 -0500 (EST)
From:   Peter Hutterer <peter.hutterer@who-t.net>
To:     linux-input@vger.kernel.org
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Harry Cutts <hcutts@chromium.org>,
        torvalds@linux-foundation.org,
        Nestor Lopez Casado <nlopezcasad@logitech.com>,
        linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 8/8] HID: logitech: Use LDJ_DEVICE macro for existing Logitech mice
Date:   Wed,  5 Dec 2018 10:42:28 +1000
Message-Id: <20181205004228.10714-9-peter.hutterer@who-t.net>
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

Signed-off-by: Harry Cutts <hcutts@chromium.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Changes to v1, v2:
- reordered from 6/8 to 8/8 so the intermediate steps all build

 drivers/hid/hid-logitech-hidpp.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index a66daf8acd87..15ed6177a7a3 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -3362,13 +3362,11 @@ static void hidpp_remove(struct hid_device *hdev)
 
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
@@ -3408,16 +3406,13 @@ static const struct hid_device_id hidpp_devices[] = {
 	{ /* Mouse Logitech Performance MX */
 	  LDJ_DEVICE(0x101a), .driver_data = HIDPP_QUIRK_HI_RES_SCROLL_1P0 },
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
2.19.2

