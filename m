Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD91C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3252F214C1
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 10:29:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yx+qJZSE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3252F214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbeLCKaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 05:30:15 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33186 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbeLCKaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 05:30:15 -0500
Received: by mail-wm1-f67.google.com with SMTP id r24so6614164wmh.0
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 02:29:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f2d05Erv6S9E0ZU9gj0Ovl7L2m019u559hKyrxCLRic=;
        b=Yx+qJZSEOwcRbDeGCCs6UTIlz15vgl63CPgXjs6JDcCme3dKgpddIoot+K3PKUsQD2
         bRMV2+O9fBXRpniaf8ii2WgEfVrNP0acjsu3il7E0I0NpOpbhQUHxJuUND7jV32awv3m
         byqJrxJsi9UjAx2GM80/Lt3inJaFHFxHDR9ZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f2d05Erv6S9E0ZU9gj0Ovl7L2m019u559hKyrxCLRic=;
        b=ublzC5URei7/7tCNwUzlZiQNRUIJQYkpUgTS6w9dcG6sG3vjIgOy1cm/dBt77bpF20
         8zmPgJ8VH3cxuZC9T/tr5kCcETOYKM7ymWRYMwIoI35nQteTj1VUC4nmnlhsdfVT4+Vk
         /bOgtBbHwS8puRYiPDniZgKnRFT3wDOdndAF3AZuQRdYavJ7Kyp8xTok3ywK+7rbnhzN
         HzpuRzSrNKtuR9REk0qNKiin6WXgvtPwE1Rhi2mOJRhJ+Owwc0KnKjPOVH5jl8QRVeB0
         WfB4nUltKt0LJIEs9WHya7+hhI7f7juQQVwgntyMec2yFFLa3x5Xxbt/WAQtULq/4v41
         Kwow==
X-Gm-Message-State: AA+aEWZ6XdB6Nw3jZyZV8/JdQJeQ7VGe8X/Lqb9mpJwg3fKSwcrAXqA+
        sqhtBxzT0OuV3ryaEhG0mRzaxA==
X-Google-Smtp-Source: AFSGD/VmkEVo4VNVyhwctbzHDdb2RfcFdn0tEBNQMczMmW2AhbOkEaR4DK7H2K3xB9oab5qY6jAP/Q==
X-Received: by 2002:a1c:a6cd:: with SMTP id p196mr7740329wme.142.1543832986222;
        Mon, 03 Dec 2018 02:29:46 -0800 (PST)
Received: from localhost.localdomain (104.183.88.92.rev.sfr.net. [92.88.183.104])
        by smtp.gmail.com with ESMTPSA id 125-v6sm8619843wmr.22.2018.12.03.02.29.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 03 Dec 2018 02:29:45 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH RESEND] sched/cpufreq: Add the SPDX tags
Date:   Mon,  3 Dec 2018 11:29:29 +0100
Message-Id: <1543832969-8440-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <CAJZ5v0hRgBShA_MkqTtvX+Y9QVYKKyLW5jtTzEsNpZYaRTcEFQ@mail.gmail.com>
References: <CAJZ5v0hRgBShA_MkqTtvX+Y9QVYKKyLW5jtTzEsNpZYaRTcEFQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SPDX tags are not present in cpufreq.c and cpufreq_schedutil.c.

Add them and remove the license descriptions

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 kernel/sched/cpufreq.c           | 5 +----
 kernel/sched/cpufreq_schedutil.c | 5 +----
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/cpufreq.c b/kernel/sched/cpufreq.c
index 5e54cbc..22bd898 100644
--- a/kernel/sched/cpufreq.c
+++ b/kernel/sched/cpufreq.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * Scheduler code and data structures related to cpufreq.
  *
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 #include "sched.h"
 
diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 3fffad3..626ddd4 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -1,12 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  * CPUFreq governor based on scheduler-provided CPU utilization data.
  *
  * Copyright (C) 2016, Intel Corporation
  * Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
  */
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
-- 
2.7.4

