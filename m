Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UPPERCASE_50_75,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C22AC04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38F0D2081B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:59:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38F0D2081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbeLDU7r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:59:47 -0500
Received: from mail.bootlin.com ([62.4.15.54]:51586 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbeLDU7q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:59:46 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 2BB512074F; Tue,  4 Dec 2018 21:59:44 +0100 (CET)
Received: from localhost (pou84-1-88-186-186-126.fbx.proxad.net [88.186.186.126])
        by mail.bootlin.com (Postfix) with ESMTPSA id D67B320729;
        Tue,  4 Dec 2018 21:59:43 +0100 (CET)
From:   Michael Opdenacker <michael.opdenacker@bootlin.com>
To:     tony@atomide.com
Cc:     linux@armlinux.org.uk, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Michael Opdenacker <michael.opdenacker@bootlin.com>
Subject: [PATCH] ARM: omap2plus_defconfig: add networking over USB device
Date:   Tue,  4 Dec 2018 21:59:01 +0100
Message-Id: <20181204205901.14620-1-michael.opdenacker@bootlin.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds support for networking over USB device,
which allows boards such as the BeagleBoneBlack Wireless and
Pocket Beagle to boot on an NFS root filesystem. Such boards
have no Ethernet port.

This is for consistency with CONFIG_ROOT_NFS=y
which makes no sense if there is no networking.

Tested on BeagleBoneBlack Wireless and BeagleBoneBlack

Signed-off-by: Michael Opdenacker <michael.opdenacker@bootlin.com>
---
 arch/arm/configs/omap2plus_defconfig | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 6491419b1dad..7e8a8ed028fd 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -403,11 +403,11 @@ CONFIG_USB_EHCI_HCD=m
 CONFIG_USB_OHCI_HCD=m
 CONFIG_USB_ACM=m
 CONFIG_USB_STORAGE=m
-CONFIG_USB_MUSB_HDRC=m
-CONFIG_USB_MUSB_TUSB6010=m
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_TUSB6010=y
 CONFIG_USB_MUSB_OMAP2PLUS=m
 CONFIG_USB_MUSB_AM35X=m
-CONFIG_USB_MUSB_DSPS=m
+CONFIG_USB_MUSB_DSPS=y
 CONFIG_USB_INVENTRA_DMA=y
 CONFIG_USB_TI_CPPI41_DMA=y
 CONFIG_USB_TUSB_OMAP_DMA=y
@@ -418,10 +418,10 @@ CONFIG_USB_SERIAL_SIMPLE=m
 CONFIG_USB_SERIAL_FTDI_SIO=m
 CONFIG_USB_SERIAL_PL2303=m
 CONFIG_USB_TEST=m
-CONFIG_NOP_USB_XCEIV=m
-CONFIG_AM335X_PHY_USB=m
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_AM335X_PHY_USB=y
 CONFIG_TWL6030_USB=m
-CONFIG_USB_GADGET=m
+CONFIG_USB_GADGET=y
 CONFIG_USB_GADGET_DEBUG=y
 CONFIG_USB_GADGET_DEBUG_FILES=y
 CONFIG_USB_GADGET_DEBUG_FS=y
@@ -442,6 +442,7 @@ CONFIG_USB_CONFIGFS_F_UAC1=y
 CONFIG_USB_CONFIGFS_F_UAC2=y
 CONFIG_USB_CONFIGFS_F_MIDI=y
 CONFIG_USB_CONFIGFS_F_HID=y
+CONFIG_USB_ETH=y
 CONFIG_USB_ZERO=m
 CONFIG_USB_G_NOKIA=m
 CONFIG_MMC=y
-- 
2.17.1

