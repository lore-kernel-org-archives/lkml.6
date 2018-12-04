Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E76C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:27:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17FD22081C
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="kxLmWbLT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17FD22081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbeLDR12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:27:28 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44020 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726042AbeLDR12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:27:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=GGvcLdxVaAG3EXYSPKPSJ5TfyFYVOapbIuhjn/KsGI0=; b=kxLmWbLTbMe4
        dor55wp51m1K/RNCdJ6YJ+Upxb/DiG1HBiO7ivPyowKybO4uxNOa7b9dJulrd0kavgwvKG76HhTHG
        Xwc+9p6x81yPwXoFXImaVmafQk9K2DVcoTAaTSnNVl9New0Tx5u+izjaoPHePNMsw2RN68+hzE9wx
        JMSkU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gUETk-0007xQ-Lm; Tue, 04 Dec 2018 17:27:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5848811251E3; Tue,  4 Dec 2018 17:27:24 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Allow regulator nodes to contain their own init data" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20181204172724.5848811251E3@debutante.sirena.org.uk>
Date:   Tue,  4 Dec 2018 17:27:24 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Allow regulator nodes to contain their own init data

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

From eba9473f6761d8df6cabf278b272cc5466733737 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 29 Nov 2018 10:28:21 +0000
Subject: [PATCH] regulator: Allow regulator nodes to contain their own init
 data

Currently it is expected that regulator init data will be defined as a
series of sub-nodes from the node that bound in the driver. Add support
for a node to both bind in a driver and contain init data for that
regulator.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/of_regulator.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/of_regulator.c b/drivers/regulator/of_regulator.c
index 4bb8928bdb3f..ffa5fc3724e4 100644
--- a/drivers/regulator/of_regulator.c
+++ b/drivers/regulator/of_regulator.c
@@ -380,12 +380,16 @@ struct device_node *regulator_of_get_init_node(struct device *dev,
 	if (!dev->of_node || !desc->of_match)
 		return NULL;
 
-	if (desc->regulators_node)
+	if (desc->regulators_node) {
 		search = of_get_child_by_name(dev->of_node,
 					      desc->regulators_node);
-	else
+	} else {
 		search = of_node_get(dev->of_node);
 
+		if (!strcmp(desc->of_match, search->name))
+			return search;
+	}
+
 	if (!search) {
 		dev_dbg(dev, "Failed to find regulator container node '%s'\n",
 			desc->regulators_node);
-- 
2.19.0.rc2

