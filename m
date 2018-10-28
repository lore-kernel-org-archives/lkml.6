Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A46ECDE46
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:55:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7225C20843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:55:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="rHY3Tter"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7225C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbeJ1Vjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:39:52 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55862 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbeJ1Vjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:39:51 -0400
Received: by mail-wm1-f65.google.com with SMTP id s10-v6so5548382wmc.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 05:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+uso9Ozi2wPAuGZmooAksNGFtRAXXFWFpj8R8QZQcQY=;
        b=rHY3Tter6Fb0Dwp8XneSYCUsQpNLF15iKBiXqtoaHKN+4jevMyuREpxcXKF9uYcG4/
         a3Rgp+rky6z8v9w4TUv/3GQlHXT/vi1BsS1eTwafvQfRD8cBnyQR+Ne2dQQoECxj7t4R
         B0Z2wzceoS/MZYsdumf3ly3lSRnOxms4sBxtFyR80+SstzQzVnLnB69LKZE84jVm/HqE
         DrnTCydS82xPpW8JwRdVPRJfXJBQHltEtGnaourwVzPztJy6vjtWkxciIeVnc5R7Od1i
         ctemHSLZLJmlmKtZ9qtsRBD5v5oKFeyAXa5O+2LNdYyDKPCaOLqb0OshGKkdoQqnrTIr
         kdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+uso9Ozi2wPAuGZmooAksNGFtRAXXFWFpj8R8QZQcQY=;
        b=RVJwrkLKTYphuDm5QhdgnNElXkg0lX7FzV3MzZSCi2x5CdqEqnG6WLsi61+HnTMpnH
         SuRuKGuHmd8sw4yKGQvQajnCz0fDIWWBIvXTEgWIfH/vyOzoK+4ghT4LJxdhw6H8HKXq
         25f3jqsuOy53KMLqxuSYKmZPHHw3baCq1KPhJkFC3qzxkK1H+d73gkowa77hAWSWMIKL
         HtlWOYYIShu0LTANoYc+NlmWl3+2fZDZuIdjzG+VZ3DW21FfQQ5bbzFDXB+cDJdS4Va7
         4vZjv+b3yV245kYU/DlXZXSj2SqAlOxgV88tnGEUeZgciZevgkUtE+QSantJyGO3YmLs
         Q2Vg==
X-Gm-Message-State: AGRZ1gKlSAVt9oDTmQHQlYYEEwmuFyJo7dVhmHCkKOkuybR3akwS7zb4
        mK7K+t/PtJDlPRt6Z+Tb2Is=
X-Google-Smtp-Source: AJdET5e3x0NXEiTH9nbYaj1j08PjQrqKi0tyZgbYHohu4PUwv+a8+zUwvEBDBpmxJDUiMqmAbigobQ==
X-Received: by 2002:a1c:ce0e:: with SMTP id e14-v6mr10474129wmg.45.1540731315393;
        Sun, 28 Oct 2018 05:55:15 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7072200691979D1FB980407.dip0.t-ipconnect.de. [2003:dc:d707:2200:6919:79d1:fb98:407])
        by smtp.googlemail.com with ESMTPSA id u10-v6sm13759388wrt.59.2018.10.28.05.55.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 05:55:14 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 1/2] clocksource: meson6_timer: use register names from the datasheet
Date:   Sun, 28 Oct 2018 13:55:00 +0100
Message-Id: <20181028125501.17336-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
References: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the driver use the names from S805 datasheet for the
preprocessor #defines. This makes it easier to spot that the driver
currently only supports Timer A (as clockevent with interrupt support)
and Timer E (as clocksource without interrupts). Timer B, C and D (which
are similar to Timer A) are currently not supported by the driver.

While here, this also removes the internal "CED_ID" and "CSD_ID" defines
which are used to identify the timer. These IDs are not described in the
datasheet and thus make it harder to compare the code to what's written
in the datasheet.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clocksource/meson6_timer.c | 110 ++++++++++++++++++-----------
 1 file changed, 68 insertions(+), 42 deletions(-)

diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 92f20991a937..c622135bee9d 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -10,6 +10,8 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/clockchips.h>
 #include <linux/interrupt.h>
