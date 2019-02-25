Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60850C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25EF820652
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551131124;
	bh=ZXjDvH5wFP6mXWq/+3GHYNgx1ScuqlOiOmUfI+QVG+Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=aQ+XteHtMl8dR2RFYybzpXuxwf/1T0K+Ni3J0UVVM+XXAXYdEWULAFEE3/nRB2W+5
	 leF9PB9p5zf2cKi2WbXpnB4fYMhvRmnzeWcmB/Yf/689Ia1zRz7f8gtZ8/j8st7lt6
	 MqfZDFGpGmVgWS98PbzAkdNtDAXMi0gsoJAmWMtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731690AbfBYVpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:45:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfBYV3W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:29:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8FE22084D;
        Mon, 25 Feb 2019 21:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551130161;
        bh=ZXjDvH5wFP6mXWq/+3GHYNgx1ScuqlOiOmUfI+QVG+Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eimf+/Gl1FD9HdQLtEiO6Lo20lkMf+cE5I1kJLcq1CE0NJMd0GvYUPs3F8fU1hre9
         Sms4HLCpBmLULg/hd2s4HiBbAs4oWGUt3GI3zLDFwawRRSlVWetZm8PUS/rwECEMCo
         hamXnOtJ4UpukSGvWPyOYeTozwWbji3EJ1ZqePb0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
        Oskari Lemmela <oskari@lemmela.net>,
        Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 034/183] mfd: axp20x: Re-align MFD cell entries
Date:   Mon, 25 Feb 2019 22:10:07 +0100
Message-Id: <20190225195100.445175348@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195054.748060397@linuxfoundation.org>
References: <20190225195054.748060397@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index dfc3cff1d08b4..8037b4e01ed67 100644
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



