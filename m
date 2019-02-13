Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17887C282C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1DE1207E0
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 03:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550027064;
	bh=qfP/oAi2OZLsa1qvUPB8pF1cUEbG8ZBaAU7TfcW2HTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i8oXbGf/XbERDyyl+fip6qHLrOdAZHpf/IZ2HP/SY5eCbQIPB21HVPQ034KojIv3A
	 XgdCkUmiAzETtb6tLLFinEMOK624vQfQkOSi1m1C+zfz50eTNYiuYP6fDBif5e8Z1n
	 zVU9+Tt3io8151zidt/YB/uA61O/mJwgmVB/tP3M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387597AbfBMCeH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 21:34:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:37516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387501AbfBMCdy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 21:33:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6D60F222C7;
        Wed, 13 Feb 2019 02:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550025233;
        bh=qfP/oAi2OZLsa1qvUPB8pF1cUEbG8ZBaAU7TfcW2HTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wa7LWYMPrXDTNU3FNcf6VDXmxdw49ov0cZdyCXXFMAf0/Xa2m10gMw2Zg5E/LaOg0
         A9Ix0OcMsaPE63tRoIQsdRKAHgVFR8en2t8hNmOKFD7x9SoDLHe8642ZfBIDrIBdW3
         uCBar8H6OmPYHOgdJ9VCKhswfaFm/xsM4p0M3msM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Chen-Yu Tsai <wens@csie.org>, Oskari Lemmela <oskari@lemmela.net>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 016/105] mfd: axp20x: Re-align MFD cell entries
Date:   Tue, 12 Feb 2019 21:32:07 -0500
Message-Id: <20190213023336.19019-16-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190213023336.19019-1-sashal@kernel.org>
References: <20190213023336.19019-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit 753a8d083e085c6f552c7982749de4cc7c40e2ac ]

In the axp20x driver, the various mfd_cell lists had varying amounts
of indentation, sometimes even within the same list. For the axp288,
there's no alignment at all.

Re-align the right hand side of the assignments with the least amount
of tabs possible. Also collapse the closing bracket and the opening
bracket of the next entry onto the same line for the axp288, to be
consistent with all the other mfd_cell lists.

This patch is whitespace change only. No functionality is modified.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Oskari Lemmela <oskari@lemmela.net>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/axp20x.c | 107 +++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 56 deletions(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index dfc3cff1d08b..8037b4e01ed6 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -640,9 +640,9 @@ static const struct mfd_cell axp221_cells[] = {
 
 static const struct mfd_cell axp223_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp22x_pek_resources),
-		.resources		= axp22x_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp22x_pek_resources),
+		.resources	= axp22x_pek_resources,
 	}, {
 		.name		= "axp22x-adc",
 		.of_compatible	= "x-powers,axp221-adc",
@@ -650,7 +650,7 @@ static const struct mfd_cell axp223_cells[] = {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp221-battery-power-supply",
 	}, {
-		.name			= "axp20x-regulator",
+		.name		= "axp20x-regulator",
 	}, {
 		.name		= "axp20x-ac-power-supply",
 		.of_compatible	= "x-powers,axp221-ac-power-supply",
@@ -666,9 +666,9 @@ static const struct mfd_cell axp223_cells[] = {
 
 static const struct mfd_cell axp152_cells[] = {
 	{
-		.name			= "axp20x-pek",
-		.num_resources		= ARRAY_SIZE(axp152_pek_resources),
-		.resources		= axp152_pek_resources,
+		.name		= "axp20x-pek",
+		.num_resources	= ARRAY_SIZE(axp152_pek_resources),
+		.resources	= axp152_pek_resources,
 	},
 };
 
@@ -697,84 +697,79 @@ static const struct resource axp288_charger_resources[] = {
 
 static const struct mfd_cell axp288_cells[] = {
 	{
-		.name = "axp288_adc",
-		.num_resources = ARRAY_SIZE(axp288_adc_resources),
-		.resources = axp288_adc_resources,
-	},
-	{
-		.name = "axp288_extcon",
-		.num_resources = ARRAY_SIZE(axp288_extcon_resources),
-		.resources = axp288_extcon_resources,
-	},
-	{
-		.name = "axp288_charger",
-		.num_resources = ARRAY_SIZE(axp288_charger_resources),
-		.resources = axp288_charger_resources,
-	},
-	{
-		.name = "axp288_fuel_gauge",
-		.num_resources = ARRAY_SIZE(axp288_fuel_gauge_resources),
-		.resources = axp288_fuel_gauge_resources,
-	},
-	{
-		.name = "axp221-pek",
-		.num_resources = ARRAY_SIZE(axp288_power_button_resources),
-		.resources = axp288_power_button_resources,
-	},
-	{
-		.name = "axp288_pmic_acpi",
+		.name		= "axp288_adc",
+		.num_resources	= ARRAY_SIZE(axp288_adc_resources),
+		.resources	= axp288_adc_resources,
+	}, {
+		.name		= "axp288_extcon",
+		.num_resources	= ARRAY_SIZE(axp288_extcon_resources),
+		.resources	= axp288_extcon_resources,
+	}, {
+		.name		= "axp288_charger",
+		.num_resources	= ARRAY_SIZE(axp288_charger_resources),
+		.resources	= axp288_charger_resources,
+	}, {
+		.name		= "axp288_fuel_gauge",
+		.num_resources	= ARRAY_SIZE(axp288_fuel_gauge_resources),
+		.resources	= axp288_fuel_gauge_resources,
+	}, {
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp288_power_button_resources),
+		.resources	= axp288_power_button_resources,
+	}, {
+		.name		= "axp288_pmic_acpi",
 	},
 };
 
 static const struct mfd_cell axp803_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
-		.resources		= axp803_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
+		.resources	= axp803_pek_resources,
 	},
-	{	.name			= "axp20x-regulator" },
+	{	.name		= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_self_working_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp806_pek_resources),
-		.resources		= axp806_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp806_pek_resources),
+		.resources	= axp806_pek_resources,
 	},
-	{	.name			= "axp20x-regulator" },
+	{	.name		= "axp20x-regulator" },
 };
 
 static const struct mfd_cell axp806_cells[] = {
 	{
-		.id			= 2,
-		.name			= "axp20x-regulator",
+		.id		= 2,
+		.name		= "axp20x-regulator",
 	},
 };
 
 static const struct mfd_cell axp809_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp809_pek_resources),
-		.resources		= axp809_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp809_pek_resources),
+		.resources	= axp809_pek_resources,
 	}, {
-		.id			= 1,
-		.name			= "axp20x-regulator",
+		.id		= 1,
+		.name		= "axp20x-regulator",
 	},
 };
 
 static const struct mfd_cell axp813_cells[] = {
 	{
-		.name			= "axp221-pek",
-		.num_resources		= ARRAY_SIZE(axp803_pek_resources),
-		.resources		= axp803_pek_resources,
+		.name		= "axp221-pek",
+		.num_resources	= ARRAY_SIZE(axp803_pek_resources),
+		.resources	= axp803_pek_resources,
 	}, {
-		.name			= "axp20x-regulator",
+		.name		= "axp20x-regulator",
 	}, {
-		.name			= "axp20x-gpio",
-		.of_compatible		= "x-powers,axp813-gpio",
+		.name		= "axp20x-gpio",
+		.of_compatible	= "x-powers,axp813-gpio",
 	}, {
-		.name			= "axp813-adc",
-		.of_compatible		= "x-powers,axp813-adc",
+		.name		= "axp813-adc",
+		.of_compatible	= "x-powers,axp813-adc",
 	}, {
 		.name		= "axp20x-battery-power-supply",
 		.of_compatible	= "x-powers,axp813-battery-power-supply",
-- 
2.19.1

