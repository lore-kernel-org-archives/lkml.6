Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFBDC46469
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 007C920880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 08:30:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BnFj8fwJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007C920880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbeILNdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 09:33:38 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41589 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728122AbeILNdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 09:33:36 -0400
Received: by mail-pf1-f193.google.com with SMTP id h79-v6so643333pfk.8
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6pZdqzyNFzV9hoYXx9iwC3ap2vB1NU1hBlJF3aGozkE=;
        b=BnFj8fwJnhndXq1Pp4qGfFt1Rh5us1B1XFwLDGN6iRpdghqXxBb4SEtSEulWyWZi74
         Uv7rCQrAqz6+ogMqmFwQShCcuIdOTJS9Jbm+QVqp62D8lgw4CLZ1sMC8gZQAM/RZvCdG
         c7sD4CSSgHMJxZz4yS9aDQgyVkPPiO1+Mo5JU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6pZdqzyNFzV9hoYXx9iwC3ap2vB1NU1hBlJF3aGozkE=;
        b=glTGQEriDgNHdDIEQkOgb0L7w+y9sTyYcldwbZSY6gKZ+qrfEQ1r+3LdC0okaECDAM
         Zo6gdVm7D3kA7T1bZ/dbyCaHQqq+tJGQ1BAQ2Wf857NYbzl2F6ZZO6635B4c9lPnlXUT
         +wCqgqQdRk3LEOL5sbiF8QF506RoONHYKBE4Z/3/8jZdHdWttCS9Qdqoo57PsiIQhoNI
         9DucAs7T2uEwkqtszG/NJnSt7owrd0ze7Vi6cdWMabT26GAxMcaTGd1K3cGxyz+nO1WJ
         OksyGECs5dsV2PpKd04fAhMEE5+7cRkq31SdiLBCutE3XeqYEjsvWaOzMZKNzPDkIzhA
         pH2g==
X-Gm-Message-State: APzg51DwxiTygIV0uw20RezBIS74ALxvYZHodY2as2M13dryErM6+hWZ
        kg2HF3LZtTEfZNhoMYLNRblDyg==
X-Google-Smtp-Source: ANB0VdY0ib/62jVG2gz+hs6NFsmjxcJiGyqXdsFTiw6b3Mqp3bqtoaczwNPj8V/E/jrKzB+iLI0fzw==
X-Received: by 2002:a63:e949:: with SMTP id q9-v6mr914185pgj.4.1536741008837;
        Wed, 12 Sep 2018 01:30:08 -0700 (PDT)
Received: from localhost ([122.171.64.45])
        by smtp.gmail.com with ESMTPSA id w69-v6sm686923pgd.37.2018.09.12.01.30.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 01:30:08 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     niklas.cassel@linaro.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Stephen Boyd <sboyd@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 07/11] cpufreq: mvebu: Remove OPPs using dev_pm_opp_remove()
Date:   Wed, 12 Sep 2018 13:58:46 +0530
Message-Id: <b6e58baec5ee4cf56f82c4b14dad7320cf01ce7f.1536736872.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1536736872.git.viresh.kumar@linaro.org>
References: <cover.1536736872.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dev_pm_opp_cpumask_remove_table() is going to change in the next commit
and will not remove dynamic OPPs automatically. They must be removed
with a call to dev_pm_opp_remove().

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/mvebu-cpufreq.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/cpufreq/mvebu-cpufreq.c b/drivers/cpufreq/mvebu-cpufreq.c
index 31513bd42705..6d33a639f902 100644
--- a/drivers/cpufreq/mvebu-cpufreq.c
+++ b/drivers/cpufreq/mvebu-cpufreq.c
@@ -84,9 +84,10 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 
 		ret = dev_pm_opp_add(cpu_dev, clk_get_rate(clk) / 2, 0);
 		if (ret) {
+			dev_pm_opp_remove(cpu_dev, clk_get_rate(clk));
 			clk_put(clk);
 			dev_err(cpu_dev, "Failed to register OPPs\n");
-			goto opp_register_failed;
+			return ret;
 		}
 
 		ret = dev_pm_opp_set_sharing_cpus(cpu_dev,
@@ -99,11 +100,5 @@ static int __init armada_xp_pmsu_cpufreq_init(void)
 
 	platform_device_register_simple("cpufreq-dt", -1, NULL, 0);
 	return 0;
-
-opp_register_failed:
-	/* As registering has failed remove all the opp for all cpus */
-	dev_pm_opp_cpumask_remove_table(cpu_possible_mask);
-
-	return ret;
 }
 device_initcall(armada_xp_pmsu_cpufreq_init);
-- 
2.18.0.rc1.242.g61856ae69a2c

