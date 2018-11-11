Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 325C8C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0070B2080D
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 20:06:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0070B2080D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731318AbeKLFz1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 00:55:27 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:51882 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726519AbeKLFz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 00:55:26 -0500
Received: from [192.168.4.242] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvss-0000lK-1T; Sun, 11 Nov 2018 19:59:02 +0000
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gLvsV-0001i0-Rj; Sun, 11 Nov 2018 19:58:39 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Nico Sneck" <snecknico@gmail.com>
Date:   Sun, 11 Nov 2018 19:49:05 +0000
Message-ID: <lsq.1541965745.535746665@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 238/366] usb: quirks: add delay quirks for Corsair Strafe
In-Reply-To: <lsq.1541965744.387173642@decadent.org.uk>
X-SA-Exim-Connect-IP: 192.168.4.242
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.61-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Nico Sneck <snecknico@gmail.com>

commit bba57eddadda936c94b5dccf73787cb9e159d0a5 upstream.

Corsair Strafe appears to suffer from the same issues
as the Corsair Strafe RGB.
Apply the same quirks (control message delay and init delay)
that the RGB version has to 1b1c:1b15.

With these quirks in place the keyboard works correctly upon
booting the system, and no longer requires reattaching the device.

Signed-off-by: Nico Sneck <snecknico@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/core/quirks.c | 4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -228,6 +228,10 @@ static const struct usb_device_id usb_qu
 	/* Corsair K70 RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b13), .driver_info = USB_QUIRK_DELAY_INIT },
 
+	/* Corsair Strafe */
+	{ USB_DEVICE(0x1b1c, 0x1b15), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
+
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },

