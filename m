Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE16C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:30:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B667217D9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 02:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BlqO+m0j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfBSCa2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 21:30:28 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:43222 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726142AbfBSCa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 21:30:27 -0500
Received: by mail-pl1-f196.google.com with SMTP id f90so9612912plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 18:30:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=AVTwKX6Baw7wrNpsm5UZq1npDrofJNhJlE1mZ0tAJUY=;
        b=BlqO+m0j1/1B2O7vOjg1nfc7dBSoIhq+02AWDDOdH+O6pqEx3ClP3t7ud4UptUfQTX
         tAkpQ5jGzMx/YPT87gbIqQJXoK1Dnij4dsFBNE8+U1LFeU003B4/N7Ck3CxErr1e7ISg
         QIo/aInVQV2OANiFa3L8Y0XQcBO4KI24pVDq2w0hS4b+2j+XFp9FWjuJyNISxSLZkCus
         gO+uqum4Yo4Fk+tt/dDUMb19nnTihmKdBYM9O2/pqAfna6/TGYpqhpAlRqYYtwTjebbN
         hcdOp+Nkj/UJJKfRzAUR9U8C93ZIsmQP26bHkVUpPVn4j8rT+WqIfdpVcb4VqIrM/YU5
         uvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=AVTwKX6Baw7wrNpsm5UZq1npDrofJNhJlE1mZ0tAJUY=;
        b=MznHcNN+MTo065L3laVoqn01VP97QOJcG9quGU8m4pHi7CauAFcgR4ylLEokOJihLk
         8MjtX8uBENpMnhR85eebXBum/vU6SsT0EA8p8VzTwg22RNTnM+qIK6Q+io4Sqacl5wQ9
         Z//zZySRQcDdPyN47+hIM1+AKPVSWW2JUbiqVdGdyOmvU1dFzv0b5y/4s0NhCzacxCVR
         Y5M4e+WqBVsT/Rn3OZPeOCUbpKAYK+lm4RaDK7l2Zojp5cVf+H6ost1UA7qNT7gLlfKZ
         Q17/LBV5+xOGt0H77Gsw+9Q4DL8G/MUU7GTuGlHzLj+Uu4uuw9FzQhlAMW0fks0iAQGr
         3iNg==
X-Gm-Message-State: AHQUAua2tFjI4x33BRaqAsAiOjqv1t08cNFoEUmK6NaXD9HScsQiCBnU
        aWSRZV8q1a3QdFvK8dqgaAqxiw==
X-Google-Smtp-Source: AHgI3IZcuOGqeUIeK5T6j7E7tBNz17eXSiPLfu/W+A2z2pcxGul0jIS+tVW8wInlMBTKpbERAeLvmA==
X-Received: by 2002:a17:902:ba85:: with SMTP id k5mr28409926pls.130.1550543426721;
        Mon, 18 Feb 2019 18:30:26 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id e19sm18552336pfn.145.2019.02.18.18.30.22
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 18 Feb 2019 18:30:25 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] gpio: sprd: Change to use SoC compatible string
Date:   Tue, 19 Feb 2019 10:29:58 +0800
Message-Id: <d0f8377078efc1af13fa81c5d6837f3f26ddc1fb.1550543288.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <70f5476004b2f4e4b444bf8425f21a3c993edf47.1550543288.git.baolin.wang@linaro.org>
References: <70f5476004b2f4e4b444bf8425f21a3c993edf47.1550543288.git.baolin.wang@linaro.org>
In-Reply-To: <70f5476004b2f4e4b444bf8425f21a3c993edf47.1550543288.git.baolin.wang@linaro.org>
References: <70f5476004b2f4e4b444bf8425f21a3c993edf47.1550543288.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use SoC compatible string instead of wildcard string.

The Spreadtrum SC9860 platform device trees and drivers' development
are still in progress, and now we will always recompile and ship
device trees at the same time as we will compile and ship the kernel,
so we do not need care about the backwards compatibility.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes from v2:
 - Add some comments to explain why we do not care backwards compatibility.

Changes from v1:
 - None.
---
 drivers/gpio/gpio-pmic-eic-sprd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index ac573da..24228cf 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -364,7 +364,7 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 }
 
 static const struct of_device_id sprd_pmic_eic_of_match[] = {
-	{ .compatible = "sprd,sc27xx-eic", },
+	{ .compatible = "sprd,sc2731-eic", },
 	{ /* end of list */ }
 };
 MODULE_DEVICE_TABLE(of, sprd_pmic_eic_of_match);
-- 
1.7.9.5

