Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F6BECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:54:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9885F20854
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:54:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="N/Js02cB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9885F20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbeGWS4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:56:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388503AbeGWS4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:56:24 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68A020880;
        Mon, 23 Jul 2018 17:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532368443;
        bh=LSZ8RPWF8Rc3eM3KGpRy1XMBCsA91VtHyt3LV643lTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N/Js02cBtoXnCyI9B4+xZqjyfAiovv/aXzBLyBNAV9UDUPFz8QwpvGoNY8OSgn7Gk
         ZGQd3fc/UmeqAfmOzXQiZwq+twhIHWe/sWuSYrQP+IwyHBiySiSP6s8crygorGN61u
         9wSjyZpYFXDxO+fknASXtMSrSskG3WodZZ9E+XJY=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>
Subject: [RFT v2 09/10] ARM: exynos: Remove legacy setting of external wakeup interrupts
Date:   Mon, 23 Jul 2018 19:53:01 +0200
Message-Id: <20180723175302.22535-10-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180723175302.22535-1-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Exynos/S5Pv210 pin-controller driver is taking care about setting
the external wakeup interrupts mask, the legacy code can be removed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/common.h  |  2 --
 arch/arm/mach-exynos/suspend.c | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-exynos/common.h b/arch/arm/mach-exynos/common.h
index dcd21bb95e3b..035e51c5f0fc 100644
--- a/arch/arm/mach-exynos/common.h
+++ b/arch/arm/mach-exynos/common.h
@@ -113,8 +113,6 @@ void exynos_firmware_init(void);
 void exynos_set_boot_flag(unsigned int cpu, unsigned int mode);
 void exynos_clear_boot_flag(unsigned int cpu, unsigned int mode);
 
-extern u32 exynos_get_eint_wake_mask(void);
-
 #ifdef CONFIG_PM_SLEEP
 extern void __init exynos_pm_init(void);
 #else
diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 991938e19e17..554d6ea2cb3c 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -88,6 +88,11 @@ static const struct exynos_wkup_irq exynos5250_wkup_irq[] = {
 	{ /* sentinel */ },
 };
 
+static u32 exynos_read_eint_wakeup_mask(void)
+{
+	return pmu_raw_readl(EXYNOS_EINT_WAKEUP_MASK);
+}
+
 static int exynos_irq_set_wake(struct irq_data *data, unsigned int state)
 {
 	const struct exynos_wkup_irq *wkup_irq;
@@ -271,8 +276,10 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 
 static void exynos_pm_set_wakeup_mask(void)
 {
-	/* Set wake-up mask registers */
-	pmu_raw_writel(exynos_get_eint_wake_mask(), EXYNOS_EINT_WAKEUP_MASK);
+	/*
+	 * Set wake-up mask registers
+	 * EXYNOS_EINT_WAKEUP_MASK is set by pinctrl driver in late suspend.
+	 */
 	pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
 }
 
@@ -482,6 +489,7 @@ static void exynos5420_pm_resume(void)
 
 static int exynos_suspend_enter(suspend_state_t state)
 {
+	u32 eint_wakeup_mask = exynos_read_eint_wakeup_mask();
 	int ret;
 
 	s3c_pm_debug_init();
@@ -489,10 +497,10 @@ static int exynos_suspend_enter(suspend_state_t state)
 	S3C_PMDBG("%s: suspending the system...\n", __func__);
 
 	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
-			exynos_irqwake_intmask, exynos_get_eint_wake_mask());
+		  exynos_irqwake_intmask, eint_wakeup_mask);
 
 	if (exynos_irqwake_intmask == -1U
-	    && exynos_get_eint_wake_mask() == -1U) {
+	    && eint_wakeup_mask == EXYNOS_EINT_WAKEUP_MASK_DISABLED) {
 		pr_err("%s: No wake-up sources!\n", __func__);
 		pr_err("%s: Aborting sleep\n", __func__);
 		return -EINVAL;
-- 
2.14.1

