Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7058EECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:54:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1779020883
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:54:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YsJNtprE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1779020883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbeGWS4V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:56:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:39606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388503AbeGWS4U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:56:20 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 36F9620882;
        Mon, 23 Jul 2018 17:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532368439;
        bh=FI3LZgVfT5XftbkDdboHT2jJONeQ0M0ZqghnjUfO2mE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YsJNtprEKO8bzcM9jmL0/YeR9kQa6ldQlBpfAL+Gog0hXPOssAv5GnAAVj29JnYrL
         RLfI6He6LoJq7vrUdNsbbtqcEVfxbIgFuEZLN9Gr6KAptvMzFVdaD7m0k5sxBD8AFo
         R0AjvIaK+dycodPQLH42R11uAyggY5vOT9N2nqhA=
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
Subject: [RFT v2 08/10] ARM: s5pv210: Remove legacy setting of external wakeup interrupts
Date:   Mon, 23 Jul 2018 19:53:00 +0200
Message-Id: <20180723175302.22535-9-krzk@kernel.org>
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
 arch/arm/mach-s5pv210/common.h |  1 -
 arch/arm/mach-s5pv210/pm.c     | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-s5pv210/common.h b/arch/arm/mach-s5pv210/common.h
index 0a188134deae..cb36058bc35e 100644
--- a/arch/arm/mach-s5pv210/common.h
+++ b/arch/arm/mach-s5pv210/common.h
@@ -10,7 +10,6 @@
 #define __ARCH_ARM_MACH_S5PV210_COMMON_H
 
 #ifdef CONFIG_PM_SLEEP
-u32 exynos_get_eint_wake_mask(void);
 void s5pv210_cpu_resume(void);
 void s5pv210_pm_init(void);
 #else
diff --git a/arch/arm/mach-s5pv210/pm.c b/arch/arm/mach-s5pv210/pm.c
index f491249ab658..b336df0c57f3 100644
--- a/arch/arm/mach-s5pv210/pm.c
+++ b/arch/arm/mach-s5pv210/pm.c
@@ -32,6 +32,11 @@ static struct sleep_save s5pv210_core_save[] = {
  */
 static u32 s5pv210_irqwake_intmask = 0xffffffff;
 
+static u32 s5pv210_read_eint_wakeup_mask(void)
+{
+	return __raw_readl(S5P_EINT_WAKEUP_MASK);
+}
+
 /*
  * Suspend helpers.
  */
@@ -59,8 +64,10 @@ static void s5pv210_pm_prepare(void)
 {
 	unsigned int tmp;
 
-	/* Set wake-up mask registers */
-	__raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
+	/*
+	 * Set wake-up mask registers
+	 * S5P_EINT_WAKEUP_MASK is set by pinctrl driver in late suspend.
+	 */
 	__raw_writel(s5pv210_irqwake_intmask, S5P_WAKEUP_MASK);
 
 	/* ensure at least INFORM0 has the resume address */
@@ -89,6 +96,7 @@ static void s5pv210_pm_prepare(void)
  */
 static int s5pv210_suspend_enter(suspend_state_t state)
 {
+	u32 eint_wakeup_mask = s5pv210_read_eint_wakeup_mask();
 	int ret;
 
 	s3c_pm_debug_init();
@@ -96,10 +104,10 @@ static int s5pv210_suspend_enter(suspend_state_t state)
 	S3C_PMDBG("%s: suspending the system...\n", __func__);
 
 	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
-			s5pv210_irqwake_intmask, exynos_get_eint_wake_mask());
+			s5pv210_irqwake_intmask, eint_wakeup_mask);
 
 	if (s5pv210_irqwake_intmask == -1U
-	    && exynos_get_eint_wake_mask() == -1U) {
+	    && eint_wakeup_mask == -1U) {
 		pr_err("%s: No wake-up sources!\n", __func__);
 		pr_err("%s: Aborting sleep\n", __func__);
 		return -EINVAL;
-- 
2.14.1

