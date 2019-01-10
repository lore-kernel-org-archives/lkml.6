Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE092C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A942177E
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 20:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Htf7k0Ex"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730749AbfAJUxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 15:53:21 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45413 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730669AbfAJUxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 15:53:19 -0500
Received: by mail-lf1-f65.google.com with SMTP id b20so9258368lfa.12;
        Thu, 10 Jan 2019 12:53:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pV8kbDyRB/8qZ90lJTc0lEk+FaV2Ra/kqeVF/E8Hnfk=;
        b=Htf7k0ExehzCaF3zhHh1dRJbDHstaIkx5+nKHbbc/ILqAjuqaUwe3koIB3cNj44gz2
         ZwF0a1qw6466nImj6AWCNYVaJdU0eXFGt6hVW2tW/n6Db5HoOaqLFVTWnulK4rMHo6Q8
         saKPC9Pv/qlO+joFcR3ASl0LCqDVgoAWDWRhxz8JScyXXxDt5zQbW4LkHBbKBTfSRfam
         S2rH4mnhsuT5xDuyvYWeSvpj2VL23FZunTRa6t18CsuqH2gu/7q/Igb53u9n5Cqmrj0Y
         EP5sYVhOQ2c1w4Gwji6GfVl/y+MJwSuyCwubB7fzG44E5g3khbFVV9PhOr6Ab/gnxmvU
         aybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pV8kbDyRB/8qZ90lJTc0lEk+FaV2Ra/kqeVF/E8Hnfk=;
        b=l+AWFj54GPo6xRdkIzUU3k+r+vouYTCGtjUZiCbUFPoOxt3Wy1eIGvpJp2x1l/AXck
         8vyn3upj6Uz5gWeIo0uQMGITSvWL4PGiu8YOZ4SC3BVziOPUgZBxlEVtqMsp8UGBjTtK
         ENMXiD66LoPjsAGf9aEtE8bPNS8eWgmVcjdm5ztODlDh70ABoAF3HuLVLWOz+Rth4MB+
         TewHNNuvDrUG/Ehq0VKerPw+hZUrp7fgzkfN4rxSeVWKDxYXhcMhjLSl6nyGAQRwDdLg
         jephbvQyl1AydAtcKmO0IECua10SW7xfVRrpnw2cC0ANQkMTlugNcY/ADkAOdptUzfms
         4P7Q==
X-Gm-Message-State: AJcUukfUxjUQkYJ9Jl0orXe52h6inVrGbhbQ+qVTsCswxRLeKAxFSOEr
        DLQotzdWTZc4tCsRHgENOW0=
X-Google-Smtp-Source: ALg8bN5+qL67TTptupCRMWOWMH6hxida6ZissbV6ggdz+24+VlshN7ushnka9oUaZ9ltQc93hn1ACg==
X-Received: by 2002:a19:d5:: with SMTP id 204mr6311233lfa.116.1547153596596;
        Thu, 10 Jan 2019 12:53:16 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:5dc1:592c:c674:2869])
        by smtp.googlemail.com with ESMTPSA id z7-v6sm15389690lji.42.2019.01.10.12.53.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jan 2019 12:53:16 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v2 3/4] cpufreq: s5pv210: Defer probe if getting regulators fail
Date:   Thu, 10 Jan 2019 21:52:14 +0100
Message-Id: <20190110205215.22030-4-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
References: <20190110205215.22030-1-pawel.mikolaj.chmiel@gmail.com>
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
Changes from v1:
  - Fix compilation error
  - Reorganize code so it's smaller
---
 drivers/cpufreq/s5pv210-cpufreq.c | 32 ++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index f51697f1e0b3..6df95941ba96 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -594,6 +594,25 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
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
+		regulator_put(arm_regulator);
+		return PTR_ERR(int_regulator);
+	}
+
 	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
 	if (!np) {
 		pr_err("%s: failed to find clock controller DT node\n",
@@ -633,19 +652,6 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
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

