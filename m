Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C7A4C282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC6F820823
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="FlvF7l6l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729200AbfAUICm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:02:42 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37159 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfAUICl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:02:41 -0500
Received: by mail-pf1-f195.google.com with SMTP id y126so9762277pfb.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=YSO3o33xwpZEnY3dvM5KsEyTJ0JSkemSKiFEUP456FU=;
        b=FlvF7l6lfla3iCYt5v9kdG+acvXvTeFeg/qzfGi5BNxYTpZYrPAeDngZg6nm00b9S3
         NbGwHhlcE6GYx4P0ta4rjdqhQdwf/QcNJI79EKuQ/yyb1KuL+pqdmZW0MqeCtizSPRJV
         AOMpETPdNE2cjwkASbSwY6na1Fs2BcMC5j1AU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YSO3o33xwpZEnY3dvM5KsEyTJ0JSkemSKiFEUP456FU=;
        b=MS8vi9wk4fcK7okSKPztD+JrCYMz1IDqLonY5W1WjT3n2QfuXPy1G7hXqs2yQUAPA6
         JqgLd7bkae96hMID8MTNklUtJ/UweNHJGA93kc4dxZftlTzg/TmH+QHLAM2wAS5IYwn4
         RzzHubTM5ih5k8Ib+mjeLIkXj+mQPlbnX45V/hVb5IG0N4w4x5W6WF6yh5ylGVifhFqb
         koTThiSSqKMt5/m4yqbN2h3Ol1hKB4EGccOtgb4LWnOqQRg8WEhavja8UmI7ofib9+Qp
         qAnpjWmfDFiBzYniPUhaHH4u4sSGHT8Q8fc/hzMNjpLnvGswT4gjxKxVzntj6OkX3hHx
         UlcQ==
X-Gm-Message-State: AJcUukfaDe7inwSymXJSEA90NOiycjzLVhUVrTScAV+Gd3gwTlxHqnYg
        MOfxOXcxU7QpAg5uIjkzprELiQ==
X-Google-Smtp-Source: ALg8bN628PJ/H0gKED4QC4efZUQWbB3egHAmjavO6rCI1l6uN/ac5MmUe+WCQFamxSECTuShHFzdVA==
X-Received: by 2002:a62:5e41:: with SMTP id s62mr28172745pfb.232.1548047193126;
        Sun, 20 Jan 2019 21:06:33 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id u87sm27186794pfi.2.2019.01.20.21.06.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Jan 2019 21:06:32 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        neo.hou@unisoc.com, broonie@kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] gpio: sprd: Remove unused irq trigger setting
Date:   Mon, 21 Jan 2019 13:05:39 +0800
Message-Id: <972fd6c1a222b35159671ca82fb63db1632c3ba3.1548046988.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Spreadtrum PMIC interrupt controller has no registers to set irq
trigger type, since it is always high level trigger. That means the
PMIC EIC controller as a child device of PMIC INTC does not need to
set the trigger type, so remove it.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/gpio/gpio-pmic-eic-sprd.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpio/gpio-pmic-eic-sprd.c b/drivers/gpio/gpio-pmic-eic-sprd.c
index 29e044f..ac573da 100644
--- a/drivers/gpio/gpio-pmic-eic-sprd.c
+++ b/drivers/gpio/gpio-pmic-eic-sprd.c
@@ -322,7 +322,6 @@ static int sprd_pmic_eic_probe(struct platform_device *pdev)
 
 	ret = devm_request_threaded_irq(&pdev->dev, pmic_eic->irq, NULL,
 					sprd_pmic_eic_irq_handler,
-					IRQF_TRIGGER_LOW |
 					IRQF_ONESHOT | IRQF_NO_SUSPEND,
 					dev_name(&pdev->dev), pmic_eic);
 	if (ret) {
-- 
1.7.9.5

