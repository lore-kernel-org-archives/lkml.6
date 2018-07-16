Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDC7ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9863820BF3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 11:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NBWIJUKl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9863820BF3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731305AbeGPMDr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 08:03:47 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36016 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729601AbeGPMDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 08:03:46 -0400
Received: by mail-lj1-f194.google.com with SMTP id u7-v6so27011284lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 04:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JNvG3eLHP0vyil+U68PGufNVjPg3Z649Xk1WFSlBycA=;
        b=NBWIJUKl7PmtHd6WwJLHxbs8OnTZLSm+pyfHkT2JvYAf4jjG6V9IW8NnbeNogCio6i
         hK5woeI2AV7nowyVdx6GInIyyAN5t0keRsInv5cr+8EKNfzF8vYtbNoUM4WOb8IHtmLQ
         Z4jyyS4Q6MCbm2RJOCvwh+vNYiDczX+q3L+LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JNvG3eLHP0vyil+U68PGufNVjPg3Z649Xk1WFSlBycA=;
        b=ZsUSVjojTSd4aSiWHws7n5O/CpP5jivTPxQFryaZw3DOnDbP1LVrbc4QrTIWbD5F6b
         IxQmGzluiBa9xYfNXV7i6qgX5EB3i4bBUuIquW7U0DaH2FfvGXns3/pX4DSsw4c+G/sz
         7IDY39Jql/j3hoACrL1jOVkKK+TNhIsFF1Wkz8ZMNW+Gg7+UH7mjNPBdZcPVNemGuy4S
         Rt2+XamHLaer2Lp95+80/XHoyDY/iLWdmTIhedApELwDYRnGo69elVb0505iPO9iyhC6
         dFNmIEu3ZN8zeyG/NfVJYQVT5oG8H9Vu+4268Qk2yOzQ8RrICWakccpGQ8O42VyZiHJt
         v9PA==
X-Gm-Message-State: AOUpUlGEq/FHtH7uHPx2D1Rdd1uIiBTw5np3yJN4hNnKrbaGPFzrUSrm
        OXnqPKBJnhiYE5HSa+33X+i8wg==
X-Google-Smtp-Source: AAOMgpdpVNcXhTW0hZp/Xr3u4f6Sp3J3HT4Hj5YwjTdc1u3aWE5rcDa4bOZVMWV5Y2qax45i0Ua3Wg==
X-Received: by 2002:a2e:84c6:: with SMTP id q6-v6mr10574367ljh.65.1531741004164;
        Mon, 16 Jul 2018 04:36:44 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id v136-v6sm8104913lfa.10.2018.07.16.04.36.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 04:36:43 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] regulator: qcom_spmi: Use correct regmap when checking for error
Date:   Mon, 16 Jul 2018 13:35:23 +0200
Message-Id: <20180716113525.9335-3-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716113525.9335-1-niklas.cassel@linaro.org>
References: <20180716113525.9335-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we have just assigned saw_regmap, and since the error message
refers to saw_regmap, it feels safe to assume that it is saw_regmap,
and not regmap, that should be checked for errors.

Fixes: 0caecaa87202 ("regulator: qcom_spmi: Add support for SAW")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 8b921b1b1df5..054c0245aec1 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1775,7 +1775,7 @@ static int qcom_spmi_regulator_probe(struct platform_device *pdev)
 		syscon = of_parse_phandle(node, "qcom,saw-reg", 0);
 		saw_regmap = syscon_node_to_regmap(syscon);
 		of_node_put(syscon);
-		if (IS_ERR(regmap))
+		if (IS_ERR(saw_regmap))
 			dev_err(dev, "ERROR reading SAW regmap\n");
 	}
 
-- 
2.17.1

