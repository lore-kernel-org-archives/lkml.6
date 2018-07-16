Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 240A2ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5C75208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 13:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KivylH9w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5C75208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbeGPOA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 10:00:58 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:33511 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbeGPOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 10:00:57 -0400
Received: by mail-lf0-f65.google.com with SMTP id u14-v6so32262972lfu.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jul 2018 06:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gNY/u5IfBn+WPrF9/q8QV4Fv05wKjSYEjbXLAtlmLPI=;
        b=KivylH9w7gQDgAsfV3EiG1hsYD9DSP7nI6erenVxzw5y1VwamUQK0gWnhnioubePMr
         4RuqtxgJciaEfG0OKXFDBjTTOQfxrrZRyUjHn3HASOB918O2qn+lm2qUyG01UFVWccu+
         K6retx8lpTvy/0XhVH8r8iCaLj5TTy0aVG9VI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gNY/u5IfBn+WPrF9/q8QV4Fv05wKjSYEjbXLAtlmLPI=;
        b=dz1Fh2WxnNpYBHT/igwPJLZ1qpmX/XAo71hOE2T0d9F0kv7dQmtg3tNyDbiJCSP9q6
         DWl+rSZhBTk3R6uxiJsZU6hpwIxvCboHYMLQrI6qkhqj28ROpLzMcaUEMRekEcnPyGZw
         fwrv5DddEfIpeAhQVp5a4g0Snrr8Pde0V3yyDsAlLsZ6Ms08DUKviSVbYhYB2x/VU0I6
         R3aEKuCmxe+eh5bmeWkYeQF3GqUjw2S5JCvXSJW4Jwj/dhTnNAmn2uzbEODv8amvAB0M
         AAMVrPGw9OBfBRu+/rcuFrw2ZfQKc3Q6qXaOBwdBCLh1D5U6a/axhQcLq8wE6HykExkx
         vcJw==
X-Gm-Message-State: AOUpUlFVjDfb9ZKsBoOWYkImzmnd7ymPpBYlxOcRYDGLJzX2blw+FNMS
        UbVving3Ake0da9ccQzm7laD/g==
X-Google-Smtp-Source: AAOMgpf5bbehdhwjyDNXTp2ersT3l9fZuISMb/oufP9JABeI5hNhyKkexE/Ndtob8MpAmkdTwTwByQ==
X-Received: by 2002:a19:e803:: with SMTP id f3-v6mr12402555lfh.84.1531748007457;
        Mon, 16 Jul 2018 06:33:27 -0700 (PDT)
Received: from centauri.lan (h-229-118.A785.priv.bahnhof.se. [5.150.229.118])
        by smtp.gmail.com with ESMTPSA id x3-v6sm4915998ljb.25.2018.07.16.06.33.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 16 Jul 2018 06:33:27 -0700 (PDT)
From:   Niklas Cassel <niklas.cassel@linaro.org>
To:     broonie@kernel.org, Liam Girdwood <lgirdwood@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, johan@kernel.org,
        Niklas Cassel <niklas.cassel@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/4] regulator: qcom_spmi: Indent with tabs instead of spaces
Date:   Mon, 16 Jul 2018 15:32:54 +0200
Message-Id: <20180716133255.1506-5-niklas.cassel@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180716133255.1506-1-niklas.cassel@linaro.org>
References: <20180716133255.1506-1-niklas.cassel@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following checkpatch error:

ERROR: code indent should use tabs where possible
+        { }$

Fixes: ca5cd8c9400c ("regulator: qcom_spmi: Add support for pmi8994")
Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
---
 drivers/regulator/qcom_spmi-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/qcom_spmi-regulator.c b/drivers/regulator/qcom_spmi-regulator.c
index 5246f5b870c2..53a61fb65642 100644
--- a/drivers/regulator/qcom_spmi-regulator.c
+++ b/drivers/regulator/qcom_spmi-regulator.c
@@ -1728,7 +1728,7 @@ static const struct spmi_regulator_data pmi8994_regulators[] = {
 	{ "s2", 0x1700, "vdd_s2", },
 	{ "s3", 0x1a00, "vdd_s3", },
 	{ "l1", 0x4000, "vdd_l1", },
-        { }
+	{ }
 };
 
 static const struct of_device_id qcom_spmi_regulator_match[] = {
-- 
2.17.1

