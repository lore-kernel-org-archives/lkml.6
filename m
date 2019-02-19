Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A7DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D690821848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 09:58:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4DLEUO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfBSJ6n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 04:58:43 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:51603 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbfBSJ63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 04:58:29 -0500
Received: by mail-wm1-f67.google.com with SMTP id n19so1860228wmi.1;
        Tue, 19 Feb 2019 01:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MmokmzNg6WkTR+NygtzuXU+g6jndTuYFkgnanLj3Ipo=;
        b=B4DLEUO0DFsRBjtKvitDAKr7JA8wB558yyNXOe0AF8OFun32pRzSMXI+4bIjb+58R0
         x5wU1ZthIDtA8nMbne+AjAJRtu0ANmZg42Eyj72ZTaXcYJoRbGsdoeoWDlls/aCx0Ba9
         oAQtJWtQeSp/r0MpqLz4DYDbZ1/utmQtltjZzqC2sVdGVYGzz1yPeMZbCyKpuNjYp2y3
         mxEhe0CR/AYryQ1MgIuHpJy7dPkVECGaTKvC0kud8Bzr2V0u9ibzGLmzGG7zxqmXk9rl
         GlQ2cM1Vu9PxqGess0cAwQp5fuKnnfJwi6ZfDhA4UPSEhyK4oPndXumFZCW/28fVIatL
         3L6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MmokmzNg6WkTR+NygtzuXU+g6jndTuYFkgnanLj3Ipo=;
        b=I3xs2q4MhAZwA4lILB1JckE6lAJIhn/UKWhnL16bJO+u92CjAYjsvUDD3pL/6SSGbK
         6xw0zhSI7ZCHl0c79j9oZiYuTzj8P3CtghsHYf+wVQeDtv0iUAp9bL0vWyYgeRu7KOL3
         4RMnCmHEQLXxody133j12BUBsi2Qgfd8plBfk1lXCrVPlgEIC3V1nqTjcaw5KMarRBzE
         YcOa4EGH57oCUkRUXmk9U4Fi63e5yYSLy80rU/aUAQ/JmKvaJtSPFxEozbL0Bq43x3EW
         v5gHgmirt1lvNoEXNHaHx0HzRf+CL1+d68cwwNHQG4ZuJP4FZsykP+26NdrmFozTa0gb
         uvLA==
X-Gm-Message-State: AHQUAububSfNhBec0BwGE8usNBjvA+DZokjbecAJLmWKez9gj7fmiJta
        L+XYQfjboViO63cydr2QaCY=
X-Google-Smtp-Source: AHgI3IZ8oVD5uxw/MiO3KUSfJZ+7bVrdejE22hlYNUuSdIPuPWie8H43PcjkKNjcapqgcihkv4L1Jg==
X-Received: by 2002:a05:600c:2159:: with SMTP id v25mr2097620wml.17.1550570307194;
        Tue, 19 Feb 2019 01:58:27 -0800 (PST)
Received: from fuji.Parrot.Biz (smtp.parrot.biz. [62.23.167.188])
        by smtp.gmail.com with ESMTPSA id k20sm31639220wre.41.2019.02.19.01.58.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 01:58:26 -0800 (PST)
From:   Mathieu Othacehe <m.othacehe@gmail.com>
To:     thierry.reding@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Mathieu Othacehe <m.othacehe@gmail.com>
Subject: [PATCH v3 3/3] pwm: hibvt: Add hi3559v100 support
Date:   Tue, 19 Feb 2019 10:58:08 +0100
Message-Id: <20190219095808.12059-3-m.othacehe@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219095808.12059-1-m.othacehe@gmail.com>
References: <20190219095808.12059-1-m.othacehe@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for hi3559v100-shub-pwm and hisilicon,hi3559v100-pwm
platforms. They require a special quirk: pwm has to be enabled again
to force duty_cycle refresh.

Signed-off-by: Mathieu Othacehe <m.othacehe@gmail.com>
---
 drivers/pwm/pwm-hibvt.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-hibvt.c b/drivers/pwm/pwm-hibvt.c
index ffc803818c3c..f81c6fcb79be 100644
--- a/drivers/pwm/pwm-hibvt.c
+++ b/drivers/pwm/pwm-hibvt.c
@@ -54,6 +54,7 @@ struct hibvt_pwm_chip {
 
 struct hibvt_pwm_soc {
 	u32 num_pwms;
+	bool quirk_force_enable;
 };
 
 static const struct hibvt_pwm_soc hi3516cv300_soc_info = {
@@ -64,6 +65,16 @@ static const struct hibvt_pwm_soc hi3519v100_soc_info = {
 	.num_pwms = 8,
 };
 
+static const struct hibvt_pwm_soc hi3559v100_shub_soc_info = {
+	.num_pwms = 8,
+	.quirk_force_enable = true,
+};
+
+static const struct hibvt_pwm_soc hi3559v100_soc_info = {
+	.num_pwms = 2,
+	.quirk_force_enable = true,
+};
+
 static inline struct hibvt_pwm_chip *to_hibvt_pwm_chip(struct pwm_chip *chip)
 {
 	return container_of(chip, struct hibvt_pwm_chip, chip);
@@ -152,13 +163,23 @@ static void hibvt_pwm_get_state(struct pwm_chip *chip, struct pwm_device *pwm,
 static int hibvt_pwm_apply(struct pwm_chip *chip, struct pwm_device *pwm,
 				struct pwm_state *state)
 {
+	struct hibvt_pwm_chip *hi_pwm_chip = to_hibvt_pwm_chip(chip);
+
 	if (state->polarity != pwm->state.polarity)
 		hibvt_pwm_set_polarity(chip, pwm, state->polarity);
 
 	if (state->period != pwm->state.period ||
-		state->duty_cycle != pwm->state.duty_cycle)
+	    state->duty_cycle != pwm->state.duty_cycle) {
 		hibvt_pwm_config(chip, pwm, state->duty_cycle, state->period);
 
+		/*
+		 * Some implementations require the pwm to be enabled
+		 * once more each time the duty cycle is refreshed.
+		 */
+		if (hi_pwm_chip->soc->quirk_force_enable && state->enabled)
+			hibvt_pwm_enable(chip, pwm);
+	}
+
 	if (state->enabled != pwm->state.enabled) {
 		if (state->enabled)
 			hibvt_pwm_enable(chip, pwm);
@@ -259,6 +280,10 @@ static const struct of_device_id hibvt_pwm_of_match[] = {
 	  .data = &hi3516cv300_soc_info },
 	{ .compatible = "hisilicon,hi3519v100-pwm",
 	  .data = &hi3519v100_soc_info },
+	{ .compatible = "hisilicon,hi3559v100-shub-pwm",
+	  .data = &hi3559v100_shub_soc_info },
+	{ .compatible = "hisilicon,hi3559v100-pwm",
+	  .data = &hi3559v100_soc_info },
 	{  }
 };
 MODULE_DEVICE_TABLE(of, hibvt_pwm_of_match);
-- 
2.17.1

