Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE49AC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9ECF6217D6
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 20:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548188822;
	bh=QbX6TrJhi3QqFNPy485f2iCUJRxWcPeRIyrH+KQ8dhQ=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=WfNkoroyttOeyvBQLg1r3F5wiQPQxY6yK0mpIFjT8S/2mpLHpiyS3jP26l4YVofDR
	 AB4n3tHZ8jon5cb2WWU01PiQ6jdUFrami2k3qHV7nb1gY1CL2aWM0DWoMTdgStWuxt
	 UUu0/iMgT5jzHkBzfjGjC5hIG5kq7c2y6ip3SQJQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbfAVU1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 15:27:01 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52858 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726127AbfAVU07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 15:26:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=5VLBVQxBuE54bneSct0eouRZ7ruwrRlC/w0RaRfzCh4=; b=NbB+8OwPbwZc
        IKIQtBiO9aLBG1zDg/6K+7aaiUzz5+UiwR2df7wodSs3spBeiL5InsDwRbhmDJg19D8RBp45rcOC4
        LRz5burxPbfxgeEtxh9eiRz4Ub6HbNNhAKtB+0yMaSU3P+6hx9Ywgtf3EbWG3zKFzYpNZ06upbF6b
        pjJ8I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gm2dM-0007D3-GF; Tue, 22 Jan 2019 20:26:56 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 1E43D1127955; Tue, 22 Jan 2019 20:26:56 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm831x-dcdc: Convert to use regulator_linear_range for wm831x_buckv" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190122202656.1E43D1127955@debutante.sirena.org.uk>
Date:   Tue, 22 Jan 2019 20:26:56 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm831x-dcdc: Convert to use regulator_linear_range for wm831x_buckv

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

From ccffcb8e9a11fe91f3577cefeed00b1f58d51671 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 20 Jan 2019 15:33:56 +0800
Subject: [PATCH] regulator: wm831x-dcdc: Convert to use regulator_linear_range
 for wm831x_buckv

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm831x-dcdc.c | 39 ++++++++-------------------------
 1 file changed, 9 insertions(+), 30 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 5a5bc4bb08d2..4a573eea284a 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -205,33 +205,10 @@ static irqreturn_t wm831x_dcdc_oc_irq(int irq, void *data)
  * BUCKV specifics
  */
 
-static int wm831x_buckv_list_voltage(struct regulator_dev *rdev,
-				      unsigned selector)
-{
-	if (selector <= 0x8)
-		return 600000;
-	if (selector <= WM831X_BUCKV_MAX_SELECTOR)
-		return 600000 + ((selector - 0x8) * 12500);
-	return -EINVAL;
-}
-
-static int wm831x_buckv_map_voltage(struct regulator_dev *rdev,
-				   int min_uV, int max_uV)
-{
-	u16 vsel;
-
-	if (min_uV < 600000)
-		vsel = 0;
-	else if (min_uV <= 1800000)
-		vsel = DIV_ROUND_UP(min_uV - 600000, 12500) + 8;
-	else
-		return -EINVAL;
-
-	if (wm831x_buckv_list_voltage(rdev, vsel) > max_uV)
-		return -EINVAL;
-
-	return vsel;
-}
+static const struct regulator_linear_range wm831x_buckv_ranges[] = {
+	REGULATOR_LINEAR_RANGE(600000, 0, 0x7, 0),
+	REGULATOR_LINEAR_RANGE(600000, 0x8, 0x68, 12500),
+};
 
 static int wm831x_buckv_set_dvs(struct regulator_dev *rdev, int state)
 {
@@ -309,7 +286,7 @@ static int wm831x_buckv_set_suspend_voltage(struct regulator_dev *rdev,
 	u16 reg = dcdc->base + WM831X_DCDC_SLEEP_CONTROL;
 	int vsel;
 
-	vsel = wm831x_buckv_map_voltage(rdev, uV, uV);
+	vsel = regulator_map_voltage_linear_range(rdev, uV, uV);
 	if (vsel < 0)
 		return vsel;
 
@@ -368,8 +345,8 @@ static int wm831x_buckv_get_current_limit(struct regulator_dev *rdev)
 static const struct regulator_ops wm831x_buckv_ops = {
 	.set_voltage_sel = wm831x_buckv_set_voltage_sel,
 	.get_voltage_sel = wm831x_buckv_get_voltage_sel,
-	.list_voltage = wm831x_buckv_list_voltage,
-	.map_voltage = wm831x_buckv_map_voltage,
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
 	.set_suspend_voltage = wm831x_buckv_set_suspend_voltage,
 	.set_current_limit = wm831x_buckv_set_current_limit,
 	.get_current_limit = wm831x_buckv_get_current_limit,
@@ -492,6 +469,8 @@ static int wm831x_buckv_probe(struct platform_device *pdev)
 	dcdc->desc.id = id;
 	dcdc->desc.type = REGULATOR_VOLTAGE;
 	dcdc->desc.n_voltages = WM831X_BUCKV_MAX_SELECTOR + 1;
+	dcdc->desc.linear_ranges = wm831x_buckv_ranges;
+	dcdc->desc.n_linear_ranges = ARRAY_SIZE(wm831x_buckv_ranges);
 	dcdc->desc.ops = &wm831x_buckv_ops;
 	dcdc->desc.owner = THIS_MODULE;
 	dcdc->desc.enable_reg = WM831X_DCDC_ENABLE;
-- 
2.20.1

