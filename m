Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0153EC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C031221773
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 07:07:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y4HZ6tlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfBLHHC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 02:07:02 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:37158 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfBLHHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 02:07:00 -0500
Received: by mail-pl1-f194.google.com with SMTP id b5so861078plr.4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 23:07:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bl67EUE/XY/6X5G+dYl3utZYVkMZx8TlxGZKFfW5yh8=;
        b=Y4HZ6tlhiVMul1p4bXQfywgRLmphH1w3FXiaYP7OuYI9IiNUy0KC4Azirsq/dLEPBU
         9Bkgi94cwcVIyJXh1y9+r7FTWLH2G7XmS8JnfQoAsoK+5JneSTVDzJS7DE4w/TLLQ/dz
         /loClwAiQP7aP+8zh4qnhFgVd4lmLDDDgp0wY/bYiPU7OObxEHei+WjKwYXJtmw2ru61
         PNSzkWkB9eLGIs1We9Qs4Y0DwhZyb3vwwnCM5bOsbk0IhTFTEqmVwrX+5QgqCZg5kPMj
         UfrJS7HZYrtOfL4EcpVm2YaXIx7L6ci2y9tngggX0EFtwUehIMiyXMToCVcmZaI5WeE9
         2Nlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bl67EUE/XY/6X5G+dYl3utZYVkMZx8TlxGZKFfW5yh8=;
        b=SqtS/4QhtM8XL5+qghD5SqMYV8fTSmUSJd9NFcT9OGOTtWqkG+Jl5y8V6p8mE+j6pl
         OVJbH46W0UHgWnWA8Lw/fgUvK70hvYycAzonZHrHRvgjhR5ZCoSU7vniL1GTu4q5sXGx
         +6uCnBcAbjLjcVEvTyJWk4XX/LlpCY5935BcyKiY2uScnsPsn08mIwN9wL/m3rGC42/x
         usKuhAbKyK/ySLbjVVnDgY6vyzpLCzmiOWQjT1ANyRmWlXCEyPhcbiOOat22/9KwGjM+
         CUGs9EChf4GEbzNfMa5GCOi8OAG3kbLAnIQHhR4xl6US9tjawmDX8Jz9ahLasYwDlKEy
         yHUQ==
X-Gm-Message-State: AHQUAuZ9wUEbXBp3C4Pyu9r1/ES7XPrVFk9Sn00c8DBgjTy3z/GfAk7P
        /ZWrhbeYYG7HcFVmp20cjr3huA==
X-Google-Smtp-Source: AHgI3IZRItGHq7KeOyt8RacrgJij9HH+qOWMCu1cMeQjt/wAzEH5OutpK/W4lBTNBjyF7gfsioUnFg==
X-Received: by 2002:a17:902:2a69:: with SMTP id i96mr2562023plb.58.1549955219631;
        Mon, 11 Feb 2019 23:06:59 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id v13sm16233278pff.20.2019.02.11.23.06.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 23:06:58 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/2] cpufreq: dt: Implement online/offline() callbacks
Date:   Tue, 12 Feb 2019 12:36:47 +0530
Message-Id: <8030961ef762018fc286e4d3d3a010638e900e53.1549955027.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <cover.1549955027.git.viresh.kumar@linaro.org>
References: <cover.1549955027.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the light-weight tear down and bring up helpers to reduce the
amount of work to do on CPU offline/online operation.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 7ba392911cd0..1aefaa1b0ca2 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -295,6 +295,21 @@ static int cpufreq_init(struct cpufreq_policy *policy)
 	return ret;
 }
 
+static int cpufreq_online(struct cpufreq_policy *policy)
+{
+	/* We did light-weight tear down earlier, nothing to do here */
+	return 0;
+}
+
+static int cpufreq_offline(struct cpufreq_policy *policy)
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
@@ -319,6 +334,8 @@ static struct cpufreq_driver dt_cpufreq_driver = {
 	.get = cpufreq_generic_get,
 	.init = cpufreq_init,
 	.exit = cpufreq_exit,
+	.online = cpufreq_online,
+	.offline = cpufreq_offline,
 	.name = "cpufreq-dt",
 	.attr = cpufreq_dt_attr,
 	.suspend = cpufreq_generic_suspend,
-- 
2.20.1.321.g9e740568ce00

