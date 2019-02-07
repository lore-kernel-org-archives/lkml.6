Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEDBC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2987221872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 10:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QHcllTWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfBGKqT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 05:46:19 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42124 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfBGKqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 05:46:18 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4314702pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 07 Feb 2019 02:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l8W/PruHRLm7V9RCGIGL3xdZzxFuSJMsXboxSXJ3x4I=;
        b=QHcllTWLIaJQjzssPmlKe9+gVJPOWK8m+ro3g4JdjkPS3MXqW7Sf1VLMqWz+KEtNEX
         d+YrmLWWhLH9zi7n7aXCxhEENazemsV3LUzw6p1h1WYPgxkwUc4h8F8MweEIJgNkfTat
         hZubo3hDhk33dnO2JUDR8xZfiRZ/vLBmiq2L90dAnsZVql2SAfqegzoDOp4nzjEb8xP+
         ZWvMgBmYRkD5g1rbLL2OPW6MKuxPz8DyBlbjeEvGd9/LSIHnPNBPMmtB9PHyS28gcM4b
         mTuwU2/ijV+oION308PqStT7HKyguZzGg6itboUWqL1QJf6Mfk/+o7h3Md0lK89bY9VV
         NZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l8W/PruHRLm7V9RCGIGL3xdZzxFuSJMsXboxSXJ3x4I=;
        b=au/5rCfzEANtR3L7Bh83iS9z2oL47SbwFk44eKkzCQ7HZD2ePJkqMyoj2kBNUmfYBM
         3u9b/juH8rdbRfIZQhD0l/ZqH4+iv51JzEYWShLnvRk0oDDjFHdLRnxkH5zCSAkc02Mv
         /5eY24RXlv93xBvpKXNTUZTfM/DwKDCscw/H8wB0MrcJdjsB2lLPxexPemceACyDNe8I
         oVOecOgWGhHs0BW6x5XgoBIg9XZbTpP34bEQlyEbpJSrK61lgu+CJcLreRsCe8b5GuGM
         lQ4rZ/TEVKGxJe0wBu0w0mDKLPWKYEASrUX18Ky/69jH9MrqQk8zFsAxGbXRBeuyZ9Wa
         JPhw==
X-Gm-Message-State: AHQUAuZiQPa/QYlLk3OnjalZFXm4Vrrx2sOOcuZXSY25tQlaMgRrOwJO
        YlRBy+wiE39Nlb6s3pMOEf4izg==
X-Google-Smtp-Source: AHgI3Ia/GcCsoSnCIH64vrHBxFqB4QzeIkC2PBrqi2V9fGwFn8tMK7TSdsaxiN03faNEu5M98KcmNA==
X-Received: by 2002:a62:c505:: with SMTP id j5mr15448980pfg.149.1549536377383;
        Thu, 07 Feb 2019 02:46:17 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id e23sm8396175pfb.97.2019.02.07.02.46.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 02:46:16 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] sched/fair: Improve the for loop in select_idle_core()
Date:   Thu,  7 Feb 2019 16:16:06 +0530
Message-Id: <6b165676325a47d67e667582a7b78da85c5c118a.1549536337.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.20.1.321.g9e740568ce00
In-Reply-To: <f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org>
References: <f91c5e118183e79d4a982e9ac4ce5e47948f6c1b.1549536337.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once a non-idle thread is found for a core, there is no point in
traversing rest of the threads of that core. We continue traversal
currently to clear those threads from "cpus" mask. Clear all the
threads with a single call to cpumask_andnot(), which will also let us
exit the loop earlier.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 kernel/sched/fair.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 8d5c82342a36..ccd0ae9878a2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6068,6 +6068,7 @@ void __update_idle_core(struct rq *rq)
 static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+	const struct cpumask *smt;
 	int core, cpu;
 
 	if (!static_branch_likely(&sched_smt_present))
@@ -6081,10 +6082,14 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 	for_each_cpu_wrap(core, cpus, target) {
 		bool idle = true;
 
-		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			cpumask_clear_cpu(cpu, cpus);
-			if (!available_idle_cpu(cpu))
+		smt = cpu_smt_mask(core);
+		cpumask_andnot(cpus, cpus, smt);
+
+		for_each_cpu(cpu, smt) {
+			if (!available_idle_cpu(cpu)) {
 				idle = false;
+				break;
+			}
 		}
 
 		if (idle)
-- 
2.20.1.321.g9e740568ce00

