Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74130C10F02
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4210621924
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 04:55:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="InlORRX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388439AbfBOEzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 23:55:40 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:41611 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388317AbfBOEzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 23:55:38 -0500
Received: by mail-pl1-f193.google.com with SMTP id k15so4327128pls.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 20:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=Qupsk1SvP4uPjxCdck7dbvtWJL9P1nZ/WFvQV4WBoGU=;
        b=InlORRX3RrOUc0zLLRa/Xsg4FSwWz4g70IyYD6jLfw/ceXZCJ+aczzC3rJh9ANZqZP
         IbuXEnXT2fuoCeAh/l+AzWj9EMJSc0pHifYn3F26cKyTe/FKDF7fxF0nEfDGPJ5e37dZ
         M4OSm7LkyX1ydAVSj4bUEr48qWfnk0OhQZBFKBuv6HKVpw8/WJC3UvFbnJJ9hH2qZ1F2
         bKrMOO8xICpDov07xvoLh23j6jGvctIf6T7z07eXxqf8CuidlDIv9RSaX/4GCbILTu9i
         yPNFg4mjDh846Q3VtTwz0wyhtIL1xoJIV3k3owhMRaEgD5bqvNm+7zObU6ZVQbGMnv5S
         jK4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=Qupsk1SvP4uPjxCdck7dbvtWJL9P1nZ/WFvQV4WBoGU=;
        b=V4FsJ+78Kf7Ip3FjL5OPELsVp8GSBuKy19cThoTuaGEHLxjIxn8v+F8amcRkQwsxYJ
         LEYq4TsFeisK6x9u3u3SxxJsCT9SSLlUwLWdNLokyVTx3UWk/lMa9YqZw4hRDMxBCUTI
         jcok7QjESVF5hjNqa/IYGqCsi+5FfVulWRyhj8Rn5k7x+qMPI/7wvU5hgo9M0nePX5DD
         OvYgwGMihoIb/Q4rsOIbTFQm5gDF9r0QWhv36xxmfCVWOSm1rA4RANQZQkPmNZFMV2tj
         w+3Vd4BX2rqTjzer5X7dqXugY78hsRd1L9enaHhgzUjV8MFnsI3yRYVxXIdipg+sTpfR
         5baA==
X-Gm-Message-State: AHQUAuaIGkDFGJ0GWWXTEfcmLo2WLhEPObYshPac7vJOZ9M5rgZi5NYh
        U9Mtodjlz+7K5MlmOYj4uAgwiA==
X-Google-Smtp-Source: AHgI3IaPsjcSyqQY0+3ZxpMLEfbf2UCoNDUwJeTMduzvBwNtwvQMqWm75S3M6Ok7ylDpmZE99y+5oA==
X-Received: by 2002:a17:902:6e0f:: with SMTP id u15mr8038993plk.175.1550206538248;
        Thu, 14 Feb 2019 20:55:38 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id o1sm8600106pgn.63.2019.02.14.20.55.34
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 14 Feb 2019 20:55:37 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     robh+dt@kernel.org, mark.rutland@arm.com, linus.walleij@linaro.org,
        bgolaszewski@baylibre.com
Cc:     orsonzhai@gmail.com, zhang.lyra@gmail.com, baolin.wang@linaro.org,
        broonie@kernel.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] gpio: sprd: Change to use SoC compatible string
Date:   Fri, 15 Feb 2019 12:55:19 +0800
Message-Id: <ad2fbe222ad715b3f7e6e093a7f822743e465f9a.1550201284.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
References: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
In-Reply-To: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
References: <3818909a5d6f956ef30ff25cfc42f7550d062086.1550201284.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change to use SoC compatible string instead of wildcard string.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
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

