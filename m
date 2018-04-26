Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeDZC7u (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 22:59:50 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:35001 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752129AbeDZC7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 22:59:44 -0400
X-Google-Smtp-Source: AB8JxZryxjQU9D6DHMI31A9PvmcR6d+vPxf07WJNy5T5tM2W3Tnr5U7Y0vVuLL15Y87CuMV7LdD1Wg==
From: Baolin Wang <baolin.wang@linaro.org>
To: a.zummo@towertech.it, alexandre.belloni@bootlin.com
Cc: baolin.wang@linaro.org, broonie@kernel.org, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rtc: sprd: Add RTC hardware range
Date: Thu, 26 Apr 2018 10:58:45 +0800
Message-Id: <e8ad73f71c8976658ce7e9d6eb8b228349fb3116.1524710929.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
References: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
In-Reply-To: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
References: <95b85b6d0369b4693e9d4e57af5eac49eee87dc9.1524710929.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SC27xx RTC can support dates from 1970-01-01 00:00:00 to 2149-06-06
23:59:59.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/rtc/rtc-sc27xx.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-sc27xx.c b/drivers/rtc/rtc-sc27xx.c
index ac86322..6a3876e 100644
--- a/drivers/rtc/rtc-sc27xx.c
+++ b/drivers/rtc/rtc-sc27xx.c
@@ -631,6 +631,8 @@ static int sprd_rtc_probe(struct platform_device *pdev)
 	}
 
 	rtc->rtc->ops = &sprd_rtc_ops;
+	rtc->rtc->range_min = 0;
+	rtc->rtc->range_max = 5662310399LL;
 	ret = rtc_register_device(rtc->rtc);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register rtc device\n");
-- 
1.7.9.5
