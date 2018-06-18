Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE913C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B86320850
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 12:02:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sirena.org.uk header.i=@sirena.org.uk header.b="OsovJ8IF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B86320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935095AbeFRMB6 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 08:01:58 -0400
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:48496 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933575AbeFRMB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 08:01:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sirena.org.uk; s=20170815-heliosphere; h=Date:Message-Id:In-Reply-To:
        Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:
        List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:
        List-Archive; bh=HassRNtlIEc03r5PzBir987FHavdB107lk5h3dTo3Kc=; b=OsovJ8IFCbtT
        8FL8ZiNAGuc7huWTuE/wJMTNi39FPTL9F10CMFyTGPfHLck952rCJ1+K2DGx8qOgQ02PXa4XOfHsl
        OwfleY9jZUeSaIWsO14b8Nu+zv3LBo3HmM5YCeeav+xkElIBwQPmuTUQIcba3TvdSrr6OqQpOAdRs
        7gExg=;
Received: from debutante.sirena.org.uk ([2001:470:1f1d:6b5::3] helo=debutante)
        by heliosphere.sirena.org.uk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspc-0007z1-RS; Mon, 18 Jun 2018 12:00:24 +0000
Received: from broonie by debutante with local (Exim 4.91)
        (envelope-from <broonie@sirena.org.uk>)
        id 1fUspc-0000Fh-CS; Mon, 18 Jun 2018 13:00:24 +0100
From:   Mark Brown <broonie@kernel.org>
To:     olivier moysan <olivier.moysan@st.com>
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com,
        broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@st.com,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel@stlinux.com, linux-kernel@vger.kernel.org,
        olivier.moysan@st.com, arnaud.pouliquen@st.com,
        benjamin.gaignard@st.com, alsa-devel@alsa-project.org
Subject: Applied "ASoC: stm32: sai: add iec958 controls support" to the asoc tree
In-Reply-To:  <1528730039-15757-2-git-send-email-olivier.moysan@st.com>
Message-Id: <E1fUspc-0000Fh-CS@debutante>
Date:   Mon, 18 Jun 2018 13:00:24 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The patch

   ASoC: stm32: sai: add iec958 controls support

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

From 187e01d0d56d1fd682dfaafb0b45d332abec6387 Mon Sep 17 00:00:00 2001
From: olivier moysan <olivier.moysan@st.com>
Date: Mon, 11 Jun 2018 17:13:59 +0200
Subject: [PATCH] ASoC: stm32: sai: add iec958 controls support

Add support of iec958 controls for STM32 SAI.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/stm/Kconfig         |   1 +
 sound/soc/stm/stm32_sai_sub.c | 139 +++++++++++++++++++++++++++++++---
 2 files changed, 128 insertions(+), 12 deletions(-)

diff --git a/sound/soc/stm/Kconfig b/sound/soc/stm/Kconfig
index 48f9ddd94016..9b2681397dba 100644
--- a/sound/soc/stm/Kconfig
+++ b/sound/soc/stm/Kconfig
@@ -6,6 +6,7 @@ config SND_SOC_STM32_SAI
 	depends on SND_SOC
 	select SND_SOC_GENERIC_DMAENGINE_PCM
 	select REGMAP_MMIO
+	select SND_PCM_IEC958
 	help
 	  Say Y if you want to enable SAI for STM32
 
diff --git a/sound/soc/stm/stm32_sai_sub.c b/sound/soc/stm/stm32_sai_sub.c
index cfeb219e1d78..c4f15ea14197 100644
--- a/sound/soc/stm/stm32_sai_sub.c
+++ b/sound/soc/stm/stm32_sai_sub.c
@@ -96,7 +96,8 @@
  * @slot_mask: rx or tx active slots mask. set at init or at runtime
  * @data_size: PCM data width. corresponds to PCM substream width.
  * @spdif_frm_cnt: S/PDIF playback frame counter
