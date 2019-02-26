Return-Path: <SRS0=tlbf=RB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147F5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D144221872
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Feb 2019 12:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551182814;
	bh=mcUY1sZAkfN89+M5wCH16iGKULy4/VBvlOgXCV7XeJ0=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=c9qWj470+OxbgrGS47A+q6a69h84+Tce3OkcEOf9oQqbwONQEucuCKfF5p7WgC+Hc
	 G2YRpx1IT/WepBTlrB8sGcHl74zmbPE9o9TKiAXWd/uDlskq6Zbv9uzgDPVja8s+ol
	 3prndkzuu32phREaYErBRA/c8l+7AOlXIdcjOSkw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727246AbfBZMGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Feb 2019 07:06:53 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58312 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfBZMGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Feb 2019 07:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4n7nOMTZ6Zb7Az3aag077TLk80GddxXDPMz1N5sHLOQ=; b=q305PRtSBkSA
        mWW39qBje2SDU9kMcOZg/rlmBTVoJ3XqyOGZNs/hja6wY5g9AM9v6c7ciWusa8087MNIebTKiQD5M
        4XyNDJaY4nagOu8MJ79qUG6DXorEqjJ6wvs4InSnI7b5auTsouumqUxhP3MeAZ/ixUFjJ6nNTGCgC
        IAN9I=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gybVX-0007ij-Hw; Tue, 26 Feb 2019 12:06:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 0965611284F0; Tue, 26 Feb 2019 12:06:47 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Axel Lin <axel.lin@ingics.com>
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: mcp16502: Remove module version" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190226120647.0965611284F0@debutante.sirena.org.uk>
Date:   Tue, 26 Feb 2019 12:06:47 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: mcp16502: Remove module version

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

From 1ec9c179c07ab6b17dd482033e0216409d46fc57 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 24 Feb 2019 14:41:10 +0800
Subject: [PATCH] regulator: mcp16502: Remove module version

The module version is unlikely to be updated, use kernel version should be
enough.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/mcp16502.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/mcp16502.c b/drivers/regulator/mcp16502.c
index 0fc4963bd5b0..3a8004abe044 100644
--- a/drivers/regulator/mcp16502.c
+++ b/drivers/regulator/mcp16502.c
@@ -547,7 +547,6 @@ static struct i2c_driver mcp16502_drv = {
 
 module_i2c_driver(mcp16502_drv);
 
-MODULE_VERSION("1.0");
 MODULE_LICENSE("GPL v2");
 MODULE_DESCRIPTION("MCP16502 PMIC driver");
 MODULE_AUTHOR("Andrei Stefanescu andrei.stefanescu@microchip.com");
-- 
2.20.1

