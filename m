Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C70ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B84E52146E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 10:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IdFwpuGD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B84E52146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730652AbeGQKor (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 06:44:47 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33565 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729703AbeGQKor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 06:44:47 -0400
Received: by mail-pf0-f193.google.com with SMTP id b17-v6so291194pfi.0;
        Tue, 17 Jul 2018 03:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6v7xIcQtev6PS5EdUYoy4t3aEJvp+7bKhBuKy52r3wQ=;
        b=IdFwpuGDd57ZEnUjVtBKYmhX5PfEtkt9DrxENoHk6wxl8WJS+aO4P8MUz+cU2QIku0
         bQ/Tv29sScMbpGNlp3H7Agy2s45xOC9AzmcFx2hMhKAp1vBSxiBdq0jEFdM+d+lEmx+F
         CDFd7L+LISJGHnRGBhSWxF1b7af/As6D+kjoOIMsBvtAemUXZ6HrxGD0ab0DAwlif4Hw
         1wypjNCZe3CysIYmxdDHQIAy+ZM+HLUM9FZ7zE16LN0ImWJsTeETC0QYk2MMUNqtn3l/
         B8mUirdAPlkPBhaBTILEdihRblSl6I31030gn5BLFfM9/8Y9sZiyGjANWE3EpQaaxTOf
         L6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6v7xIcQtev6PS5EdUYoy4t3aEJvp+7bKhBuKy52r3wQ=;
        b=I2k8sqJ2ogBUdMD+TKlz7cdcCX6kX9/xvVikEBbG+gL16+A3deFFWQPScPFt2Nd+aP
         gkfw7DrSFy7q/s6XzVJ6IGv3aQWVph9/tRhWH41zM3YO0YcvN7d3vAx+bTcmewjMSdoP
         qWYhczukZIM0RQv92ZpQ7wMwX2GAa0XhS1jAVQCPn23sLCmPffz9G08xLPYuhxmRnOhU
         mf5+0NRdwtJlHd9V++Y9XNzwK659E2kCCRinMhF8d/KHIKUneT+bglbAMOmcyO4zgn5X
         bGiTxQEeauTQ2M7/qKUuZhh7+k1Yxi7ujaJLrU+HHx4BT0as66Anro84FSEgQxkfsze/
         WhXQ==
X-Gm-Message-State: AOUpUlHjLyoNq4Ub6x125luxV47vU9DO8TSc+lcxXZ45odFNmE128Fnd
        tH7Ys6ET41kZ9mdL5HBYcjA=
X-Google-Smtp-Source: AAOMgpeZ2ZNZB7gnq5VLJRpv2AIolGzhEmx9dNrPiiRTvj+8guhkMOZMHGbaRoMFB02ADt9piJdO8Q==
X-Received: by 2002:a63:1403:: with SMTP id u3-v6mr982494pgl.13.1531822375048;
        Tue, 17 Jul 2018 03:12:55 -0700 (PDT)
Received: from localhost.localdomain ([103.51.74.210])
        by smtp.gmail.com with ESMTPSA id 203-v6sm2809963pgb.14.2018.07.17.03.12.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 17 Jul 2018 03:12:54 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH 1/5] thermal: exynos: enable core tmu clk on exynos platform
Date:   Tue, 17 Jul 2018 10:12:18 +0000
Message-Id: <1531822342-4293-1-git-send-email-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clk_summary do not show tmu_apbif clk enable, so replace
the clk_prepare with clk_prepare_enables to enable tmu clk.
simplify the enable of tmu_triminfo_apbif clk, also fixed
the order of goto error for failed cases.

CC: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
before:
cat /sys/kernel/debug/clk/clk_summary | grep tmu
                         tmu_gpu           0            2    66600000          0 0
                         tmu              0            6    66600000          0 0
after:
cat /sys/kernel/debug/clk/clk_summary | grep tmu
                         tmu_gpu       2        2        0    66600000          0 0
                         tmu          6        6        0    66600000          0 0
---
 drivers/thermal/samsung/exynos_tmu.c | 45 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
index a992e51..0164c9e 100644
--- a/drivers/thermal/samsung/exynos_tmu.c
+++ b/drivers/thermal/samsung/exynos_tmu.c
@@ -1060,41 +1060,40 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Failed to get clock\n");
 		ret = PTR_ERR(data->clk);
 		goto err_sensor;
-	}
-
-	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
-	if (IS_ERR(data->clk_sec)) {
-		if (data->soc == SOC_ARCH_EXYNOS5420_TRIMINFO) {
-			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
-			ret = PTR_ERR(data->clk_sec);
-			goto err_sensor;
-		}
 	} else {
-		ret = clk_prepare(data->clk_sec);
+		ret = clk_prepare_enable(data->clk);
 		if (ret) {
 			dev_err(&pdev->dev, "Failed to get clock\n");
 			goto err_sensor;
 		}
 	}
 
-	ret = clk_prepare(data->clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Failed to get clock\n");
-		goto err_clk_sec;
-	}
-
 	switch (data->soc) {
+	case SOC_ARCH_EXYNOS5420_TRIMINFO:
+		data->clk_sec = devm_clk_get(&pdev->dev, "tmu_triminfo_apbif");
+		if (IS_ERR(data->clk_sec)) {
+			dev_err(&pdev->dev, "Failed to get triminfo clock\n");
+			ret = PTR_ERR(data->clk_sec);
+			goto err_clk;
+		} else {
+			ret = clk_prepare_enable(data->clk_sec);
+			if (ret) {
+				dev_err(&pdev->dev, "Failed to get clock\n");
+				goto err_clk;
+			}
+		}
+		break;
 	case SOC_ARCH_EXYNOS5433:
 	case SOC_ARCH_EXYNOS7:
 		data->sclk = devm_clk_get(&pdev->dev, "tmu_sclk");
 		if (IS_ERR(data->sclk)) {
 			dev_err(&pdev->dev, "Failed to get sclk\n");
-			goto err_clk;
+			goto err_clk_sec;
 		} else {
 			ret = clk_prepare_enable(data->sclk);
 			if (ret) {
 				dev_err(&pdev->dev, "Failed to enable sclk\n");
-				goto err_clk;
+				goto err_clk_sec;
 			}
 		}
 		break;
@@ -1134,11 +1133,11 @@ static int exynos_tmu_probe(struct platform_device *pdev)
 	thermal_zone_of_sensor_unregister(&pdev->dev, data->tzd);
 err_sclk:
 	clk_disable_unprepare(data->sclk);
-err_clk:
-	clk_unprepare(data->clk);
 err_clk_sec:
 	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+		clk_disable_unprepare(data->clk_sec);
+err_clk:
+	clk_disable_unprepare(data->clk);
 err_sensor:
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
@@ -1155,9 +1154,9 @@ static int exynos_tmu_remove(struct platform_device *pdev)
 	exynos_tmu_control(pdev, false);
 
 	clk_disable_unprepare(data->sclk);
-	clk_unprepare(data->clk);
+	clk_disable_unprepare(data->clk);
 	if (!IS_ERR(data->clk_sec))
-		clk_unprepare(data->clk_sec);
+		clk_disable_unprepare(data->clk_sec);
 
 	if (!IS_ERR(data->regulator))
 		regulator_disable(data->regulator);
-- 
2.7.4

