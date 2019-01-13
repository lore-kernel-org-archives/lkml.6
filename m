Return-Path: <SRS0=GEt/=PV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2165C43387
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:58:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E85F20850
	for <linux-kernel@archiver.kernel.org>; Sun, 13 Jan 2019 19:58:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/Roh39Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbfAMT6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 13 Jan 2019 14:58:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:45346 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfAMT6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jan 2019 14:58:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id b20so14138856lfa.12;
        Sun, 13 Jan 2019 11:57:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFXW5esP1qyBjm7dno9fSDhMNRBkGYcMnaFJwnRT22g=;
        b=i/Roh39YbMiqa1az+3XQH5GBrXp8Vqh+6ewCUAWo+UHSjvXIi2yUlFXdY9YNBgWYhW
         eiO6mYgkvpswKpd9Gs1Jai4VLsX51zNLqRmvjIADXxyvL8I6zOthzjau2g8iX86J7bl2
         0jsQeWHc4dnHpBq6xVcr3UI0MVLLhgblbUH9MnMOoG3fc5QhViIEQUKvJER/HWZMSu+Y
         LEfzd6/F4V6SUxAzQ05bZxIjsS0LCazZRBEY20WnqBPOKToEc627sIhugXLm2J3BjmWl
         8PnAwa821urEs0K/XNVGtQCb5H2L2QjyewheFgHgDQWdyBX7JQ2UgqZ1/IqGDf9DY1Ay
         FHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bFXW5esP1qyBjm7dno9fSDhMNRBkGYcMnaFJwnRT22g=;
        b=YOFGbwfJPqNaxKaM/ZJI/jzCTD64rdgt+9QAbip+v6mclgzfkm3OktGVpVW6plT8S7
         tWZSi3lNA1cRrDE1fSu2dLBgQs8dm8AajH2vrBlKTQC3Pnvg11ATYW9Whvy9aN115Mc3
         GoM9THbx/Te63ES0XfZBiFY3tKQh8LdWbtEj85DtSgm+wl8nAxKO3kXzClJa7XWbyRR6
         Jp0c+4wKw3M2JImOdH8L3Qp4mMxXAprWVmb04MDaQnpwvJueDCAvIdVABidiUGjoCzJA
         NKviA9ZUEPbA3Eb05OoUSOennsylA3Tqf2ZlyU0yfmKjsEq8tkqs/7FXQsbUBkOnTF8K
         34yA==
X-Gm-Message-State: AJcUukcJnct7pbBt6FsP3oi/MO+9xx2PBDs9wSTqIFcgn4KPv4wzkdNc
        pQPEG1zHD95h50+XBOZFEE8=
X-Google-Smtp-Source: ALg8bN5U+PN5/aIg1CEXUH+saRACDLlkJv34dKzI8/1IPsGyTPGNSXjpdKtSpHna2biSnNDjNe/sJw==
X-Received: by 2002:a19:7d42:: with SMTP id y63mr11329886lfc.47.1547409478957;
        Sun, 13 Jan 2019 11:57:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:607a:1b80:a32f:5413])
        by smtp.googlemail.com with ESMTPSA id q67sm15988569lfe.19.2019.01.13.11.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Jan 2019 11:57:58 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v4] cpufreq: s5pv210: Defer probe if getting regulators fail
Date:   Sun, 13 Jan 2019 20:57:54 +0100
Message-Id: <20190113195754.30525-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is possibility, that when probing driver, regulators are not yet
initialized. In this case we should return EPROBE_DEFER and wait till
they're initialized, since they're required currently for cpufreq driver
to work. Also move regulator initialization code at beginning of probe,
so we can defer as fast as posibble.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v3:
  - Zero dmc_base pointers after unmapping them
  - If getting vddarm regulator fails just return, no need to do goto
    jump which would do the same

Changes from v2:
  - Handle all error paths in probe

Changes from v1:
  - Fix compilation error
  - Reorganize code so it's smaller
---
 drivers/cpufreq/s5pv210-cpufreq.c | 67 ++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index f51697f1e0b3..c7b7d1e65b08 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -584,7 +584,7 @@ static struct notifier_block s5pv210_cpufreq_reboot_notifier = {
 static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
-	int id;
+	int id, result = 0;
 
 	/*
 	 * HACK: This is a temporary workaround to get access to clock
@@ -594,18 +594,39 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	 * this whole driver as soon as S5PV210 gets migrated to use
 	 * cpufreq-dt driver.
 	 */
+	arm_regulator = regulator_get(NULL, "vddarm");
+	if (IS_ERR(arm_regulator)) {
+		if (PTR_ERR(arm_regulator) == -EPROBE_DEFER)
+			pr_debug("vddarm regulator not ready, defer\n");
+		else
+			pr_err("failed to get regulator vddarm\n");
+		return PTR_ERR(arm_regulator);
+	}
+
+	int_regulator = regulator_get(NULL, "vddint");
+	if (IS_ERR(int_regulator)) {
+		if (PTR_ERR(int_regulator) == -EPROBE_DEFER)
+			pr_debug("vddint regulator not ready, defer\n");
+		else
+			pr_err("failed to get regulator vddint\n");
+		result = PTR_ERR(int_regulator);
+		goto err_int_regulator;
+	}
+
 	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
 	if (!np) {
 		pr_err("%s: failed to find clock controller DT node\n",
 			__func__);
-		return -ENODEV;
+		result = -ENODEV;
+		goto err_clock;
 	}
 
 	clk_base = of_iomap(np, 0);
 	of_node_put(np);
 	if (!clk_base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		return -EFAULT;
+		result = -EFAULT;
+		goto err_clock;
 	}
 
 	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
@@ -614,7 +635,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
 				__func__, np);
 			of_node_put(np);
-			return id;
+			result = id;
+			goto err_clk_base;
 		}
 
 		dmc_base[id] = of_iomap(np, 0);
@@ -622,33 +644,40 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 			pr_err("%s: failed to map dmc%d registers\n",
 				__func__, id);
 			of_node_put(np);
-			return -EFAULT;
+			result = -EFAULT;
+			goto err_dmc;
 		}
 	}
 
 	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id) {
 		if (!dmc_base[id]) {
 			pr_err("%s: failed to find dmc%d node\n", __func__, id);
-			return -ENODEV;
+			result = -ENODEV;
+			goto err_dmc;
 		}
 	}
 
-	arm_regulator = regulator_get(NULL, "vddarm");
-	if (IS_ERR(arm_regulator)) {
-		pr_err("failed to get regulator vddarm\n");
-		return PTR_ERR(arm_regulator);
-	}
-
-	int_regulator = regulator_get(NULL, "vddint");
-	if (IS_ERR(int_regulator)) {
-		pr_err("failed to get regulator vddint\n");
-		regulator_put(arm_regulator);
-		return PTR_ERR(int_regulator);
-	}
-
 	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
 
 	return cpufreq_register_driver(&s5pv210_driver);
+
+err_dmc:
+	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id)
+		if (dmc_base[id]) {
+			iounmap(dmc_base[id]);
+			dmc_base[id] = NULL;
+		}
+
+err_clk_base:
+	iounmap(clk_base);
+
+err_clock:
+	regulator_put(int_regulator);
+
+err_int_regulator:
+	regulator_put(arm_regulator);
+
+	return result;
 }
 
 static struct platform_driver s5pv210_cpufreq_platdrv = {
-- 
2.17.1

