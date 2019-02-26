Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07FF0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCD06217F9
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182820;
	bh=wdUdkjQa/BAAvCWQDJkyvakRCmNpfs/h5I7sGrXCEGU=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=ekvy9bCV/IZ9iSBNALtDa2jxyndVCF0ogGp6GJA4znfn1AlnsnA+No70NCn4RGMi9
	 1RhoQtcekitkKMoDbRQQbq8si6YAyp+7DtY51tqEcx1avX1E+orhYcvdHDPqak0xhV
	 R2f+flsMZ3oxufbZDpHfCsUN68P/TYv3/rqqLtEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfBZMG7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:06:59 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58482 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727268AbfBZMG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=1eDJ+lzj1tIJyBPbzjNjwHzcsg/hiWinn++xrg+3B9o=; b=jd2iyjL22a0E
        l+IBcMTTaVdyUttqninGPUKzHC+lzTjEVd/d4lYDn+FWdYUrBNfOsWxgyqHXLK03WrXh2QZuzj+2m
        1bvnGULI0uYCq7q3lcveD+ZuxHqQJmbQNbNV9wROtbaRn13bQ3wQ2fOH7XkD5I1lUh09d1RrPVv9S
        tqCKk=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybVc-0007j6-Sd; Tue, 26 Feb 2019 12:06:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4F23911284E3; Tue, 26 Feb 2019 12:06:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: wm831x-dcdc: Fix list of wm831x_dcdc_ilim from mA to uA" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226120652.4F23911284E3@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: wm831x-dcdc: Fix list of wm831x_dcdc_ilim from mA to uA

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

From c25d47888f0fb3d836d68322d4aea2caf31a75a6 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 24 Feb 2019 21:16:51 +0800
Subject: [PATCH] regulator: wm831x-dcdc: Fix list of wm831x_dcdc_ilim from mA
 to uA

The wm831x_dcdc_ilim entries needs to be uA because it is used to compare
with min_uA and max_uA.
While at it also make the array const and change to use unsigned int.

Fixes: e4ee831f949a ("regulator: Add WM831x DC-DC buck convertor support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/wm831x-dcdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/wm831x-dcdc.c b/drivers/regulator/wm831x-dcdc.c
index 5a5bc4bb08d2..df591435d12a 100644
--- a/drivers/regulator/wm831x-dcdc.c
+++ b/drivers/regulator/wm831x-dcdc.c
@@ -327,8 +327,8 @@ static int wm831x_buckv_get_voltage_sel(struct regulator_dev *rdev)
 }
 
 /* Current limit options */
-static u16 wm831x_dcdc_ilim[] = {
-	125, 250, 375, 500, 625, 750, 875, 1000
+static const unsigned int wm831x_dcdc_ilim[] = {
+	125000, 250000, 375000, 500000, 625000, 750000, 875000, 1000000
 };
 
 static int wm831x_buckv_set_current_limit(struct regulator_dev *rdev,
-- 
2.20.1

