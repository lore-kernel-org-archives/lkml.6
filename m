Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F015C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:27:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C922021019
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 12:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="rnwhQNLj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfAWM1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 07:27:01 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:35635 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbfAWM1B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 07:27:01 -0500
Received: by mail-pg1-f193.google.com with SMTP id s198so1025139pgs.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Jan 2019 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=bsR8qRzyz/YgW6Zc8INA6GIeWqXxEPXe50zmok7vXW0=;
        b=rnwhQNLjPm/y+yNdjyEyJJ0XhvAXYzPq+PpNhTCwV1LRwDrQngYdo159chENId+OYI
         nsPpPBK2t1kvEH98mHqMOFjtElLcOA2hCLjrRQbqlkxbW6GpLBCsVfehjFJIVSM2j6mQ
         kXeYrBmmO1lDlLtSNI2EzEkL1Gn5Lmg9V4Du64wWP0PX2pDjlH7k82hBjxHwpRITloRo
         i0ef+LqytvlQz4Z4XnGzZ5azWxn6lgTRZ+vANG5YRNxJ+vXLIqQcvt2lmTNtprie9nwI
         4ukSdoMK+Up6GH4x5OaKPfiDonhQqF0EDzER5zzGOalMqQsqD5CbZPSB9/khiBY3lWZK
         cZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bsR8qRzyz/YgW6Zc8INA6GIeWqXxEPXe50zmok7vXW0=;
        b=YnK35UEYbBfvFnFCByg8cUTK3jbBtS/cbQ27G4dXcrPHcxFnJSvd+zClqFujq7sn0Q
         6pgNbkycI7Nz5bWUN+VU+ygzCTu454Lt3WbwBwV7xoUcgBHdNKtT2mBmhdf5BhvNnAtE
         SaAe4EBtRBWTjGhqCNr0ta3zDLrfwz0SmOCXyGvxBJdNTVxnZhyc1nJ9GMns/tqJmTMf
         HpaNk7FVXV2Uzst8vFG3lc2052Y1iLfQfzThW9AFOOqP6A1WngsXToQlatkizqJ3HQRr
         FyoNKO8ZaqQjz6P/zdq+Vuu5Pc6J0PATFx8jiOAPyr5GdKFR7mWjJd9okmYnloWUwE9v
         w68A==
X-Gm-Message-State: AJcUukcfrqr1sDRlyNfPBLqt0bxmsaSk2kOAB/54/8ExYB2RjJ3Whqjw
        qhzLryaFee+DY2XzYTJoyKHgww==
X-Google-Smtp-Source: ALg8bN66ar2vZ0aV2fJxS8AYhmJf5eSYmAzNbYS+oNM02yNrQ/z16XEUCIZRpbycBiy5w1wQoJIDIQ==
X-Received: by 2002:a63:91c1:: with SMTP id l184mr1808447pge.29.1548246419533;
        Wed, 23 Jan 2019 04:26:59 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id o4sm45124334pgs.12.2019.01.23.04.26.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 04:26:58 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Pascal Paillet <p.paillet@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: stpmic1: Add static const qualifier at peroper places
Date:   Wed, 23 Jan 2019 20:26:39 +0800
Message-Id: <20190123122639.31954-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The regulator_linear_range arrays and stpmic1_regulator_cfgs are only
accessed by this driver and the values are never changed so make them
static const. regulator_ops variables can also be const.
Also clean up a few empty lines in regulator_linear_range array.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/stpmic1_regulator.c | 38 ++++++++++++---------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index 16ba0297f709..963e67fa9ca6 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -40,7 +40,7 @@ struct stpmic1_regulator_cfg {
 struct stpmic1_regulator {
 	unsigned int regul_id;
 	struct device_node *reg_node;
-	struct stpmic1_regulator_cfg *cfg;
+	const struct stpmic1_regulator_cfg *cfg;
 	u8 mask_reset;
 	int irq_curlim;
 	struct regmap *regmap;
@@ -75,12 +75,12 @@ enum {
 #define STPMIC1_BUCK_MODE_NORMAL 0
 #define STPMIC1_BUCK_MODE_LP BUCK_HPLP_ENABLE_MASK
 
-struct regulator_linear_range buck1_ranges[] = {
+static const struct regulator_linear_range buck1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 30, 25000),
 	REGULATOR_LINEAR_RANGE(1350000, 31, 63, 0),
 };
 
-struct regulator_linear_range buck2_ranges[] = {
+static const struct regulator_linear_range buck2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 17, 0),
 	REGULATOR_LINEAR_RANGE(1050000, 18, 19, 0),
 	REGULATOR_LINEAR_RANGE(1100000, 20, 21, 0),
@@ -94,7 +94,7 @@ struct regulator_linear_range buck2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1500000, 36, 63, 0),
 };
 
