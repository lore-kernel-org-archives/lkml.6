Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2ABECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5A01205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 16:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="pH/NJ9R7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5A01205F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388063AbeGTRch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 13:32:37 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:56666 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731792AbeGTRch (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 13:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=9wElBBIwqm+CHiOeBHtlX9zCPwG78dkHg7fBcv4eeS4=; b=pH/NJ9R7yzlS
        dUoHn+mfm3jmzDPohe1mMAS5bkcJsCCD2Qi7y7J4zr/gSjEupqUegKfrWEopDayZv8tRjDHsFXr3f
        MYKyiHXM1kUJa7q16LdEWM/vuFs2ERY6ajgPxpTU5bKQ/Q/KJvVuL/+PQ6qpYyREIhM7KLRsqYZFP
        gPoMU=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYUs-00004u-W8; Fri, 20 Jul 2018 16:43:15 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fgYUs-0000jP-HW; Fri, 20 Jul 2018 17:43:14 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add axg sound card DT bindings documentation" to the asoc tree
In-Reply-To:  <20180717153643.8806-18-jbrunet@baylibre.com>
Message-Id: <E1fgYUs-0000jP-HW@debutante>
Date:   Fri, 20 Jul 2018 17:43:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add axg sound card DT bindings documentation

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

From 2a05c71ea17b09c88a212e8fa6be1ccddd4613ab Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:43:03 +0200
Subject: [PATCH] ASoC: meson: add axg sound card DT bindings documentation

Add the DT bindings documentation for axg sound card

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,axg-sound-card.txt | 124 ++++++++++++++++++
 1 file changed, 124 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
new file mode 100644
index 000000000000..39e005da0407
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-sound-card.txt
@@ -0,0 +1,124 @@
+Amlogic AXG sound card:
+
+Required properties:
+
+- compatible: "amlogic,axg-sound-card"
+- amlogic,name : User specified audio sound card name, one string
+
+Optional properties:
+
+- amlogic,aux-devs : List of phandles pointing to auxiliary devices
+- amlogic,widgets : Please refer to widgets.txt.
+- amlogic,routing : A list of the connections between audio components.
+
+Subnodes:
+
+- amlogic,dai-link: Container for dai-link level properties and the
+		    CODEC sub-nodes. There should be at least one (and
+		    probably) subnode of this type.
+
+Required dai-link properties:
+
+- sound-dai: phandle and port of the CPU DAI.
+
+Required TDM Backend dai-link properties:
+- dai-format : CPU/CODEC common audio format
+
+Optional TDM Backend dai-link properties:
+- dai-tdm-slot-rx-mask-{0,1,2,3}: Receive direction slot masks
+- dai-tdm-slot-tx-mask-{0,1,2,3}: Transmit direction slot masks
+				  When omitted, mask is assumed to have to no
+				  slots. A valid must have at one slot, so at
+				  least one these mask should be provided with
+				  an enabled slot.
+- dai-tdm-slot-num : Please refer to tdm-slot.txt.
+		     If omitted, slot number is set to accommodate the largest
+		     mask provided.
+- dai-tdm-slot-width : Please refer to tdm-slot.txt. default to 32 if omitted.
+- mclk-fs : Multiplication factor between stream rate and mclk
+
+Backend dai-link subnodes:
+
+- codec: dai-link representing backend links should have at least one subnode.
+	 One subnode for each codec of the dai-link.
+	 dai-link representing frontend links have no codec, therefore have no
+	 subnodes
+
+Required codec subnodes properties:
+
+- sound-dai: phandle and port of the CODEC DAI.
+
+Optional codec subnodes properties:
+
+- dai-tdm-slot-tx-mask : Please refer to tdm-slot.txt.
+- dai-tdm-slot-rx-mask : Please refer to tdm-slot.txt.
+
+Example:
+
+sound {
+	compatible = "amlogic,axg-sound-card";
+	amlogic,name = "AXG-S420";
+	amlogic,aux-devs = <&tdmin_a>, <&tdmout_c>;
+	amlogic,widgets = "Line", "Lineout",
+			  "Line", "Linein",
+			  "Speaker", "Speaker1 Left",
+			  "Speaker", "Speaker1 Right";
+			  "Speaker", "Speaker2 Left",
+			  "Speaker", "Speaker2 Right";
+	amlogic,routing = "TDMOUT_C IN 0", "FRDDR_A OUT 2",
+			  "SPDIFOUT IN 0", "FRDDR_A OUT 3",
+			  "TDM_C Playback", "TDMOUT_C OUT",
+			  "TDMIN_A IN 2", "TDM_C Capture",
+			  "TDMIN_A IN 5", "TDM_C Loopback",
+			  "TODDR_A IN 0", "TDMIN_A OUT",
+			  "Lineout", "Lineout AOUTL",
+			  "Lineout", "Lineout AOUTR",
+			  "Speaker1 Left", "SPK1 OUT_A",
+			  "Speaker2 Left", "SPK2 OUT_A",
+			  "Speaker1 Right", "SPK1 OUT_B",
+			  "Speaker2 Right", "SPK2 OUT_B",
+			  "Linein AINL", "Linein",
+			  "Linein AINR", "Linein";
+
+	amlogic,dai-link@0 {
+		sound-dai = <&frddr_a>;
+	};
+
+	amlogic,dai-link@1 {
+		sound-dai = <&toddr_a>;
+	};
+
+	amlogic,dai-link@2 {
+		sound-dai = <&tdmif_c>;
+		dai-format = "i2s";
+		dai-tdm-slot-tx-mask-2 = <1 1>;
+		dai-tdm-slot-tx-mask-3 = <1 1>;
+		dai-tdm-slot-rx-mask-1 = <1 1>;
+		mclk-fs = <256>;
+
+		codec@0 {
+			sound-dai = <&lineout>;
+		};
+
+		codec@1 {
+			sound-dai = <&speaker_amp1>;
+		};
+
+		codec@2 {
+			sound-dai = <&speaker_amp2>;
+		};
+
+		codec@3 {
+			sound-dai = <&linein>;
+		};
+
+	};
+
+	amlogic,dai-link@4 {
+		sound-dai = <&spdifout>;
+
+		codec {
+			sound-dai = <&spdif_dit>;
+		};
+	};
+};
-- 
2.18.0

