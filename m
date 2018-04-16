Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754494AbeDPKQh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 06:16:37 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:52054 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753994AbeDPKOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 06:14:08 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180416101406epoutp0256b5c27092845b80cf6c075d7138e986~l4wISxzfM0421804218epoutp029
X-AuditID: b6c32a48-8c1ff70000000ff2-cb-5ad4776eab12
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 07/14] thermal: exynos: remove parsing of
 samsung,tmu_noise_cancel_mode property
Date: Mon, 16 Apr 2018 12:11:58 +0200
Message-id: <1523873525-23718-8-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsWy7bCmuW5e+ZUog4aDKhYbZ6xntZj3WdZi
        /pVrrBb9j18zW5w/v4Hd4vKuOWwWn3uPMFrMOL+PyeLJwz42B06PnbPusnss3vOSyWPTqk42
        jzvX9rB59G1ZxejxeZNcAFsUl01Kak5mWWqRvl0CV8bfB99ZCiaLVry7OYGlgfGdYBcjJ4eE
        gInE+g2/2bsYuTiEBHYwSsw+OwnK+c4oceXeW2aYqpPzZ7NCJDYwSiw8O4cZwvnFKLH/4jEm
        kCo2ASuJie2rGEFsEQEtiROXtjOBFDELTGCSePpqJhtIQlggSWL1lS5WEJtFQFXi1+NPYA28
        Ah4SC84tZoFYJydx8thksBpOAU+JpjXX2EAGSQgsYJOYuLCXDaLIReL3rSNQ9wlLvDq+hR3C
        lpZ4tmojI0RDM6PEtx17oIomMErsWS8EYVtLHD5+EWwDswCfRMfhv0DNHEBxXomONqgSD4nL
        3+5CHeQo8e30H2jAzGGU+PF0I+sERqkFjAyrGMVSC4pz01OLjQpM9IoTc4tL89L1kvNzNzGC
        41bLYwfjgXM+hxgFOBiVeHh3nL0cJcSaWFZcmXuIUYKDWUmEd1kiUIg3JbGyKrUoP76oNCe1
        +BCjNAeLkjhvg++ZKCGB9MSS1OzU1ILUIpgsEwenVAOj//07bQEStt+Kby6+E2BefHpB+fJP
        LOde3nHZ2OGRfsSt6sVbBcvbukq7WbgO5Ly4/v9ExbwLtszs0xb6u046fba2+/YR273ah7Ul
        Dy5dby6V7bxBUMusNDEg//6JzedfSfWcav/sksV0xdCZQ8faxOaAQmbsR5dzXkkeXtwMcy3b
        3P5UWrUrsRRnJBpqMRcVJwIABiMZ+9cCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsVy+t9jQd288itRBjNuiFpsnLGe1WLeZ1mL
        +VeusVr0P37NbHH+/AZ2i8u75rBZfO49wmgx4/w+JosnD/vYHDg9ds66y+6xeM9LJo9NqzrZ
        PO5c28Pm0bdlFaPH501yAWxRXDYpqTmZZalF+nYJXBl/H3xnKZgsWvHu5gSWBsZ3gl2MnBwS
        AiYSJ+fPZu1i5OIQEljHKPG4fwmU84tRYsmliawgVWwCVhIT21cxgtgiAloSJy5tZwIpYhaY
        wCSxZO0idpCEsECSxOorXWANLAKqEr8efwJr4BXwkFhwbjELxDo5iZPHJoPVcAp4SjStucYG
        YgsB1TROvMo4gZFnASPDKkbJ1ILi3PTcYqMCo7zUcr3ixNzi0rx0veT83E2MwCDbdlirfwfj
        4yXxhxgFOBiVeHh3nL0cJcSaWFZcmXuIUYKDWUmEd1kiUIg3JbGyKrUoP76oNCe1+BCjNAeL
        kjgvf/6xSCGB9MSS1OzU1ILUIpgsEwenVAOjisimysNJGk4dUVctss+t3bom+W1i998n0fwz
        3mx7V+u27szb86Jh2+uuik8KMGKP65haIBOa23qG7ezsqj96K5p71XYtmLzggKPqrzLZkqcu
        m6PMbKpePr8bWcSTXd639Xtlm7OZ0Y056/V2Oa+9J11WKLdxFSdbou6tiecKhLLb4k71Ryso
        sRRnJBpqMRcVJwIAkZYpbS4CAAA=