-struct regulator_linear_range buck3_ranges[] = {
+static const struct regulator_linear_range buck3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1000000, 0, 19, 0),
 	REGULATOR_LINEAR_RANGE(1100000, 20, 23, 0),
 	REGULATOR_LINEAR_RANGE(1200000, 24, 27, 0),
@@ -102,10 +102,9 @@ struct regulator_linear_range buck3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1400000, 32, 35, 0),
 	REGULATOR_LINEAR_RANGE(1500000, 36, 55, 100000),
 	REGULATOR_LINEAR_RANGE(3400000, 56, 63, 0),
-
 };
 
-struct regulator_linear_range buck4_ranges[] = {
+static const struct regulator_linear_range buck4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 27, 25000),
 	REGULATOR_LINEAR_RANGE(1300000, 28, 29, 0),
 	REGULATOR_LINEAR_RANGE(1350000, 30, 31, 0),
@@ -113,24 +112,21 @@ struct regulator_linear_range buck4_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1450000, 34, 35, 0),
 	REGULATOR_LINEAR_RANGE(1500000, 36, 60, 100000),
 	REGULATOR_LINEAR_RANGE(3900000, 61, 63, 0),
-
 };
 
-struct regulator_linear_range ldo1_ranges[] = {
+static const struct regulator_linear_range ldo1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 31, 0),
-
 };
 
-struct regulator_linear_range ldo2_ranges[] = {
+static const struct regulator_linear_range ldo2_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 30, 0),
-
 };
 
-struct regulator_linear_range ldo3_ranges[] = {
+static const struct regulator_linear_range ldo3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 30, 0),
@@ -138,18 +134,18 @@ struct regulator_linear_range ldo3_ranges[] = {
 	REGULATOR_LINEAR_RANGE(500000, 31, 31, 0),
 };
 
-struct regulator_linear_range ldo5_ranges[] = {
+static const struct regulator_linear_range ldo5_ranges[] = {
 	REGULATOR_LINEAR_RANGE(1700000, 0, 7, 0),
 	REGULATOR_LINEAR_RANGE(1700000, 8, 30, 100000),
 	REGULATOR_LINEAR_RANGE(3900000, 31, 31, 0),
 };
 
-struct regulator_linear_range ldo6_ranges[] = {
+static const struct regulator_linear_range ldo6_ranges[] = {
 	REGULATOR_LINEAR_RANGE(900000, 0, 24, 100000),
 	REGULATOR_LINEAR_RANGE(3300000, 25, 31, 0),
 };
 
-static struct regulator_ops stpmic1_ldo_ops = {
+static const struct regulator_ops stpmic1_ldo_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -161,7 +157,7 @@ static struct regulator_ops stpmic1_ldo_ops = {
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
-static struct regulator_ops stpmic1_ldo3_ops = {
+static const struct regulator_ops stpmic1_ldo3_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_iterate,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -175,7 +171,7 @@ static struct regulator_ops stpmic1_ldo3_ops = {
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
-static struct regulator_ops stpmic1_ldo4_fixed_regul_ops = {
+static const struct regulator_ops stpmic1_ldo4_fixed_regul_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -183,7 +179,7 @@ static struct regulator_ops stpmic1_ldo4_fixed_regul_ops = {
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
-static struct regulator_ops stpmic1_buck_ops = {
+static const struct regulator_ops stpmic1_buck_ops = {
 	.list_voltage = regulator_list_voltage_linear_range,
 	.map_voltage = regulator_map_voltage_linear_range,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -197,14 +193,14 @@ static struct regulator_ops stpmic1_buck_ops = {
 	.set_over_current_protection = stpmic1_set_icc,
 };
 
-static struct regulator_ops stpmic1_vref_ddr_ops = {
+static const struct regulator_ops stpmic1_vref_ddr_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.set_pull_down = regulator_set_pull_down_regmap,
 };
 
-static struct regulator_ops stpmic1_switch_regul_ops = {
+static const struct regulator_ops stpmic1_switch_regul_ops = {
 	.is_enabled = regulator_is_enabled_regmap,
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
@@ -334,7 +330,7 @@ static struct regulator_ops stpmic1_switch_regul_ops = {
 	.supply_name = #base, \
 }
 
-struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] = {
+static const struct stpmic1_regulator_cfg stpmic1_regulator_cfgs[] = {
 	[STPMIC1_BUCK1] = {
 		.desc = REG_BUCK(BUCK1, buck1),
 		.icc_reg = BUCKS_ICCTO_CR,
-- 
2.17.1

