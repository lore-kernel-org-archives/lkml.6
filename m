Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E75C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A5080223F6
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 09:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVhkma87"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5080223F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbeHJMJ4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 08:09:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34740 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeHJMJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 08:09:55 -0400
Received: by mail-wm0-f65.google.com with SMTP id l2-v6so988304wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=hOhR9T6U43/UxXWdhl1DTfvHpLz3HKY9cbQNM8I7B7Y=;
        b=TVhkma87XvNc0s4SkzVW6R8/dYpokFv8m/BrBhRX5FTo+HaVpTe4r6U4e7kpofOUDc
         Z8Sk3rwgNId/9QLxGRULw/5ef5LLF7luGfLl3kq0XaLIm52FYpw+4vHURdcNTFAG0cNE
         xuhoLytNMe50PdNIdcv+XuQ8fA4L52K/C+FzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=hOhR9T6U43/UxXWdhl1DTfvHpLz3HKY9cbQNM8I7B7Y=;
        b=IBXRDyMjmXjWTgAtBqeiAA8DFhH5u3F1ZNmTEuvHykmgZL4y/gDBuJbAJx3WQBhPIi
         PdPFcteozQOTPZ2oKR326ePPu3zjJHG8kSnO33b+qk2nfG1UIBkNCVPLvzP4SisKs+GU
         zQ/YyQHfokl3M/m8nW1174oEsNYsqe1QYpiAcb/TwZCxsB7djYrDHvDB4ym0T5YNroVe
         IK1Nn1Hag2YfoAdEUwEqcIReeaH26HGNQP85axABQVUI/tka1H/aLVacbsbvWHqsNBTy
         LDhbGDSyTbKhZDZlbODlPynNn0FgsIq02f7hnCpVgIwy80YqmczxkarmwfyLM2aibXN0
         NQZw==
X-Gm-Message-State: AOUpUlFcSPPfRghFvxAoiOSuBQFpzw1drDehZ6shttgadiMUV0NIfc2Y
        oWM4x+KjVRGJfboOIfc0a8k9W6+pCUA=
X-Google-Smtp-Source: AA+uWPznGbVEk15+dWhDh7pZpqPaEgSmKrySVw7n/L2lBSSCjhfZj6cD00fQ9bP5QfNhEK8E58ai5Q==
X-Received: by 2002:a1c:8e8c:: with SMTP id q134-v6mr1094115wmd.3.1533894047843;
        Fri, 10 Aug 2018 02:40:47 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 198-v6sm2253787wmm.0.2018.08.10.02.40.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 10 Aug 2018 02:40:47 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: core: add support to card rebind
Date:   Fri, 10 Aug 2018 10:37:08 +0100
Message-Id: <20180810093708.13290-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current behaviour of ASoC core w.r.t to component removal is that it
unregisters dependent sound card totally. There is no support to
rebind the card if the component comes back.
Typical use case is DSP restart or kernel modules itself.

With this patch, core now maintains list of cards that are unbind due to
any of its depended components are removed and card not unregistered yet.
This list is cleared when the card is rebind successfully or when the
card is unregistered from machine driver.

This list of unbind cards are tried to bind once again after every new
component is successfully added, giving a fair chance for card bind
to be successful.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
Hi Mark,

This time I tried doing this without component framework, by maintaining
list of ubind card in ASoC core that are still not unregistered.
This list is tried to bind for every successful add of component.
It looks much better than the component framework one!

thanks,
srini

 include/sound/soc.h  |  2 ++
 sound/soc/soc-core.c | 86 ++++++++++++++++++++++++++++++--------------
 2 files changed, 61 insertions(+), 27 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a4915148f739..d9a8aea213cf 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1092,6 +1092,7 @@ struct snd_soc_card {
 
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
+	struct list_head list;
 
 	struct list_head widgets;
 	struct list_head paths;
@@ -1359,6 +1360,7 @@ static inline void snd_soc_initialize_card_lists(struct snd_soc_card *card)
 	INIT_LIST_HEAD(&card->dapm_list);
 	INIT_LIST_HEAD(&card->aux_comp_list);
 	INIT_LIST_HEAD(&card->component_dev_list);
+	INIT_LIST_HEAD(&card->list);
 }
 
 static inline bool snd_soc_volsw_is_stereo(struct soc_mixer_control *mc)
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6d33634b934b..795796978fc8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -52,6 +52,7 @@ EXPORT_SYMBOL_GPL(snd_soc_debugfs_root);
 
 static DEFINE_MUTEX(client_mutex);
 static LIST_HEAD(component_list);
