Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 215F6ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6C3920825
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 16:18:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="whEtXp3m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6C3920825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbeKIByz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 20:54:55 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:45960 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726895AbeKIByy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 20:54:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=TgdCmEKlsc58sfanjxeJb1jdEA+2pZEhHAaKeDF5XvE=; b=whEtXp3mTq62
        ejpUhqcAO2Lh+9azEW21TrE9ofncN2RxPFeSENFJcnGdUrxlaFEey1gWLAwVX2GvNz+BVrdqxCo51
        5jTUYSat3hOZh4Ln33BnpcFq40QdXKCWnzOKCc8d10WIlZhuq5ERvqnXR/ARzxUawwmno1wDelTcA
        H7ZWs=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gKn0x-0000CB-Kz; Thu, 08 Nov 2018 16:18:39 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 5B0031124D9E; Thu,  8 Nov 2018 16:18:39 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Dmitry Osipenko <digetx@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "regulator: Document new regulator-max-step-microvolt property" to the regulator tree
In-Reply-To: 
Message-Id: <20181108161839.5B0031124D9E@debutante.sirena.org.uk>
Date:   Thu,  8 Nov 2018 16:18:39 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   regulator: Document new regulator-max-step-microvolt property

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

From cb163520d4626a5965190404ec1052c70dfbd147 Mon Sep 17 00:00:00 2001
From: Dmitry Osipenko <digetx@gmail.com>
Date: Fri, 5 Oct 2018 18:36:34 +0300
Subject: [PATCH] regulator: Document new regulator-max-step-microvolt property

Certain hardware may require supply voltage to be changed in steps. Define
new property that allow to describe such hardware.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/regulator/regulator.txt | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/regulator/regulator.txt b/Documentation/devicetree/bindings/regulator/regulator.txt
index 9b525b657fca..0c3a243c95df 100644
--- a/Documentation/devicetree/bindings/regulator/regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/regulator.txt
@@ -79,6 +79,8 @@ Optional properties:
 - regulator-coupled-max-spread: Array of maximum spread between voltages of
   coupled regulators in microvolts, each value in the array relates to the
   corresponding couple specified by the regulator-coupled-with property.
+- regulator-max-step-microvolt: Maximum difference between current and target
+  voltages that can be changed safely in a single step.
 
 Deprecated properties:
 - regulator-compatible: If a regulator chip contains multiple
-- 
2.19.0.rc2

