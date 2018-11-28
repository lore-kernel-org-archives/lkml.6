Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBD3C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E43C21019
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 12:57:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="k8kiA2VY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E43C21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbeK1X7N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 18:59:13 -0500
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:32786 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727823AbeK1X7N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 18:59:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=Xwn57SUI/LzLHGRGOCoAJupK9qcKbrs6rfIwz+5UMCc=; b=k8kiA2VY4rVm
        CodiOJpJcN8Vb/xZioboBBd/MUnNFHYiFz2+P7SG0MoVIkrGaKDrlgTkVSofOZGfLWmumW716AqSA
        fVnouPtTmiVfMxqDhYyzEErzjOqZl+i8/iZ4aF1gPm33SR+3ORIjurrMRgEIxSd2QY1QYPFGv0MD1
        FpeBg=;
Received: from 92.40.248.202.threembb.co.uk ([92.40.248.202] helo=finisterre.ee.mobilebroadband)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1gRzPH-0005Gx-QC; Wed, 28 Nov 2018 12:57:32 +0000
Received: by finisterre.ee.mobilebroadband (Postfix, from userid 1000)
        id F3C34440078; Wed, 28 Nov 2018 12:57:30 +0000 (GMT)
From:   Mark Brown <broonie@kernel.org>
To:     Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc:     Mark Brown <broonie@kernel.org>, Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, jsarha@ti.com, robh+dt@kernel.org,
        misael.lopez@ti.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: davinci-mcasp: Update PDIR (pin direction) register handling" to the asoc tree
In-Reply-To:  <20181116134141.17396-3-peter.ujfalusi@ti.com>
Message-Id: <20181128125730.F3C34440078@finisterre.ee.mobilebroadband>
Date:   Wed, 28 Nov 2018 12:57:30 +0000 (GMT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: davinci-mcasp: Update PDIR (pin direction) register handling

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

From ca3d9433349ed6a8eadfc9d0ec9e88fff439d0e9 Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Fri, 16 Nov 2018 15:41:39 +0200
Subject: [PATCH] ASoC: davinci-mcasp: Update PDIR (pin direction) register
 handling

When McASP is master and the PDIR for the clock pins are configured as
outputs before the clocking is configured it will output whatever clock
is generated at the moment internally.
The clock will switch to the correct rate only when the we start the clock
generators.

To avoid this we must only set the pin as output after the clock is
configured and enabled.

AXR pins configured as outputs behaves somehow interesting as well:
when McASP is not enabled and the pin is selected as output it will not
honor the DISMOD settings for the inactive state, but will pull the pin
down.

Add a new bitfield and mark the pins there which needs to be output and
set the pins only at the time when they will behave correctly.

On stream stop configure the pins back to input which makes them to obey
the global pin configuration regarding to pull up/down.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/davinci/davinci-mcasp.c | 88 ++++++++++++++++++++++++++-----
 sound/soc/davinci/davinci-mcasp.h | 29 ++++------
 2 files changed, 85 insertions(+), 32 deletions(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c b/sound/soc/davinci/davinci-mcasp.c
index 740030b4d37a..0f3911be1c8e 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -28,6 +28,7 @@
 #include <linux/of_device.h>
 #include <linux/platform_data/davinci_asp.h>
 #include <linux/math64.h>
+#include <linux/bitmap.h>
 
 #include <sound/asoundef.h>
 #include <sound/core.h>
@@ -95,6 +96,8 @@ struct davinci_mcasp {
 	int	sysclk_freq;
 	bool	bclk_master;
 
+	unsigned long pdir; /* Pin direction bitfield */
+
 	/* McASP FIFO related */
 	u8	txnumevt;
 	u8	rxnumevt;
@@ -169,6 +172,30 @@ static bool mcasp_is_synchronous(struct davinci_mcasp *mcasp)
 	return !(aclkxctl & TX_ASYNC) && rxfmctl & AFSRE;
 }
 
+static inline void mcasp_set_clk_pdir(struct davinci_mcasp *mcasp, bool enable)
+{
+	u32 bit = PIN_BIT_AMUTE;
+
+	for_each_set_bit_from(bit, &mcasp->pdir, PIN_BIT_AFSR + 1) {
+		if (enable)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+	}
+}
+
+static inline void mcasp_set_axr_pdir(struct davinci_mcasp *mcasp, bool enable)
+{
+	u32 bit;
+
+	for_each_set_bit(bit, &mcasp->pdir, PIN_BIT_AFSR) {
+		if (enable)
+			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+		else
+			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, BIT(bit));
+	}
+}
+
 static void mcasp_start_rx(struct davinci_mcasp *mcasp)
 {
 	if (mcasp->rxnumevt) {	/* enable FIFO */
@@ -220,6 +247,8 @@ static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 	/* Start clocks */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXHCLKRST);
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXCLKRST);
+	mcasp_set_clk_pdir(mcasp, true);
+
 	/* Activate serializer(s) */
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSERCLR);
@@ -230,6 +259,8 @@ static void mcasp_start_tx(struct davinci_mcasp *mcasp)
 	       (cnt < 100000))
 		cnt++;
 
