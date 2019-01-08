Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772E9C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46CDA20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UKAEwXL9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733013AbfAHUFe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 15:05:34 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42297 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732418AbfAHUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 15:05:29 -0500
Received: by mail-lf1-f68.google.com with SMTP id l10so3870571lfh.9;
        Tue, 08 Jan 2019 12:05:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nLRztxJAeC5B0+rbtnhFFtucRRJLwQz+ndZxADHnDTU=;
        b=UKAEwXL9hYyXEhhP0NaziiUWYqtM6BZnjtuY+YV4w3EzYgVDCGF3EV88PHcZqc+mdj
         kC1+FienrQZD3XyfAczMzbeAcbTJxyBsWlvBk4Vbve7llKXm/9t+zIy4BQi1m622tmCm
         25pwUNv1EFNO00GYU9IPFFQrPrcnBrZal6T0s2Rg/iUuKCX29JhDRvBrqLzBfDrKXVoo
         h81FLSoQEcCFH13fIo5ttsZ/7y8cob+nd8JLbaOQ8XGsiLmK04Y0Jd1HRIhlgtY9S2wl
         C26jgTV29SW98g1h2mBR9enBj0IY/cgyQgj7cU1frTbBatiPf9hZtfnXezqThHppiczR
         0yYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nLRztxJAeC5B0+rbtnhFFtucRRJLwQz+ndZxADHnDTU=;
        b=WsU3x7FCjVx8jLeZR2J4LrBF2Q1GQSAbyph+SCkR/S3olCcAZZFMDVMJeDb8NZnFFL
         NpHPbgRhTQTU54hgqR++vZ/n3oYpi4ShY8qDylRngPjPEZfHpBxden2rfJ2iXQUwqfSA
         aDV/oSPYnPXONEGyUelYSfosp9gn2XArWOjk7FFvZb9WbdoJU3YUaGfQ5y5oKmn7Xzqf
         o2t7+g/qHGJkVNgkRSFaUO7xcX6llZj4XBmPjbCjnSCu8vclwB4QsmrANvZk18/e3hKK
         N6YHG76gR+7fWTAHEK0nPWLcuMbqIAK62JgDLGGBkanEMxrcaUk9Rzp3hQnnL8dMtMmf
         Jq4A==
X-Gm-Message-State: AJcUukcKUuK0yEDTXmn/6C/lfKMQ2Tpopie+8M5K34QGPOEwHgk7reAj
        WvhAjDFNzTAbVJ/q7PaZoFnlMQ1vxwl/3g==
X-Google-Smtp-Source: ALg8bN4IdbHawsPUgv2UefkEeNdV4W9bb30hNxa2Lb9Non7jT4OuwfzlsfKBZFvMSSdHmRw4GLI39g==
X-Received: by 2002:a19:4ed9:: with SMTP id u86mr1752659lfk.78.1546977926750;
        Tue, 08 Jan 2019 12:05:26 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:d033:e708:8ec7:810d])
        by smtp.googlemail.com with ESMTPSA id y23-v6sm14486768ljk.95.2019.01.08.12.05.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 12:05:26 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH 3/4] cpufreq: s5pv210: Defer probe if getting regulators fail
Date:   Tue,  8 Jan 2019 21:05:08 +0100
Message-Id: <20190108200509.30494-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190108200509.30494-1-pawel.mikolaj.chmiel@gmail.com>
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
 drivers/cpufreq/s5pv210-cpufreq.c | 33 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index f51697f1e0b3..2d0e4dc7ede7 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -594,6 +594,26 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	 * this whole driver as soon as S5PV210 gets migrated to use
 	 * cpufreq-dt driver.
 	 */
+	arm_regulator = regulator_get(NULL, "vddarm");
+	if (PTR_ERR(arm_regulator) == -EPROBE_DEFER) {
+		pr_dbg("vddarm regulator not ready, defer\n");
+		return -EPROBE_DEFER;
+	} else if (IS_ERR(arm_regulator)) {
+		pr_err("failed to get regulator vddarm\n");
+		return PTR_ERR(arm_regulator);
+	}
+
+	int_regulator = regulator_get(NULL, "vddint");
+	if (PTR_ERR(int_regulator == -EPROBE_DEFER) {
+		regulator_put(arm_regulator);
+		pr_dbg("vddint regulator not ready, defer\n");
+		return -EPROBE_DEFER;
+	} else if (IS_ERR(int_regulator)) {
+		regulator_put(arm_regulator);
+		pr_err("failed to get regulator vddint\n");
+		return PTR_ERR(int_regulator);
+	}
+
 	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
 	if (!np) {
 		pr_err("%s: failed to find clock controller DT node\n",
@@ -633,19 +653,6 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
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
-- 
2.17.1

