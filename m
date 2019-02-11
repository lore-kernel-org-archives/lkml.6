Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D0BC282DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A42C3214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 08:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQPLUdQ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727194AbfBKIl5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 03:41:57 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39418 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727153AbfBKIlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 03:41:53 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so4985780pld.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 00:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y3+EyDegbUZpN+/R1MgR55TgRo8j8NBTJTSndSQPWD0=;
        b=nQPLUdQ88SR8I618ybEF8PhcK/8OnkEyxsMH/TdZxs7qW3iSyHn7lUcaTr8GQ07QWH
         iP8FXv5dSYeLNQ0lCSXM/MvC73lxeaWP0nVpsNe3lQNpbsuhWzrSMT7pBof4smocsBTv
         0EFbGSxTAYh11BQc9kFDi2RgQXbMy4FK2V1k7PvPEiFEh9PV9h55in5F+Ec/wZdcarzQ
         Dui1JyeqHyKrv6xU5PtT/ztO0z6rR6lLmaqtwCuVhLjcuih/x62+TvrlRHYvUQX9umqp
         nIdG9qsZC5arJT66/GjlQcog2UhnNUaFYYKg3f6EU+PnezQFBUdn23SvQVqRdUHOxYt0
         fcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y3+EyDegbUZpN+/R1MgR55TgRo8j8NBTJTSndSQPWD0=;
        b=Fen8zVYvkETPPPFfGrfcAxsuL/PpIpFHUMFlAtU8UtZ+bI4SScbvrX6xknsktRbKqD
         kfD6mk8AVk3qfGdXigfCw/cSjr1fOw+GbafbPxim4ggajOxAlPceU1lSr1XshleBWPP/
         Ofh21ExRV9Qq0/gNBSQypPHNA0f40zJUPzqlvaTRfupRthBRoR5ztRK4mEl7hE5SoPPH
         x5rcpNPR60BsERHTNh3sznDdTgHAOAnvagP1dczx7XhIF35mtuNSHoZvGHG8WcUq3hN3
         1yh4BKE4U4NQXvRZ1wXZmtDzJcttv3USzbzCMJGz6GWh9UVmJ0zSQH1u2fE8q6TXD/4x
         LneQ==
X-Gm-Message-State: AHQUAuZVkvNH6r0pjxL+fukkA1buIDe+a8/eOwrCWCfSo2hRDiOYtaX2
        30InHYQgp3AdJGh7Q6vsbNA1xw==
X-Google-Smtp-Source: AHgI3IZ7b5gWH4z0Fbn6KmUML8IyAYZ8dPzxF0dYqE9ATazTuoXrXzwyxYo2J/qghKJo3d6HDJtuqQ==
X-Received: by 2002:a17:902:a411:: with SMTP id p17mr36083302plq.292.1549874512588;
        Mon, 11 Feb 2019 00:41:52 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id m68sm3134173pfj.89.2019.02.11.00.41.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 00:41:51 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] cpufreq: dt: Implement light_weight_exit() callback
Date:   Mon, 11 Feb 2019 14:11:36 +0530
Message-Id: <742f4f42ae944a3ad13216f96fb0d03d394c395e.1549874368.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <cover.1549874368.git.viresh.kumar@linaro.org>
References: <cover.1549874368.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the light-weight tear down helper to reduce the amount of work
to do on CPU offline/online operation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 7ba392911cd0..69309a8121f0 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -160,6 +160,15 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	const char *name;
 	int ret;
 
+	/*
+	 * We did light-weight shutdown earlier, nothing else to initialize here
+	 * apart from policy->cpus.
+	 */
+	if (policy->driver_data) {
+		cpumask_copy(policy->cpus, policy->related_cpus);
+		return 0;
+	}
+
 	cpu_dev = get_cpu_device(policy->cpu);
 	if (!cpu_dev) {
 		pr_err("failed to get cpu%d device\n", policy->cpu);
@@ -295,6 +304,15 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cpufreq_light_weight_exit(struct cpufreq_policy *policy)
+{
+	/*
+	 * Preserve policy->driver_data and don't free resources on light-weight
+	 * tear down.
+	 */
+	return 0;
+}
+
 static int cpufreq_exit(struct cpufreq_policy *policy)
 {
 	struct private_data *priv = policy->driver_data;
@@ -319,6 +337,7 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.get = cpufreq_generic_get,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
+	.light_weight_exit = cpufreq_light_weight_exit,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.20.1.321.g9e740568ce00

