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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E864C04EBF
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5837820869
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 22:47:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="FWd4RUOR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5837820869
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389132AbeKPI47 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 03:56:59 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52974 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbeKPI46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 03:56:58 -0500
Received: by mail-wm1-f65.google.com with SMTP id r11-v6so20277902wmb.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Nov 2018 14:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GMPyNiqLjvHcd9Iqda1trGeUXVz09DqMlOTmyPfaoFc=;
        b=FWd4RUORdm/F2gAsZfiI6Msn7lYVHAyTvaiTVBwzxlhhjMZfSaMMTyLRsXcSs3FHvW
         TuER3cVrfbXfTCS0J1Gu8csKLVVQ0R0kMxqxQzR0JqA30onJ3FrIWkIwB8Q2Ibz31JL5
         NA12VozX24M3wXibA04m5SEA6sh32yzlMYPwFlsKGhmu4R+JjYOHR3zBv6Zzx04tFlM+
         79J5Qhwlq7RJE/F2S7O/ajASU9RK7msP/DDTn5o4FqkArppnpz7bUN1RfP76d3TJMbNF
         YwjtWLWGwkaJCdTOByd/3TeToNgW9rZwEuTBHyWjxg+/pU768/6Cq5c1RVhJUrbe0NaP
         IvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GMPyNiqLjvHcd9Iqda1trGeUXVz09DqMlOTmyPfaoFc=;
        b=N8Ct4XFj4/Kq2fPZ4TGl7pGeVl27RKsYYRBopnS+T5d3f5PrtEYeIs04NnAdJTEIoG
         rNK6dVjQZSnVl+H4B1bIv9c2R2cMFv7bJ0kH1bB9EIB3y4+YHaEcITVrF4SRS60oMSJk
         Ajyk67y7fR/Qdf1HW09uipEZQv+RbjhmsXNN3rJJggxqw/CnQSLG9o9/HG6Hpn5MaQbv
         Oq3/yD+hf7wqOTZFBng5QLy4GJDaPP0UnWRVqvt1IlxkBg2LxNRxZ0Zb8xaSnod0t/fi
         Mn/F/qSWwteC4pXFKO+NTunftTR5oZUJe6Wqao98RNY2UTxQR9Bqf3cR8rcUP0oiAJe+
         2aEg==
X-Gm-Message-State: AGRZ1gKXWrtSQ5bcR8CsAM/DDH8loaUDhJVg7JyBKDpfbr5mAWdToxAK
        LFyoNv++UYUD7Qv/RFJO1X4=
X-Google-Smtp-Source: AJdET5e5km//vYh73YTXArS0mCou7BpCnOpL9oD51y3M942BPQik2Kcw1qT6ihtnQpmgR/ZEutrBRA==
X-Received: by 2002:a1c:9706:: with SMTP id z6-v6mr599196wmd.86.1542322030464;
        Thu, 15 Nov 2018 14:47:10 -0800 (PST)
Received: from blackbox.darklights.net (p200300DCD717A100B85ACE585A885C51.dip0.t-ipconnect.de. [2003:dc:d717:a100:b85a:ce58:5a88:5c51])
        by smtp.googlemail.com with ESMTPSA id x142-v6sm50950160wmd.20.2018.11.15.14.47.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Nov 2018 14:47:09 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 2/2] clocksource: meson6_timer: implement ARM delay timer
Date:   Thu, 15 Nov 2018 23:46:57 +0100
Message-Id: <20181115224657.14736-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
References: <20181115224657.14736-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement an ARM delay timer to be used for udelay(). This allows us to
skip the delay loop calibration at boot.

With this patch udelay() is now independent of CPU frequency changes.
This is a good thing on Meson8, Meson8b and Meson8m2 because changing
the CPU frequency requires running the CPU clock off the XTAL while
changing the PLL or it's dividers. After changing the CPU clocks we need
to wait a few usecs for the clock to become stable. So having an
udelay() implementation that doesn't depend on the CPU frequency is
beneficial.

Suggested-by: Jianxin Pan <jianxin.pan@amlogic.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clocksource/meson6_timer.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/clocksource/meson6_timer.c b/drivers/clocksource/meson6_timer.c
index 23c7638e2bb3..84bd9479c3f8 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -22,6 +22,10 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#ifdef CONFIG_ARM
+#include <linux/delay.h>
+#endif
+
 #define MESON_ISA_TIMER_MUX					0x00
 #define MESON_ISA_TIMER_MUX_TIMERD_EN				BIT(19)
 #define MESON_ISA_TIMER_MUX_TIMERC_EN				BIT(18)
@@ -54,6 +58,18 @@
 
 static void __iomem *timer_base;
 
+#ifdef CONFIG_ARM
+static unsigned long meson6_read_current_timer(void)
+{
+	return readl_relaxed(timer_base + MESON_ISA_TIMERE);
+}
+
+static struct delay_timer meson6_delay_timer = {
+	.read_current_timer = meson6_read_current_timer,
+	.freq = 1000 * 1000,
+};
+#endif
+
 static u64 notrace meson6_timer_sched_read(void)
 {
 	return (u64)readl(timer_base + MESON_ISA_TIMERE);
@@ -192,6 +208,12 @@ static int __init meson6_timer_init(struct device_node *node)
 
 	clockevents_config_and_register(&meson6_clockevent, USEC_PER_SEC,
 					1, 0xfffe);
+
+#ifdef CONFIG_ARM
+	/* Also use MESON_ISA_TIMERE for delays */
+	register_current_timer_delay(&meson6_delay_timer);
+#endif
+
 	return 0;
 }
 TIMER_OF_DECLARE(meson6, "amlogic,meson6-timer",
-- 
2.19.1

