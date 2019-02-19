Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A61EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:12:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0282147C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 19:12:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrulZOWa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbfBSTMf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 14:12:35 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:34383 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbfBSTMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 14:12:34 -0500
Received: by mail-pl1-f196.google.com with SMTP id d15so3736496plr.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Feb 2019 11:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=VHWMlfMrTM94H6bRgK8jtWQ5WLwGNoqEAx6AZJOMxRg=;
        b=SrulZOWaIyBv5yIc5mXmO3mFbboC90sxAkEqy69UQ6rSsYIjntnb5L1FSFvvIOZPBy
         WH0b24VW/e78Gr/mdQLXp2Cz+gCjOAEN55VLNUmhzauyfAE851KM9N4Ls1PXQMxttUn6
         kBMLFDEvxIKE8K5cYzfcgIpj0Qohm9BLuIX+Q0AqWnZusR9hjcn4ly8GULAY0h196Sdf
         kBbYxNetwDYiIRYjxw2T1Q6Dw5XJbXxkctWy6C1r7b2JhJwOcXxhjKFVbpGTCTmd4Eeg
         ga1Ih3NI252JzZTYxtRaUUcUWuoi0PUoJQkUMOOBYV+/uh1gfuEBcp1rr1MIQTbadx3X
         dfug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VHWMlfMrTM94H6bRgK8jtWQ5WLwGNoqEAx6AZJOMxRg=;
        b=kAJ1FEwfnoc4/XeFUJRrDL3+5vXvkO/0UkVNVFjgxKe2EZiFAEOi90yI1lqzlMywnv
         y2lB/1FX+Nd44b7Q1Woo+v25wtvIAxa5Qu5MTaXkTql3iplSTRteWYkJ/LHeblFqaGBh
         SirKqdTeSEePkh4MNt1TFKNS09eJOx+v627E4bQg5mFXXCSrfT5qxNVVs6mPgniahXyC
         NjmXMix177gpCmGEV5KKVngaZDipFr/rfPt1gwxZYB7u357tm0GTaxYbTbBdx6IwJZ8s
         y2SLvYx/8FgzzK5NB0j1kEIdyN2W2iqcDXkHupFOrSdSuy885xJK7cDKJ5CXbn9tJBcT
         ZVXg==
X-Gm-Message-State: AHQUAuYdrMX40Dl6Nt8/PWaKeOKDKgpFMlf2kp3SbGpz8DxTcqJnNTZk
        T6bZmGk22R3TlF1FcRHcQaMknQ==
X-Google-Smtp-Source: AHgI3Ia3b6ZJlhKBY1BcA9LcZZe9n2aMztSYcGq1/yrdTjXG5zxg37y4BCsv61wBENeYZjCzBG1pyA==
X-Received: by 2002:a17:902:bc88:: with SMTP id bb8mr32864928plb.12.1550603553928;
        Tue, 19 Feb 2019 11:12:33 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id h64sm24910009pfc.142.2019.02.19.11.12.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Feb 2019 11:12:33 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pinctrl: qcom: spmi-gpio: Reorder debug print
Date:   Tue, 19 Feb 2019 11:12:53 -0800
Message-Id: <20190219191253.21712-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's reasonable to expect that people turn to the "gpio" debugfs file to
first and foremost learn about the direction and value of a gpio, and
second to that about it's pinconf. So reorder the value so each line
reads:

gpioN: direction value ...

This also makes it consistent with the TLMM pinctrl driver's output in
the same dump.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index cb512c7a5251..76e57ae2f6e8 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -675,11 +675,11 @@ static void pmic_gpio_config_dbg_show(struct pinctrl_dev *pctldev,
 		else
 			seq_printf(s, " %-4s",
 					pad->output_enabled ? "out" : "in");
+		seq_printf(s, " %-4s", pad->out_value ? "high" : "low");
 		seq_printf(s, " %-7s", pmic_gpio_functions[function]);
 		seq_printf(s, " vin-%d", pad->power_source);
 		seq_printf(s, " %-27s", biases[pad->pullup]);
 		seq_printf(s, " %-10s", buffer_types[pad->buffer_type]);
-		seq_printf(s, " %-4s", pad->out_value ? "high" : "low");
 		seq_printf(s, " %-7s", strengths[pad->strength]);
 		seq_printf(s, " atest-%d", pad->atest);
 		seq_printf(s, " dtest-%d", pad->dtest_buffer);
-- 
2.18.0

