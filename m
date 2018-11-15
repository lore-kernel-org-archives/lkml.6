Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6869C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4ECA620869
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:47:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="SKUE2Mf6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4ECA620869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389102AbeKPI46 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:56:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55522 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbeKPI45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:56:57 -0500
Received: by mail-wm1-f68.google.com with SMTP id y139so2964183wmc.5
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 14:47:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Yai6kOkdbw3N837BcqOINMGeryz33QgiE98cWtBiMiw=;
        b=SKUE2Mf66cSy/0LTyTms94ffN6PIr05OrUiDnrmvlDRnQ3B/i58fsSL9GoOGlYz70Z
         ORtruLU4Tb8vUHteQc2IGPYKEQEeB+QPzbhKp3RAJUjNHljS9efZ5t88/szf0OttfZ3E
         icp6+I16i7nTFAunfh8jEr2uiy6yoUgBSadMifwDgN5GnBsBawvHzAmm9A48mE8KN3UX
         KIUwphhcpckYkGdaJgik77SEc07VZ+/iQeqliEDUT3VtP2sbYZQk8ARiOyLQQPfATGQp
         y9t8h/V19dSCqGAu/qXBbeaT4LAIJICcG7QGz4eY66KRyysDuqaXGWwhCnFcn4wPwF6+
         IreQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Yai6kOkdbw3N837BcqOINMGeryz33QgiE98cWtBiMiw=;
        b=b1I+MZq5GXEMzciW/u6D9YAF0A7l78lloyclwrdSW/ifb5xqaKFbqrSNB3YY27jnIe
         lgzrD3xxg6RDMPnirx16wY1CML3jQJ/ODaJ5Q7UYyDTia/X608B+tpZISlSu/JjupstJ
         Xw8s7QCKCMArG96aUZ734F2HxiSTkaVss7TwA2FSrBCy8lsAfJGa0RTu5n+ZP0dWU0qS
         p1iI2HmbnHe+yaSNNbyP1wRi9s0fB06cFlmOpa0joqfkZ23yG5d+pDVIYpmqkwrVDpb4
         40Pz3oM8DUT8+tJSDYzEDW7mdOtdpui6ojzBgZpQhYU79pIXXCVZjS01yQU4MVS+n6zm
         51cA==
X-Gm-Message-State: AGRZ1gKiUSFChHi5WrVxZ8BRKOU1kLles+iCi19qDnc7d5kLlYcRLKtu
        +xuURzuN/GEstNlJhj2Zszs=
X-Google-Smtp-Source: AJdET5dtW1pKhEhExwPvAOXbAeB0p+JXzBZS8H+j+H9I2KdOULe0LBpcnyWv6kXHGkWTPm+B93M1RQ==
X-Received: by 2002:a1c:2283:: with SMTP id i125-v6mr7052232wmi.42.1542322029253;
        Thu, 15 Nov 2018 14:47:09 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x142-v6sm50950160wmd.20.2018.11.15.14.47.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:47:08 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 1/2] clocksource: meson6_timer: use register names from the datasheet
Date:   Thu, 15 Nov 2018 23:46:56 +0100
Message-Id: <20181115224657.14736-2-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
References: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
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
 drivers/clocksource/meson6_timer.c | 108 +++++++++++++++++------------
 1 file changed, 64 insertions(+), 44 deletions(-)

diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 92f20991a937..23c7638e2bb3 100644
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
@@ -20,80 +22,96 @@
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
-
-#define TIMER_CED_INPUT_MASK	(3UL << TIMER_INPUT_BIT(CED_ID))
-#define TIMER_CSD_INPUT_MASK	(7UL << TIMER_INPUT_BIT(CSD_ID))
-
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
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_SYSTEM_CLOCK	0x0
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_1US		0x1
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_10US		0x2
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_100US		0x3
+#define MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_1MS		0x4
+#define MESON_ISA_TIMER_MUX_TIMERD_INPUT_CLOCK_MASK		GENMASK(7, 6)
+#define MESON_ISA_TIMER_MUX_TIMERC_INPUT_CLOCK_MASK		GENMASK(5, 4)
+#define MESON_ISA_TIMER_MUX_TIMERB_INPUT_CLOCK_MASK		GENMASK(3, 2)
+#define MESON_ISA_TIMER_MUX_TIMERA_INPUT_CLOCK_MASK		GENMASK(1, 0)
+#define MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_1US		0x0
+#define MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_10US		0x1
+#define MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_100US		0x0
+#define MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_1MS		0x3
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
@@ -144,22 +162,24 @@ static int __init meson6_timer_init(struct device_node *node)
 	}
 
 	/* Set 1us for timer E */
-	val = readl(timer_base + TIMER_ISA_MUX);
-	val &= ~TIMER_CSD_INPUT_MASK;
-	val |= TIMER_CSD_UNIT_1US << TIMER_INPUT_BIT(CSD_ID);
-	writel(val, timer_base + TIMER_ISA_MUX);
+	val = readl(timer_base + MESON_ISA_TIMER_MUX);
+	val &= ~MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_MASK;
+	val |= FIELD_PREP(MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_MASK,
+			  MESON_ISA_TIMER_MUX_TIMERE_INPUT_CLOCK_1US);
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
+			  MESON_ISA_TIMER_MUX_TIMERABCD_INPUT_CLOCK_1US);
+	writel(val, timer_base + MESON_ISA_TIMER_MUX);
 
 	/* Stop the timer A */
-	meson6_clkevt_time_stop(CED_ID);
+	meson6_clkevt_time_stop();
 
 	ret = setup_irq(irq, &meson6_timer_irq);
 	if (ret) {
-- 
2.19.1

