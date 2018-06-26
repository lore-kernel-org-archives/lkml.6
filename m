Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEE2C43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8074B21757
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YEzKI8ML"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8074B21757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934201AbeFZJY2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:24:28 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:40020 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933677AbeFZJW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:28 -0400
Received: by mail-wr0-f195.google.com with SMTP id g18-v6so16452982wro.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cEqIPpNtjb9dQHb944VG2jBsTOC/VovGjNwlIJ+31Dg=;
        b=YEzKI8MLQZfuWw9gYQhtHgB5gdDGlKPY1gKV+yUFrT3XdbWybEYPlHTjR/CBkJqcqd
         4T4VEo9rXJKgUPtP1J7Tl/R6NOHP+xQob37Bie4z3o+0lr/jxinDQDjjmkju8ONGTJb/
         r1ehZNGBo3C2IF+94XFq8Jpg/SKK+iYJIV10I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cEqIPpNtjb9dQHb944VG2jBsTOC/VovGjNwlIJ+31Dg=;
        b=I80wRIiV14mEJMyNxtP4oBCQq3KedQ9xanKGCSYduO1a/cPzAvFrk8eD2kIByu48jW
         Dzb4W5AUS/GDT00cLMRcCP/EyskClCw2S+HI/ueVrhX1bWno2PbZwQekYSC04aBlEZHc
         iBRMHjPMpYQJZMWW1q1BlJqfGsvPDvzlOqst66cLHEqeRIlJFT/ht5hmbEiI8iuQGyIa
         e1GTzdQRtAkX7gac4xKwEJjNkhLgLUZw1WIaOMsqVZX8MZCmzA1rAQIL7pM5t/W6UMd2
         xD7mDLIVtD2vJBOI/K00FIb6UI0WL5YtUMQd5foWann37Zdzm4bSMAJ7BUwvd1inHPdM
         utjw==
X-Gm-Message-State: APt69E0b7SOemFgjm+jDj6v02PoG0Itr0p0dAn8ueIbkafRxpY2X+4HW
        ZFlyAsrjrTyIJK3YMuaHhcsY9w==
X-Google-Smtp-Source: AAOMgpd+uLbZssc2kK+bH2G/6CAXQBD+Mv7ZyBgOAYorHcX3t7N06eaDlAdNJ7NZCD3qUUUfemtM8g==
X-Received: by 2002:adf:9246:: with SMTP id 64-v6mr755074wrj.109.1530004947635;
        Tue, 26 Jun 2018 02:22:27 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:26 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 04/12] ASoC: qdsp6: q6adm: use of_platform_populate/depopulate()
Date:   Tue, 26 Jun 2018 10:20:08 +0100
Message-Id: <20180626092016.9296-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
References: <20180626092016.9296-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the child nodes have there own compatible strings,
Use of_platform_populate/depopulate() instead of less common
of_platform_device_create()/destroy().

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/q6adm.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 9983c665a941..932c3ebfd252 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -64,7 +64,6 @@ struct q6adm {
 	struct aprv2_ibasic_rsp_result_t result;
 	struct mutex lock;
 	wait_queue_head_t matrix_map_wait;
-	struct platform_device *pdev_routing;
 };
 
 struct q6adm_cmd_device_open_v5 {
@@ -588,7 +587,6 @@ EXPORT_SYMBOL_GPL(q6adm_close);
 static int q6adm_probe(struct apr_device *adev)
 {
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 	struct q6adm *adm;
 
 	adm = devm_kzalloc(&adev->dev, sizeof(*adm), GFP_KERNEL);
@@ -605,22 +603,12 @@ static int q6adm_probe(struct apr_device *adev)
 	INIT_LIST_HEAD(&adm->copps_list);
 	spin_lock_init(&adm->copps_list_lock);
 
-	dais_np = of_get_child_by_name(dev->of_node, "routing");
-	if (dais_np) {
-		adm->pdev_routing = of_platform_device_create(dais_np,
-							   "q6routing", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6adm_remove(struct apr_device *adev)
 {
-	struct q6adm *adm = dev_get_drvdata(&adev->dev);
-
-	if (adm->pdev_routing)
-		of_platform_device_destroy(&adm->pdev_routing->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.16.2

