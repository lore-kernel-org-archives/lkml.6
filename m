Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E4CC282C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E69321773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 03:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+cDA7H9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbfBLDwD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 22:52:03 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41554 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbfBLDwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 22:52:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id b7so608508pfi.8
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 19:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=yNNbD6//shUgVJDqF6KkOVva8DupadW9tZS+I+T4ju8=;
        b=i+cDA7H9QfmewUC29F2PK07rfP/QTMGy++9SRwsK9yFiSU1r16P0XzVUD3wORds3NP
         R6ZlyvdugRISarS8v0HVuAjhSekp/JxCjnjLOX9WcIa5hjTqRLUiNRfFLbR15oUw80XM
         CfswiSZZ+56c1W3eKtlmB35L9Ni5sK/cVAfTR6Pi//CtMSJUxeSwA++UouyawNeHftk0
         IEHc4AgRZfTQYrYkoHcKtbPLeT519oBvHLwB0IwKgEI9g+fAdXejFxKoSnYRLxJDgfLP
         fZOLe4fPBXADSsyLaDjD2sAx89ZC5zv+oseaZSu7HOaC/rQKN2eq9XCpE9VhaRvgEk/1
         blLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yNNbD6//shUgVJDqF6KkOVva8DupadW9tZS+I+T4ju8=;
        b=Yv1uH709AXrH1yvmjJBRO45ylCVNDFF8y4ft26vr2EhT2t4UKczcO+PTHzjTVbolQi
         noUKLQaub5PFWvE8npf0QXwHSXxepB15GYWd9f/OGhr1DFO+PPml2eG8D6ycY4UZcGiv
         GYVDv7o/H7HCA+FNR9BcYojU6kkf7Uwu7HtyqdzIDmhR+viHl54tPnKzzYbSa9WKFYC1
         gu+aduutfxu3PV0Sp/Dwg2vDS4WJ04A8/bERUS8SEbPQDlYX0cPTTOhDxN3XuCZfuvtx
         yHIqpP24F16yNgDxFE9mz0DxbIiafVvpHnCJ++CzHNSwoqs1YwJbz4EQTF1Hb630Gst+
         HnQw==
X-Gm-Message-State: AHQUAuaeCqjx2nvEn9gIC1HIbJYW80oaGjTyB1gcY8AWRD2zVanO+rDV
        aQkvOwFaCiItSgTcAZppBCtUyw==
X-Google-Smtp-Source: AHgI3IZHX18AzaQOVLSpHAkcDO03lmNTkvZBqwuY4k4MZHIx7Js6XgCG2GzIh1KOaWCjLRpxnZJQqw==
X-Received: by 2002:a62:28c9:: with SMTP id o192mr1871984pfo.57.1549943520323;
        Mon, 11 Feb 2019 19:52:00 -0800 (PST)
Received: from localhost.localdomain (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id m3sm20311131pfi.102.2019.02.11.19.51.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 19:51:59 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Brian Masney <masneyb@onstation.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] qcom: spmi-gpio: Fix boundary conditions IRQ domain translate
Date:   Mon, 11 Feb 2019 19:52:05 -0800
Message-Id: <20190212035205.23477-1-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GPIOs on the SPMI PMIC are numbered 1..ngpio, so the boundary check in
pmic_gpio_domain_translate() is off by one, correct this.

Fixes: ca69e2d165eb ("qcom: spmi-gpio: add support for hierarchical IRQ chip")
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/pinctrl/qcom/pinctrl-spmi-gpio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
index e01a556ac586..cb512c7a5251 100644
--- a/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
+++ b/drivers/pinctrl/qcom/pinctrl-spmi-gpio.c
@@ -962,7 +962,8 @@ static int pmic_gpio_domain_translate(struct irq_domain *domain,
 						     struct pmic_gpio_state,
 						     chip);
 
-	if (fwspec->param_count != 2 || fwspec->param[0] >= state->chip.ngpio)
+	if (fwspec->param_count != 2 ||
+	    fwspec->param[0] < 1 || fwspec->param[0] > state->chip.ngpio)
 		return -EINVAL;
 
 	*hwirq = fwspec->param[0] - PMIC_GPIO_PHYSICAL_OFFSET;
-- 
2.18.0

