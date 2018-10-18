Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66424ECDE43
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C63C208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 19:55:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZDSgGaJ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C63C208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727400AbeJSD6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 23:58:20 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37742 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeJSD6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 23:58:19 -0400
Received: by mail-wm1-f66.google.com with SMTP id 185-v6so1534988wmt.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Oct 2018 12:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=f2d05Erv6S9E0ZU9gj0Ovl7L2m019u559hKyrxCLRic=;
        b=ZDSgGaJ9FGPvKXpYdKBOi4gAaE6vvl0/9OP+UvWgDC/0A9EamLrFIVpLCn6t/dUnRn
         Au9yqsf21y+I+IEvpRl+577FQvXRXxsFGFHBHDuIdmmWJNCYq7EFl5uHO8KRh7zQ0nHo
         LmwCGDyTyuaRmhuR8hmYr4W5R3ZDLAHfdWFkE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=f2d05Erv6S9E0ZU9gj0Ovl7L2m019u559hKyrxCLRic=;
        b=E044hIKqA89qlVZzHWFOkjivMGBpISUcFxvFBgY+KqwIfFOEGY9+dXQBYKwppuLGV4
         OfNkQNolLM+dUfdqQx3lxgajjKkSbOOHsIAET7MASb3oO1BMTqP/0ywW3LadOM6rQok9
         nXo7bB80FxfaWEsCFOrxbdzvmZ5j1s09Cp3UnGENBw0cik0xMq8t3UY+xHdhl0jQ1N4a
         NJ7RyGSnkEkR9PRUUIdMScmhltrftsLv+6HKATpVeqwHPU8zaMLAAzIvNIPwULpQ28Y8
         aEf+UxlYP+mBepuCOwdTxzbx7mgiIdIPfHn3kLtCotmYgNyVvFSb+ytWvKj1Medp8Her
         kwMQ==
X-Gm-Message-State: ABuFfojzJb0h65OjGgf74oi+G5G6LQoPTBU4A98D2LdIZEv2tjcRmd5I
        YgpSeEo3FpKojVTf6h6v1ug24Q==
X-Google-Smtp-Source: ACcGV60sYxhCDm8BsxsBWTrrg+kMXS4Uy3znXzFv/RIQQ4JdWKozS+dnXmkaRjolsSDG33/o+stDMg==
X-Received: by 2002:a1c:9fd5:: with SMTP id i204-v6mr1831630wme.88.1539892544040;
        Thu, 18 Oct 2018 12:55:44 -0700 (PDT)
Received: from localhost.localdomain (77.65.136.77.rev.sfr.net. [77.136.65.77])
        by smtp.gmail.com with ESMTPSA id h18-v6sm1540260wro.0.2018.10.18.12.55.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 18 Oct 2018 12:55:43 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     rafael@kernel.org, mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
Subject: [PATCH] sched/cpufreq: Add the SPDX tags
Date:   Thu, 18 Oct 2018 21:55:34 +0200
Message-Id: <1539892534-16917-1-git-send-email-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.7.4
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

