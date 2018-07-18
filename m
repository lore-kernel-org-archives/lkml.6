Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F70ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE2FE20850
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 12:27:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="iKJIY0nW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE2FE20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731186AbeGRNFE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 09:05:04 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:46550 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726747AbeGRNFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 09:05:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=EkFqJYFKmGUmHC+chBNeENndJ2TbWzrY3qsFqhVwk0E=; b=iKJIY0nWlyZX
        o8Jfo+2WjOdIJo0yu9md6wq0EWW/nMuoGbqZilitkrpl9B5iwiGLpq0TgCX4aUdp2ir+DjFVMRFip
        VPoz4OHBf1A6b/Mv4XRx1a/lkNB2tokvFcGw/nJNeSYPHj7+EukbCh0+hdOA6Y6WCM1E05Kkdd5Uc
        P9bAc=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflXv-0003VG-19; Wed, 18 Jul 2018 12:27:07 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fflXu-0007H0-JJ; Wed, 18 Jul 2018 13:27:06 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: meson: add axg fifos DT binding documentation" to the asoc tree
In-Reply-To:  <20180717153643.8806-2-jbrunet@baylibre.com>
Message-Id: <E1fflXu-0007H0-JJ@debutante>
Date:   Wed, 18 Jul 2018 13:27:06 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: meson: add axg fifos DT binding documentation

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

From e32d99af6830c9a8f37b4f2637ef0cdc60fa79fb Mon Sep 17 00:00:00 2001
From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue, 17 Jul 2018 17:42:50 +0200
Subject: [PATCH] ASoC: meson: add axg fifos DT binding documentation

Add the DT bindings documentation for axg's FIFOs: TODDR and FRDDR.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/amlogic,axg-fifo.txt       | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt

diff --git a/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
new file mode 100644
index 000000000000..3dfc2515e5c6
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/amlogic,axg-fifo.txt
@@ -0,0 +1,23 @@
+* Amlogic Audio FIFO controllers
+
+Required properties:
+- compatible: 'amlogic,axg-toddr' or
+	      'amlogic,axg-frddr'
+- reg: physical base address of the controller and length of memory
+       mapped region.
+- interrupts: interrupt specifier for the fifo.
+- clocks: phandle to the fifo peripheral clock provided by the audio
+	  clock controller.
+- resets: phandle to memory ARB line provided by the arb reset controller.
+- #sound-dai-cells: must be 0.
+
+Example of FRDDR A on the A113 SoC:
+
+frddr_a: audio-controller@1c0 {
+	compatible = "amlogic,axg-frddr";
+	reg = <0x0 0x1c0 0x0 0x1c>;
+	#sound-dai-cells = <0>;
+	interrupts = <GIC_SPI 88 IRQ_TYPE_EDGE_RISING>;
+	clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
+	resets = <&arb AXG_ARB_FRDDR_A>;
+};
-- 
2.18.0

