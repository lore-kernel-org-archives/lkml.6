Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6090EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27814218A2
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548355626;
	bh=pbW2LyW4UJjYQ2PXTacAlYdjr8kuwPD2PprQCiFL0bU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=UKlaKrWWvQPTaj9LgVLhyucdrbFdrjLFIvzMg2HEli0YWCDMEQns/c831BdGl/RTB
	 qQdkXQJQjp7oWwIRLadFGXZzTeFDQvHI8yVg549cKB7FSO0XJamfZV0VZza4R0d2Tw
	 GXO2vahxON/qS8c0/aDvFcQXKwDNIpWBL1jgFDq8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727912AbfAXSrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 13:47:04 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:33134 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbfAXSrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 13:47:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=80xZvucTmPmsHlkTF3JWEx4EChJbinPNFCAYBS79k7E=; b=NhKrWjl5LwJm
        JJC3Y0O7tkC72xJ2y9hrjETF/np+3mqnitr5Xab+f0fLAEHihLLcmcx1SzQIx7gDO6BTFpDd9aNjd
        jBKLdXD5+kR0EyAbA2Tsx4hlp/dcLQ2TAZ8XaB//SrD6gR7hgtw4UiMi2Q3aIHF/VLtScn9Qf2tcc
        uWmYU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gmk1m-0006bl-IF; Thu, 24 Jan 2019 18:47:02 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 138B11121B6F; Thu, 24 Jan 2019 18:47:02 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: bd9571mwv: Constify regulator_ops" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190124184702.138B11121B6F@debutante.sirena.org.uk>
Date:   Thu, 24 Jan 2019 18:47:02 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: bd9571mwv: Constify regulator_ops

has been applied to the regulator tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

From e109e7111084e2c7be32c0bcc800dde20eeae126 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 24 Jan 2019 18:02:09 +0800
Subject: [PATCH] regulator: bd9571mwv: Constify regulator_ops

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/bd9571mwv-regulator.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/regulator/bd9571mwv-regulator.c b/drivers/regulator/bd9571mwv-regulator.c
index e12dd1f750f3..e690c2ce5b3c 100644
--- a/drivers/regulator/bd9571mwv-regulator.c
+++ b/drivers/regulator/bd9571mwv-regulator.c
@@ -100,7 +100,7 @@ static int bd9571mwv_reg_set_voltage_sel_regmap(struct regulator_dev *rdev,
 }
 
 /* Operations permitted on AVS voltage regulator */
-static struct regulator_ops avs_ops = {
+static const struct regulator_ops avs_ops = {
 	.set_voltage_sel	= bd9571mwv_avs_set_voltage_sel_regmap,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= bd9571mwv_avs_get_voltage_sel_regmap,
@@ -108,7 +108,7 @@ static struct regulator_ops avs_ops = {
 };
 
 /* Operations permitted on voltage regulators */
-static struct regulator_ops reg_ops = {
+static const struct regulator_ops reg_ops = {
 	.set_voltage_sel	= bd9571mwv_reg_set_voltage_sel_regmap,
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
@@ -116,13 +116,13 @@ static struct regulator_ops reg_ops = {
 };
 
 /* Operations permitted on voltage monitors */
-static struct regulator_ops vid_ops = {
+static const struct regulator_ops vid_ops = {
 	.map_voltage		= regulator_map_voltage_linear,
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.list_voltage		= regulator_list_voltage_linear,
 };
 
-static struct regulator_desc regulators[] = {
+static const struct regulator_desc regulators[] = {
 	BD9571MWV_REG("VD09", "vd09", VD09, avs_ops, 0, 0x7f,
 		      0x80, 600000, 10000, 0x3c),
 	BD9571MWV_REG("VD18", "vd18", VD18, vid_ops, BD9571MWV_VD18_VID, 0xf,
-- 
2.20.1

