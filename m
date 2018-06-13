Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 7340EC004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28FDE204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZEpVWiWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28FDE204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935514AbeFMLeG (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:34:06 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33945 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935498AbeFMLd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:33:58 -0400
Received: by mail-pg0-f65.google.com with SMTP id q4-v6so1153058pgr.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=eYsaNDXipDe/lJhotbiCb787ugqu/85X8+2xC+bpmGQ=;
        b=ZEpVWiWrP7BA3MdccZkJpaRhQkH3n9pAVvH5/bFfXXkW51iMrGyt2iXRekl+tw0nxI
         LvR6KaRN9p8OErUhzSYvQSrUj8EvefINyX3KU4ETegdqyWOC8UnlZH5HUVCkSOHXJvH/
         hFXnJPioHEiQSdQfRimDnXyAAIifQxb+IyRxw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=eYsaNDXipDe/lJhotbiCb787ugqu/85X8+2xC+bpmGQ=;
        b=EqOu3Ch09JloKiayCaeLNill6Hb11Ct4NMGD9dl3ig5DAvKF+ACKhdyxjKg3HcmYyv
         668n7Ird38hJP7RnTPhVfFlr2GhTW+ZuBJt3j1ikbo+SaGATeHIAd2M404I2IjJWAN8A
         TXjvJBPo+gyOcvrhsgeI4D3GTm3MIT4xkPT6EVBc9v84X/Rtg5fxr/WXGmwCFySAKuaE
         AfyEjfqto+YONTf8ikyEp5cvyu2Mns+e++L3y0KT0RuZcio0DS2+QOx/9FpY7SdrFb7v
         O456Cg/7PzRp+3vHrHYKiAPjFvgg6pUPDwwvkLU2pXQWztEht3THrhSizOTa3dAykeMP
         JFFQ==
X-Gm-Message-State: APt69E163V496OjrDSDzvDHC7pweu5PZuArNqrpEff1evgjsh5KWb9ra
        XtIkYwRs5SSVZDGf8tOiVxh42w==
X-Google-Smtp-Source: ADUXVKLrn+a9fFXavYXiRSsORht7x3JF+vrVsGt06RtkqBYlaFxl6lnxrZYbeGpO/xWVtLXkP33jtw==
X-Received: by 2002:a65:6148:: with SMTP id o8-v6mr3707740pgv.93.1528889637833;
        Wed, 13 Jun 2018 04:33:57 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2745370pgq.35.2018.06.13.04.33.49
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:33:57 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     tglx@linutronix.de, john.stultz@linaro.org,
        daniel.lezcano@linaro.org, arnd@arndb.de, tony@atomide.com,
        aaro.koskinen@iki.fi, linux@armlinux.org.uk, mark.rutland@arm.com,
        marc.zyngier@arm.com
Cc:     baolin.wang@linaro.org, broonie@kernel.org,
        paulmck@linux.vnet.ibm.com, mlichvar@redhat.com,
        rdunlap@infradead.org, kstewart@linuxfoundation.org,
        gregkh@linuxfoundation.org, pombredanne@nexb.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, heiko@sntech.de,
        linus.walleij@linaro.org, viresh.kumar@linaro.org,
        mingo@kernel.org, hpa@zytor.com, peterz@infradead.org,
        douly.fnst@cn.fujitsu.com, len.brown@intel.com,
        rajvi.jingar@intel.com, alexandre.belloni@bootlin.com,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: [PATCH 7/8] x86: tsc: Register the persistent clock
Date:   Wed, 13 Jun 2018 19:32:34 +0800
Message-Id: <3010faf8a1dda56be4eac0d5aa393fbfb96f3077.1528878545.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the tsc as one persistent clock to compensate the suspend time
if the tsc clocksource is always available.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/x86/Kconfig      |    1 +
 arch/x86/kernel/tsc.c |   21 +++++++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 297789a..549dd01 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -200,6 +200,7 @@ config X86
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
+	select PERSISTENT_CLOCK
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9..cb4f495 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/clocksource.h>
 #include <linux/percpu.h>
+#include <linux/persistent_clock.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
 
@@ -1032,6 +1033,11 @@ static u64 read_tsc(struct clocksource *cs)
 	return (u64)rdtsc_ordered();
 }
 
+static u64 notrace tsc_read_persistent_clock(void)
+{
+	return (u64)rdtsc_ordered();
+}
+
 static void tsc_cs_mark_unstable(struct clocksource *cs)
 {
 	if (tsc_unstable)
@@ -1300,6 +1306,14 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	if (boot_cpu_has(X86_FEATURE_ART))
 		art_related_clocksource = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
+
+	if (clocksource_tsc.flags & CLOCK_SOURCE_SUSPEND_NONSTOP) {
+		persistent_clock_init_and_register(tsc_read_persistent_clock,
+						   CLOCKSOURCE_MASK(64),
+						   tsc_khz * 1000, 0);
+		persistent_clock_start_alarmtimer();
+	}
+
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
 }
@@ -1327,6 +1341,13 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
+
+		if (clocksource_tsc.flags & CLOCK_SOURCE_SUSPEND_NONSTOP) {
+			persistent_clock_init_and_register(tsc_read_persistent_clock,
+							   CLOCKSOURCE_MASK(64),
+							   tsc_khz * 1000, 0);
+			persistent_clock_start_alarmtimer();
+		}
 unreg:
 		clocksource_unregister(&clocksource_tsc_early);
 		return 0;
-- 
1.7.9.5

