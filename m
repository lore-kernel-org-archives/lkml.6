Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3CC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 285B32147A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 11:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550576859;
	bh=OC6EqUVQB1uT7CBAOwPLw2H0yT2h96+3KqWC8bXdPro=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cu4K/RxxTm83t8YqASORWJC4a8FsBa7pCbhqGGBy3G/B21CkTEtOw//55Jyqxkcls
	 lZRfh1gnUuIDKkODe7qMly1G9ZVmjDYZuP+061YRf/ocmB+QRPbA7ItAg8BTMsVr4N
	 wJw2Bt8aCcByc6bIpwzqfbymxXMu6SkcHLfP0oFg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728465AbfBSLrh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 06:47:37 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56728 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727915AbfBSLre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 06:47:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=YSPW22hRTJqlDr00Z4y4l0+kAZVEcGPBV0/AHXz+4o4=; b=c6GeQa3zjceX
        rQGP4MAbYYcDADpvNtn30/z2yVpR1tcw+/rX/yniK48NFlwsNvXy5xv9K1mkMUNK6xEdy1KYJU0I/
        R9mMKRSrV7u+J3lSAkgau4jkg8pbjX6i1ZzyWM1WsSYN0oNabVro0z9MV6CYbvkml22EG/zlmT/rG
        /whcI=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gw3s4-0008TW-4z; Tue, 19 Feb 2019 11:47:32 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id A2CF111284A6; Tue, 19 Feb 2019 11:47:26 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Pascal PAILLET-LME <p.paillet@st.com>
Cc:     pascal paillet <p.paillet@st.com>, Mark Brown <broonie@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: regulator: remove interrupt-parent description on stpmic1" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190219114726.A2CF111284A6@debutante.sirena.org.uk>
Date:   Tue, 19 Feb 2019 11:47:26 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: remove interrupt-parent description on stpmic1

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

From cde999e2a7b238ef46875a724d3630e168d94f4d Mon Sep 17 00:00:00 2001
From: Pascal PAILLET-LME <p.paillet@st.com>
Date: Tue, 19 Feb 2019 10:04:32 +0000
Subject: [PATCH] dt-bindings: regulator: remove interrupt-parent description
 on stpmic1

The interrupt parent description is not needed as the parent is a parent
node with 'interrupt-controller' property.

Signed-off-by: pascal paillet <p.paillet@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/st,stpmic1-regulator.txt     | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
index a3f476240565..de27897d3f3a 100644
--- a/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
+++ b/Documentation/devicetree/bindings/regulator/st,stpmic1-regulator.txt
@@ -29,7 +29,6 @@ Optional properties:
     if set, all regulators are switched off in case of over-current detection
     on this regulator,
     if not set, the driver only sends an over-current event.
-- interrupt-parent: phandle to the parent interrupt controller
 - interrupts: index of current limit detection interrupt
 - <regulator>-supply: phandle to the parent supply/regulator node
 	each regulator supply can be described except vref_ddr.
@@ -43,7 +42,6 @@ regulators {
 	vdd_core: buck1 {
 		regulator-name = "vdd_core";
 		interrupts = <IT_CURLIM_BUCK1 0>;
-		interrupt-parent = <&pmic>;
 		st,mask-reset;
 		regulator-pull-down;
 		regulator-min-microvolt = <700000>;
@@ -53,7 +51,6 @@ regulators {
 	v3v3: buck4 {
 		regulator-name = "v3v3";
 		interrupts = <IT_CURLIM_BUCK4 0>;
-		interrupt-parent = <&mypmic>;
 
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
-- 
2.20.1

