Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /PXHIu1AGVvmZgAAmS7hNA
	; Thu, 07 Jun 2018 14:29:07 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 472B1607E7; Thu,  7 Jun 2018 14:29:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 58FE16063F;
	Thu,  7 Jun 2018 14:29:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 58FE16063F
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933580AbeFGO3D (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:29:03 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40205 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932915AbeFGO3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:29:00 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005Zx-60; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb4-0002wa-6i; Thu, 07 Jun 2018 15:09:02 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "Chu.Mike [=?UTF-8?Q?=E6=9C=B1=E5=A0=85=E5=AE=9C?=]"
        <Mike-Chu@prolific.com.tw>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Johan Hovold" <johan@kernel.org>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.141373629@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 166/410] USB: serial: pl2303: new device id for Chilitag
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

commit d08dd3f3dd2ae351b793fc5b76abdbf0fd317b12 upstream.

This adds a new device id for Chilitag devices to the pl2303 driver.

Reported-by: "Chu.Mike [朱堅宜]" <Mike-Chu@prolific.com.tw>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/pl2303.c | 1 +
 drivers/usb/serial/pl2303.h | 1 +
 2 files changed, 2 insertions(+)

--- a/drivers/usb/serial/pl2303.c
+++ b/drivers/usb/serial/pl2303.c
@@ -39,6 +39,7 @@ static const struct usb_device_id id_tab
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ2) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_DCU11) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_RSAQ3) },
+	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_CHILITAG) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_PHAROS) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_ALDIGA) },
 	{ USB_DEVICE(PL2303_VENDOR_ID, PL2303_PRODUCT_ID_MMX) },
--- a/drivers/usb/serial/pl2303.h
+++ b/drivers/usb/serial/pl2303.h
@@ -17,6 +17,7 @@
 #define PL2303_PRODUCT_ID_DCU11		0x1234
 #define PL2303_PRODUCT_ID_PHAROS	0xaaa0
 #define PL2303_PRODUCT_ID_RSAQ3		0xaaa2
+#define PL2303_PRODUCT_ID_CHILITAG	0xaaa8
 #define PL2303_PRODUCT_ID_ALDIGA	0x0611
 #define PL2303_PRODUCT_ID_MMX		0x0612
 #define PL2303_PRODUCT_ID_GPRS		0x0609
