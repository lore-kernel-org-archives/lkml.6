Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35FD4ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E33DA208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 15:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SiO1Emh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E33DA208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbeGMPyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 11:54:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34621 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731895AbeGMPyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 11:54:36 -0400
Received: by mail-wm0-f65.google.com with SMTP id s13-v6so4816175wmc.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Jul 2018 08:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gfafMkLu59T46j/xhUfD5cqyO4e9j7V6stGEV8DhnRc=;
        b=SiO1Emh86qjtfSNJR7vucbFQ6L8onXUyDYX/fF/5fLwHHDMXgBTZPTMLvWWPejyFcN
         Vxdx0yna9wR/XE3oHaCAOZTYwzYrRStplMLXIaDmr3wNA/4SuPTE22K1myLyLI3VCRFA
         ZShF9nplPT7ITYTLG2A30rgjj2Tvxir2zoMzQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gfafMkLu59T46j/xhUfD5cqyO4e9j7V6stGEV8DhnRc=;
        b=RAt6mLI337cgkZfHgCUXPfh+edUkv44xz29POWiDrSejaW/insfB2pvtG8NGgob+EV
         JeS6L5NYJpzE/sFYs2Nufo6qPlZtk8l+A9PfVuv2Pjm5hZT0Wbpu9cxPlc6VVRlz2Xzs
         IYUrlE691hpC1LSuMQbD3ipSnVGs14U1v+B35m4OvWiz5yrefGzpWt2Ta+SyENyEG9yG
         y+VI5M98lT+Se1assV/wG3XWvsR7PdfIjVcEynTVB11JfdxEXPmhf5PgaICzMfNR8mZT
         fGq2hcbvIxRTE8n+LHFus4ipsacJCu9/vgqb0gfXpf435YXF1/dBi3qqUnNYmnfY1wC0
         webA==
X-Gm-Message-State: AOUpUlFw3PBMwJMW8RRCAWXD16VxfC2OF/K0Fz2yqBGZkvOOgusC8jt2
        syLfvMLDairtWGkTz/q9MGu/2A==
X-Google-Smtp-Source: AAOMgpfx8GKjbwv4k8vqdvm83tjwvNRXC7bmvXkkpmfS543VC1+EGGH+j/TvuYBa+1kuaGyqi2GScA==
X-Received: by 2002:a1c:8e8c:: with SMTP id q134-v6mr1700220wmd.3.1531496366286;
        Fri, 13 Jul 2018 08:39:26 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id 63-v6sm4840902wmo.22.2018.07.13.08.39.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 13 Jul 2018 08:39:25 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com,
        alsa-devel@alsa-project.org
Cc:     perex@perex.cz, tiwai@suse.com, vkoul@kernel.org,
        linux-kernel@vger.kernel.org, rohitkr@codeaurora.org,
        bgoswami@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 5/5] ASoC: qcom: apq8096: remove component framework related code
Date:   Fri, 13 Jul 2018 16:36:32 +0100
Message-Id: <20180713153632.32511-6-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
References: <20180713153632.32511-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the component framework is integrated into the ASoC core,
remove any redundant code in this driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/apq8096.c | 75 ++++--------------------------------------------
 1 file changed, 6 insertions(+), 69 deletions(-)

diff --git a/sound/soc/qcom/apq8096.c b/sound/soc/qcom/apq8096.c
index cab8c4ff7c00..a56156281c8d 100644
--- a/sound/soc/qcom/apq8096.c
+++ b/sound/soc/qcom/apq8096.c
@@ -129,17 +129,18 @@ static int apq8096_sbc_parse_of(struct snd_soc_card *card)
 	return ret;
 }
 
-static int apq8096_bind(struct device *dev)
+static int apq8096_platform_probe(struct platform_device *pdev)
 {
 	struct snd_soc_card *card;
+	struct device *dev = &pdev->dev;
 	int ret;
 
 	card = kzalloc(sizeof(*card), GFP_KERNEL);
 	if (!card)
 		return -ENOMEM;
 
-	component_bind_all(dev, card);
 	card->dev = dev;
+	card->auto_bind = true;
 	dev_set_drvdata(dev, card);
 	ret = apq8096_sbc_parse_of(card);
 	if (ret) {
@@ -154,82 +155,18 @@ static int apq8096_bind(struct device *dev)
 	return 0;
 
 err:
-	component_unbind_all(dev, card);
 	kfree(card);
 	return ret;
 }
 
-static void apq8096_unbind(struct device *dev)
+static int apq8096_platform_remove(struct platform_device *pdev)
 {
-	struct snd_soc_card *card = dev_get_drvdata(dev);
+	struct snd_soc_card *card = dev_get_drvdata(&pdev->dev);
 
+	card->auto_bind = false;
 	snd_soc_unregister_card(card);
-	component_unbind_all(dev, card);
 	kfree(card->dai_link);
 	kfree(card);
-}
-
-static const struct component_master_ops apq8096_ops = {
-	.bind = apq8096_bind,
-	.unbind = apq8096_unbind,
-};
-
-static int apq8016_compare_of(struct device *dev, void *data)
-{
-	return dev->of_node == data;
-}
-
-static void apq8016_release_of(struct device *dev, void *data)
-{
-	of_node_put(data);
-}
-
-static int add_audio_components(struct device *dev,
-				struct component_match **matchptr)
-{
-	struct device_node *np, *platform, *cpu, *node, *dai_node;
-
-	node = dev->of_node;
-
-	for_each_child_of_node(node, np) {
-		cpu = of_get_child_by_name(np, "cpu");
-		if (cpu) {
-			dai_node = of_parse_phandle(cpu, "sound-dai", 0);
-			of_node_get(dai_node);
-			component_match_add_release(dev, matchptr,
-						    apq8016_release_of,
-						    apq8016_compare_of,
-						    dai_node);
-		}
-
-		platform = of_get_child_by_name(np, "platform");
-		if (platform) {
-			dai_node = of_parse_phandle(platform, "sound-dai", 0);
-			component_match_add_release(dev, matchptr,
-						    apq8016_release_of,
-						    apq8016_compare_of,
-						    dai_node);
-		}
-	}
-
-	return 0;
-}
-
-static int apq8096_platform_probe(struct platform_device *pdev)
-{
-	struct component_match *match = NULL;
-	int ret;
-
-	ret = add_audio_components(&pdev->dev, &match);
-	if (ret)
-		return ret;
-
-	return component_master_add_with_match(&pdev->dev, &apq8096_ops, match);
-}
-
-static int apq8096_platform_remove(struct platform_device *pdev)
-{
-	component_master_del(&pdev->dev, &apq8096_ops);
 
 	return 0;
 }
-- 
2.16.2

