Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A41C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32CE720661
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:09:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwFsOfX9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbfBWNJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:09:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40571 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727882AbfBWNIG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:08:06 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so4232562wmi.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Feb 2019 05:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FvWbQwT7yD0J6wXiJv9iSEtwBLiuq9ZwuzA1XeKrA9g=;
        b=IwFsOfX98LVVF+r7B8EMzjeW6rylRGOIFvg/d1eTz8NQWX5DF2V0ksBTYDYAo9pKRm
         oZ9ycTByKDlmw5uywBGZH1GzlmrQToRsQEq4uz8L6EX4XvUbEHGHtWlGX540oZaB5OFK
         s3oKIVSQ71Hc7brd87dYmPE84xFwU5RPM/j3ht/ljkSWwm65jWXyKbvaMQP7kRbbG0cs
         tR/rwvkPFHQI21Wc90u3M41xkavzkyTAC1DCRcSxjDGfhjlrwE08/zmVDgcjWIznom3G
         rhdPt6QwydZbX3+fvqcxMC/3HpfZtTpFwURHceq+80/6Y45hdAkHVQnZ+WTBUF/1YaWS
         MQdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FvWbQwT7yD0J6wXiJv9iSEtwBLiuq9ZwuzA1XeKrA9g=;
        b=IQ9Anm9Hku/WaldUnI4N6pcA/t7zVkkIdYp/yOeaNo6vC3v/CWekw0D9Umdhl/fkPF
         KJtMOtB0jEGlHi+TzDU1v1T+IcrsJxmN0hMiilmzwsDJSaRYueoN7JaJf+1SN0vWN9v2
         5wP416VIXy2W4XvOR2tIUfuCvDW6NSB+k1YTr9eWu3nVK6DtXpAoLosVuESi1rgZkxM3
         fKgEkCWjeoaO5EvoK4614Diev3T7jR7xASJU2QICDu46JaeIFHKOOvbwS0hLGPH1HWH+
         8FPxV4FJKKlb+EUOoZ5BLBSE4PpYCbFBssg89NCYmGN4f5jJNvv75+GsLNehXFL0A1hz
         Ih2w==
X-Gm-Message-State: AHQUAuZ2Un0rjeNXl7VFHyaa0Yxj+1IlAYebRPsLK+4UzXLalM6uDMI/
        GJh+e3zpxsFvmxuUHS441R3B8w==
X-Google-Smtp-Source: AHgI3Ias4KcVPoc17ozN6m5RJJSZcPhaaIFTt5CqkYQhqOaBZ+y9ug5Nv4yZQD5V3FVg4SQT75Hy5g==
X-Received: by 2002:a1c:2743:: with SMTP id n64mr4706807wmn.143.1550927284690;
        Sat, 23 Feb 2019 05:08:04 -0800 (PST)
Received: from clegane.local (189.126.130.77.rev.sfr.net. [77.130.126.189])
        by smtp.gmail.com with ESMTPSA id i12sm7830746wrq.21.2019.02.23.05.08.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:08:04 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     tglx@linutronix.de
Cc:     linux-kernel@vger.kernel.org, Atish Patra <atish.patra@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH 07/18] clocksource/drivers/riscv: Add required checks during clock source init
Date:   Sat, 23 Feb 2019 14:06:55 +0100
Message-Id: <20190223130707.16704-7-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190223130707.16704-1-daniel.lezcano@linaro.org>
References: <b5d75b05-b78c-535c-2b35-9a1f5a3a853f@linaro.org>
 <20190223130707.16704-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

Currently, clocksource registration happens for an invalid cpu for
non-smp kernels. This lead to kernel panic as cpu hotplug registration
will fail for those cpus. Moreover, riscv_hartid_to_cpuid can return
errors now.

Do not proceed if hartid or cpuid is invalid. Take this opportunity to
print appropriate error strings for different failure cases.

Signed-off-by: Atish Patra <atish.patra@wdc.com>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-riscv.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 431892200a08..e8163693e936 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -95,13 +95,30 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	struct clocksource *cs;
 
 	hartid = riscv_of_processor_hartid(n);
+	if (hartid < 0) {
+		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
+			n, hartid);
+		return hartid;
+	}
+
 	cpuid = riscv_hartid_to_cpuid(hartid);
+	if (cpuid < 0) {
+		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
+		return cpuid;
+	}
 
 	if (cpuid != smp_processor_id())
 		return 0;
 
+	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
+	       __func__, cpuid, hartid);
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
-	clocksource_register_hz(cs, riscv_timebase);
+	error = clocksource_register_hz(cs, riscv_timebase);
+	if (error) {
+		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
+		       error, cpuid);
+		return error;
+	}
 
 	sched_clock_register(riscv_sched_clock,
 			BITS_PER_LONG, riscv_timebase);
@@ -110,8 +127,8 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
 	if (error)
-		pr_err("RISCV timer register failed [%d] for cpu = [%d]\n",
-		       error, cpuid);
+		pr_err("cpu hp setup state failed for RISCV timer [%d]\n",
+		       error);
 	return error;
 }
 
-- 
2.17.1

