Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F01CBC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFA7721104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 17:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=p23q.org header.i=@p23q.org header.b="hxMz7VI8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFA7721104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=p23q.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731795AbeK1Edp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 23:33:45 -0500
Received: from mail.gnuzifer.de ([78.46.242.17]:33564 "EHLO mail.gnuzifer.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726288AbeK1Edo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 23:33:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=p23q.org; s=20170531;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:From:Date; bh=vNn8dtlOlZMDMT+wQHIFp3JVDhG7q/BpcttuwY56EGU=;
        b=hxMz7VI8lrMnAVAiVIcmenkCzTor9RsegEx/lhgIzN/5cEjxKhC72TEpoDYpUYzTQU7sBSuBDTVcYufA7YQ5Dv2wxW00lGDV7ajT2+d8nGNRkPtP4vDgOwwbq5xyNtRX9FTYsjgS7QpHYDbFrLREJHnBinTqGT/opdQaX5Po78Ehuu71Wec7kfqcKcfaY6cigquY7a9WzH0ylK/vGV3CoxjiGMI2cVc/sqWq0H6gZErPZo3DtJARPszNfvtx7R3Qkwz5g17UZPxpKGqJDCQshnGfrl6E6ay8BiBLtjfi1l7j2Eli1ki32ku6yBw4npuZummgTh4jJqxIB3TE4qGBPq+125Kv3ZTeU7YWR5B67/dd6pzktnohfqXbs46nJz3ZDvhwVVtQvzxC58v35+l+G7NV64Fk9ZjM/GuZHLoRDm+QWwSO5BFdKTwv/5hJGsIeiYOQI0keVuWOxhT4T3K6RwGULSqOOCSqrfRsDgx+OX8xy8THnboyA1RWpO1IhJuW03NOCtfcaC39qDJCyOdCIh/ZjlOzmygcpxTjpatilvV4cj60wpvCj/yL+KLeoCG1zJNTYjFtWk90Y7Ljf5BYYi5Uq/46R64UPaJzg26kb4ei5nKde8RxDYOg4bI7SIRHY28AhjVdGUYpjYuFgw7AHRrjWDYBI7asSdtofX6Xc6A=;
Received: from authenticated user
        by mail.gnuzifer.de with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.84_2)
        (envelope-from <lkml@p23q.org>)
        id 1gRgg9-0000G8-3K; Tue, 27 Nov 2018 17:57:41 +0100
Date:   Tue, 27 Nov 2018 16:57:34 +0000
From:   "David R. Piegdon" <lkml@p23q.org>
To:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>, Kay Sievers <kay@vrfy.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Roger Quadros <rogerq@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, systemd-devel@lists.freedesktop.org
Subject: [RFC PATCH 1/2] usb core: dts: allow suggesting usb bus number for
 platform busses
Message-ID: <20181127165734.GB13460@lagavulin.indurad.x>
References: <cover.1543332368.git.lkml@p23q.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1543332368.git.lkml@p23q.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: "David R. Piegdon" <lkml@p23q.org>

systemd allows use of predictable netdev names. these currently do
not work for netdevs connected to USB platform busses, as the id
of the platform bus is not necessarily consistent across kernel
versions. this patch allows setting a suggested bus id for platform
busses. in combination with a suggested systemd-patch, see
https://github.com/systemd/systemd/pull/7273 , this allows persistent
netdev names for such devices.

NOTE: this patch might change ordering of busses on devices that use
platform-busses, if aliases for these busses have already been defined!
---
 drivers/usb/core/hcd.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 487025d31d44..901173d33f6e 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -998,6 +998,7 @@ static void usb_bus_init (struct usb_bus *bus)
 /**
  * usb_register_bus - registers the USB host controller with the usb core
  * @bus: pointer to the bus to register
+ * @suggested_busnum: suggested bus number to use for this bus (e.g. 1 for usb1)
  * Context: !in_interrupt()
  *
  * Assigns a bus number, and links the controller into usbcore data
@@ -1005,24 +1006,33 @@ static void usb_bus_init (struct usb_bus *bus)
  *
  * Return: 0 if successful. A negative error code otherwise.
  */
-static int usb_register_bus(struct usb_bus *bus)
+static int usb_register_bus(struct usb_bus *bus, int suggested_busnum)
 {
 	int result = -E2BIG;
+	int wantnum = suggested_busnum;
 	int busnum;
 
+	if ((wantnum < 1) || (wantnum >= USB_MAXBUS))
+		wantnum = 1;
+
 	mutex_lock(&usb_bus_idr_lock);
-	busnum = idr_alloc(&usb_bus_idr, bus, 1, USB_MAXBUS, GFP_KERNEL);
+	busnum = idr_alloc(&usb_bus_idr, bus, wantnum, USB_MAXBUS, GFP_KERNEL);
 	if (busnum < 0) {
 		pr_err("%s: failed to get bus number\n", usbcore_name);
 		goto error_find_busnum;
 	}
+	if ((suggested_busnum == wantnum) && (busnum != wantnum))
+		dev_warn(bus->controller,
+			"suggested USB bus number %d was already taken\n",
+			suggested_busnum);
 	bus->busnum = busnum;
 	mutex_unlock(&usb_bus_idr_lock);
 
 	usb_notify_add_bus(bus);
 
-	dev_info (bus->controller, "new USB bus registered, assigned bus "
-		  "number %d\n", bus->busnum);
+	dev_info(bus->controller,
+		"new USB bus registered, assigned bus number %d\n",
+		bus->busnum);
 	return 0;
 
 error_find_busnum:
@@ -1040,7 +1050,7 @@ static int usb_register_bus(struct usb_bus *bus)
  */
 static void usb_deregister_bus (struct usb_bus *bus)
 {
-	dev_info (bus->controller, "USB bus %d deregistered\n", bus->busnum);
+	dev_info(bus->controller, "USB bus %d deregistered\n", bus->busnum);
 
 	/*
 	 * NOTE: make sure that all the devices are removed by the
@@ -2728,6 +2738,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 {
 	int retval;
 	struct usb_device *rhdev;
+	int bus_id = -1;
 
 	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
 		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
@@ -2772,7 +2783,14 @@ int usb_add_hcd(struct usb_hcd *hcd,
 		goto err_create_buf;
 	}
 
-	retval = usb_register_bus(&hcd->self);
+	if (hcd->self.controller->of_node)
+		bus_id = of_alias_get_id(hcd->self.controller->of_node, "usb");
+
+	if (bus_id > 0)
+		dev_info(hcd->self.controller, "suggested busnum: usb%d\n",
+							bus_id);
+
+	retval = usb_register_bus(&hcd->self, bus_id);
 	if (retval < 0)
 		goto err_register_bus;
 
-- 
2.11.0