@@ -20,80 +22,102 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
-#define CED_ID			0
-#define CSD_ID			4
-
-#define TIMER_ISA_MUX		0
-#define TIMER_ISA_VAL(t)	(((t) + 1) << 2)
-
-#define TIMER_INPUT_BIT(t)	(2 * (t))
-#define TIMER_ENABLE_BIT(t)	(16 + (t))
-#define TIMER_PERIODIC_BIT(t)	(12 + (t))
+enum meson6_timera_input_clock {
+	MESON_TIMERA_CLOCK_1US = 0x0,
+	MESON_TIMERA_CLOCK_10US = 0x1,
+	MESON_TIMERA_CLOCK_100US = 0x2,
+	MESON_TIMERA_CLOCK_1MS = 0x3,
+};
 
-#define TIMER_CED_INPUT_MASK	(3UL << TIMER_INPUT_BIT(CED_ID))
-#define TIMER_CSD_INPUT_MASK	(7UL << TIMER_INPUT_BIT(CSD_ID))
+enum meson6_timere_input_clock {
+	MESON_TIMERE_CLOCK_SYSTEM_CLOCK = 0x0,
+	MESON_TIMERE_CLOCK_1US = 0x1,
+	MESON_TIMERE_CLOCK_10US = 0x2,
+	MESON_TIMERE_CLOCK_100US = 0x3,
+	MESON_TIMERE_CLOCK_1MS = 0x4,
+};
 
-#define TIMER_CED_UNIT_1US	0
-#define TIMER_CSD_UNIT_1US	1
+#define MESON_ISA_TIMER_MUX					0x00
+#define MESON_ISA_TIMER_MUX_TIMERD_EN				BIT(19)
+#define MESON_ISA_TIMER_MUX_TIMERC_EN				BIT(18)
+#define MESON_ISA_TIMER_MUX_TIMERB_EN				BIT(17)
+#define MESON_ISA_TIMER_MUX_TIMERA_EN				BIT(16)
+#define MESON_ISA_TIMER_MUX_TIMERD_MODE				BIT(15)
+#define MESON_ISA_TIMER_MUX_TIMERC_MODE				BIT(14)
+#define MESON_ISA_TIMER_MUX_TIMERB_MODE				BIT(13)
+#define MESON_ISA_TIMER_MUX_TIMERA_MODE				BIT(12)
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_MASK		GENMASK(10, 8)
+#define MESON_ISA_TIMER_MUX_TIMERD_INPUT_CLOCK_MASK		GENMASK(7, 6)
+#define MESON_ISA_TIMER_MUX_TIMERC_INPUT_CLOCK_MASK		GENMASK(5, 4)
+#define MESON_ISA_TIMER_MUX_TIMERB_INPUT_CLOCK_MASK		GENMASK(3, 2)
+#define MESON_ISA_TIMER_MUX_TIMERA_INPUT_CLOCK_MASK		GENMASK(1, 0)
+
+#define MESON_ISA_TIMERA					0x04
+#define MESON_ISA_TIMERB					0x08
+#define MESON_ISA_TIMERC					0x0c
+#define MESON_ISA_TIMERD					0x10
+#define MESON_ISA_TIMERE					0x14
 
 static void __iomem *timer_base;
 
 static u64 notrace meson6_timer_sched_read(void)
 {
-	return (u64)readl(timer_base + TIMER_ISA_VAL(CSD_ID));
+	return (u64)readl(timer_base + MESON_ISA_TIMERE);
 }
 
-static void meson6_clkevt_time_stop(unsigned char timer)
+static void meson6_clkevt_time_stop(void)
 {
-	u32 val = readl(timer_base + TIMER_ISA_MUX);
+	u32 val = readl(timer_base + MESON_ISA_TIMER_MUX);
 
-	writel(val & ~TIMER_ENABLE_BIT(timer), timer_base + TIMER_ISA_MUX);
+	writel(val & ~MESON_ISA_TIMER_MUX_TIMERA_EN,
+	       timer_base + MESON_ISA_TIMER_MUX);
 }
 
-static void meson6_clkevt_time_setup(unsigned char timer, unsigned long delay)
+static void meson6_clkevt_time_setup(unsigned long delay)
 {
-	writel(delay, timer_base + TIMER_ISA_VAL(timer));
+	writel(delay, timer_base + MESON_ISA_TIMERA);
 }
 
