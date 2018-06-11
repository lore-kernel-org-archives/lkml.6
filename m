Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id La3+Cl2SHlsGFwAAmS7hNA
	; Mon, 11 Jun 2018 15:17:15 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id E089C60791; Mon, 11 Jun 2018 15:17:14 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 3025460791;
	Mon, 11 Jun 2018 15:17:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3025460791
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=st.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754220AbeFKPRM (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 11:17:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:7554 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753988AbeFKPRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 11:17:11 -0400
Received: from pps.filterd (m0046037.ppops.net [127.0.0.1])
        by mx07-.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id w5BEsReo005141;
        Mon, 11 Jun 2018 17:14:08 +0200
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 2jg4nr1k2c-1
        (version=TLSv1 cipher=ECDHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 11 Jun 2018 17:14:08 +0200
Received: from zeta.dmz-eu.st.com (zeta.dmz-eu.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 5922D31;
        Mon, 11 Jun 2018 15:14:07 +0000 (GMT)
Received: from Webmail-eu.st.com (Safex1hubcas21.st.com [10.75.90.44])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3439F2D5F;
        Mon, 11 Jun 2018 15:14:07 +0000 (GMT)
Received: from SAFEX1HUBCAS22.st.com (10.75.90.93) by SAFEX1HUBCAS21.st.com
 (10.75.90.44) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun
 2018 17:14:07 +0200
Received: from localhost (10.201.23.16) by Webmail-ga.st.com (10.75.90.48)
 with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 11 Jun 2018 17:14:06
 +0200
From: Olivier Moysan <olivier.moysan@st.com>
To: <lgirdwood@gmail.com>, <broonie@kernel.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <mcoquelin.stm32@gmail.com>,
        <alexandre.torgue@st.com>, <alsa-devel@alsa-project.org>,
        <linux-arm-kernel@lists.infradead.org>, <kernel@stlinux.com>,
        <linux-kernel@vger.kernel.org>, <olivier.moysan@st.com>
CC: <arnaud.pouliquen@st.com>, <benjamin.gaignard@st.com>
Subject: [PATCH v2 1/1] ASoC: stm32: sai: add iec958 controls support
Date: Mon, 11 Jun 2018 17:13:59 +0200
Message-ID: <1528730039-15757-2-git-send-email-olivier.moysan@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1528730039-15757-1-git-send-email-olivier.moysan@st.com>
References: <1528730039-15757-1-git-send-email-olivier.moysan@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.23.16]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-06-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support of iec958 controls for STM32 SAI.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/Kconfig         |   1 +
 sound/soc/stm/stm32_sai_sub.c | 139 ++++++++++++++++++++++++++++++++++++++----
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
@@ -210,6 +208,49 @@ static bool stm32_sai_sub_writeable_reg(struct device *dev, unsigned int reg)
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
 
@@ -888,6 +1000,7 @@ static int stm32_sai_pcm_process_spdif(struct snd_pcm_substream *substream,
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
1.9.1
