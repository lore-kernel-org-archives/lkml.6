Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78088C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31B7420850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:00:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="bcklLpHw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31B7420850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934574AbeFRL77 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:59:59 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:44682 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934215AbeFRL7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:59:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=vczOLRD7+HcqhRcFNi3/Dox1q9WSnKKsfYgu+T9/UZY=; b=bcklLpHwDxRf
        41NNHbq5A3e5RIirRsIiImZnMy0tRGBgfUyWGYkclww244WInMxin1u1994gW+B0DreUXkcu/bvYL
        7fg0FsmDMcROfDNT1PJDFJ3a+Go7D1MGzfrqUA+Bgt/1Ync7KwXlW1mrLs/Tm0r0la13csxs+8IIX
        HVosk=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsoy-0007w2-Mv; Mon, 18 Jun 2018 11:59:44 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUsoy-0008OD-95; Mon, 18 Jun 2018 12:59:44 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, alsa-devel@alsa-project.org
Subject: Applied "ASoC: pxa: add binding for pxa2xx-ac97 audio complex" to the asoc tree
In-Reply-To:  <20180617105001.17784-1-robert.jarzmik@free.fr>
Message-Id: <E1fUsoy-0008OD-95@debutante>
Date:   Mon, 18 Jun 2018 12:59:44 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: pxa: add binding for pxa2xx-ac97 audio complex

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

From e2b35e468c89000cf3b8b5beb63fd73dfa8a5435 Mon Sep 17 00:00:00 2001
From: Robert Jarzmik <robert.jarzmik@free.fr>
Date: Sun, 17 Jun 2018 12:50:00 +0200
Subject: [PATCH] ASoC: pxa: add binding for pxa2xx-ac97 audio complex

This adds a binding for the Marvell PXA audio complex, available in
pxa2xx and pxa3xx variants.

Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../bindings/sound/marvell,pxa2xx-ac97.txt    | 27 +++++++++++++++++++
 1 file changed, 27 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt

diff --git a/Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt b/Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt
new file mode 100644
index 000000000000..2ea85d5be6a4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/marvell,pxa2xx-ac97.txt
@@ -0,0 +1,27 @@
+Marvell PXA2xx audio complex
+
+This descriptions matches the AC97 controller found in pxa2xx and pxa3xx series.
+
+Required properties:
+  - compatible: should be one of the following:
+    "marvell,pxa250-ac97"
+    "marvell,pxa270-ac97"
+    "marvell,pxa300-ac97"
+  - reg: device MMIO address space
+  - interrupts: single interrupt generated by AC97 IP
+  - clocks: input clock of the AC97 IP, refer to clock-bindings.txt
+
+Optional properties:
+  - pinctrl-names, pinctrl-0: refer to pinctrl-bindings.txt
+  - reset-gpios: gpio used for AC97 reset, refer to gpio.txt
+
+Example:
+	ac97: sound@40500000 {
+		compatible = "marvell,pxa250-ac97";
+		reg = < 0x40500000 0x1000 >;
+		interrupts = <14>;
+		reset-gpios = <&gpio 113 GPIO_ACTIVE_HIGH>;
+		#sound-dai-cells = <1>;
+		pinctrl-names = "default";
+		pinctrl-0 = < &pmux_ac97_default >;
+	};
-- 
2.17.1

