Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F3EAC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2994C20857
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="VLhElt92"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2994C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731429AbeGZQTV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 12:19:21 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48100 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729801AbeGZQTV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 12:19:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=eUPX1AWkX1Ooypk2rr9kSi6nOMuC+J0hsovmlnnah+M=; b=VLhElt92zCbf
        es5o1LHl/OFvLRGHFi+A5BhLDFWC2x8DaL77QzDFgQv7nhSyeKUQ3UiBIQ1BFTfPX1fdav5visi9U
        qffs+EDUuxsDLqYUAEIM3TYpORZ3jqOQVKMzllm221vgz/Ig1pFHIAhUU2ELwSLnkJ7rX2SLF0Sex
        jAtsw=;
Received: from [2a00:23c4:5d8e:0:97c8:1971:bc17:6a1a] (helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fihm3-0007gp-Px; Thu, 26 Jul 2018 15:01:51 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id 53568440078; Thu, 26 Jul 2018 16:01:51 +0100 (BST)
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: update axg sound card bindings" to the asoc tree
In-Reply-To:  <20180726124544.14740-3-jbrunet@baylibre.com>
Message-Id: <20180726150151.53568440078@finisterre.ee.mobilebroadband>
Date:   Thu, 26 Jul 2018 16:01:51 +0100 (BST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: update axg sound card bindings

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

From d9e81048127604fe6373fb76181fefcf218965f4 Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Thu, 26 Jul 2018 14:45:43 +0200
Subject: [PATCH] ASoC: meson: update axg sound card bindings

Remove the amlogic prefix in front of the generic properties and change
the card 'name' property to 'model'

Suggested-by: Rob Herring <robh@kernel.org>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,axg-sound-card.txt | 68 +++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
index 39e005da0407..80b411296480 100644
--- a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
@@ -3,19 +3,19 @@ Amlogic AXG sound card:
 Required properties:
 
 - compatible: "amlogic,axg-sound-card"
-- amlogic,name : User specified audio sound card name, one string
+- model : User specified audio sound card name, one string
 
 Optional properties:
 
-- amlogic,aux-devs : List of phandles pointing to auxiliary devices
-- amlogic,widgets : Please refer to widgets.txt.
-- amlogic,routing : A list of the connections between audio components.
+- audio-aux-devs : List of phandles pointing to auxiliary devices
+- audio-widgets : Please refer to widgets.txt.
+- audio-routing : A list of the connections between audio components.
 
 Subnodes:
 
-- amlogic,dai-link: Container for dai-link level properties and the
-		    CODEC sub-nodes. There should be at least one (and
-		    probably) subnode of this type.
+- dai-link: Container for dai-link level properties and the CODEC
+	    sub-nodes. There should be at least one (and probably more)
+	    subnode of this type.
 
 Required dai-link properties:
 
@@ -57,38 +57,38 @@ Example:
 
 sound {
 	compatible = "amlogic,axg-sound-card";
-	amlogic,name = "AXG-S420";
-	amlogic,aux-devs = <&tdmin_a>, <&tdmout_c>;
-	amlogic,widgets = "Line", "Lineout",
-			  "Line", "Linein",
-			  "Speaker", "Speaker1 Left",
-			  "Speaker", "Speaker1 Right";
-			  "Speaker", "Speaker2 Left",
-			  "Speaker", "Speaker2 Right";
-	amlogic,routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
-			  "SPDIFOUT IN 0", "FRDDR_A OUT 3",
-			  "TDM_C Playback", "TDMOUT_C OUT",
-			  "TDMIN_A IN 2", "TDM_C Capture",
-			  "TDMIN_A IN 5", "TDM_C Loopback",
-			  "TODDR_A IN 0", "TDMIN_A OUT",
-			  "Lineout", "Lineout AOUTL",
-			  "Lineout", "Lineout AOUTR",
-			  "Speaker1 Left", "SPK1 OUT_A",
-			  "Speaker2 Left", "SPK2 OUT_A",
-			  "Speaker1 Right", "SPK1 OUT_B",
-			  "Speaker2 Right", "SPK2 OUT_B",
-			  "Linein AINL", "Linein",
-			  "Linein AINR", "Linein";
-
-	amlogic,dai-link@0 {
+	model = "AXG-S420";
+	audio-aux-devs = <&tdmin_a>, <&tdmout_c>;
+	audio-widgets = "Line", "Lineout",
+			"Line", "Linein",
+			"Speaker", "Speaker1 Left",
+			"Speaker", "Speaker1 Right";
+			"Speaker", "Speaker2 Left",
+			"Speaker", "Speaker2 Right";
+	audio-routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+			"SPDIFOUT IN 0", "FRDDR_A OUT 3",
+			"TDM_C Playback", "TDMOUT_C OUT",
+			"TDMIN_A IN 2", "TDM_C Capture",
+			"TDMIN_A IN 5", "TDM_C Loopback",
+			"TODDR_A IN 0", "TDMIN_A OUT",
+			"Lineout", "Lineout AOUTL",
+			"Lineout", "Lineout AOUTR",
+			"Speaker1 Left", "SPK1 OUT_A",
+			"Speaker2 Left", "SPK2 OUT_A",
+			"Speaker1 Right", "SPK1 OUT_B",
+			"Speaker2 Right", "SPK2 OUT_B",
+			"Linein AINL", "Linein",
+			"Linein AINR", "Linein";
+
+	dai-link@0 {
 		sound-dai = <&frddr_a>;
 	};
 
-	amlogic,dai-link@1 {
+	dai-link@1 {
 		sound-dai = <&toddr_a>;
 	};
 
-	amlogic,dai-link@2 {
+	dai-link@2 {
 		sound-dai = <&tdmif_c>;
 		dai-format = "i2s";
 		dai-tdm-slot-tx-mask-2 = <1 1>;
@@ -114,7 +114,7 @@ sound {
 
 	};
 
-	amlogic,dai-link@4 {
+	dai-link@3 {
 		sound-dai = <&spdifout>;
 
 		codec {
-- 
2.18.0

