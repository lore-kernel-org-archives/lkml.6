Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2950DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD7B2147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576851;
	bh=J1A6UUVQKmfhpMiL8AVk+xgwXTH+GBJqkCEhRtMGmCg=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=Yc+9hQh5FaSEieAJrYc1VrQRIpW5ywPrKtksLOzlYxk/DhQW8D1h1Sh+0ny7hrVSq
	 WIACvoNBOhlqgbAOxS291ctK5pXYKZbgUJZugbvCBJotv4iQv+Z1tfu6fRpT4J0rCX
	 OQ0YMroUJZ0cSLd8+Wy0l0Dv+qPopVlg/ih95zDI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728321AbfBSLr3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:47:29 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56498 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727857AbfBSLr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=4Q5ILBUdQ6a3dhJG5pODJTms4cVLyGMSqPghjhXHvWg=; b=CvCQ765yFH3J
        LGNVgD3s1unnH4usr3eTqYDAxzGNIONUt05oPvkv4n3nCzRzzfTzDrETGzCn2IK2NlOibxDzRrWmZ
        irQSZYGswUAdo3xSb1/xvtrnSXC+DfxYg1KEbpjLtAGWW7BsmPQmtdqtsXicTvWmKVDWGoYbJsmIm
        gEJZE=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3rv-0008T9-Va; Tue, 19 Feb 2019 11:47:24 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 329EA11284A6; Tue, 19 Feb 2019 11:47:23 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     Pascal Paillet <p.paillet@st.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: regulator: remove regulator pull-down support for stpmic1" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219114723.329EA11284A6@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:23 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: remove regulator pull-down support for stpmic1

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

From f369788894a483f9e703b13c0841ee0069eed758 Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Tue, 19 Feb 2019 10:04:33 +0000
Subject: [PATCH] dt-bindings: regulator: remove regulator pull-down support
 for stpmic1

Regulator high pull down are enabled by default so remove support in the
driver.

Signed-off-by: Pascal Paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/st,stpmic1-regulator.txt      | 2 --
 1 file changed, 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
index de27897d3f3a..bf9385b11da6 100644
--- a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
@@ -23,8 +23,6 @@ Switches are fixed voltage regulators with only enable/disable capability.
 Optional properties:
 - st,mask-reset: mask reset for this regulator: the regulator configuration
   is maintained during pmic reset.
-- regulator-pull-down: enable high pull down
-  if not specified light pull down is used
 - regulator-over-current-protection:
     if set, all regulators are switched off in case of over-current detection
     on this regulator,
-- 
2.20.1