- * @spdif_status_bits: S/PDIF status bits
+ * @snd_aes_iec958: iec958 data
+ * @ctrl_lock: control lock
  */
 struct stm32_sai_sub_data {
 	struct platform_device *pdev;
@@ -125,7 +126,8 @@ struct stm32_sai_sub_data {
 	int slot_mask;
 	int data_size;
 	unsigned int spdif_frm_cnt;
-	unsigned char spdif_status_bits[SAI_IEC60958_STATUS_BYTES];
+	struct snd_aes_iec958 iec958;
+	struct mutex ctrl_lock; /* protect resources accessed by controls */
 };
 
 enum stm32_sai_fifo_th {
@@ -184,10 +186,6 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
 	}
 }
 
-static const unsigned char default_status_bits[SAI_IEC60958_STATUS_BYTES] = {
-	0, 0, 0, IEC958_AES3_CON_FS_48000,
-};
-
 static const struct regmap_config stm32_sai_sub_regmap_config_f4 = {
 	.reg_bits = 32,
 	.reg_stride = 4,
@@ -210,6 +208,49 @@ static const struct regmap_config stm32_sai_sub_regmap_config_h7 = {
 	.fast_io = true,
 };
 
+static int snd_pcm_iec958_info(struct snd_kcontrol *kcontrol,
+			       struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+
+	return 0;
+}
+
+static int snd_pcm_iec958_get(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *uctl)
+{
+	struct stm32_sai_sub_data *sai = snd_kcontrol_chip(kcontrol);
+
+	mutex_lock(&sai->ctrl_lock);
+	memcpy(uctl->value.iec958.status, sai->iec958.status, 4);
+	mutex_unlock(&sai->ctrl_lock);
+
+	return 0;
+}
+
+static int snd_pcm_iec958_put(struct snd_kcontrol *kcontrol,
+			      struct snd_ctl_elem_value *uctl)
+{
+	struct stm32_sai_sub_data *sai = snd_kcontrol_chip(kcontrol);
+
+	mutex_lock(&sai->ctrl_lock);
+	memcpy(sai->iec958.status, uctl->value.iec958.status, 4);
+	mutex_unlock(&sai->ctrl_lock);
+
+	return 0;
+}
+
+static const struct snd_kcontrol_new iec958_ctls = {
+	.access = (SNDRV_CTL_ELEM_ACCESS_READWRITE |
+			SNDRV_CTL_ELEM_ACCESS_VOLATILE),
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.name = SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT),
+	.info = snd_pcm_iec958_info,
+	.get = snd_pcm_iec958_get,
+	.put = snd_pcm_iec958_put,
+};
+
 static irqreturn_t stm32_sai_isr(int irq, void *devid)
 {
 	struct stm32_sai_sub_data *sai = (struct stm32_sai_sub_data *)devid;
@@ -619,6 +660,59 @@ static void stm32_sai_set_frame(struct snd_soc_dai *cpu_dai)
 	}
 }
 
