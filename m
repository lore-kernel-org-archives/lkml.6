Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E82D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:49:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B97352147C
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551199772;
	bh=89aN79C7kL39NP6Lby/7EG1dksPb5vMz/bfFlPv1a6w=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=PpMFsxjNNuBikirGIguSNhpBEp8VBow4BjFzLe/pO67AK+rA44XvXzfn34kPH9UxR
	 2SjrP22ki60pfIcypL0PHq4Me62giacKEzPiYsaAlWAYU5hNv4brqhz33Rkh++V7CI
	 gbWE1QEcBzpzU+zhoqBLj4IiBiknAkPMBCGBRtYM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbfBZQtb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 11:49:31 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52908 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726801AbfBZQta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 11:49:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=sPm7k8uhu2TYRpHQ5g80LfZBH9PthCUz44hVv/kT1IM=; b=aMyU5+97Z9L8
        gnlPQWlRhmEyVcLO+0lXXzBDOThLyqrphUGr5vi80OP1FSdNvT7XnAdFd7PnEiLMh4UeruO2fLy2+
        5sxBuX8TYdP7QqOmORAzsisGb+cpdHP0YjSVpYgI/qsp5tYl+ECujTj4pSBHZdtpIImUjzHYT64xT
        9KkWc=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gyfuz-0000IG-V6; Tue, 26 Feb 2019 16:49:22 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 2EB7F1121A0A; Tue, 26 Feb 2019 16:49:21 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Tony Lindgren <tony@atomide.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "regulator: cpcap: Constify omap4_regulators and xoom_regulators" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226164921.2EB7F1121A0A@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 16:49:21 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: cpcap: Constify omap4_regulators and xoom_regulators

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

From 6145601b225f617e4b257068d1fc3cbcabd9746b Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Tue, 26 Feb 2019 13:52:30 +0800
Subject: [PATCH] regulator: cpcap: Constify omap4_regulators and
 xoom_regulators

They should never change, make them const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/cpcap-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/cpcap-regulator.c b/drivers/regulator/cpcap-regulator.c
index c15ced1b5968..e7dab5c4d1d1 100644
--- a/drivers/regulator/cpcap-regulator.c
+++ b/drivers/regulator/cpcap-regulator.c
@@ -334,7 +334,7 @@ static const unsigned int vaudio_val_tbl[] = { 0, 2775000, };
  * SW1 to SW4 and SW6 seems to be unused for mapphone. Note that VSIM and
  * VSIMCARD have a shared resource assignment bit.
  */
-static struct cpcap_regulator omap4_regulators[] = {
+static const struct cpcap_regulator omap4_regulators[] = {
 	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
 		  0, 0, 0, 0, 0),
@@ -410,7 +410,7 @@ static struct cpcap_regulator omap4_regulators[] = {
 	{ /* sentinel */ },
 };
 
-static struct cpcap_regulator xoom_regulators[] = {
+static const struct cpcap_regulator xoom_regulators[] = {
 	CPCAP_REG(SW1, CPCAP_REG_S1C1, CPCAP_REG_ASSIGN2,
 		  CPCAP_BIT_SW1_SEL, unknown_val_tbl,
 		  0, 0, 0, 0, 0),
-- 
2.20.1

