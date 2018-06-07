Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xwzqEXCcGVuMPgAAmS7hNA
	; Thu, 07 Jun 2018 20:58:54 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C23E1608BA; Thu,  7 Jun 2018 20:58:54 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfyDEhGn"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 430CE606FA;
	Thu,  7 Jun 2018 20:58:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 430CE606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933234AbeFGU6v (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:58:51 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:46472 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932402AbeFGU6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:58:50 -0400
Received: by mail-wr0-f193.google.com with SMTP id v13-v6so11203685wrp.13;
        Thu, 07 Jun 2018 13:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=EVvyk/EgVAyTW5ozsIId45DB7mvNdxPrGNWlVYHHuxA=;
        b=DfyDEhGnXYKyr69D2HiZO5jmXf8c6Rcy7j1ZQGa+YAuYp797S7s/d/5QoS/Z0HPB+6
         a7RXNg9PkmdO1tIW0/OLmrjc+cCQxrOqSbSUjOjNUq8WFv3Sd+pTVxA3Y4AdpyFjhtrU
         sfBJSvByxNLWP8Is7+YtSMkdBa3mTmBFcD5lfQEk1LvTbPa43gTyAZYkI8EjM2yEKSWb
         gCKHX/lxDoJtEuCJ+LT3K6gWGKMlMrY1sX+3oUlnGdLOaWukit7xo0F9BcqD7jzze2eC
         fB/dFWZNweFQpmcAFgqYKvvRT6D3ZK9Vc+MHyG8uI9nGTJjGaiapMBgXintgDhrgjQXZ
         bcXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=EVvyk/EgVAyTW5ozsIId45DB7mvNdxPrGNWlVYHHuxA=;
        b=m+BjWrZZbSFjvd6eYQDEHeWhlSY2Gp+M5MhFDJL2naOvt2Hhyo0F0PfN5IwGQfYPOX
         ubuuAoTKTBG5xOPQdIM2ukLBwTKF8pJubr5IdZru7jFz9hqodDWTeHy1Q/uiwJtldLPA
         0FPRM3WYRiE+ReCgKbPeuU7vn6zaAnHbBFO0414H0YDQAUVHGqMX/XQY1pScbm63r/+N
         CdZG3mGzOGmPNbweF7x7idK5ODgBZPZtfoLbQ1rM9K+qWwpR0Wnr2R/AKilVoLaMPyiv
         wNvj98X2FHHjyi6kokerd2trdfDzHKDFF94M089bKX0Gh/nVWsWLs9wdFNeSqJACVVFu
         VNMA==
X-Gm-Message-State: APt69E0r03PZF/iVh4idOF617cvIMu0jhrWS5Ymdno67ZzdPCFjms9Eq
        6wTW+9SJ8V6mwm8SAyWm8Fg=
X-Google-Smtp-Source: ADUXVKIqkZtwjrr1aORAKcfNNmaPShTBDfa1tfRZu86FkDTofbBaR8lkIZVxUkw4iGV16An6jyXn7w==
X-Received: by 2002:adf:9487:: with SMTP id 7-v6mr2430570wrr.82.1528405128570;
        Thu, 07 Jun 2018 13:58:48 -0700 (PDT)
Received: from localhost.localdomain ([5.144.60.126])
        by smtp.gmail.com with ESMTPSA id w15-v6sm30130899wro.52.2018.06.07.13.58.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:58:47 -0700 (PDT)
From: ilia.lin@gmail.com
To: Ilia Lin <ilia.lin@gmail.com>, Ilia Lin <ilialin@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: kryo: Add module remove and exit
Date: Thu,  7 Jun 2018 20:58:26 +0000
Message-Id: <20180607205827.1588-1-ilia.lin@gmail.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ilia Lin <ilia.lin@gmail.com>

Add device remove and module exit code to make the driver
functioning as a loadable module.

Fixes: ac28927659be (cpufreq: kryo: allow building as a loadable module)
Signed-off-by: Ilia Lin <ilia.lin@gmail.com>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index d049fe4b80c4..a08de0253169 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -71,10 +71,10 @@ static enum _msm8996_version __init qcom_cpufreq_kryo_get_msm_id(void)
 	return version;
 }
 
+struct platform_device *cpufreq_dt_pdev;
 static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
 	struct opp_table *opp_tables[NR_CPUS] = {0};
-	struct platform_device *cpufreq_dt_pdev;
 	enum _msm8996_version msm8996_version;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
@@ -115,6 +115,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
 	nvmem_cell_put(speedbin_nvmem);
+	if (IS_ERR(speedbin))
+		return PTR_ERR(speedbin);
 
 	switch (msm8996_version) {
 	case MSM8996_V3:
@@ -162,8 +164,15 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	return ret;
 }
 
+static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
+{
+	platform_device_unregister(cpufreq_dt_pdev);
+	return 0;
+}
+
 static struct platform_driver qcom_cpufreq_kryo_driver = {
 	.probe = qcom_cpufreq_kryo_probe,
+	.remove = qcom_cpufreq_kryo_remove,
 	.driver = {
 		.name = "qcom-cpufreq-kryo",
 	},
@@ -174,6 +183,7 @@ static const struct of_device_id qcom_cpufreq_kryo_match_list[] __initconst = {
 	{ .compatible = "qcom,msm8996", },
 };
 
+struct platform_device *kryo_cpufreq_pdev;
 /*
  * Since the driver depends on smem and nvmem drivers, which may
  * return EPROBE_DEFER, all the real activity is done in the probe,
@@ -198,8 +208,9 @@ static int __init qcom_cpufreq_kryo_init(void)
 	if (unlikely(ret < 0))
 		return ret;
 
-	ret = PTR_ERR_OR_ZERO(platform_device_register_simple(
-		"qcom-cpufreq-kryo", -1, NULL, 0));
+	kryo_cpufreq_pdev = platform_device_register_simple(
+		"qcom-cpufreq-kryo", -1, NULL, 0);
+	ret = PTR_ERR_OR_ZERO(kryo_cpufreq_pdev);
 	if (0 == ret)
 		return 0;
 
@@ -208,5 +219,12 @@ static int __init qcom_cpufreq_kryo_init(void)
 }
 module_init(qcom_cpufreq_kryo_init);
 
+static void __init qcom_cpufreq_kryo_exit(void)
+{
+	platform_device_unregister(kryo_cpufreq_pdev);
+	platform_driver_unregister(&qcom_cpufreq_kryo_driver);
+}
+module_exit(qcom_cpufreq_kryo_exit);
+
 MODULE_DESCRIPTION("Qualcomm Technologies, Inc. Kryo CPUfreq driver");
 MODULE_LICENSE("GPL v2");
-- 
2.11.0