+static void stm32_sai_init_iec958_status(struct stm32_sai_sub_data *sai)
+{
+	unsigned char *cs = sai->iec958.status;
+
+	cs[0] = IEC958_AES0_CON_NOT_COPYRIGHT | IEC958_AES0_CON_EMPHASIS_NONE;
+	cs[1] = IEC958_AES1_CON_GENERAL;
+	cs[2] = IEC958_AES2_CON_SOURCE_UNSPEC | IEC958_AES2_CON_CHANNEL_UNSPEC;
+	cs[3] = IEC958_AES3_CON_CLOCK_1000PPM | IEC958_AES3_CON_FS_NOTID;
+}
+
+static void stm32_sai_set_iec958_status(struct stm32_sai_sub_data *sai,
+					struct snd_pcm_runtime *runtime)
+{
+	if (!runtime)
+		return;
+
+	/* Force the sample rate according to runtime rate */
+	mutex_lock(&sai->ctrl_lock);
+	switch (runtime->rate) {
+	case 22050:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_22050;
+		break;
+	case 44100:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_44100;
+		break;
+	case 88200:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_88200;
+		break;
+	case 176400:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_176400;
+		break;
+	case 24000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_24000;
+		break;
+	case 48000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_48000;
+		break;
+	case 96000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_96000;
+		break;
+	case 192000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_192000;
+		break;
+	case 32000:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_32000;
+		break;
+	default:
+		sai->iec958.status[3] = IEC958_AES3_CON_FS_NOTID;
+		break;
+	}
+	mutex_unlock(&sai->ctrl_lock);
+}
+
 static int stm32_sai_configure_clock(struct snd_soc_dai *cpu_dai,
 				     struct snd_pcm_hw_params *params)
 {
@@ -709,7 +803,11 @@ static int stm32_sai_hw_params(struct snd_pcm_substream *substream,
 
 	sai->data_size = params_width(params);
 
-	if (!STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		/* Rate not already set in runtime structure */
+		substream->runtime->rate = params_rate(params);
+		stm32_sai_set_iec958_status(sai, substream->runtime);
+	} else {
 		ret = stm32_sai_set_slots(cpu_dai);
 		if (ret < 0)
 			return ret;
@@ -789,6 +887,20 @@ static void stm32_sai_shutdown(struct snd_pcm_substream *substream,
 	sai->substream = NULL;
 }
 
+static int stm32_sai_pcm_new(struct snd_soc_pcm_runtime *rtd,
+			     struct snd_soc_dai *cpu_dai)
+{
+	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
+
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai)) {
+		dev_dbg(&sai->pdev->dev, "%s: register iec controls", __func__);
+		return snd_ctl_add(rtd->pcm->card,
+				   snd_ctl_new1(&iec958_ctls, sai));
+	}
+
+	return 0;
+}
+
 static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 {
 	struct stm32_sai_sub_data *sai = dev_get_drvdata(cpu_dai->dev);
@@ -809,6 +921,10 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 	else
 		snd_soc_dai_init_dma_data(cpu_dai, NULL, &sai->dma_params);
 
+	/* Next settings are not relevant for spdif mode */
+	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
+		return 0;
+
 	cr1_mask = SAI_XCR1_RX_TX;
 	if (STM_SAI_IS_CAPTURE(sai))
 		cr1 |= SAI_XCR1_RX_TX;
@@ -820,10 +936,6 @@ static int stm32_sai_dai_probe(struct snd_soc_dai *cpu_dai)
 				     sai->synco, sai->synci);
 	}
 
-	if (STM_SAI_PROTOCOL_IS_SPDIF(sai))
-		memcpy(sai->spdif_status_bits, default_status_bits,
-		       sizeof(default_status_bits));
-
 	cr1_mask |= SAI_XCR1_SYNCEN_MASK;
 	cr1 |= SAI_XCR1_SYNCEN_SET(sai->sync);
 
@@ -861,7 +973,7 @@ static int stm32_sai_pcm_process_spdif(struct snd_pcm_substream *substream,
 		/* Set channel status bit */
 		byte = frm_cnt >> 3;
 		mask = 1 << (frm_cnt - (byte << 3));
-		if (sai->spdif_status_bits[byte] & mask)
+		if (sai->iec958.status[byte] & mask)
 			*ptr |= 0x04000000;
 		ptr++;
 
@@ -888,6 +1000,7 @@ static const struct snd_pcm_hardware stm32_sai_pcm_hw = {
 static struct snd_soc_dai_driver stm32_sai_playback_dai[] = {
 {
 		.probe = stm32_sai_dai_probe,
+		.pcm_new = stm32_sai_pcm_new,
 		.id = 1, /* avoid call to fmt_single_name() */
 		.playback = {
 			.channels_min = 1,
@@ -998,6 +1111,7 @@ static int stm32_sai_sub_parse_of(struct platform_device *pdev,
 			dev_err(&pdev->dev, "S/PDIF IEC60958 not supported\n");
 			return -EINVAL;
 		}
+		stm32_sai_init_iec958_status(sai);
 		sai->spdif = true;
 		sai->master = true;
 	}
@@ -1114,6 +1228,7 @@ static int stm32_sai_sub_probe(struct platform_device *pdev)
 	sai->id = (uintptr_t)of_id->data;
 
 	sai->pdev = pdev;
+	mutex_init(&sai->ctrl_lock);
 	platform_set_drvdata(pdev, sai);
 
 	sai->pdata = dev_get_drvdata(pdev->dev.parent);
-- 
2.17.1