-static void meson6_clkevt_time_start(unsigned char timer, bool periodic)
+static void meson6_clkevt_time_start(bool periodic)
 {
-	u32 val = readl(timer_base + TIMER_ISA_MUX);
+	u32 val = readl(timer_base + MESON_ISA_TIMER_MUX);
 
 	if (periodic)
-		val |= TIMER_PERIODIC_BIT(timer);
+		val |= MESON_ISA_TIMER_MUX_TIMERA_MODE;
 	else
-		val &= ~TIMER_PERIODIC_BIT(timer);
+		val &= ~MESON_ISA_TIMER_MUX_TIMERA_MODE;
 
-	writel(val | TIMER_ENABLE_BIT(timer), timer_base + TIMER_ISA_MUX);
+	writel(val | MESON_ISA_TIMER_MUX_TIMERA_EN,
+	       timer_base + MESON_ISA_TIMER_MUX);
 }
 
 static int meson6_shutdown(struct clock_event_device *evt)
 {
-	meson6_clkevt_time_stop(CED_ID);
+	meson6_clkevt_time_stop();
 	return 0;
 }
 
 static int meson6_set_oneshot(struct clock_event_device *evt)
 {
-	meson6_clkevt_time_stop(CED_ID);
-	meson6_clkevt_time_start(CED_ID, false);
+	meson6_clkevt_time_stop();
+	meson6_clkevt_time_start(false);
 	return 0;
 }
 
 static int meson6_set_periodic(struct clock_event_device *evt)
 {
-	meson6_clkevt_time_stop(CED_ID);
-	meson6_clkevt_time_setup(CED_ID, USEC_PER_SEC / HZ - 1);
-	meson6_clkevt_time_start(CED_ID, true);
+	meson6_clkevt_time_stop();
+	meson6_clkevt_time_setup(USEC_PER_SEC / HZ - 1);
+	meson6_clkevt_time_start(true);
 	return 0;
 }
 
 static int meson6_clkevt_next_event(unsigned long evt,
 				    struct clock_event_device *unused)
 {
-	meson6_clkevt_time_stop(CED_ID);
-	meson6_clkevt_time_setup(CED_ID, evt);
-	meson6_clkevt_time_start(CED_ID, false);
+	meson6_clkevt_time_stop();
+	meson6_clkevt_time_setup(evt);
+	meson6_clkevt_time_start(false);
 
 	return 0;
 }
@@ -144,22 +168,24 @@ static int __init meson6_timer_init(struct device_node *node)
 	}
 
 	/* Set 1us for timer E */
-	val = readl(timer_base + TIMER_ISA_MUX);
-	val &= ~TIMER_CSD_INPUT_MASK;
-	val |= TIMER_CSD_UNIT_1US << TIMER_INPUT_BIT(CSD_ID);
-	writel(val, timer_base + TIMER_ISA_MUX);
+	val = readl(timer_base + MESON_ISA_TIMER_MUX);
+	val &= ~MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_MASK;
+	val |= FIELD_PREP(MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_MASK,
+			  MESON_TIMERE_CLOCK_1US);
+	writel(val, timer_base + MESON_ISA_TIMER_MUX);
 
 	sched_clock_register(meson6_timer_sched_read, 32, USEC_PER_SEC);
-	clocksource_mmio_init(timer_base + TIMER_ISA_VAL(CSD_ID), node->name,
+	clocksource_mmio_init(timer_base + MESON_ISA_TIMERE, node->name,
 			      1000 * 1000, 300, 32, clocksource_mmio_readl_up);
 
 	/* Timer A base 1us */
-	val &= ~TIMER_CED_INPUT_MASK;
-	val |= TIMER_CED_UNIT_1US << TIMER_INPUT_BIT(CED_ID);
-	writel(val, timer_base + TIMER_ISA_MUX);
+	val &= ~MESON_ISA_TIMER_MUX_TIMERA_INPUT_CLOCK_MASK;
+	val |= FIELD_PREP(MESON_ISA_TIMER_MUX_TIMERA_INPUT_CLOCK_MASK,
+			  MESON_TIMERA_CLOCK_1US);
+	writel(val, timer_base + MESON_ISA_TIMER_MUX);
 
 	/* Stop the timer A */
-	meson6_clkevt_time_stop(CED_ID);
+	meson6_clkevt_time_stop();
 
 	ret = setup_irq(irq, &meson6_timer_irq);
 	if (ret) {
-- 
2.19.1