X-CMS-MailID: 20180416101406epcas2p267a664bb26a00bdca6c4c176f9ce08ed
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180416101406epcas2p267a664bb26a00bdca6c4c176f9ce08ed
X-RootMTR: 20180416101406epcas2p267a664bb26a00bdca6c4c176f9ce08ed
References: <1523873525-23718-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180416101406epcas2p267a664bb26a00bdca6c4c176f9ce08ed@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All SoCs use the same value (4) for the noise cancel mode so just
make it explicit and remove parsing of samsung,tmu_noise_cancel_mode
property.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/thermal/samsung/exynos_tmu.c | 10 ++++------
 drivers/thermal/samsung/exynos_tmu.h |  3 ---
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index 7ec8061..1fa162d 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -168,6 +168,8 @@
 #define EXYNOS_FIRST_POINT_TRIM			25
 #define EXYNOS_SECOND_POINT_TRIM		85
 
+#define EXYNOS_NOISE_CANCEL_MODE		4
+
 #define MCELSIUS	1000
 /**
  * struct exynos_tmu_data : A structure to hold the private data of the TMU
@@ -368,10 +370,8 @@ static u32 get_con_reg(struct exynos_tmu_data *data, u32 con)
 	con &= ~(EXYNOS_TMU_BUF_SLOPE_SEL_MASK << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 	con |= (pdata->gain << EXYNOS_TMU_BUF_SLOPE_SEL_SHIFT);
 
-	if (pdata->noise_cancel_mode) {
-		con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
-		con |= (pdata->noise_cancel_mode << EXYNOS_TMU_TRIP_MODE_SHIFT);
-	}
+	con &= ~(EXYNOS_TMU_TRIP_MODE_MASK << EXYNOS_TMU_TRIP_MODE_SHIFT);
+	con |= (EXYNOS_NOISE_CANCEL_MODE << EXYNOS_TMU_TRIP_MODE_SHIFT);
 
 	return con;
 }
@@ -1135,8 +1135,6 @@ static int exynos_of_sensor_conf(struct device_node *np,
 	pdata->gain = (u8)value;
 	of_property_read_u32(np, "samsung,tmu_reference_voltage", &value);
 	pdata->reference_voltage = (u8)value;
-	of_property_read_u32(np, "samsung,tmu_noise_cancel_mode", &value);
-	pdata->noise_cancel_mode = (u8)value;
 
 	of_property_read_u32(np, "samsung,tmu_efuse_value",
 			     &pdata->efuse_value);
diff --git a/drivers/thermal/samsung/exynos_tmu.h b/drivers/thermal/samsung/exynos_tmu.h
index a5d8c9c..b111a01 100644
--- a/drivers/thermal/samsung/exynos_tmu.h
+++ b/drivers/thermal/samsung/exynos_tmu.h
@@ -45,8 +45,6 @@ enum soc_type {
  * @reference_voltage: reference voltage of amplifier
  *	in the positive-TC generator block
  *	0 < reference_voltage <= 31
- * @noise_cancel_mode: noise cancellation mode
- *	000, 100, 101, 110 and 111 can be different modes
  * @efuse_value: platform defined fuse value
  * @min_efuse_value: minimum valid trimming data
  * @max_efuse_value: maximum valid trimming data
@@ -57,7 +55,6 @@ enum soc_type {
 struct exynos_tmu_platform_data {
 	u8 gain;
 	u8 reference_voltage;
-	u8 noise_cancel_mode;
 
 	u32 efuse_value;
 	u32 min_efuse_value;
-- 
1.9.1
