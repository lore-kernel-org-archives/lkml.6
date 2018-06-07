Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 1d6UAZ1BGVsOcgAAmS7hNA
	; Thu, 07 Jun 2018 14:31:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id AACCF6089E; Thu,  7 Jun 2018 14:31:32 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 28C47607DC;
	Thu,  7 Jun 2018 14:31:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 28C47607DC
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933550AbeFGOb2 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:31:28 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39392 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932913AbeFGOJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:08 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb7-0005Zr-Jj; Thu, 07 Jun 2018 15:09:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002uc-GZ; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org,
        "OKAMOTO Yoshiaki" <yokamoto@allied-telesis.co.jp>,
        "Johan Hovold" <johan@kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Hiroyuki Yamamoto" <hyamamo@allied-telesis.co.jp>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.414666926@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 149/410] usb: option: Add support for FS040U modem
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

From: OKAMOTO Yoshiaki <yokamoto@allied-telesis.co.jp>

commit 69341bd15018da0a662847e210f9b2380c71e623 upstream.

FS040U modem is manufactured by omega, and sold by Fujisoft. This patch
adds ID of the modem to use option1 driver. Interface 3 is used as
qmi_wwan, so the interface is ignored.

Signed-off-by: Yoshiaki Okamoto <yokamoto@allied-telesis.co.jp>
Signed-off-by: Hiroyuki Yamamoto <hyamamo@allied-telesis.co.jp>
Acked-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/option.c | 5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -385,6 +385,9 @@ static void option_instat_callback(struc
 #define FOUR_G_SYSTEMS_PRODUCT_W14		0x9603
 #define FOUR_G_SYSTEMS_PRODUCT_W100		0x9b01
 
+/* Fujisoft products */
+#define FUJISOFT_PRODUCT_FS040U			0x9b02
+
 /* iBall 3.5G connect wireless modem */
 #define IBALL_3_5G_CONNECT			0x9605
 
@@ -1908,6 +1911,8 @@ static const struct usb_device_id option
 	{ USB_DEVICE(LONGCHEER_VENDOR_ID, FOUR_G_SYSTEMS_PRODUCT_W100),
 	  .driver_info = (kernel_ulong_t)&four_g_w100_blacklist
 	},
+	{USB_DEVICE(LONGCHEER_VENDOR_ID, FUJISOFT_PRODUCT_FS040U),
+	 .driver_info = (kernel_ulong_t)&net_intf3_blacklist},
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, SPEEDUP_PRODUCT_SU9800, 0xff) },
 	{ USB_DEVICE_INTERFACE_CLASS(LONGCHEER_VENDOR_ID, 0x9801, 0xff),
 	  .driver_info = (kernel_ulong_t)&net_intf3_blacklist },
