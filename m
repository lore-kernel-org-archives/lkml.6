Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C446AC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:49:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72820208E5
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 10:49:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72820208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732472AbeGKKxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 06:53:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:47281 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbeGKKxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 06:53:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdCgU-0004bL-2J; Wed, 11 Jul 2018 10:49:22 +0000
From:   Colin King <colin.king@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Quytelda Kahja <quytelda@tamalin.org>,
        devel@driverdev.osuosl.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: gdm724x: redundant variables idProduct and idVendor
Date:   Wed, 11 Jul 2018 11:49:21 +0100
Message-Id: <20180711104921.30561-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable idProduct and idVendor are being assigned but are never used
hence they are redundant and can be removed.

Cleans up clang warnings:
warning: variable 'idProduct' set but not used [-Wunused-but-set-variable]
warning: variable 'idVendor' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/staging/gdm724x/gdm_usb.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_usb.c b/drivers/staging/gdm724x/gdm_usb.c
index 0218782d1a08..dc4da66c3695 100644
--- a/drivers/staging/gdm724x/gdm_usb.c
+++ b/drivers/staging/gdm724x/gdm_usb.c
@@ -879,14 +879,9 @@ static void gdm_usb_disconnect(struct usb_interface *intf)
 {
 	struct phy_dev *phy_dev;
 	struct lte_udev *udev;
-	u16 idVendor, idProduct;
 	struct usb_device *usbdev;
 
 	usbdev = interface_to_usbdev(intf);
-
-	idVendor = __le16_to_cpu(usbdev->descriptor.idVendor);
-	idProduct = __le16_to_cpu(usbdev->descriptor.idProduct);
-
 	phy_dev = usb_get_intfdata(intf);
 
 	udev = phy_dev->priv_dev;
-- 
2.17.1

