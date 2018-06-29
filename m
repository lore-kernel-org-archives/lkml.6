Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD596C43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:15:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1C7327D9F
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 11:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1C7327D9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=loewensteinmedical.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935852AbeF2LPf (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 07:15:35 -0400
Received: from mail.steuer-voss.de ([85.183.69.95]:51586 "EHLO
        mail.steuer-voss.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933456AbeF2LPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 07:15:33 -0400
X-Greylist: delayed 602 seconds by postgrey-1.27 at vger.kernel.org; Fri, 29 Jun 2018 07:15:32 EDT
X-Virus-Scanned: Debian amavisd-new at mail.steuer-voss.de
Received: by mail.steuer-voss.de (Postfix, from userid 1000)
        id 1280541BDD; Fri, 29 Jun 2018 13:05:41 +0200 (CEST)
Message-Id: <5d00983e4fb2869fd3152a609c1fffe7616c4963.1530268235.git.nikolaus.voss@loewensteinmedical.de>
In-Reply-To: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
References: <cover.1530268235.git.nikolaus.voss@loewensteinmedical.de>
From:   Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
Date:   Fri, 29 Jun 2018 10:45:54 +0200
Subject: [PATCH 3/3] IIO: st_accel.h: sync DT and I2C device ID table strings
To:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiongfeng Wang <xiongfeng.wang@linaro.org>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I2C device ID table strings should really match the DT compatible
strings (without the manufacturer prefix) to avoid confusion. This is
especially reasonable when using ACPI PRP0001 HID /DT compatibility
entries along with the DT compatible property in DSD which is
used as a modalias (with manufacturer prefix stripped off) by the ACPI
layer and thus as i2c_board_info->type by the I2C layer.

Signed-off-by: Nikolaus Voss <nikolaus.voss@loewensteinmedical.de>
---
 drivers/iio/accel/st_accel.h | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/accel/st_accel.h b/drivers/iio/accel/st_accel.h
index 2f931e4837e5..be4a4a41f849 100644
--- a/drivers/iio/accel/st_accel.h
+++ b/drivers/iio/accel/st_accel.h
@@ -37,23 +37,23 @@ enum st_accel_type {
 	ST_ACCEL_MAX,
 };
 
-#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl_accel"
-#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl_accel"
-#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc_accel"
-#define LIS3DH_ACCEL_DEV_NAME		"lis3dh"
-#define LSM330D_ACCEL_DEV_NAME		"lsm330d_accel"
-#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl_accel"
-#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc_accel"
-#define LIS331DL_ACCEL_DEV_NAME		"lis331dl_accel"
-#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh"
-#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl_accel"
-#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh_accel"
-#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm_accel"
-#define LSM330_ACCEL_DEV_NAME		"lsm330_accel"
-#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr_accel"
-#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12_accel"
+#define H3LIS331DL_ACCEL_DEV_NAME	"h3lis331dl-accel"
+#define LIS3LV02DL_ACCEL_DEV_NAME	"lis3lv02dl-accel"
+#define LSM303DLHC_ACCEL_DEV_NAME	"lsm303dlhc-accel"
+#define LIS3DH_ACCEL_DEV_NAME		"lis3dh-accel"
+#define LSM330D_ACCEL_DEV_NAME		"lsm330d-accel"
+#define LSM330DL_ACCEL_DEV_NAME		"lsm330dl-accel"
+#define LSM330DLC_ACCEL_DEV_NAME	"lsm330dlc-accel"
+#define LIS331DL_ACCEL_DEV_NAME		"lis331dl-accel"
+#define LIS331DLH_ACCEL_DEV_NAME	"lis331dlh-accel"
+#define LSM303DL_ACCEL_DEV_NAME		"lsm303dl-accel"
+#define LSM303DLH_ACCEL_DEV_NAME	"lsm303dlh-accel"
+#define LSM303DLM_ACCEL_DEV_NAME	"lsm303dlm-accel"
+#define LSM330_ACCEL_DEV_NAME		"lsm330-accel"
+#define LSM303AGR_ACCEL_DEV_NAME	"lsm303agr-accel"
+#define LIS2DH12_ACCEL_DEV_NAME		"lis2dh12-accel"
 #define LIS3L02DQ_ACCEL_DEV_NAME	"lis3l02dq"
-#define LNG2DM_ACCEL_DEV_NAME		"lng2dm"
+#define LNG2DM_ACCEL_DEV_NAME		"lng2dm-accel"
 #define LIS2DW12_ACCEL_DEV_NAME		"lis2dw12"
 #define LIS3DHH_ACCEL_DEV_NAME		"lis3dhh"
 
-- 
2.17.1

