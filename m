Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11429C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:49:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D52F6222BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 12:49:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="F/RF3ngD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfBMMte (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 07:49:34 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44257 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731306AbfBMMtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 07:49:33 -0500
Received: by mail-pl1-f194.google.com with SMTP id p4so1109933plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Feb 2019 04:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=n2zijRNVEEZxaFFq6SENuRdyoDepnIONcSPBxOaa6Xk=;
        b=F/RF3ngD0A5yLg+dR/9mJJO/ehA4/xBxamJuvuOrCh0KVawjkqooZYXyGc8uOIzvg4
         W2kS13JAsoqLbUBJSZDPt6AR7QDFlM9agSF34YRXUMbbOxzrhDclGzGRV7xCLKu0aPvS
         CNX758xsKKVtCjIWu4rVbC/1EBQ5bzNhoow5SjmIcNKlHfvnZpB82vn9kDh1i0luCrm/
         hNDdnimaHJmiTkT/1tVJF6sTT9vJ4d/0uSvozGUk7Kz71YkCdQML0bXHdF3kD/4SO/2U
         KVYZgDIHP4UFVb8K0YAGgS+vBrEvhslQrBeBoWqu6AbgtvJE1y54QJil4dqAtczavXLl
         pthA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=n2zijRNVEEZxaFFq6SENuRdyoDepnIONcSPBxOaa6Xk=;
        b=UwnNNCFN/QAky66QMTZ9nKxtn3YneRIl7GmyJ2SJRRcmZhIW+iYKEXs5OaaYK7vMN1
         aaX0WzIywYTABEqxrzoaKE2mQgJHj0ERzf2p39AM/1I7DBwaaA6PLWh8TUKtAx5w9woY
         MdQRSvhRo97LSmjM91KAl3/UI7w7A61yTZaKIkosMfike+iascSgY5Nlh0JUn0hMqL+i
         F7PjbLZMZEMurx1YRXjxkvqQEh/+maAepG9bDtj+XUn/iYaPwKMTbGs2dqPDD9rfu5QO
         OHSz82uXH+UU3jMACKTxWaM6RdfzunMlrIuYqlPrABtO5SvAzx2fvZA3OQ4gYT2FCVru
         vYQw==
X-Gm-Message-State: AHQUAuZhygr40nuNLBu1kJnFpOt+N8hAmiZHp7OzotTAXd+T8/4GsI9l
        jjR+obqUNMjPKLhOrwQGAQOxqg==
X-Google-Smtp-Source: AHgI3IYnRjW7jWd0DSyRrN0kdJZPs4nV9OZUKKVH8ZtTw64eVs9eyW0hBrS131kJQADvmUsE0O2Ogg==
X-Received: by 2002:a17:902:e612:: with SMTP id cm18mr372575plb.172.1550062173507;
        Wed, 13 Feb 2019 04:49:33 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id z62sm28530243pfi.4.2019.02.13.04.49.29
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Feb 2019 04:49:32 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] gpio: sprd: Change to use SoC compatible string
Date:   Wed, 13 Feb 2019 20:48:14 +0800
Message-Id: <0438b78c7f9f9bc3f0e7bcbcef3873fd2dd7e259.1550061925.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
In-Reply-To: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
References: <b8101fd6d303c1993ee294eeee8bce4d24b9547f.1550061925.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use SoC compatible string instead of wildcard string.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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

