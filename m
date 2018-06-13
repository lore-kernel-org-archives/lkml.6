Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A91C1C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E410204EC
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 11:33:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bZJ4yF8M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E410204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935457AbeFMLdh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 07:33:37 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44182 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935424AbeFMLdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 07:33:33 -0400
Received: by mail-pg0-f65.google.com with SMTP id p21-v6so1135787pgd.11
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 04:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=qOl0Hf/KoVxPAWSJiEHR+kwcAVrdVGSBzW6sJ8SSmik=;
        b=bZJ4yF8MMucwePX4a2IL1gLw8HXA4kU2ZXmm73QuocsMJp+baefw2Ul6QlDdUiuluL
         r27hCR61+zLb0kh9JNg814I/JuiMAWUR4JtblPFzDxjaC/L9A24KcXAJZ4SfUqDZwYQv
         X2ahTQwc6puDorhfLWf/IvIjAvFFtPVsZccnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=qOl0Hf/KoVxPAWSJiEHR+kwcAVrdVGSBzW6sJ8SSmik=;
        b=CmXnuMMkHUIZ4Ls//XICW9H92D8KWq+EK4GTfFElDTev9gmh1GiqXSFXNtdng6sARD
         IJ/JVIntHlpFfPMSTskOHgijYbcBdqkY8OoNn/dovcvMVSbEa+s2FEw/+fDi3as1rqud
         BFk2DpLZV6sJhyi+SpsoDDh5DtRZ5f3lGwwcqgtN/LoisrhafhzIlsmL1zU3E6Aqj2Zm
         5dfCjSeigeFYukg2VyfXacnPwuWNV9DUjKJLFVyEwMuE331Sqf6cef1mealj4DAsb/tl
         W4yZIPVmswO72YftbeaR0FsUYM1wnnChay+zHhhuLYQ/79mXbVp9Nfe1aIHHfIBVy9Da
         EZlw==
X-Gm-Message-State: APt69E2jZ4WBuKzQ7rikY+xNJ4WBoGvTvlXnJqdqc10BOpHWczezYpiI
        o5ePek531VeLKzkPJxPIFTqn7w==
X-Google-Smtp-Source: ADUXVKINz/wNoQcpZCTDZY+xayVngHHgW9EdBNYT61OV0qlmcQh3uTmF7SWiVOG4iF1FqqufI18Jvw==
X-Received: by 2002:a62:f551:: with SMTP id n78-v6mr4618811pfh.200.1528889612370;
        Wed, 13 Jun 2018 04:33:32 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id h8-v6sm2745370pgq.35.2018.06.13.04.33.24
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Jun 2018 04:33:31 -0700 (PDT)
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
Subject: [PATCH 4/8] clocksource: arm_arch_timer: Register the persistent clock
Date:   Wed, 13 Jun 2018 19:32:31 +0800
Message-Id: <5b450836ee0db88de27d47e43368de02c550425b.1528878545.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1528878545.git.baolin.wang@linaro.org>
References: <cover.1528878545.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register the persistent clock to compensate the suspend time for OS time,
if the ARM counter clocksource will not be stopped in suspend state.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/clocksource/Kconfig          |    1 +
 drivers/clocksource/arm_arch_timer.c |   10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 7f11c6c..5e51fcf 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -308,6 +308,7 @@ config ARC_TIMERS_64BIT
 
 config ARM_ARCH_TIMER
 	bool
+	select PERSISTENT_CLOCK
 	select TIMER_OF if OF
 	select TIMER_ACPI if ACPI
 
diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 57cb2f0..671be63 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -32,6 +32,7 @@
 #include <asm/virt.h>
 
 #include <clocksource/arm_arch_timer.h>
+#include <linux/persistent_clock.h>
 
 #undef pr_fmt
 #define pr_fmt(fmt) "arch_timer: " fmt
@@ -950,6 +951,15 @@ static void __init arch_counter_register(unsigned type)
 
 	/* 56 bits minimum, so we assume worst case rollover */
 	sched_clock_register(arch_timer_read_counter, 56, arch_timer_rate);
+
+	/*
+	 * Register the persistent clock if the clocksource will not be stopped
+	 * in suspend state.
+	 */
+	if (!arch_counter_suspend_stop)
+		persistent_clock_init_and_register(arch_timer_read_counter,
+						   CLOCKSOURCE_MASK(56),
+						   arch_timer_rate, 0);
 }
 
 static void arch_timer_stop(struct clock_event_device *clk)
-- 
1.7.9.5

