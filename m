Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB9FAC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A953520892
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 18:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544724700;
	bh=3IJzxXbaJklnfpvGgvul2pBHKGfLHRDVGX+K9757tGw=;
	h=From:To:Cc:Subject:In-Reply-To:Date:List-ID:From;
	b=OHHgHANtN6QwFemMTUhEvD/OO4EamV69l0xroMA7t1D1e69259e7/nVTpK2jv6dtj
	 HvLHyWWSbWsNQ8NPa7kSYSSQrv32wE6gTf06RiEvUUzPFbpRdLGNSFoxKsFchpaGbX
	 Je1P+cpWTO/QLv3sJFjUyddH2Xp/gvkfHu92k5vY=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A953520892
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729765AbeLMSLj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 13:11:39 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:37316 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729613AbeLMSLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 13:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=PJvBoSy7I/n1utfMYZM7cPizZKJpmJ1inkdeBjTtdd4=; b=mz1Zi8bfrNhA
        99gWT5+oG4Q/PJ6NIwaejlDlA27BJaUDI3cF5z7e0NDFJZlWp88U4b3cSwasmATII5htWRgHpDa9X
        detW1k8LnV/h7k2BzrhdHA1e6JW+ZN0mae4celd38hGM3D1V3xo9sUMjgP31vccgRVqkBq6sl4tfH
        dL/ec=;
Received: from cpc102320-sgyl38-2-0-cust46.18-2.cable.virginm.net ([82.37.168.47] helo=debutante.sirena.org.uk)
        by heliosphere.sirena.org.uk with esmtpa (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gXVSA-0002QF-5W; Thu, 13 Dec 2018 18:11:18 +0000
Received: by debutante.sirena.org.uk (Postfix, from userid 1000)
        id D38D311254D1; Thu, 13 Dec 2018 18:11:17 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Maruthi Srinivas Bayyavarapu 
        <maruthi.srinivas.bayyavarapu@xilinx.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Vishal Sagar <vsagar@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        alsa-devel@alsa-project.org
Subject: Applied "dt-bindings: ASoC: xlnx, i2s: Document i2s bindings" to the asoc tree
In-Reply-To:  <1544207558-72508-2-git-send-email-maruthi.srinivas.bayyavarapu@xilinx.com>
X-Patchwork-Hint: ignore
Message-Id: <20181213181117.D38D311254D1@debutante.sirena.org.uk>
Date:   Thu, 13 Dec 2018 18:11:17 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   dt-bindings: ASoC: xlnx, i2s: Document i2s bindings

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

From 644c2dcf2f2ea113602aa24170d3203942d3d140 Mon Sep 17 00:00:00 2001
From: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Date: Sat, 8 Dec 2018 00:02:36 +0530
Subject: [PATCH] dt-bindings: ASoC: xlnx, i2s: Document i2s bindings

Added documentation for I2S IP core DT bindings.

Signed-off-by: Maruthi Srinivas Bayyavarapu <maruthi.srinivas.bayyavarapu@xilinx.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 .../devicetree/bindings/sound/xlnx,i2s.txt    | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/xlnx,i2s.txt

diff --git a/Documentation/devicetree/bindings/sound/xlnx,i2s.txt b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
new file mode 100644
index 000000000000..5e7c7d5bb60a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/xlnx,i2s.txt
@@ -0,0 +1,28 @@
+Device-Tree bindings for Xilinx I2S PL block
+
+The IP supports I2S based playback/capture audio
+
+Required property:
+ - compatible: "xlnx,i2s-transmitter-1.0" for playback and
+	       "xlnx,i2s-receiver-1.0" for capture
+
+Required property common to both I2S playback and capture:
+ - reg: Base address and size of the IP core instance.
+ - xlnx,dwidth: sample data width. Can be any of 16, 24.
+ - xlnx,num-channels: Number of I2S streams. Can be any of 1, 2, 3, 4.
+		      supported channels = 2 * xlnx,num-channels
+
+Example:
+
+	i2s_receiver@a0080000 {
+		compatible = "xlnx,i2s-receiver-1.0";
+		reg = <0x0 0xa0080000 0x0 0x10000>;
+		xlnx,dwidth = <0x18>;
+		xlnx,num-channels = <1>;
+	};
+	i2s_transmitter@a0090000 {
+		compatible = "xlnx,i2s-transmitter-1.0";
+		reg = <0x0 0xa0090000 0x0 0x10000>;
+		xlnx,dwidth = <0x18>;
+		xlnx,num-channels = <1>;
+	};
-- 
2.19.0.rc2

