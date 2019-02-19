Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6DB1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7434621479
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576868;
	bh=uNCL7lkdZKb42ZY+X9p/OHzhh7ToBltahtV+4wmVXIw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=wnyijlvGjHQWNNBu3CdAGOXcQ7GOdJGbCgX8fk+0I8EVryZyCaBvWhBfNZVHW2MzU
	 bXdoLUzDmKo2oGsQyml8zJ62FKedfm5vnsWqtdJLAuS/QHWwtWzs7TfzPEQv5QUQzf
	 kf6MZHl9V3AVEFT+W5QbxH/iMCwkrdTI7fb39Tco=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728503AbfBSLrr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:47:47 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56630 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbfBSLrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=T9FRXjm3wYRqxfzUDTLYBLeQSBA6LicNZE8laXiG9Pg=; b=VkWhmEBuNxD/
        OEsX7BuhWY2Ao86CRpkyr+R6O5KcKrhtm8vQW7LvoS7pNAzbwrEGQSbcsgS3WNsNehCU7VzJn5nQ/
        LE/Q/W89hARywRm6H+Nq+M3t6wrSuUITWNlZj1/Nr/3vHTFhs9UJXib9fLJRR6vG15ISd22L+1hvV
        12rDE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3s0-0008Tc-Ns; Tue, 19 Feb 2019 11:47:28 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5640C11284A7; Tue, 19 Feb 2019 11:47:28 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     pascal paillet <p.paillet@st.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: stpmic1: Use regulator mode definition from bindings" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219114728.5640C11284A7@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:28 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: stpmic1: Use regulator mode definition from bindings

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

From b9058da8199dfdcdb6a83c60dd7d84e1c88e7d07 Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Tue, 19 Feb 2019 10:04:31 +0000
Subject: [PATCH] regulator: stpmic1: Use regulator mode definition from
 bindings

Get the regulator mode definition from the bindings header.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/stpmic1_regulator.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/stpmic1_regulator.c b/drivers/regulator/stpmic1_regulator.c
index d456fb5d4044..c25f82fc28f4 100644
--- a/drivers/regulator/stpmic1_regulator.c
+++ b/drivers/regulator/stpmic1_regulator.c
@@ -12,6 +12,8 @@
 #include <linux/regulator/machine.h>
 #include <linux/regulator/of_regulator.h>
 
+#include <dt-bindings/mfd/st,stpmic1.h>
+
 /**
  * stpmic1 regulator description
  * @desc: regulator framework description
@@ -68,9 +70,6 @@ enum {
 /* Enable time worst case is 5000mV/(2250uV/uS) */
 #define PMIC_ENABLE_TIME_US 2200
 
-#define STPMIC1_BUCK_MODE_NORMAL 0
-#define STPMIC1_BUCK_MODE_LP BUCK_HPLP_ENABLE_MASK
-
 static const struct regulator_linear_range buck1_ranges[] = {
 	REGULATOR_LINEAR_RANGE(600000, 0, 30, 25000),
 	REGULATOR_LINEAR_RANGE(1350000, 31, 63, 0),
-- 
2.20.1

