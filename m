Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754660AbeCRUes (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 16:34:48 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:53447 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754311AbeCRUeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 16:34:46 -0400
From: Stefan Agner <stefan@agner.ch>
To: shawnguo@kernel.org, kernel@pengutronix.de, arnd@arndb.de
Cc: fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH 1/7] ARM: multi_v7_defconfig: add OCOTP driver for NXP SoCs
Date: Sun, 18 Mar 2018 21:34:36 +0100
Message-Id: <20180318203442.19759-1-stefan@agner.ch>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable on-chip OTP NVMEM support for NXP i.MX and VF610 SoCs.
Since OTP values might be required by drivers required during
boot, make sure the driver is built-in (e.g. i.MX thermal
driver).

Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm/configs/multi_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index da7387689b88..6395425854cc 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -917,7 +917,9 @@ CONFIG_PHY_SAMSUNG_USB2=m
 CONFIG_PHY_TEGRA_XUSB=y
 CONFIG_PHY_BRCM_SATA=y
 CONFIG_NVMEM=y
+CONFIG_NVMEM_IMX_OCOTP=y
 CONFIG_NVMEM_SUNXI_SID=y
+CONFIG_NVMEM_VF610_OCOTP=y
 CONFIG_BCM2835_MBOX=y
 CONFIG_RASPBERRYPI_FIRMWARE=y
 CONFIG_EFI_VARS=m
-- 
2.16.2
