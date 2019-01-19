Return-Path: <SRS0=awCL=P3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC589C61CE8
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:36:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B8882084C
	for <linux-kernel@archiver.kernel.org>; Sat, 19 Jan 2019 12:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="L+TnCh1V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728055AbfASMg5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 19 Jan 2019 07:36:57 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:36189 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbfASMg4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jan 2019 07:36:56 -0500
Received: by mail-pl1-f196.google.com with SMTP id g9so7593147plo.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jan 2019 04:36:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=uFTBOHxnqCUPbadQymZ3mdmjgd4AjHv6OkdDBLVR+3Y=;
        b=L+TnCh1Vop5nq+EFY+04Ckc2Eop2yb4M2djUSMtajjJNzVp8IyhPvBzmg3lyFBG7IS
         OOtdg1pE5MMcGi0GbJ75tXSgZNtjq/RoUnA2kDn5DfSUub3EXPqfLQnMxyu1oJYy6urv
         W3oeUXK0ZmPrLXJuvUhngQRBAqTaLsQCx9TmV50wd6qMP3Bs2K0985LvTKFGbAWWC6QS
         ZSTQr0H3DK1tw4+SKuqiTfngRoHR/b3kZHn6KBh+alDu0YfeY/Y251/hpCfaG+qczjLh
         WinDi7waN/LuOHnsyUpHseriGk0N7ET9kNToWsqGYOBdhZLmO3Co+QoAKrH1dnIBkIZj
         6FEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=uFTBOHxnqCUPbadQymZ3mdmjgd4AjHv6OkdDBLVR+3Y=;
        b=NQD8ZiJ5idqbAswsFW2a8lPvtD3bNqeEqxYIPSc3xOROoArS+1i0g9Axcl/AX6sq6V
         znFTGgVIqqo+sUEjWEe4D/6M/V5gboFFQ6d43mz1Zf/2+R3fPKuQ7suOST5LHc7A44Z0
         0rLqLVkwxrdi6HaW5aOFHy40/3bvv+MHYnusbYiEFZ5hjdNSSThIlj0qBK/eE55ziJZ2
         xACrxyTgtthX0RqP/8cmDfR7Vb41VNP5xqf+xWMpvlIXGC71mdBSdbP9pXJ04+uGyVTZ
         5pxRInTEQYE0FuDTd+OdpfTZoHV71paUWD0h+BiwHF5TjcmfjQ+k5OQVMz2DiCMuzre1
         ztTg==
X-Gm-Message-State: AJcUukdakvzyihhm5sAlttgUFWLfJfqboFSY8HNEjAgz4WHJpKL4A6sy
        itSM88uFOqqG8KfcECRj6aVYUg==
X-Google-Smtp-Source: ALg8bN6PalwqyYr2LqJ+QJyjF1XXedpsYmTZY2mKVSl7KEQote4Uw/UbHIoXp618SObcEWH4ZzrxVA==
X-Received: by 2002:a17:902:981:: with SMTP id 1mr22236009pln.142.1547901415683;
        Sat, 19 Jan 2019 04:36:55 -0800 (PST)
Received: from localhost.localdomain (118-171-134-87.dynamic-ip.hinet.net. [118.171.134.87])
        by smtp.gmail.com with ESMTPSA id m85sm11971004pfj.171.2019.01.19.04.36.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jan 2019 04:36:54 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: arizona-ldo1: Convert to use regulator_linear_range for ldo1_hc
Date:   Sat, 19 Jan 2019 20:36:36 +0800
Message-Id: <20190119123636.19525-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/arizona-ldo1.c | 37 ++++++++------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/drivers/regulator/arizona-ldo1.c b/drivers/regulator/arizona-ldo1.c
index b9a93049e41e..dfed6d3f03ad 100644
--- a/drivers/regulator/arizona-ldo1.c
+++ b/drivers/regulator/arizona-ldo1.c
@@ -40,30 +40,6 @@ struct arizona_ldo1 {
 	struct gpio_desc *ena_gpiod;
 };
 
-static int arizona_ldo1_hc_list_voltage(struct regulator_dev *rdev,
-					unsigned int selector)
-{
-	if (selector >= rdev->desc->n_voltages)
-		return -EINVAL;
-
-	if (selector == rdev->desc->n_voltages - 1)
-		return 1800000;
-	else
-		return rdev->desc->min_uV + (rdev->desc->uV_step * selector);
-}
-
-static int arizona_ldo1_hc_map_voltage(struct regulator_dev *rdev,
-				       int min_uV, int max_uV)
-{
-	int sel;
-
-	sel = DIV_ROUND_UP(min_uV - rdev->desc->min_uV, rdev->desc->uV_step);
-	if (sel >= rdev->desc->n_voltages)
-		sel = rdev->desc->n_voltages - 1;
-
-	return sel;
-}
-
 static int arizona_ldo1_hc_set_voltage_sel(struct regulator_dev *rdev,
 					   unsigned sel)
 {
@@ -113,14 +89,19 @@ static int arizona_ldo1_hc_get_voltage_sel(struct regulator_dev *rdev)
 }
 
 static const struct regulator_ops arizona_ldo1_hc_ops = {
-	.list_voltage = arizona_ldo1_hc_list_voltage,
-	.map_voltage = arizona_ldo1_hc_map_voltage,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
 	.get_voltage_sel = arizona_ldo1_hc_get_voltage_sel,
 	.set_voltage_sel = arizona_ldo1_hc_set_voltage_sel,
 	.get_bypass = regulator_get_bypass_regmap,
 	.set_bypass = regulator_set_bypass_regmap,
 };
 
+static const struct regulator_linear_range arizona_ldo1_hc_ranges[] = {
+	REGULATOR_LINEAR_RANGE(900000, 0, 0x6, 50000),
+	REGULATOR_LINEAR_RANGE(1800000, 0x7, 0x7, 0),
+};
+
 static const struct regulator_desc arizona_ldo1_hc = {
 	.name = "LDO1",
 	.supply_name = "LDOVDD",
@@ -129,8 +110,8 @@ static const struct regulator_desc arizona_ldo1_hc = {
 
 	.bypass_reg = ARIZONA_LDO1_CONTROL_1,
 	.bypass_mask = ARIZONA_LDO1_BYPASS,
-	.min_uV = 900000,
-	.uV_step = 50000,
+	.linear_ranges = arizona_ldo1_hc_ranges,
+	.n_linear_ranges = ARRAY_SIZE(arizona_ldo1_hc_ranges),
 	.n_voltages = 8,
 	.enable_time = 1500,
 	.ramp_delay = 24000,
-- 
2.17.1