+	mcasp_set_axr_pdir(mcasp, true);
+
 	/* Release TX state machine */
 	mcasp_set_ctl_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, TXSMRST);
 	/* Release Frame Sync generator */
@@ -260,8 +291,10 @@ static void mcasp_stop_rx(struct davinci_mcasp *mcasp)
 	 * In synchronous mode stop the TX clocks if no other stream is
 	 * running
 	 */
-	if (mcasp_is_synchronous(mcasp) && !mcasp->streams)
+	if (mcasp_is_synchronous(mcasp) && !mcasp->streams) {
+		mcasp_set_clk_pdir(mcasp, false);
 		mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, 0);
+	}
 
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLR_REG, 0);
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_RXSTAT_REG, 0xFFFFFFFF);
@@ -287,6 +320,9 @@ static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 	 */
 	if (mcasp_is_synchronous(mcasp) && mcasp->streams)
 		val =  TXHCLKRST | TXCLKRST | TXFSRST;
+	else
+		mcasp_set_clk_pdir(mcasp, false);
+
 
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_GBLCTLX_REG, val);
 	mcasp_set_reg(mcasp, DAVINCI_MCASP_TXSTAT_REG, 0xFFFFFFFF);
@@ -296,6 +332,8 @@ static void mcasp_stop_tx(struct davinci_mcasp *mcasp)
 
 		mcasp_clr_bits(mcasp, reg, FIFO_ENABLE);
 	}
+
+	mcasp_set_axr_pdir(mcasp, false);
 }
 
 static void davinci_mcasp_stop(struct davinci_mcasp *mcasp, int stream)
@@ -446,8 +484,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		/* BCLK */
+		set_bit(PIN_BIT_ACLKX, &mcasp->pdir);
+		set_bit(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		set_bit(PIN_BIT_AFSX, &mcasp->pdir);
+		set_bit(PIN_BIT_AFSR, &mcasp->pdir);
+
 		mcasp->bclk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBS_CFM:
@@ -458,8 +501,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		/* BCLK */
+		set_bit(PIN_BIT_ACLKX, &mcasp->pdir);
+		set_bit(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		clear_bit(PIN_BIT_AFSX, &mcasp->pdir);
+		clear_bit(PIN_BIT_AFSR, &mcasp->pdir);
+
 		mcasp->bclk_master = 1;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFS:
@@ -470,8 +518,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, ACLKX | ACLKR);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AFSX | AFSR);
+		/* BCLK */
+		clear_bit(PIN_BIT_ACLKX, &mcasp->pdir);
+		clear_bit(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		set_bit(PIN_BIT_AFSX, &mcasp->pdir);
+		set_bit(PIN_BIT_AFSR, &mcasp->pdir);
+
 		mcasp->bclk_master = 0;
 		break;
 	case SND_SOC_DAIFMT_CBM_CFM:
@@ -482,8 +535,13 @@ static int davinci_mcasp_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_ACLKRCTL_REG, ACLKRE);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_RXFMCTL_REG, AFSRE);
 
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG,
-			       ACLKX | AFSX | ACLKR | AHCLKR | AFSR);
+		/* BCLK */
+		clear_bit(PIN_BIT_ACLKX, &mcasp->pdir);
+		clear_bit(PIN_BIT_ACLKR, &mcasp->pdir);
+		/* Frame Sync */
+		clear_bit(PIN_BIT_AFSX, &mcasp->pdir);
+		clear_bit(PIN_BIT_AFSR, &mcasp->pdir);
+
 		mcasp->bclk_master = 0;
 		break;
 	default:
