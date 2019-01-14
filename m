Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0707C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A620C20656
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 12:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547467291;
	bh=HwHMMPcUyY8CyzZ1wrvC4BxQ98Vp/BNqQwJVx69IFA4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=oQT9ZrqLny6S99rwE2J/fRM+WfjbwBf2gYDBO8vE2D4eXJwqwTiwn7m9i/et6yJz4
	 SBt6slylk8Jh7MK4UJtDbkZb7t42TSuZ9deu5xChCNRiOmNF4Eu0qliFsyOleZYBjk
	 ei+RTMlfeL3rJZmxsNQENUEYvpqkxpYN4Bu3odWY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfANMBa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 07:01:30 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57012 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726414AbfANMB3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 07:01:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=lOLjNDaFP2aqDA7MgUH9jkSfnCTKyh7B5nq1/Dm3dak=; b=QnyAMaMjJMBo
        KzGqSVFxKDqBU9HAr6Rw/uwIHhjMFVNEmdMFkA4E1o7GuGOIqxX9Ceh1+TQfEsO2jlPUYv6l9nVSh
        vfNEf8W3ArHk7++uZehvnFcFOL+ejd/Xex0tMPFHl8qHK2PwW7054E0KdEI2Ou99rs6u/AxCY/xrs
        XLJ2U=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gj0vn-0004tR-IF; Mon, 14 Jan 2019 12:01:27 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 35BC61127AD2; Mon, 14 Jan 2019 12:01:27 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190114120127.35BC61127AD2@debutante.sirena.org.uk>
Date:   Mon, 14 Jan 2019 12:01:27 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

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

From f01a7beb6791f1c419424c1a6958b7d0a289c974 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 10 Jan 2019 17:26:16 +0800
Subject: [PATCH] regulator: act8865: Fix act8600_sudcdc_voltage_ranges setting

The act8600_sudcdc_voltage_ranges setting does not match the datasheet.

The problems in below entry:
  REGULATOR_LINEAR_RANGE(19000000, 191, 255, 400000),

1. The off-by-one min_sel causes wrong volatage calculation.
   The min_sel should be 192.
2. According to the datasheet[1] Table 7. (on page 43):
   The selector 248 (0b11111000) ~ 255 (0b11111111) are 41.400V.

Also fix off-by-one for ACT8600_SUDCDC_VOLTAGE_NUM.

[1] https://active-semi.com/wp-content/uploads/ACT8600_Datasheet.pdf

Fixes: df3a950e4e73 ("regulator: act8865: Add act8600 support")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/act8865-regulator.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/act8865-regulator.c b/drivers/regulator/act8865-regulator.c
index 21e20483bd91..e0239cf3f56d 100644
--- a/drivers/regulator/act8865-regulator.c
+++ b/drivers/regulator/act8865-regulator.c
@@ -131,7 +131,7 @@
  * ACT8865 voltage number
  */
 #define	ACT8865_VOLTAGE_NUM	64
-#define ACT8600_SUDCDC_VOLTAGE_NUM	255
+#define ACT8600_SUDCDC_VOLTAGE_NUM	256
 
 struct act8865 {
 	struct regmap *regmap;
@@ -222,7 +222,8 @@ static const struct regulator_linear_range act8600_sudcdc_voltage_ranges[] = {
 	REGULATOR_LINEAR_RANGE(3000000, 0, 63, 0),
 	REGULATOR_LINEAR_RANGE(3000000, 64, 159, 100000),
 	REGULATOR_LINEAR_RANGE(12600000, 160, 191, 200000),
-	REGULATOR_LINEAR_RANGE(19000000, 191, 255, 400000),
+	REGULATOR_LINEAR_RANGE(19000000, 192, 247, 400000),
+	REGULATOR_LINEAR_RANGE(41400000, 248, 255, 0),
 };
 
 static struct regulator_ops act8865_ops = {
-- 
2.20.1

