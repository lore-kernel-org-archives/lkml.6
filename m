Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8CA1C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FC7920851
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 10:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="JhKZ8XBf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC7920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726198AbeLDKpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 05:45:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:36376 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725764AbeLDKps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 05:45:48 -0500
Received: by mail-pf1-f194.google.com with SMTP id b85so8029040pfc.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 02:45:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L4yb/wtuagw+sPGtsZIsDQ9oRwj4098XHksxUaA5GSM=;
        b=JhKZ8XBfpmf5oNPC5DsZRbP+06aecEB9EHz57ti9YKa8qDmAQnflfCNurq8ocVp3rk
         BFT459NWwejSu/+jAz7hXqd5sX40tOt8yFvRsv3iymTKQNHleups1SYUemKZruBGck+K
         fpxLKT3l9tdwmL6TiBfSR74ZmObeWavsE+OdLSeimwlbXiDwJE/LBNCn/n1Et8Z0nbdO
         aLHCdHP5axFGcCOawzUBv/6DUOx9WdEf8xplqkrqumjnUOtUD90+f9djKcexijrkVBue
         w7I5e/fVpFqlZrtNRbEWkR4p0+1exmaGrgihIGPI7yUIZvCNGhg7KldY532s3rxZeny/
         Gf9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L4yb/wtuagw+sPGtsZIsDQ9oRwj4098XHksxUaA5GSM=;
        b=at3ORAImFGIKvQE/3fLlAnYCCBC1Wg81MawOo7SUxvlHiBoHhpfSJ1p8Ak/5g7t9/c
         9Mk2pWX/PVyNV9CGoc9EykcowoJoVkDh2kzI3gdTJJXTjPukGdq9SNNkn4u5S4Nu5Xsh
         1EtZrLo1t83TwwX/6HUGhRbB+DftXhleneHj7XaFFqJkbQtHKHVna7do+GE1w8SVciDL
         pTYQBVdXS5N1qee+JJXhJNhfcSiE33gGC+CAtjLDFlhWnO3Yo0a6BRDFRZaLDztAjnpH
         Ryr4hFlPRNPyUqN9m580jENtCegDgkjZT93pd/AdeX+Cjk07nqN0ElUhb2VgkngPkAUF
         C0dA==
X-Gm-Message-State: AA+aEWbwob4T1Zd/wFiwpyoH/q1sNNK1aCOfOxKDcexG2eCk6SCI86nd
        DLghaVCwrllUcJabYSXCSmvGCg==
X-Google-Smtp-Source: AFSGD/XCMx2RUewUEkFdQyd/qO+zjuxGBrfBuTBAky+CysatspDpy4r+JH7O71zM+WZ9lhK+SWBwcQ==
X-Received: by 2002:a63:7556:: with SMTP id f22mr15040408pgn.231.1543920347035;
        Tue, 04 Dec 2018 02:45:47 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([106.51.23.39])
        by smtp.googlemail.com with ESMTPSA id s37sm19034734pgm.19.2018.12.04.02.45.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 02:45:46 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2 2/2] clocksource: riscv_timer: Provide sched_clock
Date:   Tue,  4 Dec 2018 15:59:52 +0530
Message-Id: <20181204102952.21297-3-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204102952.21297-1-anup@brainfault.org>
References: <20181204102952.21297-1-anup@brainfault.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, we don't have a sched_clock registered for RISC-V systems.
This means Linux time keeping will use jiffies (running at HZ) as the
default sched_clock.

To avoid this, we explicity provide sched_clock using RISC-V rdtime
instruction (similar to riscv_timer clocksource).

Signed-off-by: Anup Patel <anup@brainfault.org>
---
 drivers/clocksource/Kconfig       | 2 +-
 drivers/clocksource/riscv_timer.c | 9 +++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 55c77e44bb2d..19649abd7c75 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -611,7 +611,7 @@ config ATCPIT100_TIMER
 
 config RISCV_TIMER
 	bool "Timer for the RISC-V platform"
-	depends on RISCV
+	depends on GENERIC_SCHED_CLOCK && RISCV
 	default y
 	select TIMER_PROBE
 	select TIMER_OF
diff --git a/drivers/clocksource/riscv_timer.c b/drivers/clocksource/riscv_timer.c
index 084e97dc10ed..431892200a08 100644
--- a/drivers/clocksource/riscv_timer.c
+++ b/drivers/clocksource/riscv_timer.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/delay.h>
 #include <linux/irq.h>
+#include <linux/sched_clock.h>
 #include <asm/smp.h>
 #include <asm/sbi.h>
 
@@ -49,6 +50,11 @@ static unsigned long long riscv_clocksource_rdtime(struct clocksource *cs)
 	return get_cycles64();
 }
 
+static u64 riscv_sched_clock(void)
+{
+	return get_cycles64();
+}
+
 static DEFINE_PER_CPU(struct clocksource, riscv_clocksource) = {
 	.name		= "riscv_clocksource",
 	.rating		= 300,
@@ -97,6 +103,9 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 	cs = per_cpu_ptr(&riscv_clocksource, cpuid);
 	clocksource_register_hz(cs, riscv_timebase);
 
+	sched_clock_register(riscv_sched_clock,
+			BITS_PER_LONG, riscv_timebase);
+
 	error = cpuhp_setup_state(CPUHP_AP_RISCV_TIMER_STARTING,
 			 "clockevents/riscv/timer:starting",
 			 riscv_timer_starting_cpu, riscv_timer_dying_cpu);
-- 
2.17.1

