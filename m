Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24ECAC282F6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:43:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6E052085A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 09:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5qZut8L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbfAUJnc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 04:43:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45712 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728264AbfAUJna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 04:43:30 -0500
Received: by mail-wr1-f66.google.com with SMTP id t6so22420026wrr.12
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 01:43:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=/iO1px23azz4XYlqPGK4I0M/7XGc7/WM1npHE+nRfKQ=;
        b=Q5qZut8Lgm+vBQ73S0qqM8ppV+bIgxmc+vcYzE971tIRrk72Vd3G/jhIEKcRSWs9rC
         tTPt7FjACaJfomCX3gvrmn4yZBbJtmJd4BswDHbvFuhyBdHL6gC3WX/bWQ6hYw44J5uo
         qgkDJb7tGyafICJ1phnejx+7AJPBr2E4EEr8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=/iO1px23azz4XYlqPGK4I0M/7XGc7/WM1npHE+nRfKQ=;
        b=ns2uwOB/ziC3cTjzq6anPYqDjTosd2cx5OA/AucSrgX311ubR0LOGLHNzx5N33GYKU
         z/Ypzh5t34r5YF04ar3gHkwNcKCrq/6m1Tgx2IryYnovCmnA/QUkV3zBwrcplqycK/2w
         nfq1I0DDlEOjRaLbjV4DfYU7pFEJ1WVsJnSPkhfcoaUbxImFmcuOoriP9Qq+q0FRj5mR
         UrqXdOshrULZam3QMGc5lcxcAnD/HWAZUhT7Xji3SPeU3j5cuxZz6ZBbOy+owDI4Heo9
         7k0Bb2+ZbOWba2RWGVzuatOfY3O7gPpLJ7auS5cQLy3d3fbJvjd/f2EL5iTbVd9OqvUm
         /BjQ==
X-Gm-Message-State: AJcUukdiBEPFPNm4kKj/qNZc0tnl1ufP271eJM9Ag5KDexkOIUEEMTx8
        ymR51RTzvg/nBDC/csHVn3NtOQh2Ws8=
X-Google-Smtp-Source: ALg8bN5BbNpt9xTjrX7pXW7xYHtY4kSCbm9T5+Xrs4QGpvjZ2m7zBikHKoEz7wl4Gu23+CP7KV71NA==
X-Received: by 2002:adf:ce86:: with SMTP id r6mr28491308wrn.257.1548063808552;
        Mon, 21 Jan 2019 01:43:28 -0800 (PST)
Received: from localhost ([49.248.61.1])
        by smtp.gmail.com with ESMTPSA id t76sm52767896wme.33.2019.01.21.01.43.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 01:43:27 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, edubezval@gmail.com,
        swboyd@chromium.org, Amit Daniel Kachhap <amit.kachhap@gmail.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 2/2] thermal: cpu_cooling: Clarify error message
Date:   Mon, 21 Jan 2019 15:12:23 +0530
Message-Id: <3812a31a821981eb36858852d2f66c018c8fa0d4.1548063429.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548063429.git.amit.kucheria@linaro.org>
References: <cover.1548063429.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it clear that it is a failure if the cpufreq driver was unable to
register as a cooling device. Makes it easier to find in logs and
grepping for words like fail, err, warn.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dfd23245f778..6fff16113628 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -774,7 +774,7 @@ of_cpufreq_cooling_register(struct cpufreq_policy *policy)
 
 		cdev = __cpufreq_cooling_register(np, policy, capacitance);
 		if (IS_ERR(cdev)) {
-			pr_err("cpu_cooling: cpu%d is not running as cooling device: %ld\n",
+			pr_err("cpu_cooling: cpu%d failed to register as cooling device: %ld\n",
 			       policy->cpu, PTR_ERR(cdev));
 			cdev = NULL;
 		}
-- 
2.17.1

