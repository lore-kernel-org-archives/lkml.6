Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5252BECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F3E3208CC
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fEBEpc51"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F3E3208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731620AbeGMPye (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:54:34 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34377 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729765AbeGMPyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:54:32 -0400
Received: by mail-wr1-f65.google.com with SMTP id c13-v6so25512592wrt.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MzGp1j0ioWGKIzF4+VhKRBq/gMz1o36NO5cj7JYy6/I=;
        b=fEBEpc519bIcEIfUAJ8WbWRjMN81gnjLQ7wWbdcC4CPV7K84EyA1AYJY9T0+RsY9Nd
         wttg4qIEZl3ewEoDViECfR6x373I1sMfENgO+0Cy62SM5dlmfPOd3OOE36KkQOIFJVj/
         oX7vczhg74ZG/DEa8TSwsbC1rLJjBbzxaz98k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MzGp1j0ioWGKIzF4+VhKRBq/gMz1o36NO5cj7JYy6/I=;
        b=UPWohkCdl1xBbMdlw2e55uHPCMorM6snjQqU0ApkzBeP88ItildQ+8JvDqGQvmpg02
         24Fin9mL2q2ofZguJb0zWEBvONVnzMTTS6OkEAxK9XNNo3nZDmwO14aOXmi8lykIcYZc
         VfmCHbsEwVsH7ybBAvISFA+I9U/GLpryikRCg2scdY2uR9zIwRNAc3XaR6xaiNVq7aks
         yy7UacPObTz3isjQdoEXzWPlZ0SQmrIXcc1E0OvQT79aV9IkEBn5iyZARcF2+kwlU4fy
         GYtfiUnm6GGrfkBcbPJ5wOPtYc/pZdieP/T4aw0qJHd3cpT57EZKtNLQXe4v4naVM/t6
         8q2w==
X-Gm-Message-State: AOUpUlFVRbAWYsD+TaLGB63wYt0SqqmEPi8BflHyIuF5EOoy/tNaotV0
        4Rf9J50qNzKVntT9JNx+BKN4jQ==
X-Google-Smtp-Source: AAOMgpdw7PQ0f2pZoK/XSQ3hT1PiolrWakCLfApHLSvm1Ol3rtA+paTt7fqZlWIRmLsQKuuMwW5ILg==
X-Received: by 2002:adf:9c91:: with SMTP id d17-v6mr5144212wre.11.1531496362148;
        Fri, 13 Jul 2018 08:39:22 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4840902wmo.22.2018.07.13.08.39.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 08:39:21 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/5] ASoC: core: add support to card re-bind using component framework
Date:   Fri, 13 Jul 2018 16:36:28 +0100
Message-Id: <20180713153632.32511-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
References: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch aims at achieving dynamic behaviour of audio card when
the dependent components disappear and reappear.

With this patch the card is removed if any of the dependent component
is removed and card is added back if the dependent component comes back.
All this is done using component framework and matching based on
component name.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 include/sound/soc.h  |  7 ++++++
 sound/soc/soc-core.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index a4915148f739..a23ecdf3eff1 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -17,6 +17,7 @@
 #include <linux/workqueue.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
+#include <linux/component.h>
 #include <linux/regmap.h>
 #include <linux/log2.h>
 #include <sound/core.h>
@@ -1090,6 +1091,12 @@ struct snd_soc_card {
 
 	struct work_struct deferred_resume_work;
 
+	/* component framework related */
+	bool components_added;
+	/* set in machine driver to enable/disable auto re-binding */
+	bool auto_bind;
+	struct component_match *match;
+
 	/* lists of probed devices belonging to this card */
 	struct list_head component_dev_list;
 
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6d33634b934b..65d11c13117f 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -279,11 +279,28 @@ static inline void snd_soc_debugfs_exit(void)
 
 #endif
 
+static int snd_soc_card_comp_compare(struct device *dev, void *data)
+{
+	struct snd_soc_component *component;
+
+	lockdep_assert_held(&client_mutex);
+	list_for_each_entry(component, &component_list, list) {
+		if (dev == component->dev) {
+			if (!strcmp(component->name, data))
+				return 1;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 			      struct snd_soc_component *component)
 {
 	struct snd_soc_rtdcom_list *rtdcom;
 	struct snd_soc_rtdcom_list *new_rtdcom;
+	char *cname;
 
 	for_each_rtdcom(rtd, rtdcom) {
 		/* already connected */
@@ -300,6 +317,13 @@ static int snd_soc_rtdcom_add(struct snd_soc_pcm_runtime *rtd,
 
 	list_add_tail(&new_rtdcom->list, &rtd->component_list);
 
+	if (rtd->card->auto_bind && !rtd->card->components_added) {
+		cname = devm_kasprintf(rtd->card->dev, GFP_KERNEL,
+				       "%s", component->name);
+		component_match_add(rtd->card->dev, &rtd->card->match,
+				    snd_soc_card_comp_compare, cname);
+	}
+
 	return 0;
 }
 
@@ -835,6 +859,25 @@ static bool soc_is_dai_link_bound(struct snd_soc_card *card,
 	return false;
 }
 
+static int snd_soc_card_comp_bind(struct device *dev)
+{
+	struct snd_soc_card *card = dev_get_drvdata(dev);
+
+	if (card->instantiated)
+		return 0;
+
+	return snd_soc_register_card(card);
+}
+
+static void snd_soc_card_comp_unbind(struct device *dev)
+{
+}
+
+static const struct component_master_ops snd_soc_card_comp_ops = {
+	.bind = snd_soc_card_comp_bind,
+	.unbind = snd_soc_card_comp_unbind,
+};
+
 static int soc_bind_dai_link(struct snd_soc_card *card,
 	struct snd_soc_dai_link *dai_link)
 {
@@ -2108,6 +2151,12 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 
 	card->instantiated = 1;
 	snd_soc_dapm_sync(&card->dapm);
+	if (card->auto_bind && !card->components_added) {
+		component_master_add_with_match(card->dev,
+						&snd_soc_card_comp_ops,
+						card->match);
+		card->components_added = true;
+	}
 	mutex_unlock(&card->mutex);
 	mutex_unlock(&client_mutex);
 
@@ -2757,6 +2806,9 @@ int snd_soc_unregister_card(struct snd_soc_card *card)
 		dev_dbg(card->dev, "ASoC: Unregistered card '%s'\n", card->name);
 	}
 
+	if (!card->auto_bind && card->components_added)
+		component_master_del(card->dev, &snd_soc_card_comp_ops);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_soc_unregister_card);
@@ -3169,8 +3221,17 @@ int snd_soc_add_component(struct device *dev,
 
 	snd_soc_component_add(component);
 
+	ret = component_add(dev, NULL);
+	if (ret < 0) {
+		dev_err(dev, "ASoC: Failed to add Component: %d\n", ret);
+		goto err_comp;
+	}
+
 	return 0;
 
+err_comp:
+	soc_remove_component(component);
+	snd_soc_unregister_dais(component);
 err_cleanup:
 	snd_soc_component_cleanup(component);
 err_free:
@@ -3218,6 +3279,7 @@ static int __snd_soc_unregister_component(struct device *dev)
 	mutex_unlock(&client_mutex);
 
 	if (found) {
+		component_del(dev, NULL);
 		snd_soc_component_cleanup(component);
 	}
 
-- 
2.16.2

