Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id /L1OACZyGlvlPgAAmS7hNA
	; Fri, 08 Jun 2018 12:10:29 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 6E8AD607E4; Fri,  8 Jun 2018 12:10:29 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="T0goJCZ5"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id D60A960290;
	Fri,  8 Jun 2018 12:10:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D60A960290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752885AbeFHMK0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 08:10:26 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33736 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752853AbeFHMKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 08:10:23 -0400
Received: by mail-wr0-f194.google.com with SMTP id k16-v6so13172803wro.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jun 2018 05:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rc6KcJA7VB4fL2hYqNhJEYV529lK7iqRkyH/j0r3A1A=;
        b=T0goJCZ5EZvTsMkH/XgMyLAtxlGKeXWxgi9Mx0LplKzg2SvBkW43t8XO4cg31ZzsnI
         bjqHn3fbpmNGgThluiBF0SgZvLuUCf7rNW4WHqxknZqN9y0/LGvXuemFwZPQIDojc6Ow
         Y5W7QtFo9zg9r1Y1MU8Kd4ekBjKYzXsgWDfrs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rc6KcJA7VB4fL2hYqNhJEYV529lK7iqRkyH/j0r3A1A=;
        b=FqLXutOJfrKh214jVQTI6qQmiK60/hIv9qKzSHdSCZga8HlILL8jdAL9GrSiCtn0+M
         M/ziLRMfPVCCTmaHdzKXB0sTHyf5NRNOSzlbHI+NzGM1WNxXY5/C6srL+UF27LPbhnZa
         SKo/XYJQiSPE8M0+wbjg81HuPW4LdXs7xq0rCKjkW9YssfuP90Y68pdp/OC8cLBWz0qA
         iBolhoIfLNN0zaVMlfloekz05y8R1RsTFPOaD6iaaIrFX26Xc4vFE53Z1QqXyHWXy9Ao
         y8loAMDSs32m/iuoAeq22oNo7rbeGvAgUS3if70DdocFoPJ+m6qxWAAQxqOEODPNIHVj
         q3ww==
X-Gm-Message-State: APt69E3ZVi/YshYHWSC28ewV73rJyIHCECKsXfGcO9JBNTbq+gL9JJ7M
        UYVsdWh4U0ucQ0GfxgDxD8tmBQ==
X-Google-Smtp-Source: ADUXVKL88zauZnRaDGi2T5Q53VVo7krLMYDr8NDyoxZqxb/XlCA/U2HsyFlEmTTf1Xt74Qy8vY16lA==
X-Received: by 2002:adf:dc52:: with SMTP id m18-v6mr5154307wrj.84.1528459822438;
        Fri, 08 Jun 2018 05:10:22 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:f:6020:6c67:7ea:9f4d:8968])
        by smtp.gmail.com with ESMTPSA id b204-v6sm1546003wmh.22.2018.06.08.05.10.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Jun 2018 05:10:21 -0700 (PDT)
From: Vincent Guittot <vincent.guittot@linaro.org>
To: peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        Morten.Rasmussen@arm.com, viresh.kumar@linaro.org,
        valentin.schneider@arm.com, patrick.bellasi@arm.com,
        joel@joelfernandes.org, daniel.lezcano@linaro.org,
        quentin.perret@arm.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH v6 04/11] cpufreq/schedutil: use rt utilization tracking
Date: Fri,  8 Jun 2018 14:09:47 +0200
Message-Id: <1528459794-13066-5-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
References: <1528459794-13066-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Take into account rt utilization when selecting an OPP for cfs tasks in order
to reflect the utilization of the CPU.

Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/cpufreq_schedutil.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 28592b6..32f97fb 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -56,6 +56,7 @@ struct sugov_cpu {
 	/* The fields below are only needed when sharing a policy: */
 	unsigned long		util_cfs;
 	unsigned long		util_dl;
+	unsigned long		util_rt;
 	unsigned long		max;
 
 	/* The field below is for single-CPU policies only: */
@@ -178,15 +179,21 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
 	sg_cpu->max = arch_scale_cpu_capacity(NULL, sg_cpu->cpu);
 	sg_cpu->util_cfs = cpu_util_cfs(rq);
 	sg_cpu->util_dl  = cpu_util_dl(rq);
+	sg_cpu->util_rt  = cpu_util_rt(rq);
 }
 
 static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 {
 	struct rq *rq = cpu_rq(sg_cpu->cpu);
+	unsigned long util;
 
 	if (rq->rt.rt_nr_running)
 		return sg_cpu->max;
 
+	util = sg_cpu->util_dl;
+	util += sg_cpu->util_cfs;
+	util += sg_cpu->util_rt;
+
 	/*
 	 * Utilization required by DEADLINE must always be granted while, for
 	 * FAIR, we use blocked utilization of IDLE CPUs as a mechanism to
@@ -197,7 +204,7 @@ static unsigned long sugov_aggregate_util(struct sugov_cpu *sg_cpu)
 	 * util_cfs + util_dl as requested freq. However, cpufreq is not yet
 	 * ready for such an interface. So, we only do the latter for now.
 	 */
-	return min(sg_cpu->max, (sg_cpu->util_dl + sg_cpu->util_cfs));
+	return min(sg_cpu->max, util);
 }
 
 static void sugov_set_iowait_boost(struct sugov_cpu *sg_cpu, u64 time, unsigned int flags)
-- 
2.7.4