+static LIST_HEAD(unbind_card_list);
 
 /*
  * This is a timeout to do a DAPM powerdown after a stream is closed().
@@ -2678,6 +2679,34 @@ int snd_soc_dai_digital_mute(struct snd_soc_dai *dai, int mute,
 }
 EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 
+static int snd_soc_bind_card(struct snd_soc_card *card)
+{
+	struct snd_soc_pcm_runtime *rtd;
+	int ret;
+
+	ret = snd_soc_instantiate_card(card);
+	if (ret != 0)
+		return ret;
+
+	/* deactivate pins to sleep state */
+	list_for_each_entry(rtd, &card->rtd_list, list)  {
+		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
+		int j;
+
+		for (j = 0; j < rtd->num_codecs; j++) {
+			struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
+
+			if (!codec_dai->active)
+				pinctrl_pm_select_sleep_state(codec_dai->dev);
+		}
+
+		if (!cpu_dai->active)
+			pinctrl_pm_select_sleep_state(cpu_dai->dev);
+	}
+
+	return ret;
+}
+
 /**
  * snd_soc_register_card - Register a card with the ASoC core
  *
@@ -2687,7 +2716,6 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 int snd_soc_register_card(struct snd_soc_card *card)
 {
 	int i, ret;
-	struct snd_soc_pcm_runtime *rtd;
 
 	if (!card->name || !card->dev)
 		return -EINVAL;
@@ -2719,28 +2747,23 @@ int snd_soc_register_card(struct snd_soc_card *card)
 	mutex_init(&card->mutex);
 	mutex_init(&card->dapm_mutex);
 
-	ret = snd_soc_instantiate_card(card);
-	if (ret != 0)
-		return ret;
-
-	/* deactivate pins to sleep state */
-	list_for_each_entry(rtd, &card->rtd_list, list)  {
-		struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
-		int j;
-
-		for (j = 0; j < rtd->num_codecs; j++) {
-			struct snd_soc_dai *codec_dai = rtd->codec_dais[j];
-			if (!codec_dai->active)
-				pinctrl_pm_select_sleep_state(codec_dai->dev);
-		}
+	return snd_soc_bind_card(card);
+}
+EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
-		if (!cpu_dai->active)
-			pinctrl_pm_select_sleep_state(cpu_dai->dev);
+static void snd_soc_unbind_card(struct snd_soc_card *card, bool unregister)
+{
+	if (card->instantiated) {
+		card->instantiated = false;
+		snd_soc_dapm_shutdown(card);
+		soc_cleanup_card_resources(card);
+		if (!unregister)
+			list_add(&card->list, &unbind_card_list);
+	} else {
+		if (unregister)
+			list_del(&card->list);
 	}
-
-	return ret;
 }
-EXPORT_SYMBOL_GPL(snd_soc_register_card);
 
 /**
  * snd_soc_unregister_card - Unregister a card with the ASoC core
@@ -2750,12 +2773,8 @@ EXPORT_SYMBOL_GPL(snd_soc_register_card);
  */
 int snd_soc_unregister_card(struct snd_soc_card *card)
 {
-	if (card->instantiated) {
-		card->instantiated = false;
-		snd_soc_dapm_shutdown(card);
-		soc_cleanup_card_resources(card);
-		dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
-	}
+	snd_soc_unbind_card(card, true);
+	dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 
 	return 0;
 }
@@ -3101,7 +3120,7 @@ static void snd_soc_component_del_unlocked(struct snd_soc_component *component)
 	struct snd_soc_card *card = component->card;
 
 	if (card)
-		snd_soc_unregister_card(card);
+		snd_soc_unbind_card(card, false);
 
 	list_del(&component->list);
 }
@@ -3141,6 +3160,18 @@ static void convert_endianness_formats(struct snd_soc_pcm_stream *stream)
 			stream->formats |= endianness_format_map[i];
 }
 
+static void snd_soc_try_rebind_card(void)
+{
+	struct snd_soc_card *card, *c;
+
+	if (!list_empty(&unbind_card_list)) {
+		list_for_each_entry_safe(card, c, &unbind_card_list, list) {
+			if (!snd_soc_bind_card(card))
+				list_del(&card->list);
+		}
+	}
+}
+
 int snd_soc_add_component(struct device *dev,
 			struct snd_soc_component *component,
 			const struct snd_soc_component_driver *component_driver,
@@ -3168,6 +3199,7 @@ int snd_soc_add_component(struct device *dev,
 	}
 
 	snd_soc_component_add(component);
+	snd_soc_try_rebind_card();
 
 	return 0;
 
-- 
2.18.0

