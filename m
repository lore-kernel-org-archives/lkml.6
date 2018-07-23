Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCFCAECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E6F920671
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 19:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="dzj2CJeG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E6F920671
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388184AbeGWUNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 16:13:55 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:52520 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388068AbeGWUNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 16:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=fOoyGJtfcUwOUsrllgW1rgBefHU11CnbCGzQL5Wxl6k=; b=dzj2CJeGoEMc
        0HEOoPtihVfdWjmRz4b+oq+Uw4YNjioD/6IHRTuZa/TM/xTU/S6UN627iX5dqRqSDnDOAksb2YIXn
        zMCrf3Zvvo+Lr8fUzI7pJgs0kFUuwQjfIxtQk2v8/88htFOSltHJ6hdJUYOR9ZMw4NhfMaSkhcZKe
        0DurQ=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fhgEl-0004XX-Uk; Mon, 23 Jul 2018 19:11:15 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id AC494112387B; Mon, 23 Jul 2018 20:11:15 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: pfuze100: add optional disable switch-regulators binding" to the regulator tree
In-Reply-To: 
Message-Id: <20180723191115.AC494112387B@debutante.sirena.org.uk>
Date:   Mon, 23 Jul 2018 20:11:15 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: pfuze100: add optional disable switch-regulators binding

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

From 78170811a2048de8e77a27a053be8b3eb3d4e556 Mon Sep 17 00:00:00 2001
From: Marco Felsch <m.felsch@pengutronix.de>
Date: Mon, 23 Jul 2018 09:47:46 +0200
Subject: [PATCH] regulator: pfuze100: add optional disable switch-regulators
 binding

This binding is used to keep the backward compatibility with the current
dtb's [1]. The binding informs the driver that the unused switch regulators
can be disabled.
If it is not specified, the driver doesn't disable the switch regulators.

[1] https://patchwork.kernel.org/patch/10490381/

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/pfuze100.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/pfuze100.txt b/Documentation/devicetree/bindings/regulator/pfuze100.txt
index 672c939045ff..c7610718adff 100644
--- a/Documentation/devicetree/bindings/regulator/pfuze100.txt
+++ b/Documentation/devicetree/bindings/regulator/pfuze100.txt
@@ -4,6 +4,15 @@ Required properties:
 - compatible: "fsl,pfuze100", "fsl,pfuze200", "fsl,pfuze3000", "fsl,pfuze3001"
 - reg: I2C slave address
 
+Optional properties:
+- fsl,pfuze-support-disable-sw: Boolean, if present disable all unused switch
+  regulators to save power consumption. Attention, ensure that all important
+  regulators (e.g. DDR ref, DDR supply) has set the "regulator-always-on"
+  property. If not present, the switched regualtors are always on and can't be
+  disabled. This binding is a workaround to keep backward compatibility with
+  old dtb's which rely on the fact that the switched regulators are always on
+  and don't mark them explicit as "regulator-always-on".
+
 Required child node:
 - regulators: This is the list of child nodes that specify the regulator
   initialization data for defined regulators. Please refer to below doc
-- 
2.18.0

