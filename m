Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E3BC46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:14:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA79D21723
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 16:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA79D21723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=opensource.cirrus.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729891AbeHHSeV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 14:34:21 -0400
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:50112 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729752AbeHHSeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 14:34:21 -0400
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w78G8uuc009889;
        Wed, 8 Aug 2018 11:13:52 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=rf@opensource.cirrus.com
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
        by mx0b-001ae601.pphosted.com with ESMTP id 2kqxjv8pb4-1;
        Wed, 08 Aug 2018 11:13:52 -0500
Received: from EX17.ad.cirrus.com (unknown [172.20.9.81])
        by mail1.cirrus.com (Postfix) with ESMTP id 0AACB611C8AF;
        Wed,  8 Aug 2018 11:13:52 -0500 (CDT)
Received: from imbe.wolfsonmicro.main (198.61.95.81) by EX17.ad.cirrus.com
 (172.20.9.81) with Microsoft SMTP Server id 14.3.408.0; Wed, 8 Aug 2018
 17:13:51 +0100
Received: from edi-sw-dsktp006.ad.cirrus.com (edi-sw-dsktp006.ad.cirrus.com
 [198.90.251.121])      by imbe.wolfsonmicro.main (8.14.4/8.14.4) with ESMTP id
 w78GDoeO017811;        Wed, 8 Aug 2018 17:13:50 +0100
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: wm_adsp: Declare firmware controls from codec driver
Date:   Wed, 8 Aug 2018 17:13:38 +0100
Message-ID: <20180808161339.17402-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1807170000
 definitions=main-1808080165
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow for more flexibility in naming of DSP-type cores
move the creation of the firmware controls to the codec
drivers instead of having a hardcoded list in wm_adsp.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs47l24.c |  3 +++
 sound/soc/codecs/wm2200.c  | 10 ++++------
 sound/soc/codecs/wm5102.c  |  2 ++
 sound/soc/codecs/wm5110.c  |  5 +++++
 sound/soc/codecs/wm_adsp.c | 35 +++++++++--------------------------
 sound/soc/codecs/wm_adsp.h | 10 +++++++++-
 6 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 0da52ead91e0..45e50fe3bf25 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -235,6 +235,9 @@ ARIZONA_MIXER_CONTROLS("AIF2TX6", ARIZONA_AIF2TX6MIX_INPUT_1_SOURCE),
 
 ARIZONA_MIXER_CONTROLS("AIF3TX1", ARIZONA_AIF3TX1MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("AIF3TX2", ARIZONA_AIF3TX2MIX_INPUT_1_SOURCE),
+
+WM_ADSP_FW_CONTROL("DSP2", 1),
+WM_ADSP_FW_CONTROL("DSP3", 2),
 };
 
 ARIZONA_MIXER_ENUMS(EQ1, ARIZONA_EQ1MIX_INPUT_1_SOURCE);
diff --git a/sound/soc/codecs/wm2200.c b/sound/soc/codecs/wm2200.c
index 3663b9fd4d65..deff65161504 100644
--- a/sound/soc/codecs/wm2200.c
+++ b/sound/soc/codecs/wm2200.c
@@ -1180,6 +1180,9 @@ SOC_DOUBLE_R_TLV("OUT2 Digital Volume", WM2200_DAC_DIGITAL_VOLUME_2L,
 SOC_DOUBLE("OUT2 Switch", WM2200_PDM_1, WM2200_SPK1L_MUTE_SHIFT,
 	   WM2200_SPK1R_MUTE_SHIFT, 1, 1),
 SOC_ENUM("RxANC Src", wm2200_rxanc_input_sel),
+
+WM_ADSP_FW_CONTROL("DSP1", 0),
+WM_ADSP_FW_CONTROL("DSP2", 1),
 };
 
 WM2200_MIXER_ENUMS(OUT1L, WM2200_OUT1LMIX_INPUT_1_SOURCE);
@@ -1553,15 +1556,10 @@ static const struct snd_soc_dapm_route wm2200_dapm_routes[] = {
 static int wm2200_probe(struct snd_soc_component *component)
 {
 	struct wm2200_priv *wm2200 = snd_soc_component_get_drvdata(component);
-	int ret;
 
 	wm2200->component = component;
 
-	ret = snd_soc_add_component_controls(component, wm_adsp_fw_controls, 2);
-	if (ret != 0)
-		return ret;
-
-	return ret;
+	return 0;
 }
 
 static int wm2200_set_fmt(struct snd_soc_dai *dai, unsigned int fmt)
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a01a0c0e01eb..7e817e1877c2 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -985,6 +985,8 @@ ARIZONA_MIXER_CONTROLS("SLIMTX5", ARIZONA_SLIMTX5MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SLIMTX6", ARIZONA_SLIMTX6MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SLIMTX7", ARIZONA_SLIMTX7MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SLIMTX8", ARIZONA_SLIMTX8MIX_INPUT_1_SOURCE),
+
+WM_ADSP_FW_CONTROL("DSP1", 0),
 };
 
 ARIZONA_MIXER_ENUMS(EQ1, ARIZONA_EQ1MIX_INPUT_1_SOURCE);
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 00c735c585d9..b0789a03d699 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -927,6 +927,11 @@ ARIZONA_MIXER_CONTROLS("SLIMTX5", ARIZONA_SLIMTX5MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SLIMTX6", ARIZONA_SLIMTX6MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SLIMTX7", ARIZONA_SLIMTX7MIX_INPUT_1_SOURCE),
 ARIZONA_MIXER_CONTROLS("SLIMTX8", ARIZONA_SLIMTX8MIX_INPUT_1_SOURCE),
+
+WM_ADSP_FW_CONTROL("DSP1", 0),
+WM_ADSP_FW_CONTROL("DSP2", 1),
+WM_ADSP_FW_CONTROL("DSP3", 2),
+WM_ADSP_FW_CONTROL("DSP4", 3),
 };
 
 ARIZONA_MIXER_ENUMS(EQ1, ARIZONA_EQ1MIX_INPUT_1_SOURCE);
diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index ae131376cea1..1c12c78dbcce 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -684,8 +684,8 @@ static inline void wm_adsp_debugfs_clear(struct wm_adsp *dsp)
 }
 #endif
 
-static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
-			  struct snd_ctl_elem_value *ucontrol)
+int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
+		   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
@@ -695,9 +695,10 @@ static int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(wm_adsp_fw_get);
 
-static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
-			  struct snd_ctl_elem_value *ucontrol)
+int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
+		   struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_soc_component *component = snd_soc_kcontrol_component(kcontrol);
 	struct soc_enum *e = (struct soc_enum *)kcontrol->private_value;
@@ -721,8 +722,9 @@ static int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(wm_adsp_fw_put);
 
-static const struct soc_enum wm_adsp_fw_enum[] = {
+const struct soc_enum wm_adsp_fw_enum[] = {
 	SOC_ENUM_SINGLE(0, 0, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 	SOC_ENUM_SINGLE(0, 1, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 	SOC_ENUM_SINGLE(0, 2, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
@@ -731,24 +733,7 @@ static const struct soc_enum wm_adsp_fw_enum[] = {
 	SOC_ENUM_SINGLE(0, 5, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 	SOC_ENUM_SINGLE(0, 6, ARRAY_SIZE(wm_adsp_fw_text), wm_adsp_fw_text),
 };
-
-const struct snd_kcontrol_new wm_adsp_fw_controls[] = {
-	SOC_ENUM_EXT("DSP1 Firmware", wm_adsp_fw_enum[0],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM_EXT("DSP2 Firmware", wm_adsp_fw_enum[1],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM_EXT("DSP3 Firmware", wm_adsp_fw_enum[2],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM_EXT("DSP4 Firmware", wm_adsp_fw_enum[3],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM_EXT("DSP5 Firmware", wm_adsp_fw_enum[4],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM_EXT("DSP6 Firmware", wm_adsp_fw_enum[5],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-	SOC_ENUM_EXT("DSP7 Firmware", wm_adsp_fw_enum[6],
-		     wm_adsp_fw_get, wm_adsp_fw_put),
-};
-EXPORT_SYMBOL_GPL(wm_adsp_fw_controls);
+EXPORT_SYMBOL_GPL(wm_adsp_fw_enum);
 
 static struct wm_adsp_region const *wm_adsp_find_region(struct wm_adsp *dsp,
 							int type)
@@ -2890,9 +2875,7 @@ int wm_adsp2_component_probe(struct wm_adsp *dsp, struct snd_soc_component *comp
 
 	dsp->component = component;
 
-	return snd_soc_add_component_controls(component,
-					  &wm_adsp_fw_controls[dsp->num - 1],
-					  1);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(wm_adsp2_component_probe);
 
diff --git a/sound/soc/codecs/wm_adsp.h b/sound/soc/codecs/wm_adsp.h
index bc6d359f0533..8d58cb9d9bb9 100644
--- a/sound/soc/codecs/wm_adsp.h
+++ b/sound/soc/codecs/wm_adsp.h
@@ -121,7 +121,11 @@ struct wm_adsp {
 	.reg = SND_SOC_NOPM, .shift = num, .event = wm_adsp2_event, \
 	.event_flags = SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD }
 
-extern const struct snd_kcontrol_new wm_adsp_fw_controls[];
+#define WM_ADSP_FW_CONTROL(dspname, num) \
+	SOC_ENUM_EXT(dspname " Firmware", wm_adsp_fw_enum[num], \
+		     wm_adsp_fw_get, wm_adsp_fw_put)
+
+extern const struct soc_enum wm_adsp_fw_enum[];
 
 int wm_adsp1_init(struct wm_adsp *dsp);
 int wm_adsp2_init(struct wm_adsp *dsp);
@@ -144,6 +148,10 @@ int wm_adsp2_preloader_get(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol);
 int wm_adsp2_preloader_put(struct snd_kcontrol *kcontrol,
 			   struct snd_ctl_elem_value *ucontrol);
+int wm_adsp_fw_get(struct snd_kcontrol *kcontrol,
+		   struct snd_ctl_elem_value *ucontrol);
+int wm_adsp_fw_put(struct snd_kcontrol *kcontrol,
+		   struct snd_ctl_elem_value *ucontrol);
 
 int wm_adsp_compr_open(struct wm_adsp *dsp, struct snd_compr_stream *stream);
 int wm_adsp_compr_free(struct snd_compr_stream *stream);
-- 
2.11.0

