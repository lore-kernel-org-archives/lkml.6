Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08CCBC43144
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B1BC72677D
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 09:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OrQYumjQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1BC72677D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933899AbeFZJWh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 05:22:37 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:53189 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933784AbeFZJWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 05:22:31 -0400
Received: by mail-wm0-f67.google.com with SMTP id p126-v6so1040242wmb.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jun 2018 02:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9ntn7tvil3gnvbRPyAg0hZqRPLNr9XRiNe9LjAxmLwo=;
        b=OrQYumjQI+tnScHt4ElZzhag3QVDdpjFroKkraRlfebj8KKGyZXtzb7vL9MuyhXwaC
         m5bsQRZXcUMPBZqzSnch419tdNcJoqf3DmJDt0vsZh4lRDUT4Cv7y6Dxi+4pthPWto68
         EYLyfGbl83PioMQ6V/nOSPuirpGbv6b16EHf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9ntn7tvil3gnvbRPyAg0hZqRPLNr9XRiNe9LjAxmLwo=;
        b=BT+A8W4d/ksGD4KoT3fde0ZoHJsSxJva2qnlVlCe631hVhjr57jjEF+lpv1njvpq7Z
         AvnedXmIQmT2qTTwK2s4kzIj3aUPM5dDEQ1GUt4udUlQsmrGzBqHk3xTxalzUR+pxGlC
         FUhNiV+MkWG2+t9KLA6+Xr/JdpcB8XHy+aJWxFkQSxFJZKK60biPBeDBCWdgwQ1Qo/D+
         pEkzo/TI+REy36jI5WhAtTN63jPqGBclb9qxT/rkDFw7fCLFUazElFKoJ3uDdGzbnLhp
         wKkriTLWAIuOZyeruIrUZDcrd3GKicq3E1of41VMgALazQ1rArouHpjKzyQWGA6BRI0R
         G1Dg==
X-Gm-Message-State: APt69E3yNxP8CAxuHWYS2vGcrB3/N8BjFS9mwUUC25jxsiF4MiUL5xWC
        U3khpsDjo5LXlqOaehhCccIn6Q==
X-Google-Smtp-Source: AAOMgpfXxRRU6Qz0gU8X83f2nn2bOt89rKFbnvLzhkYLT+d9wfW1yEJCw3s85M5wt1MCOGYmACSpoA==
X-Received: by 2002:a1c:8893:: with SMTP id k141-v6mr931940wmd.133.1530004950022;
        Tue, 26 Jun 2018 02:22:30 -0700 (PDT)
Received: from localhost.localdomain (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.gmail.com with ESMTPSA id x5-v6sm1438456wrr.3.2018.06.26.02.22.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Jun 2018 02:22:29 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org, robh+dt@kernel.org, alsa-devel@alsa-project.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        lgirdwood@gmail.com, bgoswami@codeaurora.org, tiwai@suse.com,
        perex@perex.cz, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, niklas.cassel@linaro.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 06/12] ASoC: qdsp6: q6afe: use of_platform_populate/depopulate()
Date:   Tue, 26 Jun 2018 10:20:10 +0100
Message-Id: <20180626092016.9296-7-srinivas.kandagatla@linaro.org>
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
Acked-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 sound/soc/qcom/qdsp6/q6afe.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6afe.c b/sound/soc/qcom/qdsp6/q6afe.c
index 01f43218984b..621b67b34db9 100644
--- a/sound/soc/qcom/qdsp6/q6afe.c
+++ b/sound/soc/qcom/qdsp6/q6afe.c
@@ -316,7 +316,6 @@ struct q6afe {
 	struct mutex lock;
 	struct list_head port_list;
 	spinlock_t port_list_lock;
-	struct platform_device *pdev_dais;
 };
 
 struct afe_port_cmd_device_start {
@@ -1438,7 +1437,6 @@ static int q6afe_probe(struct apr_device *adev)
 {
 	struct q6afe *afe;
 	struct device *dev = &adev->dev;
-	struct device_node *dais_np;
 
 	afe = devm_kzalloc(dev, sizeof(*afe), GFP_KERNEL);
 	if (!afe)
@@ -1453,22 +1451,12 @@ static int q6afe_probe(struct apr_device *adev)
 
 	dev_set_drvdata(dev, afe);
 
-	dais_np = of_get_child_by_name(dev->of_node, "dais");
-	if (dais_np) {
-		afe->pdev_dais = of_platform_device_create(dais_np,
-							   "q6afe-dai", dev);
-		of_node_put(dais_np);
-	}
-
-	return 0;
+	return of_platform_populate(dev->of_node, NULL, NULL, dev);
 }
 
 static int q6afe_remove(struct apr_device *adev)
 {
-	struct q6afe *afe = dev_get_drvdata(&adev->dev);
-
-	if (afe->pdev_dais)
-		of_platform_device_destroy(&afe->pdev_dais->dev, NULL);
+	of_platform_depopulate(&adev->dev);
 
 	return 0;
 }
-- 
2.16.2

