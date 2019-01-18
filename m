Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63A3C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BFC420850
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547836736;
	bh=GUVyqtBpAh1ueQ2iabQj9cqbDh2ZtFLfmIpv9HE5i7A=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=DgiSxmVnvbqwcWH5wsAZtnm+eE5R9xn/orD1GQxO3ayBeubI4cmVVxbAspF2Rlukv
	 1tp0jrC5FAlNJu42O8jdgHufsxYxEvnuHQvrcadlUByOTzpRyPRRu+Rurne3M2j+ye
	 m7vC9ikxKN05mroRnDXc8vU5+LEsM3e6gC4yD/qQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729247AbfARSiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 13:38:54 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57890 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728892AbfARSix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 13:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=DZOSWtEhi0IVv6gv4mzuWFnN0gAwCNuVSO53P1JmmiA=; b=URHnV5Qesb6R
        sBs/8ujc3WrY4znkCaSSZzKBcRNbPP7ILtf+EfUn9qJT9B0khH+AdNywQ+k8XJ7szMgOrFya5dlEU
        +3Jrhkp12Swh4I30G4cv/JeAAljkxnM9vLlzlpI8dmo1MbOT7js4D0P3SN57t10c5i/oQYlXq1AYK
        AVwW0=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gkZ2V-0005N6-B8; Fri, 18 Jan 2019 18:38:47 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id F098211276E7; Fri, 18 Jan 2019 18:38:46 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lochnagar: Add missing MODULE_DEVICE_TABLE" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190118183846.F098211276E7@debutante.sirena.org.uk>
Date:   Fri, 18 Jan 2019 18:38:46 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Add missing MODULE_DEVICE_TABLE

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

From 692f8b56bb6afa06895d2723a033822994c1fe59 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Fri, 18 Jan 2019 11:36:30 +0000
Subject: [PATCH] regulator: lochnagar: Add missing MODULE_DEVICE_TABLE

Add the missing MODULE_DEVICE_TABLE and remove the comma from the
separator on the end of the of_device_id array.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lochnagar-regulator.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 5a89e6d4b9a6..2c0743e65eaf 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -232,8 +232,9 @@ static const struct of_device_id lochnagar_of_match[] = {
 		.compatible = "cirrus,lochnagar2-vddcore",
 		.data = &lochnagar_regulators[LOCHNAGAR_VDDCORE],
 	},
-	{},
+	{}
 };
+MODULE_DEVICE_TABLE(of, lochnagar_of_match);
 
 static int lochnagar_regulator_probe(struct platform_device *pdev)
 {
-- 
2.20.1

