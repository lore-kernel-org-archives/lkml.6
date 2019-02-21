Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 425CFC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1195320842
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 15:26:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="saVlx+jS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfBUP0L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 10:26:11 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37389 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfBUP0H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 10:26:07 -0500
Received: by mail-wr1-f67.google.com with SMTP id c8so30991207wrs.4;
        Thu, 21 Feb 2019 07:26:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QaXaNTZnl4LT0GvNQL4ryRi6cnfcXOGXncEBEL7o+PY=;
        b=saVlx+jSkeWUsFy1OQY3QUWnrMXEJ/0RcnYvrxtBHDD0XgM7n9q7SRLtBjG0qsNtCW
         utW746Zc1ZZ92vMwAexqMhLXdYzMkcFoGoctDKOXtIqzK8snilw3MyjfzbT7mLFjNoGO
         o+ncyf7yZqRInRljrcj5a7tam/0sqgId5g/jzkBN3dijK4qCqVeFfDCsF2dypi+a6XGr
         voTD5WurPsmeeckESq0PPrkg/ubKmunsKU5b0wlHr4DRJRDjHj69o6tQxq4Q5BlVdgCy
         E43c2AJtjpk8y7qFm05q8cTPceN19TNHdMW7VfmG8cE+F1RABWxHBgckUbfdkdkDsGpN
         hWSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QaXaNTZnl4LT0GvNQL4ryRi6cnfcXOGXncEBEL7o+PY=;
        b=SSlQBdRkLqCk7ea3ZvlSNM5YqcjM1bhWP8qmFbfcaXALcW4B1TPSzk+dep4WpzC0rF
         AtWti9RzDMtk4ATcXZXDZEfyMQpshQvWLhYCc7MwulCzX44Muuiw+shFKGwqRH+ZSwg/
         nbyuDMkHXn5dgiUCYv6VVbXB01S10n1vkvFYN9KkzaecWJldhl28v2Ika4yzMQRYENKq
         YdGywqTwC8jsmixP0Ahvg2C/ZYuFKkpIPiQSXn47Jcf9tfIYvH5AJ1m5dTJ+v2V5c68d
         EGpuoX7nsk+arynOL3NjdtxN0wkAgjTOpe8jIm/tqqckMtBHtUkGD+bkuAzrkemvvwAB
         IUdw==
X-Gm-Message-State: AHQUAubT8EeBYzK70omGt0PsyyB+Q65GMHQhpMQKDB5PruqiIhogSB09
        UKjuMzYAf2Ki9XSYkovRPQ4=
X-Google-Smtp-Source: AHgI3IZ9goUs/jn1S2BkdCfWELpYNm4Ns8anNTPb3uY2ef7Sb/rudZSEwwDzVCWscNrvlG4Opk+v5Q==
X-Received: by 2002:a1c:9d92:: with SMTP id g140mr10690726wme.35.1550762765377;
        Thu, 21 Feb 2019 07:26:05 -0800 (PST)
Received: from localhost (pD9E51D2D.dip0.t-ipconnect.de. [217.229.29.45])
        by smtp.gmail.com with ESMTPSA id z8sm6943928wmi.28.2019.02.21.07.26.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 21 Feb 2019 07:26:04 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Jonathan Hunter <jonathanh@nvidia.com>,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] drm/tegra: sor: Implement acquire/release for reset
Date:   Thu, 21 Feb 2019 16:25:57 +0100
Message-Id: <20190221152557.8534-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190221152557.8534-1-thierry.reding@gmail.com>
References: <20190221152557.8534-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

By implementing the acquire/release protocol, the SOR reset can be
shared with other drivers that also adhere to this protocol, such as the
PMC driver that uses the same reset as part of the powergate and -ungate
implementation using generic power domains.

Runtime PM makes sure that the operations are executed in the right
order, and the reset core has error handling and WARNs in place to make
sure the acquire/release protocol is followed.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/tegra/sor.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
index 40057106f5f3..5be5a0817dfe 100644
--- a/drivers/gpu/drm/tegra/sor.c
+++ b/drivers/gpu/drm/tegra/sor.c
@@ -2871,6 +2871,13 @@ static int tegra_sor_init(struct host1x_client *client)
 	 * kernel is possible.
 	 */
 	if (sor->rst) {
+		err = reset_control_acquire(sor->rst);
+		if (err < 0) {
+			dev_err(sor->dev, "failed to acquire SOR reset: %d\n",
+				err);
+			return err;
+		}
+
 		err = reset_control_assert(sor->rst);
 		if (err < 0) {
 			dev_err(sor->dev, "failed to assert SOR reset: %d\n",
@@ -2894,6 +2901,8 @@ static int tegra_sor_init(struct host1x_client *client)
 				err);
 			return err;
 		}
+
+		reset_control_release(sor->rst);
 	}
 
 	err = clk_prepare_enable(sor->clk_safe);
@@ -3331,7 +3340,7 @@ static int tegra_sor_probe(struct platform_device *pdev)
 		goto remove;
 	}
 
-	sor->rst = devm_reset_control_get(&pdev->dev, "sor");
+	sor->rst = devm_reset_control_get_exclusive_released(&pdev->dev, "sor");
 	if (IS_ERR(sor->rst)) {
 		err = PTR_ERR(sor->rst);
 
@@ -3519,6 +3528,8 @@ static int tegra_sor_suspend(struct device *dev)
 			dev_err(dev, "failed to assert reset: %d\n", err);
 			return err;
 		}
+
+		reset_control_release(sor->rst);
 	}
 
 	usleep_range(1000, 2000);
@@ -3542,9 +3553,17 @@ static int tegra_sor_resume(struct device *dev)
 	usleep_range(1000, 2000);
 
 	if (sor->rst) {
+		err = reset_control_acquire(sor->rst);
+		if (err < 0) {
+			dev_err(dev, "failed to acquire reset: %d\n", err);
+			clk_disable_unprepare(sor->clk);
+			return err;
+		}
+
 		err = reset_control_deassert(sor->rst);
 		if (err < 0) {
 			dev_err(dev, "failed to deassert reset: %d\n", err);
+			reset_control_release(sor->rst);
 			clk_disable_unprepare(sor->clk);
 			return err;
 		}
-- 
2.20.1

