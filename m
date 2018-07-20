Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5816ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 82BEB20833
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BEB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731927AbeGTNO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:14:27 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:34822 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbeGTNO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:14:26 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9003BBBD;
        Fri, 20 Jul 2018 12:26:26 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nico Sneck <snecknico@gmail.com>
Subject: [PATCH 3.18 05/29] usb: quirks: add delay quirks for Corsair Strafe
Date:   Fri, 20 Jul 2018 14:11:00 +0200
Message-Id: <20180720115159.167310159@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720115158.974693829@linuxfoundation.org>
References: <20180720115158.974693829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: stable <stable@vger.kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/core/quirks.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/core/quirks.c
+++ b/drivers/usb/core/quirks.c
@@ -221,6 +221,10 @@ static const struct usb_device_id usb_qu
 	{ USB_DEVICE(0x1a0a, 0x0200), .driver_info =
 			USB_QUIRK_LINEAR_UFRAME_INTR_BINTERVAL },
 
+	/* Corsair Strafe */
+	{ USB_DEVICE(0x1b1c, 0x1b15), .driver_info = USB_QUIRK_DELAY_INIT |
+	  USB_QUIRK_DELAY_CTRL_MSG },
+
 	/* Corsair Strafe RGB */
 	{ USB_DEVICE(0x1b1c, 0x1b20), .driver_info = USB_QUIRK_DELAY_INIT |
 	  USB_QUIRK_DELAY_CTRL_MSG },


