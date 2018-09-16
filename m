Return-Path: <SRS0=7f4r=L6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFEFECE561
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0AE42087E
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Sep 2018 23:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KYdzg5j8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0AE42087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeIQFKq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 01:10:46 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:42246 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728383AbeIQFKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 01:10:45 -0400
Received: by mail-io1-f65.google.com with SMTP id n18-v6so10035843ioa.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Sep 2018 16:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jtP5RlYyGuGTnla229QkTJ0o7oCjU+RhaUaOIesIN8I=;
        b=KYdzg5j8aQsmO9zzMB1fGl/cmsHCcObkw1uU82ow+JkH13oOCQ8kfuGjKnm5+PfODe
         EEvvH/I7x6HFe3+k94kZvBmYPuEo+EcWG+U5QQGkZ/segl5xBTPVQBo4kT5y4GMchn1U
         /P/dCEHKWWZOUs68tpxumjJSpuT/0LGWKTc+8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jtP5RlYyGuGTnla229QkTJ0o7oCjU+RhaUaOIesIN8I=;
        b=DEw2xgJ5xr/dcwJsOzcjcn1Xyr0X9XZqRH0erQWF3tCt5n1mdNPMnsGui4jeIW64L9
         XLNc6RAN+4rRLjr9H5e6IQpnIhwfFvn4mmwWOsMCZnJyudNTWDYaVOiB7iv81pejJ1ua
         afRMzPFAx0JNcH9jHDDMD1IVo3re/xVt1t0ngn/UxsBhE2nWO0H+Pa1WqtnNtg1aN76E
         e68a3su4zUunqc3t3iu3R92r6a/jj+EQGDVhR/17UiOeSmLwRejURsYldihlmUIrNDZL
         Cz3E9zMHh3uEiITrHSEamYtaJYkEPAj/STYaDKn5CvGY9Eq8ceWg1/hjZH1WxTf3tTKJ
         3e0A==
X-Gm-Message-State: APzg51BXswawDGvrvvazdfQOQf7fp8YwILqptTcpPjHp/KPdT8MqvPvB
        CeqmajhF7TE1eTSOjBINCdHFRg==
X-Google-Smtp-Source: ANB0VdZcE4KUnUJpkoR1PBkI4N1uG8oFQC7542pxVGtziJvSEHgSl9I9qvIzjjWrssBVdUMcPIZsZA==
X-Received: by 2002:a6b:1416:: with SMTP id 22-v6mr18665180iou.218.1537141564842;
        Sun, 16 Sep 2018 16:46:04 -0700 (PDT)
Received: from localhost.localdomain ([209.82.80.116])
        by smtp.gmail.com with ESMTPSA id a11-v6sm4495177ioc.63.2018.09.16.16.46.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 16 Sep 2018 16:46:04 -0700 (PDT)
From:   srinivas.kandagatla@linaro.org
To:     gregkh@linuxfoundation.org
Cc:     broonie@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        vkoul@kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 7/7] slimbus: ngd: register ngd driver only once.
Date:   Sun, 16 Sep 2018 16:45:46 -0700
Message-Id: <20180916234546.29661-8-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
References: <20180916234546.29661-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Move ngd platform driver out of loop so that it registers only once.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index f48a06e..f7490d7 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1355,7 +1355,6 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		ngd->base = ctrl->base + ngd->id * data->offset +
 					(ngd->id - 1) * data->size;
 		ctrl->ngd = ngd;
-		platform_driver_register(&qcom_slim_ngd_driver);
 
 		return 0;
 	}
@@ -1447,6 +1446,7 @@ static int qcom_slim_ngd_ctrl_probe(struct platform_device *pdev)
 	init_completion(&ctrl->reconf);
 	init_completion(&ctrl->qmi.qmi_comp);
 
+	platform_driver_register(&qcom_slim_ngd_driver);
 	return of_qcom_slim_ngd_register(dev, ctrl);
 }
 
-- 
2.9.3

