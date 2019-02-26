Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641EEC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C73920C01
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 17:07:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728732AbfBZRHQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 12:07:16 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:34548 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727580AbfBZRHQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 12:07:16 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 2230F15AC5; Tue, 26 Feb 2019 17:07:13 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: serial: option: set driver_info for SIM5218 and compatibles
Date:   Tue, 26 Feb 2019 17:07:10 +0000
Message-Id: <20190226170710.12709-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SIMCom SIM5218 and compatible devices have 5 USB interfaces, only 4
of which are serial ports.  The fifth is a network interface supported
by the qmi-wwan driver.  Furthermore, the serial ports do not support
modem control signals.  Add driver_info flags to reflect this.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/usb/serial/option.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
index fb544340888b..af4cbfecc3ff 100644
--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -1066,7 +1066,8 @@ static const struct usb_device_id option_ids[] = {
 	  .driver_info = RSVD(3) },
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x6613)}, /* Onda H600/ZTE MF330 */
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x0023)}, /* ONYX 3G device */
-	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000)}, /* SIMCom SIM5218 */
+	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000), /* SIMCom SIM5218 */
+	  .driver_info = NCTRL(0) | NCTRL(1) | NCTRL(2) | NCTRL(3) | RSVD(4) },
 	/* Quectel products using Qualcomm vendor ID */
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC15)},
 	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC20),
-- 
2.20.1

