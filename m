Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A14BBC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B4FD2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549647513;
	bh=JTtF6ah6Cr+6Ez1xO7g0tSHejag8MxwaGEpGs5XH9ng=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=cQkSLGcOi+5BJ+difpIz4AdgWrwPqCFWNwUvg2IOM1zirAKjAxRDVvXDmVOlbp1/9
	 9mTLnjX4Djj/cFjvE91OnDXRMLQgstInD+z6H4bvK73wRDfY/UZ3rO71LA8Zwmfn7O
	 x9NVdcY5r3d88RoXFVEkP83GwX+S4siSPfZTbK2c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbfBHRfR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:17 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:57446 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727994AbfBHRfM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 12:35:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=jAhNKtgZ95iRAW5JXj+tgYu1F+MBck1cit6JH2EURgU=; b=QdVKaEfFa1qN
        LgB/CsfyaanXWVwr2rAYjwKVDoxAHa9eToW1rVjjN1smEg4Dsfz7WVIyjKZC98R1NzjerthH1y3ML
        8rW13aVU/qCV0ady5yKNe9QjR6QFm73ULwHN+dbN2oQy4YOqLp7MTNEI4FTyNh60zB9u2thz45FcN
        9sHm8=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gsA3S-0002JU-Mg; Fri, 08 Feb 2019 17:35:10 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id 4D3291127F2F; Fri,  8 Feb 2019 17:35:10 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: Applied "dt-bindings: regulator: update fixed-regulator example" to the regulator tree
In-Reply-To: 
X-Patchwork-Hint: ignore
Message-Id: <20190208173510.4D3291127F2F@debutante.sirena.org.uk>
Date:   Fri,  8 Feb 2019 17:35:10 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: regulator: update fixed-regulator example

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

From b735f41dcb06ae06acab2618b8814fe2dd1fca90 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Fri, 8 Feb 2019 15:04:25 +0100
Subject: [PATCH] dt-bindings: regulator: update fixed-regulator example

Fixed regulators do not have associated bus addresses and are typically
placed directly under the root node where their names must still be
unique despite not having a unit address.

Fix the malformed example node which had a unit address but no "reg"
property by dropping the unit address.

Also, try to make the example more useful by using the recommended
generic node name "regulator", but with a suffix reflecting the
regulator name in order to make it unique.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/regulator/fixed-regulator.yaml        | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
index a7607b0baab7..d289c2f7455a 100644
--- a/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
+++ b/Documentation/devicetree/bindings/regulator/fixed-regulator.yaml
@@ -52,9 +52,9 @@ required:
 
 examples:
   - |
-    abc: fixedregulator@0 {
+    reg_1v8: regulator-1v8 {
       compatible = "regulator-fixed";
-      regulator-name = "fixed-supply";
+      regulator-name = "1v8";
       regulator-min-microvolt = <1800000>;
       regulator-max-microvolt = <1800000>;
       gpio = <&gpio1 16 0>;
-- 
2.20.1

