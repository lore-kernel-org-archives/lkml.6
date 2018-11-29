Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F4E7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9F3021019
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 14:19:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="e1nE6MZV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9F3021019
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeK3BYr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 20:24:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:47830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729808AbeK3BYq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 20:24:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0865205C9;
        Thu, 29 Nov 2018 14:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543501155;
        bh=0akjBsO4IScAdT3FMMt1rcze8ojsxVLi5pwqYK8n+3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=e1nE6MZVBMDwktpI2sTabogtIWJEbUg6KvYT3VZ6+pgwzzva7HdwAXhaxalwfPz/s
         p9s1rfpNMeWlTssJfSyFBYZ7bilJFvDK4VZY3JHqQPc+rqmLQ3MeNwq+k7s9kEhz1a
         /YQn1rnLC0K0JXhLTwXtpPmgoy0ehz/39FxOk6h0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leo Sperling <leosperling97@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 64/86] Input: xpad - fix some coding style issues
Date:   Thu, 29 Nov 2018 15:12:29 +0100
Message-Id: <20181129140115.335704910@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181129140109.832117862@linuxfoundation.org>
References: <20181129140109.832117862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 68c78d0155e37992268664e134996d2b140ddf38 ]

Fix some coding style issues reported by checkpatch.pl. Mostly brackets
in macros, spacing and comment style.

Signed-off-by: Leo Sperling <leosperling97@gmail.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/joystick/xpad.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/input/joystick/xpad.c b/drivers/input/joystick/xpad.c
index 298581b0f6c1..b6e172f22c16 100644
--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -89,8 +89,10 @@
 
 #define XPAD_PKT_LEN 64
 
-/* xbox d-pads should map to buttons, as is required for DDR pads
-   but we map them to axes when possible to simplify things */
+/*
+ * xbox d-pads should map to buttons, as is required for DDR pads
+ * but we map them to axes when possible to simplify things
+ */
 #define MAP_DPAD_TO_BUTTONS		(1 << 0)
 #define MAP_TRIGGERS_TO_BUTTONS		(1 << 1)
 #define MAP_STICKS_TO_NULL		(1 << 2)
@@ -390,15 +392,15 @@ static const signed short xpad_abs_triggers[] = {
  * match against vendor id as well. Wired Xbox 360 devices have protocol 1,
  * wireless controllers have protocol 129.
  */
-#define XPAD_XBOX360_VENDOR_PROTOCOL(vend,pr) \
+#define XPAD_XBOX360_VENDOR_PROTOCOL(vend, pr) \
 	.match_flags = USB_DEVICE_ID_MATCH_VENDOR | USB_DEVICE_ID_MATCH_INT_INFO, \
 	.idVendor = (vend), \
 	.bInterfaceClass = USB_CLASS_VENDOR_SPEC, \
 	.bInterfaceSubClass = 93, \
 	.bInterfaceProtocol = (pr)
 #define XPAD_XBOX360_VENDOR(vend) \
-	{ XPAD_XBOX360_VENDOR_PROTOCOL(vend,1) }, \
-	{ XPAD_XBOX360_VENDOR_PROTOCOL(vend,129) }
+	{ XPAD_XBOX360_VENDOR_PROTOCOL((vend), 1) }, \
+	{ XPAD_XBOX360_VENDOR_PROTOCOL((vend), 129) }
 
 /* The Xbox One controller uses subclass 71 and protocol 208. */
 #define XPAD_XBOXONE_VENDOR_PROTOCOL(vend, pr) \
@@ -408,7 +410,7 @@ static const signed short xpad_abs_triggers[] = {
 	.bInterfaceSubClass = 71, \
 	.bInterfaceProtocol = (pr)
 #define XPAD_XBOXONE_VENDOR(vend) \
-	{ XPAD_XBOXONE_VENDOR_PROTOCOL(vend, 208) }
+	{ XPAD_XBOXONE_VENDOR_PROTOCOL((vend), 208) }
 
 static const struct usb_device_id xpad_table[] = {
 	{ USB_INTERFACE_INFO('X', 'B', 0) },	/* X-Box USB-IF not approved class */
@@ -1576,6 +1578,7 @@ static void xpad_close(struct input_dev *dev)
 static void xpad_set_up_abs(struct input_dev *input_dev, signed short abs)
 {
 	struct usb_xpad *xpad = input_get_drvdata(input_dev);
+
 	set_bit(abs, input_dev->absbit);
 
 	switch (abs) {
-- 
2.17.1



