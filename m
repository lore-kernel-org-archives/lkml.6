Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07DA4C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:15:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C56CA20869
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 06:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVS0O+3n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfBAGP5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 01:15:57 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:39649 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbfBAGP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 01:15:57 -0500
Received: by mail-pl1-f195.google.com with SMTP id 101so2665704pld.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Jan 2019 22:15:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LRFuPEyKq3EzFrX7KUyuTOgSVNw77Yo4U+tkF/rdBw=;
        b=NVS0O+3nfN4m7YXiUDPq9aDSUFNnYrUgZIaweslK2RonDnychwZ3k1Nh+XWdjXlndB
         l/LKV3UEP5UPu00vLzsL1S6BWNoITlJSZ//LarAmFduzZT3GwbyMvZzjz47A3OLTtRFb
         rQ+bMGyxbsNhY9530ya1635UeN3O8c3owBnKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5LRFuPEyKq3EzFrX7KUyuTOgSVNw77Yo4U+tkF/rdBw=;
        b=qzG/K9+GXsZkNlR+F/IGdPDVk/3H9G2W5k8aEztCdzrfiQh5UJBl00pNl4SjpN+Dp6
         CSKm01gKCbkBpvXh2pI79177qwQ0HwlCGXCjZjdyJmOWu4UbY//QppzxI1M76tf9ybtD
         9I/V8BG1b/HRl2cMR46A8rXH2g1r73vCgqJyCZjEYLCY4oTeWyHm3PhRF0kcTdOaVQBx
         RujuupalDy/XuBVOr9yjXjfZ5EzHbfzfwChdNumEe2Xkgml0zCW2XCTN7twQOBE6e3Xa
         7VTE1VqBPzGoEFHIzK8F65Kp6AzrJtjKdS5TJTTfGqzNfqe+WXxzsOyWKdsoHYuYQlyC
         Kzcw==
X-Gm-Message-State: AJcUukdqLO/2rLKRdKmwlsJyQtUvwyxpa1FFNy7t2OzcJQHWF0epbS+x
        LfJrHMmgkb/51xMJontlbWrAlF2k/iU=
X-Google-Smtp-Source: ALg8bN7JTbllLT84uwGoTiEQB2gd5nqeriW5yCgxOAifrfv36bC2gBUxorfR/2ezlpr27Iqm/jDCHg==
X-Received: by 2002:a17:902:a60f:: with SMTP id u15mr36242602plq.275.1549001756370;
        Thu, 31 Jan 2019 22:15:56 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f67sm9337844pfc.141.2019.01.31.22.15.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Jan 2019 22:15:54 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] cpufreq: stats: Declare freq-attr right after their callbacks
Date:   Fri,  1 Feb 2019 11:45:44 +0530
Message-Id: <d5d8c15aca712342350d2f451002f55e15e9e93b.1549001732.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freq attribute for "trans_table" is defined right after its callback
(without any blank line between them), but the others are defined
separately later on. Keep this consistent and define all attributes
right after their callbacks.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_stats.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index 1572129844a5..941e63e3e652 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -51,6 +51,7 @@ static ssize_t show_total_trans(struct cpufreq_policy *policy, char *buf)
 {
 	return sprintf(buf, "%d\n", policy->stats->total_trans);
 }
+cpufreq_freq_attr_ro(total_trans);
 
 static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 {
@@ -69,6 +70,7 @@ static ssize_t show_time_in_state(struct cpufreq_policy *policy, char *buf)
 	}
 	return len;
 }
+cpufreq_freq_attr_ro(time_in_state);
 
 static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
 			   size_t count)
@@ -77,6 +79,7 @@ static ssize_t store_reset(struct cpufreq_policy *policy, const char *buf,
 	cpufreq_stats_clear_table(policy->stats);
 	return count;
 }
+cpufreq_freq_attr_wo(reset);
 
 static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 {
@@ -126,10 +129,6 @@ static ssize_t show_trans_table(struct cpufreq_policy *policy, char *buf)
 }
 cpufreq_freq_attr_ro(trans_table);
 
-cpufreq_freq_attr_ro(total_trans);
-cpufreq_freq_attr_ro(time_in_state);
-cpufreq_freq_attr_wo(reset);
-
 static struct attribute *default_attrs[] = {
 	&total_trans.attr,
 	&time_in_state.attr,
-- 
2.20.1.321.g9e740568ce00

