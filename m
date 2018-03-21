Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752417AbeCUOaY (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 10:30:24 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:47095 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752347AbeCUOaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 10:30:16 -0400
X-Google-Smtp-Source: AG47ELuXwVAbPS3qewNgsTAV1fKN3lnLonClr20qEgrCXvX/5E2I9yUnnPsT0teLfADKAaxjWjf/Ng==
From: =?UTF-8?q?Hern=C3=A1n=20Gonzalez?= <hernan@vanguardiasur.com.ar>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, hernan@vanguardiasur.com.ar
Subject: [PATCH 05/11] staging: iio: ad7746: Remove unused defines
Date: Wed, 21 Mar 2018 11:28:53 -0300
Message-Id: <1521642539-4845-6-git-send-email-hernan@vanguardiasur.com.ar>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
References: <1521642539-4845-1-git-send-email-hernan@vanguardiasur.com.ar>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>
---
 drivers/staging/iio/cdc/ad7746.c | 16 ----------------
 drivers/staging/iio/cdc/ad7746.h |  5 -----
 2 files changed, 21 deletions(-)

diff --git a/drivers/staging/iio/cdc/ad7746.c b/drivers/staging/iio/cdc/ad7746.c
index 57623db..cba8cd1 100644
--- a/drivers/staging/iio/cdc/ad7746.c
+++ b/drivers/staging/iio/cdc/ad7746.c
@@ -25,7 +25,6 @@
  * AD7746 Register Definition
  */
 
-#define AD7746_REG_STATUS		0
 #define AD7746_REG_CAP_DATA_HIGH	1
 #define AD7746_REG_VT_DATA_HIGH		4
 #define AD7746_REG_CAP_SETUP		7
@@ -38,17 +37,10 @@
 #define AD7746_REG_CAP_GAINH		15
 #define AD7746_REG_VOLT_GAINH		17
 
-/* Status Register Bit Designations (AD7746_REG_STATUS) */
-#define AD7746_STATUS_EXCERR		BIT(3)
-#define AD7746_STATUS_RDY		BIT(2)
-#define AD7746_STATUS_RDYVT		BIT(1)
-#define AD7746_STATUS_RDYCAP		BIT(0)
-
 /* Capacitive Channel Setup Register Bit Designations (AD7746_REG_CAP_SETUP) */
 #define AD7746_CAPSETUP_CAPEN		BIT(7)
 #define AD7746_CAPSETUP_CIN2		BIT(6) /* AD7746 only */
 #define AD7746_CAPSETUP_CAPDIFF		BIT(5)
-#define AD7746_CAPSETUP_CACHOP		BIT(0)
 
 /* Voltage/Temperature Setup Register Bit Designations (AD7746_REG_VT_SETUP) */
 #define AD7746_VTSETUP_VTEN		(1 << 7)
@@ -56,13 +48,8 @@
 #define AD7746_VTSETUP_VTMD_EXT_TEMP	(1 << 5)
 #define AD7746_VTSETUP_VTMD_VDD_MON	(2 << 5)
 #define AD7746_VTSETUP_VTMD_EXT_VIN	(3 << 5)
-#define AD7746_VTSETUP_EXTREF		BIT(4)
-#define AD7746_VTSETUP_VTSHORT		BIT(1)
-#define AD7746_VTSETUP_VTCHOP		BIT(0)
 
 /* Excitation Setup Register Bit Designations (AD7746_REG_EXC_SETUP) */
-#define AD7746_EXCSETUP_CLKCTRL		BIT(7)
-#define AD7746_EXCSETUP_EXCON		BIT(6)
 #define AD7746_EXCSETUP_EXCB		BIT(5)
 #define AD7746_EXCSETUP_NEXCB		BIT(4)
 #define AD7746_EXCSETUP_EXCA		BIT(3)
@@ -74,10 +61,7 @@
 #define AD7746_CONF_CAPFS_SHIFT		3
 #define AD7746_CONF_VTFS_MASK		GENMASK(7, 6)
 #define AD7746_CONF_CAPFS_MASK		GENMASK(5, 3)
-#define AD7746_CONF_MODE_IDLE		(0 << 0)
-#define AD7746_CONF_MODE_CONT_CONV	(1 << 0)
 #define AD7746_CONF_MODE_SINGLE_CONV	(2 << 0)
-#define AD7746_CONF_MODE_PWRDN		(3 << 0)
 #define AD7746_CONF_MODE_OFFS_CAL	(5 << 0)
 #define AD7746_CONF_MODE_GAIN_CAL	(6 << 0)
 
diff --git a/drivers/staging/iio/cdc/ad7746.h b/drivers/staging/iio/cdc/ad7746.h
index ea8572d..2fbcee8 100644
--- a/drivers/staging/iio/cdc/ad7746.h
+++ b/drivers/staging/iio/cdc/ad7746.h
@@ -13,11 +13,6 @@
  * TODO: struct ad7746_platform_data needs to go into include/linux/iio
  */
 
-#define AD7466_EXCLVL_0		0 /* +-VDD/8 */
-#define AD7466_EXCLVL_1		1 /* +-VDD/4 */
-#define AD7466_EXCLVL_2		2 /* +-VDD * 3/8 */
-#define AD7466_EXCLVL_3		3 /* +-VDD/2 */
-
 struct ad7746_platform_data {
 	unsigned char exclvl;	/*Excitation Voltage Level */
 	bool exca_en;		/* enables EXCA pin as the excitation output */
-- 
2.7.4
