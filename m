Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D3F8C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A31920685
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 17:11:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iNsGB4ug"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfAIRLa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 12:11:30 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:33092 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbfAIRL3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 12:11:29 -0500
Received: by mail-pl1-f195.google.com with SMTP id z23so3883113plo.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Jan 2019 09:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=mLHBC5DQdCXrWxo7jEcUKVSWXALigvSRLbPEyaOWX04=;
        b=iNsGB4ugj/iEnSmRiJ4c+vFtmvEU/cwfF/60PseSNbHD6dOdHyIhwONF7cOKBt7bc/
         r7/DESMcchNDN/SD5ZW52iJNL2rlONYnV+kBSoX8sDkWYC7uQcXSEZcHEX8UE/IEtd5i
         dRhzx6LnrCNdHUr9rQRyrXbWEH1FV7kdce3Romu9fFLMkPR/TXz48S6MDiG40CAdzaqc
         GsRnnuICQlV7HQEzRI7vp9BG+xPAnG//hgU2d3Q/byq8usFOs7xE8YyvR1KnMdJ3+odj
         KG+vD6I9L29OqEr288Fuq88P8L2Tl+0ojg9/jy0HgYXeeLRKgU7M03ljBhVDLsoBzF0z
         sQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=mLHBC5DQdCXrWxo7jEcUKVSWXALigvSRLbPEyaOWX04=;
        b=J6msQYIfsbNAW1huoPHNgOL6n5981hsP/ywlV3FIukVaeBurKxme1fAzTMRo2EdMLu
         +967UY+9Xvmcecct8yHLXU0c4djg2NE7W/96WaFeOUe2wcxIqJ8O1zDZ+iVGodtip1WN
         NXX6KRIEFqcY7WUme2gP/y9HijAqJLDddAoKcUrA77yEDa1sKSDms2icCUJhMBC6oO6f
         1pNx/9BclFbuns1UajDUlw1sMek8X+ybq2mCgrtNgIun3jl7Qf0s8YH1ROsBuTgVtEGp
         kIuJWwwEGiy41OlXh0IVzDvfGZFoj9hX2PqHfd9gDAVwUATGAYV6NH9Kt3bAl8gLTXl5
         XvdA==
X-Gm-Message-State: AJcUukdK/7lpgm775xQgRDyHT1K6F4durm/0/YAT+tnWBVg0V8U4wOIp
        nlEHIHMWJeZmBKWdI1dVQ6M=
X-Google-Smtp-Source: ALg8bN7IL200rXTLQlmuepFU657jeKAnDUex1q68w7P9tzhCFyBRBs7NFGIVS7SRLSUeIrdQURQ03w==
X-Received: by 2002:a17:902:20e9:: with SMTP id v38mr6552127plg.250.1547053888664;
        Wed, 09 Jan 2019 09:11:28 -0800 (PST)
Received: from Ideapad-330S ([49.206.13.149])
        by smtp.gmail.com with ESMTPSA id a195sm140166853pfa.7.2019.01.09.09.11.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 09:11:28 -0800 (PST)
Date:   Wed, 9 Jan 2019 22:41:21 +0530
From:   b-ak <anur.bhargav@gmail.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: tlv320aic32x4: SND_SOC_DAPM_MICBIAS is deprecated
Message-ID: <20190109171121.GA12810@Ideapad-330S>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SND_SOC_DAPM_MICBIAS is deprecated, replace it with SND_SOC_DAPM_SUPPLY.

MICBIAS voltage wasn't supplied to the microphone with the older
SND_SOC_DAPM_MICBIAS widget, hence the microphone wouldn't work.

This patch fixes the problem.

Signed-off-by: b-ak <anur.bhargav@gmail.com>
---
 sound/soc/codecs/tlv320aic32x4.c | 30 +++++++++++++++++++++++++++++-
 sound/soc/codecs/tlv320aic32x4.h |  1 +
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index e2b5a11b16d1..521663d8b585 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -79,6 +79,32 @@ struct aic32x4_priv {
 	struct device *dev;
 };
 
+static int mic_bias_event(struct snd_soc_dapm_widget *w,
+	struct snd_kcontrol *kcontrol, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+
+	switch (event) {
+	case SND_SOC_DAPM_POST_PMU:
+		/* Change Mic Bias Registor */
+		snd_soc_component_update_bits(component, AIC32X4_MICBIAS,
+				AIC32x4_MICBIAS_MASK,
+				AIC32X4_MICBIAS_LDOIN |
+				AIC32X4_MICBIAS_2075V);
+		printk(KERN_DEBUG "%s: Mic Bias will be turned ON\n", __func__);
+		break;
+	case SND_SOC_DAPM_PRE_PMD:
+		snd_soc_component_update_bits(component, AIC32X4_MICBIAS,
+				AIC32x4_MICBIAS_MASK, 0);
+		printk(KERN_DEBUG "%s: Mic Bias will be turned OFF\n",
+				__func__);
+		break;
+	}
+
+	return 0;
+}
+
+
 static int aic32x4_get_mfp1_gpio(struct snd_kcontrol *kcontrol,
 	struct snd_ctl_elem_value *ucontrol)
 {
@@ -450,7 +476,9 @@ static const struct snd_soc_dapm_widget aic32x4_dapm_widgets[] = {
 	SND_SOC_DAPM_MUX("IN3_R to Left Mixer Negative Resistor", SND_SOC_NOPM, 0, 0,
 			in3r_to_lmixer_controls),
 
-	SND_SOC_DAPM_MICBIAS("Mic Bias", AIC32X4_MICBIAS, 6, 0),
+	SND_SOC_DAPM_SUPPLY("Mic Bias", AIC32X4_MICBIAS, 6, 0, mic_bias_event,
+			SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+
 
 	SND_SOC_DAPM_OUTPUT("HPL"),
 	SND_SOC_DAPM_OUTPUT("HPR"),
diff --git a/sound/soc/codecs/tlv320aic32x4.h b/sound/soc/codecs/tlv320aic32x4.h
index e9df49edbf19..c2d74025bf4b 100644
--- a/sound/soc/codecs/tlv320aic32x4.h
+++ b/sound/soc/codecs/tlv320aic32x4.h
@@ -195,6 +195,7 @@ int aic32x4_remove(struct device *dev);
 /* AIC32X4_MICBIAS */
 #define AIC32X4_MICBIAS_LDOIN		BIT(3)
 #define AIC32X4_MICBIAS_2075V		0x60
+#define AIC32x4_MICBIAS_MASK            GENMASK(6, 3)
 
 /* AIC32X4_LMICPGANIN */
 #define AIC32X4_LMICPGANIN_IN2R_10K	0x10
-- 
2.19.1

