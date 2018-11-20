Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 111CFC28CF8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3EE9220831
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 14:43:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen.com header.i=@soleen.com header.b="Q0Csj2yc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE9220831
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=soleen.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729816AbeKUBNQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 20:13:16 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:45676 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727346AbeKUBNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 20:13:15 -0500
Received: by mail-qt1-f194.google.com with SMTP id e5so215939qtr.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Nov 2018 06:43:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=UnUiGYEW/uorxQqYZvnlVGMF6D60RaYNRJLOaXoi1RI=;
        b=Q0Csj2ycF8fRsLX8Pv9j2xgiid/1Ru+mS26mzYWc9Rqd+LhMBknNqNSwldrlwISN42
         dme5Fn8G5HF6/tWQAgCDnSQMVt8M/zvBATnyS8xSgGAtHwFhQPKkdwXIOxvwvAxBrubC
         RzLJKvfZUlgzs4IOtsJHOPsJU7M0wkvTEI8ZKM/sBrrMbOyr/gyAo2Apf4XAuZczEZIf
         AtDfyAnBpvVpUdCUOcY/VY082n7N1h+/HNjXj/c57Gw2c6HnQdG1fFtD3O3r//CqBwtB
         bIYLsPCitkbBfYmT7UYxP6npoPo1qrVuAL6AF/G0HVHX2fT+0nONHOPaHimEyDAAgiAV
         afeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UnUiGYEW/uorxQqYZvnlVGMF6D60RaYNRJLOaXoi1RI=;
        b=RjxBlTVZVK4B0Flgaq3aT0aceve+3S0NrTeRslkfhG6cU1cMJsx1EJysa1t9evDnD3
         JcPkFb91itsEsYxAr5+IosbrU0p+r0X8sEgMuzIUp83hvOpn2gcHd5tBwhB61iIiEDz4
         UM///Ls47PNHG1HmB9dZJ869NbReodSR+93sVNQwr15wtpoVTuIoqvlY6ne3FmKTN7fU
         YFjwsHD7AVBS0b4pwpykDM4tMYCzOGHlNKjGrZ1WYg/NOWA4E35HZjYYU1W7g9Joagbw
         85NAiUAbs8cDwW66RGTabMqy34vtNvZNEbsR41OxLBPEmxtE5p7miH5G74S7qNt/HbsS
         113g==
X-Gm-Message-State: AGRZ1gJRFTc5c42DHfHzWJerG49veCpD4nHAgc8dn1y8jydIVBCX+bMj
        Z7omwPp2D62qCKCRkw2n6q7rYtbOyeU=
X-Google-Smtp-Source: AJdET5cxsokrFGpnfQ4BuyinKwn/hrQ7XnF55wUdZ+Qy+y5Wm/oHdCvdHOgaukdEf10H33w86/7PYw==
X-Received: by 2002:ac8:75cc:: with SMTP id z12mr2032847qtq.249.1542725025345;
        Tue, 20 Nov 2018 06:43:45 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id r16sm30046529qkh.71.2018.11.20.06.43.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 06:43:44 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     catalin.marinas@arm.com, will.deacon@arm.com,
        akpm@linux-foundation.org, rppt@linux.vnet.ibm.com,
        mhocko@suse.com, ard.biesheuvel@linaro.org, andrew.murray@arm.com,
        james.morse@arm.com, marc.zyngier@arm.com, sboyd@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@soleen.com
Subject: [PATCH v2 1/1] arm64: Early boot time stamps
Date:   Tue, 20 Nov 2018 09:43:40 -0500
Message-Id: <20181120144340.30201-2-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181120144340.30201-1-pasha.tatashin@soleen.com>
References: <20181120144340.30201-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow printk time stamps/sched_clock() to be available from the early
boot.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
---
 arch/arm64/kernel/setup.c            | 25 +++++++++++++++++++++++++
 drivers/clocksource/arm_arch_timer.c |  8 ++++----
 include/clocksource/arm_arch_timer.h |  3 +++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index f4fc1e0544b7..7a43e63b737b 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -40,6 +40,7 @@
 #include <linux/efi.h>
 #include <linux/psci.h>
 #include <linux/sched/task.h>
+#include <linux/sched_clock.h>
 #include <linux/mm.h>
 
 #include <asm/acpi.h>
@@ -279,8 +280,32 @@ arch_initcall(reserve_memblock_reserved_regions);
 
 u64 __cpu_logical_map[NR_CPUS] = { [0 ... NR_CPUS-1] = INVALID_HWID };
 
+/*
+ * Get time stamps available early in boot, useful to identify boot time issues
+ * from the early boot.
+ */
+static __init void sched_clock_early_init(void)
+{
+	u64 freq = arch_timer_get_cntfrq();
+
+	/*
+	 * The arm64 boot protocol mandates that CNTFRQ_EL0 reflects
+	 * the timer frequency. To avoid breakage on misconfigured
+	 * systems, do not register the early sched_clock if the
+	 * programmed value if zero. Other random values will just
+	 * result in random output.
+	 */
+	if (!freq)
+		return;
+
+	arch_timer_read_counter = arch_counter_get_cntvct;
+	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS, freq);
+}
+
 void __init setup_arch(char **cmdline_p)
 {
+	sched_clock_early_init();
+
 	init_mm.start_code = (unsigned long) _text;
 	init_mm.end_code   = (unsigned long) _etext;
 	init_mm.end_data   = (unsigned long) _edata;
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 9a7d4dc00b6e..e4843ad48bd3 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -175,13 +175,13 @@ static struct clocksource clocksource_counter = {
 	.name	= "arch_sys_counter",
 	.rating	= 400,
 	.read	= arch_counter_read,
-	.mask	= CLOCKSOURCE_MASK(56),
+	.mask	= CLOCKSOURCE_MASK(ARCH_TIMER_NBITS),
 	.flags	= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
 static struct cyclecounter cyclecounter __ro_after_init = {
 	.read	= arch_counter_read_cc,
-	.mask	= CLOCKSOURCE_MASK(56),
+	.mask	= CLOCKSOURCE_MASK(ARCH_TIMER_NBITS),
 };
 
 struct ate_acpi_oem_info {
@@ -963,8 +963,8 @@ static void __init arch_counter_register(unsigned type)
 	timecounter_init(&arch_timer_kvm_info.timecounter,
 			 &cyclecounter, start_count);
 
-	/* 56 bits minimum, so we assume worst case rollover */
-	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+	sched_clock_register(arch_timer_read_counter, ARCH_TIMER_NBITS,
+			     arch_timer_rate);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
diff --git a/include/clocksource/arm_arch_timer.h b/include/clocksource/arm_arch_timer.h
index 349e5957c949..c485512e1d01 100644
--- a/include/clocksource/arm_arch_timer.h
+++ b/include/clocksource/arm_arch_timer.h
@@ -71,6 +71,9 @@ enum arch_timer_spi_nr {
 #define ARCH_TIMER_EVT_STREAM_FREQ				\
 	(USEC_PER_SEC / ARCH_TIMER_EVT_STREAM_PERIOD_US)
 
+/* 56 bits minimum, so we assume worst case rollover */
+#define	ARCH_TIMER_NBITS		56
+
 struct arch_timer_kvm_info {
 	struct timecounter timecounter;
 	int virtual_irq;
-- 
2.19.1

