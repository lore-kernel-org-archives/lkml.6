Return-Path: <SRS0=kemo=QR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UPPERCASE_50_75,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C51D4C282D7
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94D6321A49
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Feb 2019 12:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=onstation.org header.i=@onstation.org header.b="acaFGMgt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfBJMR1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Feb 2019 07:17:27 -0500
Received: from onstation.org ([52.200.56.107]:49860 "EHLO onstation.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbfBJMR0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Feb 2019 07:17:26 -0500
Received: from localhost.localdomain (c-98-239-145-235.hsd1.wv.comcast.net [98.239.145.235])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: masneyb)
        by onstation.org (Postfix) with ESMTPSA id 71998167;
        Sun, 10 Feb 2019 12:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=onstation.org;
        s=default; t=1549801045;
        bh=IgnOmCCFJmxuhbQ0gc2xMI4B5W8Pg2zD9KSQ5n/XF3I=;
        h=From:To:Cc:Subject:Date:From;
        b=acaFGMgtrCVCAne+nRm4gINYgue7bLlP+Ej26R4/PGWRgaLQ4NWs5gN7L1y5yilyp
         ORDVROAxh2u2zd9dENTOlAcV4xq7y1Txl2vG1xwE9m4ZX0Fwnz1JGIhwDwPta9KHFi
         GDw2N6K4BRCDpoSveTeM5QCS3jw8WtjH3n2n3NYE=
From:   Brian Masney <masneyb@onstation.org>
To:     andy.gross@linaro.org, linux@armlinux.org.uk
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: qcom_defconfig: add options for LG Nexus 5 phone
Date:   Sun, 10 Feb 2019 07:16:57 -0500
Message-Id: <20190210121657.4200-1-masneyb@onstation.org>
X-Mailer: git-send-email 2.17.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add wcn36xx wireless, msm vibrator, pm8941 power key, bq24190 charger,
spmi-iadc, spmi-vadc, mpu6515 gyroscope / accelerometer, and tsl2772
proximity / light drivers as modules to support the LG Nexus 5
(hammerhead) phone.

CFG80211 is changed to be a module to match MAC80211 since this isn't
required for initial bootup.

Device manager support is also added as a module since this is needed by
postmarketOS.

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 arch/arm/configs/qcom_defconfig | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/qcom_defconfig b/arch/arm/configs/qcom_defconfig
index bd6440f23493..7dc91e822537 100644
--- a/arch/arm/configs/qcom_defconfig
+++ b/arch/arm/configs/qcom_defconfig
@@ -50,7 +50,8 @@ CONFIG_IP_PNP_DHCP=y
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
 # CONFIG_IPV6 is not set
-CONFIG_CFG80211=y
+CONFIG_CFG80211=m
+CONFIG_MAC80211=m
 CONFIG_RFKILL=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
@@ -72,6 +73,8 @@ CONFIG_SCSI_SCAN_ASYNC=y
 CONFIG_ATA=y
 CONFIG_SATA_AHCI=y
 CONFIG_SATA_AHCI_PLATFORM=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_DM=m
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
 CONFIG_ATL1C=y
@@ -85,6 +88,7 @@ CONFIG_SLIP_MODE_SLIP6=y
 CONFIG_USB_USBNET=y
 # CONFIG_USB_NET_AX8817X is not set
 # CONFIG_USB_NET_ZAURUS is not set
+CONFIG_WCN36XX=m
 CONFIG_BRCMFMAC=m
 CONFIG_INPUT_EVDEV=y
 # CONFIG_KEYBOARD_ATKBD is not set
@@ -94,6 +98,8 @@ CONFIG_KEYBOARD_PMIC8XXX=y
 CONFIG_INPUT_JOYSTICK=y
 CONFIG_INPUT_TOUCHSCREEN=y
 CONFIG_INPUT_MISC=y
+CONFIG_INPUT_MSM_VIBRATOR=m
+CONFIG_INPUT_PM8941_PWRKEY=m
 CONFIG_INPUT_PM8XXX_VIBRATOR=y
 CONFIG_INPUT_PMIC8XXX_PWRKEY=y
 CONFIG_INPUT_UINPUT=y
@@ -127,6 +133,7 @@ CONFIG_GPIO_SYSFS=y
 CONFIG_POWER_RESET=y
 CONFIG_POWER_RESET_MSM=y
 CONFIG_CHARGER_QCOM_SMBB=y
+CONFIG_CHARGER_BQ24190=m
 CONFIG_THERMAL=y
 CONFIG_QCOM_TSENS=y
 CONFIG_MFD_PM8XXX=y
@@ -226,7 +233,11 @@ CONFIG_IIO=y
 CONFIG_IIO_BUFFER_CB=y
 CONFIG_IIO_SW_TRIGGER=y
 CONFIG_KXSD9=y
+CONFIG_QCOM_SPMI_IADC=m
+CONFIG_QCOM_SPMI_VADC=m
 CONFIG_MPU3050_I2C=y
+CONFIG_INV_MPU6050_I2C=m
+CONFIG_TSL2772=m
 CONFIG_AK8975=y
 CONFIG_IIO_HRTIMER_TRIGGER=y
 CONFIG_BMP280=y
-- 
2.17.2

