Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29281C04EBF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:35:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E151A20850
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 12:35:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="uKFkUCDH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E151A20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=brainfault.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeLCMgb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 07:36:31 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46947 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbeLCMgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 07:36:31 -0500
Received: by mail-pf1-f193.google.com with SMTP id c73so6283819pfe.13
        for <linux-kernel@vger.kernel.org>; Mon, 03 Dec 2018 04:35:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=VxYFohe4PUgyDK+i9RF4Q1Ec9VsEPmNXJGRFJEnW1vs=;
        b=uKFkUCDHyBFIxffqmFqrFo2Lrm1D/9XOiktDmXELXTMfnEF+Oi+5qhVW1A5nilB8Wp
         iUt4GM5FSlbW+iAllEui54vRSn3ZbKOVMm6VM0RdkcmQufF5ofbl/qIF/CGatdCjss4b
         rDl2bnBIQihV5XPlFWRu4p9TCRlsBCmEmg4uB+XNW8J4lWpZxsEF9RulOgytPQGHdAl+
         FAUhSBSJiN4xVYc5pFma/zjTwhRVW2YsxXaZge780HexD8HarcTOG5hprxg2R22Xi7WU
         /UwO18Xm05bCfQSNuPXXtbejApKID1fdyErpX9ETMSRBmwKU4dvyKGPL8g69PNQiZXp7
         71SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=VxYFohe4PUgyDK+i9RF4Q1Ec9VsEPmNXJGRFJEnW1vs=;
        b=i9d7RAcRsjODCXGYt1il/VyHc2/xZ4g6tgQQ+ZDc3n/5rvmAHxJ7CTuWx2w11b2xxM
         QvFAID4DhIGzVuTLV7iEQ5LaylSThoamMVWqNdbRwBmNC1l/PiEof+In15Tzfrb2FGM1
         z74bWL9DEERgVVyhSSzPKl7XwlLMNMzOTvauNRc0mhJzfdNReaeX8h7523xyuq4pOvXd
         DMY547jdxY4OCepFOLLA0qDPQvbTSCqBGSOCVzSsV46bPGQy+Rgnov0dnB9xSMOK7huC
         cy9+92Gkq2yICB0ZXESc8At1MxcjUcG27n6tJCDdwr5meuTelJs8RO/+vTIZjf/DxzKF
         ABdA==
X-Gm-Message-State: AA+aEWbp71z+ql8zJR5z2D6j35ayRzVBoPpxGqWE9vDeDMetQ2ExrYGG
        Cp90QMb0smyXzK0xLoxSp3OWlDK5R3g=
X-Google-Smtp-Source: AFSGD/VjrXjEwxL6rQlgvb3LUGa/9olGeUYZNUrpXG7eSbFvcV+DR5I7wzsgt2Gemk0hA84DCbzFxA==
X-Received: by 2002:a63:d655:: with SMTP id d21mr11952926pgj.280.1543840538071;
        Mon, 03 Dec 2018 04:35:38 -0800 (PST)
Received: from anup-ubuntu64.qualcomm.com ([106.51.23.39])
        by smtp.googlemail.com with ESMTPSA id m20sm14809124pgb.56.2018.12.03.04.35.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Dec 2018 04:35:37 -0800 (PST)
From:   Anup Patel <anup@brainfault.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Atish Patra <atish.patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH] clocksource: riscv_timer: Provide sched_clock
Date:   Mon,  3 Dec 2018 18:05:24 +0530
Message-Id: <20181203123524.11778-1-anup@brainfault.org>
X-Mailer: git-send-email 2.17.1
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
 drivers/clocksource/riscv_timer.c | 9 +++++++++
 1 file changed, 9 insertions(+)

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