@@ -598,11 +656,11 @@ static int davinci_mcasp_set_sysclk(struct snd_soc_dai *dai, int clk_id,
 	if (dir == SND_SOC_CLOCK_OUT) {
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
+		set_bit(PIN_BIT_AHCLKX, &mcasp->pdir);
 	} else {
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_clr_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
-		mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
+		clear_bit(PIN_BIT_AHCLKX, &mcasp->pdir);
 	}
 
 	mcasp->sysclk_freq = freq;
@@ -775,17 +833,21 @@ static int mcasp_common_hw_param(struct davinci_mcasp *mcasp, int stream,
 			       mcasp->serial_dir[i]);
 		if (mcasp->serial_dir[i] == TX_MODE &&
 					tx_ser < max_active_serializers) {
-			mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AXR(i));
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
 				       DISMOD_LOW, DISMOD_MASK);
+			set_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			tx_ser++;
 		} else if (mcasp->serial_dir[i] == RX_MODE &&
 					rx_ser < max_active_serializers) {
-			mcasp_clr_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AXR(i));
+			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 			rx_ser++;
 		} else if (mcasp->serial_dir[i] == INACTIVE_MODE) {
 			mcasp_mod_bits(mcasp, DAVINCI_MCASP_XRSRCTL_REG(i),
 				       SRMOD_INACTIVE, SRMOD_MASK);
+			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
+		} else if (mcasp->serial_dir[i] == TX_MODE) {
+			/* Unused TX pins, clear PDIR  */
+			clear_bit(PIN_BIT_AXR(i), &mcasp->pdir);
 		}
 	}
 
diff --git a/sound/soc/davinci/davinci-mcasp.h b/sound/soc/davinci/davinci-mcasp.h
index afddc8010c54..acb024ab6a9d 100644
--- a/sound/soc/davinci/davinci-mcasp.h
+++ b/sound/soc/davinci/davinci-mcasp.h
@@ -108,27 +108,18 @@
 
 /*
  * DAVINCI_MCASP_PFUNC_REG - Pin Function / GPIO Enable Register Bits
- */
-#define AXR(n)		(1<<n)
-#define PFUNC_AMUTE	BIT(25)
-#define ACLKX		BIT(26)
-#define AHCLKX		BIT(27)
-#define AFSX		BIT(28)
-#define ACLKR		BIT(29)
-#define AHCLKR		BIT(30)
-#define AFSR		BIT(31)
-
-/*
  * DAVINCI_MCASP_PDIR_REG - Pin Direction Register Bits
+ * DAVINCI_MCASP_PDOUT_REG - Pin output in GPIO mode
+ * DAVINCI_MCASP_PDSET_REG - Pin input in GPIO mode
  */
-#define AXR(n)		(1<<n)
-#define PDIR_AMUTE	BIT(25)
-#define ACLKX		BIT(26)
-#define AHCLKX		BIT(27)
-#define AFSX		BIT(28)
-#define ACLKR		BIT(29)
-#define AHCLKR		BIT(30)
-#define AFSR		BIT(31)
+#define PIN_BIT_AXR(n)	(n)
+#define PIN_BIT_AMUTE	25
+#define PIN_BIT_ACLKX	26
+#define PIN_BIT_AHCLKX	27
+#define PIN_BIT_AFSX	28
+#define PIN_BIT_ACLKR	29
+#define PIN_BIT_AHCLKR	30
+#define PIN_BIT_AFSR	31
 
 /*
  * DAVINCI_MCASP_TXDITCTL_REG - Transmit DIT Control Register Bits
-- 
2.19.1

