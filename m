Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABDA5C282CA
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:24:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 744722133F
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 14:24:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="ZjOY/ZcU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfA0OYM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 09:24:12 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:40259 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726511AbfA0OYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 09:24:11 -0500
Received: by mail-pl1-f194.google.com with SMTP id u18so6601299plq.7
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 06:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=Vcbc/kbmi+EHjFYqlPvU7XnQO2HoaYQfmZEVK0PCW2E=;
        b=ZjOY/ZcU8QbUVhenRfHdRRd7zH9+bUGYokqSelvjadqEhR3NZVcubjuANDj8bPwWoE
         atj+6k0uIZOeo+QxQXBau0BvTvkK9ZyVEjcqOoa1SA8p3LdpmfbFctYFpPORK0cc0Rco
         G/GYrfTNkpDxdsU7gWo3XdpIFar45LGppjWM3bZsmTIpV9EZolTfV2uafxzfzQa22Ohr
         lzTyf1z1mH1MdtObuk/Kq6HSekJq9uHsb8FvRmc2xz2mGonp3poDH+EOTXtpsimRyVvW
         YvDfgGQazBzxeQMTNONeKXOJ8CdIgy30TIZJQPqtLzmJ4uyfsQxfH0/aKHMRagUXChgB
         Hj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Vcbc/kbmi+EHjFYqlPvU7XnQO2HoaYQfmZEVK0PCW2E=;
        b=nOw6GFs7GlgOS/hFj91gF3O2KttvhE03RMmbO7Pl1b+ildDN0g86qgAmfpnHTYtUkg
         ohlYN1BN4jwpTfe2ZLBQXpjP2zulnwhgQdof9+toaFEvRnlHMR1/oA9yHFlY8c0m0csn
         nzypheUiaxJ7WYvrMpHEiQWXPWsEYQipqN6yc/yp5rZxcqlD5by3QPhOtDsWJeRxv6Fc
         Jg13dvoJsuFPkFDCcqEjMaNqIC2FoPnrwkgJiGU8jH3yIPp9kTX7HFYdis9/JR/EtAJN
         6BTNEMRZSlhUHL7TZMMCO8DL32gxUjgxKib7sVipN9Wc5Pjv7RympLiIMxJe4XvQTYR/
         Htxg==
X-Gm-Message-State: AJcUukcdGY7HjvJrkMuhFPsbcv20WEBZqJLucRLDMdK07tPVNMOfzZy7
        gqYmbRBSe5VZlPlpJGGAZaZHhw==
X-Google-Smtp-Source: ALg8bN4fmWgFB+pD1LMuWl8CFfzFmeFWenblbM5rHNQmIUBFT7aZSrllWlXGPqoHKJD1ARUF+4NTYg==
X-Received: by 2002:a17:902:209:: with SMTP id 9mr18625938plc.288.1548599050829;
        Sun, 27 Jan 2019 06:24:10 -0800 (PST)
Received: from localhost.localdomain (36-239-222-123.dynamic-ip.hinet.net. [36.239.222.123])
        by smtp.gmail.com with ESMTPSA id f67sm46757219pfc.141.2019.01.27.06.24.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 06:24:09 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Chris Zhong <zyw@rock-chips.com>,
        Wadim Egorov <w.egorov@phytec.de>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: rk808: Constify regulator_ops
Date:   Sun, 27 Jan 2019 22:23:43 +0800
Message-Id: <20190127142344.26612-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While at it, also fix indent for rk805_reg_ops and rk805_switch_ops.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/rk808-regulator.c | 42 ++++++++++++++---------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/regulator/rk808-regulator.c b/drivers/regulator/rk808-regulator.c
index 213b68743cc8..c18ed632c95d 100644
--- a/drivers/regulator/rk808-regulator.c
+++ b/drivers/regulator/rk808-regulator.c
@@ -363,28 +363,28 @@ static int rk808_set_suspend_disable(struct regulator_dev *rdev)
 				  rdev->desc->enable_mask);
 }
 
-static struct regulator_ops rk805_reg_ops = {
-		.list_voltage           = regulator_list_voltage_linear,
-		.map_voltage            = regulator_map_voltage_linear,
-		.get_voltage_sel        = regulator_get_voltage_sel_regmap,
-		.set_voltage_sel        = regulator_set_voltage_sel_regmap,
-		.enable                 = regulator_enable_regmap,
-		.disable                = regulator_disable_regmap,
-		.is_enabled             = regulator_is_enabled_regmap,
-		.set_suspend_voltage    = rk808_set_suspend_voltage,
-		.set_suspend_enable     = rk805_set_suspend_enable,
-		.set_suspend_disable    = rk805_set_suspend_disable,
+static const struct regulator_ops rk805_reg_ops = {
+	.list_voltage           = regulator_list_voltage_linear,
+	.map_voltage            = regulator_map_voltage_linear,
+	.get_voltage_sel        = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel        = regulator_set_voltage_sel_regmap,
+	.enable                 = regulator_enable_regmap,
+	.disable                = regulator_disable_regmap,
+	.is_enabled             = regulator_is_enabled_regmap,
+	.set_suspend_voltage    = rk808_set_suspend_voltage,
+	.set_suspend_enable     = rk805_set_suspend_enable,
+	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
-static struct regulator_ops rk805_switch_ops = {
-		.enable                 = regulator_enable_regmap,
-		.disable                = regulator_disable_regmap,
-		.is_enabled             = regulator_is_enabled_regmap,
-		.set_suspend_enable     = rk805_set_suspend_enable,
-		.set_suspend_disable    = rk805_set_suspend_disable,
+static const struct regulator_ops rk805_switch_ops = {
+	.enable                 = regulator_enable_regmap,
+	.disable                = regulator_disable_regmap,
+	.is_enabled             = regulator_is_enabled_regmap,
+	.set_suspend_enable     = rk805_set_suspend_enable,
+	.set_suspend_disable    = rk805_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_buck1_2_ops = {
+static const struct regulator_ops rk808_buck1_2_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= rk808_buck1_2_get_voltage_sel_regmap,
@@ -399,7 +399,7 @@ static struct regulator_ops rk808_buck1_2_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_reg_ops = {
+static const struct regulator_ops rk808_reg_ops = {
 	.list_voltage		= regulator_list_voltage_linear,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -412,7 +412,7 @@ static struct regulator_ops rk808_reg_ops = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_reg_ops_ranges = {
+static const struct regulator_ops rk808_reg_ops_ranges = {
 	.list_voltage		= regulator_list_voltage_linear_range,
 	.map_voltage		= regulator_map_voltage_linear_range,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -425,7 +425,7 @@ static struct regulator_ops rk808_reg_ops_ranges = {
 	.set_suspend_disable	= rk808_set_suspend_disable,
 };
 
-static struct regulator_ops rk808_switch_ops = {
+static const struct regulator_ops rk808_switch_ops = {
 	.enable			= regulator_enable_regmap,
 	.disable		= regulator_disable_regmap,
 	.is_enabled		= regulator_is_enabled_regmap,
-- 
2.17.1

