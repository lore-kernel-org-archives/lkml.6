Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FF91C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 15:30:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1627820841
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 15:30:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vPwlevwB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1627820841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbeHDRao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 13:30:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37244 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbeHDRao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 13:30:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id n11-v6so9538461wmc.2;
        Sat, 04 Aug 2018 08:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=lpJLt+byTH9gBcw8Y86Rn5DsC6r5w+nJ7vwnbHXQa+E=;
        b=vPwlevwBg4+Q+N26+cGNm3/a55Uy0qe/hul5crkByNkPVtscsVe/r8if3wkKBhpo7k
         abfcq59bYO+aeJuGJ79pgls9fATKW3g+ghTnCGr9FGMOnm6hjbFWVUM/lzHPE0Lw5yWG
         C2g5NH5um4NNp3rkXfXqlIjIdYEP7aQreziN58Awcz498lkvPZEjkdXZ+DLsRpGB/xvQ
         zfQn3H/4ZkcpX3MnRrsYcTngEuENgJQuQiH0Ovn1QP67dUWPqOJo1biA0RGtqbJYAFgy
         2FZ1z4eJ84f3RzdgirAQJ3J5vs32BqlYoQm/g57HJa6gO2AiNzESVGzxy8CfSFRV2y72
         ThMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=lpJLt+byTH9gBcw8Y86Rn5DsC6r5w+nJ7vwnbHXQa+E=;
        b=FETctUEjxtRMijTuizckNAG7aMJ2RwZZY1RyX5N6YflgNZLjE1rnaeWXKNboMWtAvF
         bchWXTgemouyqwbuS8AGcP1Muf8QekGP0sv/m5Ki3soGxVVEL27JSTfjcv9OoQ1xq/0F
         XuseL9dfWkuWi0IaM5rzQqjgQ1BT6SBXeUmZK4rSSuZfb4K3YQUvReopGxAhG99vh7dk
         Rgpqyo6mgsn2maLW73KSU75hXNaNHBEergMaXD11janfKuVlkXzeEIEnZEm4WW1OtSWA
         9DXzhGEbfG2Q70JhxjrKWkuUP8D/ruXl1adEXm019X4HCDR7awasahn95ZDQAsU+zOZg
         V5UA==
X-Gm-Message-State: AOUpUlHISfQPQWF2nG32zDuXSsGY7Gsc03cspVit4JECH6QxGH+wStbH
        YHMvOq24K4n9h1awB8UNbxaIIFY9
X-Google-Smtp-Source: AAOMgpcM0BGC/sGhzJpvlTMRC5gqaLsuSqYhpgYxp3nbe2dNhmoCy8bWugyBUAMJNIejUjtpfzjFdg==
X-Received: by 2002:a1c:f306:: with SMTP id q6-v6mr7416143wmq.111.1533396580823;
        Sat, 04 Aug 2018 08:29:40 -0700 (PDT)
Received: from xps13.fritz.box (2-230-197-194.ip203.fastwebnet.it. [2.230.197.194])
        by smtp.gmail.com with ESMTPSA id z8-v6sm7027923wrp.54.2018.08.04.08.29.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 04 Aug 2018 08:29:39 -0700 (PDT)
From:   Gabriele Mazzotta <gabriele.mzt@gmail.com>
To:     srinivas.pandruvada@linux.intel.com, rjw@rjwysocki.net
Cc:     lenb@kernel.org, viresh.kumar@linaro.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: [PATCH] Revert "cpufreq: intel_pstate: Fix ->set_policy() interface for no_turbo"
Date:   Sat,  4 Aug 2018 17:29:32 +0200
Message-Id: <20180804152932.3861-1-gabriele.mzt@gmail.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change does not take into account that some BIOSes change
MSR_IA32_MISC_ENABLE_TURBO_DISABLE depending on the power source.
If the turbo is disabled when the system boots, policy.max_freq
is set to pstate.max_pstate. However, if the BIOS later enables
the turbo, the CPU will never be able to run at pstate.turbo_pstate.

Since now intel_pstate_set_policy() does its calculations using
pstate.max_freq and pstate.turbo_freq, we can always calculate
cpuinfo.max_freq using pstate.turbo_pstate, thus allowing system
with varying MSR_IA32_MISC_ENABLE_TURBO_DISABLE to run at full
speed when the turbo is enabled.

This reverts commit 983e600e88835f0321d1a0ea06f52d48b7b5a544.

Signed-off-by: Gabriele Mazzotta <gabriele.mzt@gmail.com>
---
 drivers/cpufreq/intel_pstate.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3c3971256130..4043aae2d611 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2068,9 +2068,8 @@ static int __intel_pstate_cpu_init(struct cpufreq_policy *policy)
 	/* cpuinfo and default policy values */
 	policy->cpuinfo.min_freq = cpu->pstate.min_pstate * cpu->pstate.scaling;
 	update_turbo_state();
-	policy->cpuinfo.max_freq = global.turbo_disabled ?
-			cpu->pstate.max_pstate : cpu->pstate.turbo_pstate;
-	policy->cpuinfo.max_freq *= cpu->pstate.scaling;
+	policy->cpuinfo.max_freq =
+		cpu->pstate.turbo_pstate * cpu->pstate.scaling;
 
 	intel_pstate_init_acpi_perf_limits(policy);
 
-- 
2.18.0

