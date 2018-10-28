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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA9CC6786F
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:55:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B71E120843
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 12:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="Z7IWfZcP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B71E120843
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbeJ1Vjx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 17:39:53 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54715 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbeJ1Vjw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 17:39:52 -0400
Received: by mail-wm1-f66.google.com with SMTP id r63-v6so5555490wma.4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Oct 2018 05:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkqiSK0foukgf/wyUrP43W1JLOOI7NiMe4dW1YSf01k=;
        b=Z7IWfZcPcB/PNywoYxW/PWEV03Ypu5mWL0eY1bCC+X3r+BP99BfoGGhcKQA7pl7Q7y
         /5lVMTeT4PokHF3gUNtwNJsRtm89a5ctfXv9b+U7YyAB+9UWDmYzg9RtgOQbbPpLReRD
         K/5Y5mEtemcD5PeIvgFTBiCNGzm3R8BBgJhlF8vaBqP7BnXPDpzNDkR7FgCbeCm+Mkt/
         u7W3Xt3vsfyGtDjUCpDXMADD186INcbV85TSXjIlN9iWsK90Xb2/RCthxxkScwrnFVea
         b1wqhdPm7AsucPhx4JwhdyvS+CtNlks54LE/eYtEaVc0e0vpUGzfmtBsZI0oUVJbyWmW
         mmbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkqiSK0foukgf/wyUrP43W1JLOOI7NiMe4dW1YSf01k=;
        b=mmZSZVL8pc7OjxQNNSdzfJSPzSXlMIysdo3nFcI6czDGgFCW1vHJKlHDENJgDrhfth
         ldQlyq3Smhx6foAe46WreyQAKCDff37DRYltR191aQy8A430lh6iDdYSKDoLMsZoXM3y
         NhGF1TzWGSisF9ZTO/7+LlUSRn4D0g9XJYj2EBwQCVhW3G2IVWJ6bW4Qgmgl21nHT93t
         NNgUBbWNvJU+n+nkcIDC7utkIoINvyx7TNu5Tugl34fBLmJ/C4t12a0qv5ZUPprVKqAI
         hcrS+0da24BIA4p6CWDAs421rydPcwbHb3dBt1mMZftXxuU2KBXHVh0m+26y0PWFgwrT
         wc3w==
X-Gm-Message-State: AGRZ1gLkiXplJSSQoQLw7IBzUqG2ZZYhr2NKoz0p81ZQKUV3OhSrnaef
        pmQoEokfhzaPtTRjyhK5dag=
X-Google-Smtp-Source: AJdET5fNaBy49wFoVlhlhHSMueD4TpIheu+8OV97VsJV+9DxdBtIU+NJ0UVQP41SqmDOxXSw0prkjg==
X-Received: by 2002:a1c:a794:: with SMTP id q142-v6mr11517090wme.77.1540731316600;
        Sun, 28 Oct 2018 05:55:16 -0700 (PDT)
Received: from blackbox.darklights.net (p200300DCD7072200691979D1FB980407.dip0.t-ipconnect.de. [2003:dc:d707:2200:6919:79d1:fb98:407])
        by smtp.googlemail.com with ESMTPSA id u10-v6sm13759388wrt.59.2018.10.28.05.55.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Oct 2018 05:55:15 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, daniel.lezcano@linaro.org
Cc:     linux-arm-kernel@lists.infradead.org, khilman@baylibre.com,
        carlo@caione.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH 2/2] clocksource: meson6_timer: implement ARM delay timer
Date:   Sun, 28 Oct 2018 13:55:01 +0100
Message-Id: <20181028125501.17336-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
References: <20181028125501.17336-1-martin.blumenstingl@googlemail.com>
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
index c622135bee9d..5ee2a575069b 100644
--- a/drivers/clocksource/meson6_timer.c
+++ b/drivers/clocksource/meson6_timer.c
@@ -22,6 +22,10 @@
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
 
+#ifdef CONFIG_ARM
+#include <linux/delay.h>
+#endif
+
 enum meson6_timera_input_clock {
 	MESON_TIMERA_CLOCK_1US = 0x0,
 	MESON_TIMERA_CLOCK_10US = 0x1,
@@ -60,6 +64,18 @@ enum meson6_timere_input_clock {
 
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
@@ -198,6 +214,12 @@ static int __init meson6_timer_init(struct device_node *node)
 
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

