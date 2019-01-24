Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10939C282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:02:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D319E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 10:02:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ingics-com.20150623.gappssmtp.com header.i=@ingics-com.20150623.gappssmtp.com header.b="iFBtjwGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727603AbfAXKC2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 05:02:28 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37756 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725287AbfAXKC1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 05:02:27 -0500
Received: by mail-pf1-f193.google.com with SMTP id y126so2741656pfb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 02:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=X0iI5/X7ac/v4/6HfnmmJsg6Ea4T7AmBgs1w3d0DlQQ=;
        b=iFBtjwGHQgtbAP1lAgBPGJQKyD8ruJKmpgjRvqDTpdca0Ikc3/vu0yiQiuekWYN9Kj
         sSwtDFLTBfbceN0FNXt2QsJYqXBCw4XnmOehhDR5c62h1FWbCHDHoQYMyzggp7ePyQlk
         jP0l3LIuI7lH8bbHEeSeChyRX6iHUlU7JQWhrVr9CwpZyiONHUzIBcmMWXzkZugXZwav
         WgonM/RbHgN1D56b0imUfnTWVz6zWlLb+W8gz8ZjfA3T40vEDKEHRMPH/3v3bb4yfUBo
         07vOY1Nn6pYX2I6aazckW5l+eqYE/igKHBnuu91VNQ0URtkWgXi7Iy4RJHmQbE1jb2XG
         PXAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=X0iI5/X7ac/v4/6HfnmmJsg6Ea4T7AmBgs1w3d0DlQQ=;
        b=jbSH0eMNCu+IhCCeHxIELKUfwR5afoHxQe9y9C/vhWRBZ4V5FPmoMHnH7ahPEj/hkx
         RQF0AK0EUAgHdqpGY6emQ2FozFumhtnR6xg0RrEEhP+ThBrVdyVWRK4JAgvagBG3zTxh
         XRPfYaPcrCoe2/+/UZ65OMjvHnpLiAjsHdLaPAISgSUXJq1lqGOD8RL1C4JABV3nxnn5
         8Bt7R519YEVQWi2s2ZYDMNLEQYHZ0fpr3DTzQn1tU9vwuMk/KNHzVWteM3ajg82EiQOn
         03dsVCt5YFIAXkQUJSNGzj14r6yzyy9i1N8ZDarU9f3phl3ptWeQob0ovzcZAoia8Iy1
         cazQ==
X-Gm-Message-State: AJcUukee0CLQ5xcdvtxiF1y4VuM5su7eB+DCsea02G3BUBVKcFJIu+aG
        duvUanMX/6OTe+Nxm+UfyZQXHw==
X-Google-Smtp-Source: ALg8bN4cKIZEbkCT5/jDTKl+azyLtMyrat1ku0AJs3zJdqtrH/+L250/c1iCENgQW24/l8wF7kmjBA==
X-Received: by 2002:a62:f907:: with SMTP id o7mr5735209pfh.244.1548324146466;
        Thu, 24 Jan 2019 02:02:26 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id h15sm24968523pgl.43.2019.01.24.02.02.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 02:02:25 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Marek Vasut <marek.vasut+renesas@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 2/3] regulator: bd718x7: Constify regulator_ops
Date:   Thu, 24 Jan 2019 18:02:08 +0800
Message-Id: <20190124100209.12275-2-axel.lin@ingics.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124100209.12275-1-axel.lin@ingics.com>
References: <20190124100209.12275-1-axel.lin@ingics.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/bd718x7-regulator.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index b8dcdc21dc22..ccea133778c8 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -79,7 +79,7 @@ static int bd718xx_set_voltage_sel_pickable_restricted(
 	return regulator_set_voltage_sel_pickable_regmap(rdev, sel);
 }
 
-static struct regulator_ops bd718xx_pickable_range_ldo_ops = {
+static const struct regulator_ops bd718xx_pickable_range_ldo_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -88,7 +88,7 @@ static struct regulator_ops bd718xx_pickable_range_ldo_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_pickable_regmap,
 };
 
-static struct regulator_ops bd718xx_pickable_range_buck_ops = {
+static const struct regulator_ops bd718xx_pickable_range_buck_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -98,7 +98,7 @@ static struct regulator_ops bd718xx_pickable_range_buck_ops = {
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops bd718xx_ldo_regulator_ops = {
+static const struct regulator_ops bd718xx_ldo_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -107,7 +107,7 @@ static struct regulator_ops bd718xx_ldo_regulator_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
+static const struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -116,7 +116,7 @@ static struct regulator_ops bd718xx_ldo_regulator_nolinear_ops = {
 	.get_voltage_sel = regulator_get_voltage_sel_regmap,
 };
 
-static struct regulator_ops bd718xx_buck_regulator_ops = {
+static const struct regulator_ops bd718xx_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -126,7 +126,7 @@ static struct regulator_ops bd718xx_buck_regulator_ops = {
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
+static const struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
@@ -137,7 +137,7 @@ static struct regulator_ops bd718xx_buck_regulator_nolinear_ops = {
 	.set_voltage_time_sel = regulator_set_voltage_time_sel,
 };
 
-static struct regulator_ops bd718xx_dvs_buck_regulator_ops = {
+static const struct regulator_ops bd718xx_dvs_buck_regulator_ops = {
 	.enable = regulator_enable_regmap,
 	.disable = regulator_disable_regmap,
 	.is_enabled = regulator_is_enabled_regmap,
-- 
2.17.1

