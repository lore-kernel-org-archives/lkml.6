Return-Path: <stable-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-516909-1519834107-2-11856000436464902874
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN', FromHeader='uk',
  MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: stable-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519834106; b=gkS+cfELBVvGS9jrarn0TtE8CPftMdgjBDWvbUstu8sAI2w
    99IzvzyhL+BcquDif/jFrhDKa8bISF1xLP9e0FZZ0Tr3Pk9bO+rDFXkBdpKxSjHH
    7AKcW/nRA/zPiXzJ+tdW/9i/kC6W8StN3AVdCqX0xAK/VweGb1yJn8vQYhUNR3u4
    MUImATeX6PO6tWWQzsioIdFg3o1Oza2/30rU8p/zy/co4KZXD4Xa1QJ1VAAn21X5
    BVstRb/u5U63me+zoynDCR0ricps3eu2DUOqN5XaEqnoX4RdHYE47WZdTtiwjmhi
    dCeuXzoUC7P27FLKsYYcqk8LcnYQuWoor1OyYeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=content-type:content-transfer-encoding
    :mime-version:from:to:cc:date:message-id:subject:in-reply-to
    :sender:list-id; s=arctest; t=1519834106; bh=RbxShw+iZEZ3UQYe/3K
    t0AwjWgA1echt/S20FPe3yRw=; b=ay3io26XTJT3K+2dfYs/2No4LQ2U48dl5L4
    kSxprfOdOH7t2gVTCcBCI+ZtvdSmG46CmtqF3Z9KmS5JoEE0ITxsEc68iVe0tDm+
    u6K0fus13DrN/tnOKR6UnHObF2S1U3ioHeekXwp84iOW5XzAOL9Ud9dRj2ydVobF
    i+61MqiIInFSjNk5kLkDE1khMlOEMi63Bc6v9Iz+/kBay8IADW3rqREUZrZd7fJL
    CUkKdKaC+uAvJRwdPER3P3WoMp+3AJ8iQcP2DaAzdRvwwECyZXfdNuKji7o8QzPJ
    AEWIBYSmM32zG00dngT20RJPCGqB59KmhU8cN+JpyjR4KTgtyfQ==
ARC-Authentication-Results: i=1; mx3.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Authentication-Results: mx3.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=decadent.org.uk;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=stable-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=decadent.org.uk header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753271AbeB1QFF (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 11:05:05 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34859 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753114AbeB1QFD (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 28 Feb 2018 11:05:03 -0500
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Johan Hovold" <johan@kernel.org>,
        "Daniele Palmas" <dnlplm@gmail.com>
Date: Wed, 28 Feb 2018 15:20:18 +0000
Message-ID: <lsq.1519831218.426237655@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 116/254] USB: serial: option: add support for Telit
 ME910 PID 0x1101
In-Reply-To: <lsq.1519831217.271785318@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: stable-owner@vger.kernel.org
X-Mailing-List: stable@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.16.55-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Daniele Palmas <dnlplm@gmail.com>

commit 08933099e6404f588f81c2050bfec7313e06eeaf upstream.

This patch adds support for PID 0x1101 of Telit ME910.

Signed-off-by: Daniele Palmas <dnlplm@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/usb/serial/option.c | 8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -286,6 +286,7 @@ static void option_instat_callback(struc
 #define TELIT_PRODUCT_LE922_USBCFG3		0x1043
 #define TELIT_PRODUCT_LE922_USBCFG5		0x1045
 #define TELIT_PRODUCT_ME910			0x1100
+#define TELIT_PRODUCT_ME910_DUAL_MODEM		0x1101
 #define TELIT_PRODUCT_LE920			0x1200
 #define TELIT_PRODUCT_LE910			0x1201
 #define TELIT_PRODUCT_LE910_USBCFG4		0x1206
@@ -658,6 +659,11 @@ static const struct option_blacklist_inf
 	.reserved = BIT(1) | BIT(3),
 };
 
+static const struct option_blacklist_info telit_me910_dual_modem_blacklist = {
+	.sendsetup = BIT(0),
+	.reserved = BIT(3),
+};
+
 static const struct option_blacklist_info telit_le910_blacklist = {
 	.sendsetup = BIT(0),
 	.reserved = BIT(1) | BIT(2),
@@ -1266,6 +1272,8 @@ static const struct usb_device_id option
 		.driver_info = (kernel_ulong_t)&telit_le922_blacklist_usbcfg0 },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910),
 		.driver_info = (kernel_ulong_t)&telit_me910_blacklist },
+	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_ME910_DUAL_MODEM),
+		.driver_info = (kernel_ulong_t)&telit_me910_dual_modem_blacklist },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910),
 		.driver_info = (kernel_ulong_t)&telit_le910_blacklist },
 	{ USB_DEVICE(TELIT_VENDOR_ID, TELIT_PRODUCT_LE910_USBCFG4),
