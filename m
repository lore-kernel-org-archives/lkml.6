Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FE3CC468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B8B12084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 16:01:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1Ritjcpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B8B12084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbeGSQpn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:60120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732090AbeGSQpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:45:42 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2FABD2084E;
        Thu, 19 Jul 2018 16:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532016112;
        bh=FVHpr9r//JYD/0uePoYwYWwe9stYrK8DHRwDirQYf6s=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=1Ritjcpoy1z+8lKoVau46Oc+Rt8pkoI3stMAYsODG6aMpq9FKFSyu+BQ1JrvCfEdo
         7C4m/k9euhxA175QdHHL5XPksvF4wgpK9Hv1uXGaZXqu25q/sm6V/H1Ji0Xu0vEgXx
         DxAsYQ9qAbuf0egUS4Kx9RcX+ohYmSNsE8WmFFac=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Pankaj Dubey <pankaj.dubey@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 08/10] ARM: s5pv210: Remove legacy setting of external wakeup interrupts
Date:   Thu, 19 Jul 2018 18:00:48 +0200
Message-Id: <20180719160050.22566-9-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180719160050.22566-1-krzk@kernel.org>
References: <20180719160050.22566-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Exynos/S5Pv210 pin-controller driver is taking care about setting
the external wakeup interrupts mask, the legacy code can be removed.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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

