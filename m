Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7837DC4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4405F2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 10:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DoIancko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbfB0KEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 05:04:48 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:35609 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726652AbfB0KEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 05:04:47 -0500
Received: by mail-pl1-f195.google.com with SMTP id p19so7785687plo.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 02:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zg0+GNn7Z6P9rpnhFL7IPuLh6JHfTMBGrvRxKokx2eg=;
        b=DoIanckoA0erRA0PrlnqWrq/AlZ2MR2T5dT4KJ1uwAxKjqAMMvCAyXZgqOa39Q8+Ku
         wvLF37wKlTMWykM2z8Mdizume3X79EjM7DYWseNCBbAQ7BsS4TANbBOP+QuQyl5D780R
         x1HWQlaa5kYCfd0PtTumQPUZR25ew2mWxJzfXIggKYBe+pxVIrsdZVHsVbfJS6hNR7kg
         KwCiH8y8ftEsxYCtv6OmgAm5BnERmJKSRLkCpdvAOI9DejMKEflD6pHCAupWfxfFR55A
         /ijfJbTbv79fGyZz9RoX4BDkqhB12vmRtCo4KUrydywmEHjkkjxOMggKpPLHkzqo0P6y
         NpPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Zg0+GNn7Z6P9rpnhFL7IPuLh6JHfTMBGrvRxKokx2eg=;
        b=UfbvfW8m1zRBZKMKHtJkkAkRabP/JebXbXHKcIEIBrFEEV7ZYkD4HQSsRr8Hoxsw8B
         +4JVqlunObyVGCrHY995JP7NQhC/tkh94r5ZOWdRlTEE10Tj7LgwQy3m1Ob+pk6FmwVN
         WipLvh9wsk6CdfJO5/MOyr7MJschmsFISf40/zOFXrX6/Rrz4FU0WVaIz7z/aqBCFzNj
         SFww6jm3/JDOiCOHYGZ/z0ftC7aTUkNdy6K2UFGrkWDWEe1t8Y34QVdS9wX6yTpDgAlw
         +iWrszRq3LGy1ev/QAPicM2eto+qjw8Q5XTLyc8WOr8vWiCWY37ADaDCBkPTPOsye/T9
         NB4w==
X-Gm-Message-State: AHQUAuZAeC5dKjGukh77ic1/bFK65OcqLT15NgvUjDkq8NOo2q8uIsPL
        x084z9cE8Ksu8znw4V/uXil2oQ==
X-Google-Smtp-Source: AHgI3IaUArMmcXyIfHpin3HkAYvncnr9y/5I5YYKQADUQgTBOif1B4Pni2WF/b2Uhvw54WvJAS2Fjg==
X-Received: by 2002:a17:902:8690:: with SMTP id g16mr1285258plo.284.1551261886367;
        Wed, 27 Feb 2019 02:04:46 -0800 (PST)
Received: from localhost ([122.167.168.92])
        by smtp.gmail.com with ESMTPSA id v4sm12051216pff.181.2019.02.27.02.04.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 02:04:45 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, amit.kucheria@linaro.org,
        "4 . 18+" <stable@vger.kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2] cpufreq: kyro: Release OPP tables on module removal
Date:   Wed, 27 Feb 2019 15:34:27 +0530
Message-Id: <78f96969448b17e95b0b21cb78194bb9f709a897.1551261748.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit") made
it possible to build the kyro cpufreq driver as a module, but it failed
to release all the resources, i.e. OPP tables, when the module is
unloaded.

This patch fixes it by releasing the OPP tables, by calling
dev_pm_opp_put_supported_hw() for them, from the
qcom_cpufreq_kryo_remove() routine. The array of pointers to the OPP
tables is also allocated dynamically now in qcom_cpufreq_kryo_probe(),
as the pointers will be required while releasing the resources.

Compile tested only.

Cc: 4.18+ <stable@vger.kernel.org> # v4.18+
Fixes: 5ad7346b4ae2 ("cpufreq: kryo: Add module remove and exit")
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
V1->V2:
- The previous version targeted a compile time issue of frame size but
  this fixes a bug in the driver and needs to get applied to 4.18+
  kernels.
- This may go in 5.0 release.
- Haven't included any Reviewed-by tags as there were many changes in
  this version.

 drivers/cpufreq/qcom-cpufreq-kryo.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 2a3675c24032..65edbfd4d4a5 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 
 static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
-	struct opp_table *opp_tables[NR_CPUS] = {0};
+	struct opp_table **opp_tables;
 	enum _msm8996_version msm8996_version;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
@@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	}
 	kfree(speedbin);
 
+	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
+	if (!opp_tables)
+		return -ENOMEM;
+
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (NULL == cpu_dev) {
@@ -151,8 +155,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
 							  NULL, 0);
-	if (!IS_ERR(cpufreq_dt_pdev))
+	if (!IS_ERR(cpufreq_dt_pdev)) {
+		platform_set_drvdata(pdev, opp_tables);
 		return 0;
+	}
 
 	ret = PTR_ERR(cpufreq_dt_pdev);
 	dev_err(cpu_dev, "Failed to register platform device\n");
@@ -163,13 +169,23 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 			break;
 		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
 	}
+	kfree(opp_tables);
 
 	return ret;
 }
 
 static int qcom_cpufreq_kryo_remove(struct platform_device *pdev)
 {
+	struct opp_table **opp_tables = platform_get_drvdata(pdev);
+	unsigned cpu;
+
 	platform_device_unregister(cpufreq_dt_pdev);
+
+	for_each_possible_cpu(cpu)
+		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
+
+	kfree(opp_tables);
+
 	return 0;
 }
 
-- 
2.21.0.rc0.269.g1a574e7a288b

