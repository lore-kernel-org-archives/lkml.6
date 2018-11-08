Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF024ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:19:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 720E920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:19:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dDyl9Au6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 720E920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbeKIBzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:55:12 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeKIBzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:55:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=wXS0Ho0F+tDND9if3IAjYfX/4lIDKAPlY9og1cqkxGs=; b=dDyl9Au6cysr
        GvMWd0dp4yJl6kM793TtjJI/VjzJZVFq23X6/TE60wnL5EjVrPqj86C7bjrXQpiPqnwVGCnzuaixV
        AsfmSo8C+cSxN/MDpDpCXZtlBBzET1GqrLirYAr9Rn5jAbkIRPcYfuRcxr8hnCjXI3NYdfndFB4ST
        C9QsU=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKn1A-0000Cz-K7; Thu, 08 Nov 2018 16:18:52 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5092F1124D9E; Thu,  8 Nov 2018 16:18:52 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: lochnagar: Explicitly include register headers" to the regulator tree
In-Reply-To: 
Message-Id: <20181108161852.5092F1124D9E@debutante.sirena.org.uk>
Date:   Thu,  8 Nov 2018 16:18:52 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: lochnagar: Explicitly include register headers

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

From fa2bb8b97d77b4b91658e448e7701d6a432e5b6f Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Thu, 8 Nov 2018 10:14:00 +0000
Subject: [PATCH] regulator: lochnagar: Explicitly include register headers

Review of the MFD component has stated we should not include the
register headers through lochnagar.h and thus removed them from that
header. Explicitly include them in the end drivers manually.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/regulator/lochnagar-regulator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/regulator/lochnagar-regulator.c b/drivers/regulator/lochnagar-regulator.c
index 2b5073b9ff86..182198246479 100644
--- a/drivers/regulator/lochnagar-regulator.c
+++ b/drivers/regulator/lochnagar-regulator.c
@@ -20,6 +20,8 @@
 #include <linux/regulator/of_regulator.h>
 
 #include <linux/mfd/lochnagar.h>
+#include <linux/mfd/lochnagar1_regs.h>
+#include <linux/mfd/lochnagar2_regs.h>
 
 static const struct regulator_ops lochnagar_micvdd_ops = {
 	.enable = regulator_enable_regmap,
-- 
2.19.0.rc2

