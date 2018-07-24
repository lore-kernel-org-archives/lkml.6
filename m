Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723A1C6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A65420880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="keKfup2u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A65420880
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388494AbeGXSnf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:43:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33768 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388434AbeGXSnf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:43:35 -0400
Received: by mail-pg1-f195.google.com with SMTP id r5-v6so3387423pgv.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jul 2018 10:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=drQgHff0Z7JTZYtCB2EFIHygtH5rcojdmre/pe07yT0=;
        b=keKfup2uinI29UnVDia9wxrDXzyc5E9b1ejjK4AAUOHcfmeUKFYZLZ4TZF4FQQzBFF
         D4OisbPiML/UnZamBt0mU5EcOjwygfuVsC93YpQIa6wYQ9gQGWDGgfOK8XGnPCiTw/B+
         n8etUDrT7fEYccI8xcVV4sKloKauaK5hC7sls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=drQgHff0Z7JTZYtCB2EFIHygtH5rcojdmre/pe07yT0=;
        b=uCGcFZ6WH3lyowJzcmjzpwZq6rBQfyb7mMMNjQ4/+OZ9Uy3miVsxJzxFlUFlv7FbG3
         QF+HZpD6ByHbQAg8R9C5qiRTCMqCCQB+BgVeWP9YxDPS5pvWmvRt70y1exTWXK9yn1rV
         2qR/FM/NKAzZ2HCJsopVmWryOiSjBJyRrAa5Nsn/xukUMOHzgAiN1HYmD9aNRCL90Wej
         dyBhlf+Jhm2FAlFQnmc7FO1Lv7VWGDur2zGcL6rX7c/SmdFlWxjcE/ycrNX/bP+uZDCu
         8HmDzUV3TRNP4NkRLOfJy8DwVRg8kCxfG4mkpq6O/HIW9qeehS70tReKkFZQ68NSLduB
         UVjQ==
X-Gm-Message-State: AOUpUlGgQB+oYi5N5RpNaPZ4uFqIG32f/e0uwExRmqKpdbEntij/cBM1
        mrAdlG+LlQvFw5Ly1ZGsJEsakVYdoks=
X-Google-Smtp-Source: AAOMgpex18OY1o9C5cko5tmcESmLSGrIUKcg2jsI6DCWycA3CO4tI+ch7vUd7u9HIJoMdGkkwnwgwg==
X-Received: by 2002:a62:6b44:: with SMTP id g65-v6mr18582910pfc.226.1532453762429;
        Tue, 24 Jul 2018 10:36:02 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1600:3122:ea9c:d178:eb])
        by smtp.gmail.com with ESMTPSA id h10-v6sm23151306pfj.78.2018.07.24.10.36.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Jul 2018 10:36:01 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Ruchi Kandoi <kandoiruchi@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Ingo Molnar <mingo@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v3] cpufreq: trace frequency limits change
Date:   Tue, 24 Jul 2018 10:35:44 -0700
Message-Id: <20180724173544.18876-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.233.g985f88cf7e-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruchi Kandoi <kandoiruchi@google.com>

systrace used for tracing for Android systems has carried a patch for
many years in the Android tree that traces when the cpufreq limits
change.  With the help of this information, systrace can know when the
policy limits change and can visually display the data. Lets add
upstream support for the same.

Signed-off-by: Ruchi Kandoi <kandoiruchi@google.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
Viresh since I changed the patch, could you Ack it again?

v2->v3: reduce parameters to tracepoint call (Steve)
v1->v2: correct ordering of min/max (Viresh)

 Documentation/trace/events-power.rst |  1 +
 drivers/cpufreq/cpufreq.c            |  1 +
 include/trace/events/power.h         | 25 +++++++++++++++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/Documentation/trace/events-power.rst b/Documentation/trace/events-power.rst
index a77daca75e30..2ef318962e29 100644
--- a/Documentation/trace/events-power.rst
+++ b/Documentation/trace/events-power.rst
@@ -27,6 +27,7 @@ cpufreq.
 
   cpu_idle		"state=%lu cpu_id=%lu"
   cpu_frequency		"state=%lu cpu_id=%lu"
+  cpu_frequency_limits	"min=%lu max=%lu cpu_id=%lu"
 
 A suspend event is used to indicate the system going in and out of the
 suspend mode:
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b0dfd3222013..52566f1f1050 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2236,6 +2236,7 @@ static int cpufreq_set_policy(struct cpufreq_policy *policy,
 
 	policy->min = new_policy->min;
 	policy->max = new_policy->max;
+	trace_cpu_frequency_limits(policy);
 
 	policy->cached_target_freq = UINT_MAX;
 
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 908977d69783..f7aece721aed 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -5,6 +5,7 @@
 #if !defined(_TRACE_POWER_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_POWER_H
 
+#include <linux/cpufreq.h>
 #include <linux/ktime.h>
 #include <linux/pm_qos.h>
 #include <linux/tracepoint.h>
@@ -148,6 +149,30 @@ DEFINE_EVENT(cpu, cpu_frequency,
 	TP_ARGS(frequency, cpu_id)
 );
 
+TRACE_EVENT(cpu_frequency_limits,
+
+	TP_PROTO(struct cpufreq_policy *policy),
+
+	TP_ARGS(policy),
+
+	TP_STRUCT__entry(
+		__field(u32, min_freq)
+		__field(u32, max_freq)
+		__field(u32, cpu_id)
+	),
+
+	TP_fast_assign(
+		__entry->min_freq = policy->min;
+		__entry->max_freq = policy->max;
+		__entry->cpu_id = policy->cpu;
+	),
+
+	TP_printk("min=%lu max=%lu cpu_id=%lu",
+		  (unsigned long)__entry->min_freq,
+		  (unsigned long)__entry->max_freq,
+		  (unsigned long)__entry->cpu_id)
+);
+
 TRACE_EVENT(device_pm_callback_start,
 
 	TP_PROTO(struct device *dev, const char *pm_ops, int event),
-- 
2.18.0.233.g985f88cf7e-goog

