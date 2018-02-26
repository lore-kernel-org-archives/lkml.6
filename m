Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeBZLVn (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 06:21:43 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:58444 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752048AbeBZLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 06:21:41 -0500
From: Mark Brown <broonie@kernel.org>
To: Olivier Moysan <olivier.moysan@st.com>
Cc: olivier moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, robh@kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@stlinux.com, linux-kernel@vger.kernel.org,
        olivier.moysan@st.com, arnaud.pouliquen@st.com,
        benjamin.gaignard@st.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: Add S/PDIF to SAI bindings" to the asoc tree
In-Reply-To: <1519052437-24011-2-git-send-email-olivier.moysan@st.com>
Message-Id: <E1eqGpT-0006EP-2M@debutante>
Date: Mon, 26 Feb 2018 11:20:23 +0000
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: Add S/PDIF to SAI bindings

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

>From 994f46610bafd75a5881544bce9dd3acdbe3626a Mon Sep 17 00:00:00 2001
From: Olivier Moysan <olivier.moysan@st.com>
Date: Mon, 19 Feb 2018 16:00:35 +0100
Subject: [PATCH] ASoC: stm32: Add S/PDIF to SAI bindings

Add S/PDIF IEC6958 protocol support to STM32 SAI bindings.

Signed-off-by: olivier moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 Documentation/devicetree/bindings/sound/st,stm32-sai.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
index b1acc1a256ba..f301cdf0b7e6 100644
--- a/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
+++ b/Documentation/devicetree/bindings/sound/st,stm32-sai.txt
@@ -45,6 +45,12 @@ SAI subnodes Optional properties:
 	This property sets SAI sub-block as slave of another SAI sub-block.
 	Must contain the phandle and index of the sai sub-block providing
 	the synchronization.
+  - st,iec60958: support S/PDIF IEC6958 protocol for playback
+	IEC60958 protocol is not available for capture.
+	By default, custom protocol is assumed, meaning that protocol is
+	configured according to protocol defined in related DAI link node,
+	such as i2s, left justified, right justified, dsp and pdm protocols.
+	Note: ac97 protocol is not supported by SAI driver
 
 The device node should contain one 'port' child node with one child 'endpoint'
 node, according to the bindings defined in Documentation/devicetree/bindings/
-- 
2.16.1
