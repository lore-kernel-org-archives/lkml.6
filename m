Return-Path: <SRS0=0E8K=OK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CEF1C64EB4
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E80BD21479
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Dec 2018 15:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="St0vJBFM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80BD21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbeLBDGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Dec 2018 22:06:17 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37945 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727379AbeLBDGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Dec 2018 22:06:17 -0500
Received: by mail-lj1-f193.google.com with SMTP id c19-v6so7638158lja.5
        for <linux-kernel@vger.kernel.org>; Sat, 01 Dec 2018 07:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ruvG321c2erSKd4WYuxWeHCQ5T1dUamVjuDaYGBmTnk=;
        b=St0vJBFMo1PEOsZeu5nQ1jcY2njdXe6Z9sgqA8e0yP5b9MZIoE8amrZwNPJfR02BZ0
         33PhtotojcF3qCbbj8J4oyxDYszcJP2IeY6RjxkIh+NmY/Ko0yThJ2HSpiBL+JwI4Xe5
         8XHZWoG5y60Hma2lanMhUPrr3PDd4JBWbPbSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ruvG321c2erSKd4WYuxWeHCQ5T1dUamVjuDaYGBmTnk=;
        b=nXRxEGOyj4/cLk0KBzwb46ROYC1RwNAS/PZoUNY0VLPbTJ2s/lBonRZpRhomHOpUch
         LTZyuY78T/o9lwhpXwQmkaHpjKIaedHyhNE+72JJ4c+Pw1/m2/cRUpTvC9pXAwU9szUn
         wYIRyh4RZLXLcCwrLN5gxXjHozRIBPpRPnJz3aAO8IsQVoEfL6QQsrOCYvRddiB24OtM
         io4AlWj1L/bnLXpeij4nnuApbY6W1+57J9nfiU/yvS1WpOJJfCtU5DVptmrP7UnN7BnN
         ncb8MG9U7t8yKcXue1qC8U69WS/CrxldquJUKQXxXAeJhVrnN9pG9tQzvAjSjcjvBjcB
         g+yw==
X-Gm-Message-State: AA+aEWbBxlaHppPcGlWr452ebPgFvJXc8USrFWAT4yPmUnXSmUrs0inl
        1HrPAlD6ogF55CauIePwAqX38A==
X-Google-Smtp-Source: AFSGD/Ub9uDR2lO8FAGV2RO3FGinCpDK9rpfdIkqLb+1xouj+w06Q6pZ7PLoQ53iFX6VfmHgtpeESA==
X-Received: by 2002:a2e:5b1d:: with SMTP id p29-v6mr6224863ljb.176.1543679606971;
        Sat, 01 Dec 2018 07:53:26 -0800 (PST)
Received: from localhost.localdomain (c-ae7b71d5.014-348-6c756e10.bbcust.telenor.se. [213.113.123.174])
        by smtp.gmail.com with ESMTPSA id 13-v6sm1365426ljj.49.2018.12.01.07.53.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 01 Dec 2018 07:53:26 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 12/13 v2] regulator: tps65090: Hand over GPIO to regulator core
Date:   Sat,  1 Dec 2018 16:41:50 +0100
Message-Id: <20181201154151.14890-13-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181201154151.14890-1-linus.walleij@linaro.org>
References: <20181201154151.14890-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The GPIO descriptors used by the TPS65090 driver are retrieved
during probe() and it is really helpful to have those under
devres management because of all the errorpaths in the
intialization.

Using the new dev_gpiod_unhinge() call we can remove the
devres management of the descriptor right before handing
it over to the regulators core.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- New patch handling this drivers GPIO descriptors properly.
---
 drivers/regulator/tps65090-regulator.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/regulator/tps65090-regulator.c b/drivers/regulator/tps65090-regulator.c
index db714d5edafc..0614551796a1 100644
--- a/drivers/regulator/tps65090-regulator.c
+++ b/drivers/regulator/tps65090-regulator.c
@@ -480,6 +480,12 @@ static int tps65090_regulator_probe(struct platform_device *pdev)
 		else
 			config.of_node = NULL;
 
+		/*
+		 * Hand the GPIO descriptor management over to the regulator
+		 * core, remove it from devres management.
+		 */
+		if (config.ena_gpiod)
+			devm_gpiod_unhinge(&pdev->dev, config.ena_gpiod);
 		rdev = devm_regulator_register(&pdev->dev, ri->desc, &config);
 		if (IS_ERR(rdev)) {
 			dev_err(&pdev->dev, "failed to register regulator %s\n",
-- 
2.19.1

