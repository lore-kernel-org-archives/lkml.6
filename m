Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A403C282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22F32218AD
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 09:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbuvdiXo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728368AbfBLJtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 04:49:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35367 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727600AbfBLJth (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 04:49:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so2285689wmt.0;
        Tue, 12 Feb 2019 01:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uqe/TFtTZ0ij7Yuis+KAoIHGt2xbd1SMI4ZKNHTGhLs=;
        b=bbuvdiXoO4qmGCB1F9eX2x0tME1+jJWavdYsDdC2ih2RxgKpPgtkjifbNWs5OZKz5g
         zxEOfzsZRFfCxF11PwdOtl/crKgm2Hyu4CbCef9X0XlfSbof5AX31DH2o2HF5zGYqMHv
         I3GRc1XsGMmTY3ndcvOl6KSC/IZeNTaqUt2FlatjoB9ebmSmwWiv+5GC7EFSWpTN46VH
         FBIARHL163sGayAMJpI4AiMhraJIvYcii+3AVFtPArd/TVW4PGxrPiY7vyc+h4MT3R2w
         cBT83v4GhiqYRWzJxQQHLoz9XiGmW9ctHqBBikM40P3xux/y7d3P5R2ZXu3pnLy3wggO
         Y+uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=uqe/TFtTZ0ij7Yuis+KAoIHGt2xbd1SMI4ZKNHTGhLs=;
        b=brnxa6woTWEgpXNbsM/C1wA+Kkg5efxYZ4xQBlGeIwMyJlQRO1rL4jJSvuRDCxybTW
         1j+/zqm2f8jdUM/9fKInpBoMS1usGqSTBeqzIzvpRuI4lv9Omqd2V9ekYDAaI0jSEVYI
         OXt8N5YjEnU/AhnCTEVvkwLe0F0CJtz0g6IDFgG3BoVaw5enILWXV2g7DreJfJBA+NXP
         /4d25sXUt6kiashoiAm91uN28yNoHutDWNNr3zTOSlRLMWUuBpwEJDsmenYLn9CnNvfb
         NSpVIioTUbU5u6gO/G+eaHaMWZrgqNc9arrNZOsXT/TFF46+rzDlGV09vUz6nBjH6OhP
         P+ww==
X-Gm-Message-State: AHQUAuaDJ3qfWZF2L0iV6wD7WZUsiQUxsxaJ1XO2AzTExE1pf4YCFlcx
        ZanMgTCOV6zc1Tuq7XZutSAHcDQVP1E=
X-Google-Smtp-Source: AHgI3IblHVRXcMnVWn+hkF424TDLgbbXXf7vx3xOyKihoESrAq2HygoB15m9Q9NNtBBIpLOPnhWJLQ==
X-Received: by 2002:a7b:c7c2:: with SMTP id z2mr2055796wmk.47.1549964974696;
        Tue, 12 Feb 2019 01:49:34 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id d2sm9299843wrs.97.2019.02.12.01.49.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Feb 2019 01:49:33 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH 2/2] pwm: hibvt: Add hi3559v100 support
Date:   Tue, 12 Feb 2019 10:49:27 +0100
Message-Id: <20190212094927.5900-2-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190212094927.5900-1-m.othacehe@gmail.com>
References: <20190212094927.5900-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
platforms. They require a special quirk: pwm has to be enabled again
to force duty_cycle refresh.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index 27c107e78d59..bf33aa24433c 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -49,6 +49,7 @@ struct hibvt_pwm_chip {
 	struct clk *clk;
 	void __iomem *base;
 	struct reset_control *rstc;
+	bool quirk_force_enable;
 };
 
 struct hibvt_pwm_soc {
@@ -56,6 +57,7 @@ struct hibvt_pwm_soc {
 };
 
 static const struct hibvt_pwm_soc pwm_soc[2] = {
+	{ .num_pwms = 2 },
 	{ .num_pwms = 4 },
 	{ .num_pwms = 8 },
 };
@@ -148,13 +150,19 @@ static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+
 	if (state->polarity != pwm->state.polarity)
 		hibvt_pwm_set_polarity(chip, pwm, state->polarity);
 
 	if (state->period != pwm->state.period ||
-		state->duty_cycle != pwm->state.duty_cycle)
+		state->duty_cycle != pwm->state.duty_cycle) {
 		hibvt_pwm_config(chip, pwm, state->duty_cycle, state->period);
 
+		if (hi_pwm_chip->quirk_force_enable && state->enabled)
+			hibvt_pwm_enable(chip, pwm);
+	}
+
 	if (state->enabled != pwm->state.enabled) {
 		if (state->enabled)
 			hibvt_pwm_enable(chip, pwm);
@@ -176,6 +184,7 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 {
 	const struct hibvt_pwm_soc *soc =
 				of_device_get_match_data(&pdev->dev);
+	struct device_node *np = pdev->dev.of_node;
 	struct hibvt_pwm_chip *pwm_chip;
 	struct resource *res;
 	int ret;
@@ -199,6 +208,15 @@ static int hibvt_pwm_probe(struct platform_device *pdev)
 	pwm_chip->chip.of_xlate = of_pwm_xlate_with_flags;
 	pwm_chip->chip.of_pwm_n_cells = 3;
 
+	/*
+	 * On those platforms, it is required to enable the
+	 * pwm again each time we want to refresh the duty
+	 * cycle.
+	 */
+	if (of_device_is_compatible(np, "hisilicon,hi3559v100-shub-pwm") ||
+		of_device_is_compatible(np, "hisilicon,hi3559v100-pwm"))
+		pwm_chip->quirk_force_enable = true;
+
 	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
 	pwm_chip->base = devm_ioremap_resource(&pdev->dev, res);
 	if (IS_ERR(pwm_chip->base))
@@ -250,8 +268,10 @@ static int hibvt_pwm_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id hibvt_pwm_of_match[] = {
-	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[0] },
-	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[1] },
+	{ .compatible = "hisilicon,hi3516cv300-pwm", .data = &pwm_soc[1] },
+	{ .compatible = "hisilicon,hi3519v100-pwm", .data = &pwm_soc[2] },
+	{ .compatible = "hisilicon,hi3559v100-shub-pwm", .data = &pwm_soc[2] },
+	{ .compatible = "hisilicon,hi3559v100-pwm", .data = &pwm_soc[0] },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
-- 
2.17.1

