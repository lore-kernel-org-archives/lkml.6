Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1240C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8025B218D8
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 13:52:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728731AbfBCNud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 08:50:33 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53528 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728256AbfBCNty (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:54 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9g-0003wN-30; Sun, 03 Feb 2019 13:49:52 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9c-00075O-GB; Sun, 03 Feb 2019 14:49:48 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Emmanuel Pescosta" <emmanuelpescosta099@gmail.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.442654719@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 152/305] usb: quirks: Add delay-init quirk for
 Corsair K70 LUX RGB
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Emmanuel Pescosta <emmanuelpescosta099@gmail.com>

commit a77112577667cbda7c6292c52d909636aef31fd9 upstream.

Following on from this patch: https://lkml.org/lkml/2017/11/3/516,
Corsair K70 LUX RGB keyboards also require the DELAY_INIT quirk to
start correctly at boot.

Dmesg output:
usb 1-6: string descriptor 0 read error: -110
usb 1-6: New USB device found, idVendor=1b1c, idProduct=1b33
usb 1-6: New USB device strings: Mfr=1, Product=2, SerialNumber=3
usb 1-6: can't set config #1, error -110

Signed-off-by: Emmanuel Pescosta <emmanuelpescosta099@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -243,6 +243,9 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },
 
+	/* Corsair K70 LUX RGB */
+	{ USB_DEVICE(0x1b1c, 0x1b33), .driver_info = USB_QUIRK_DELAY_INIT },
+
 	/* Corsair K70 LUX */
 	{ USB_DEVICE(0x1b1c, 0x1b36), .driver_info = USB_QUIRK_DELAY_INIT },
 

