Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62F36ECDFB8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:53:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCA9A20880
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 17:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gh/4evC3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCA9A20880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388466AbeGWS4J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 14:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:39400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388181AbeGWS4J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 14:56:09 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D96020854;
        Mon, 23 Jul 2018 17:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532368428;
        bh=3G1xGdphu9qI0r1LczDRmvPjw20Z3aQGDIrH3q6qK2g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gh/4evC3vS5IiSpkzSte+oehRMu1HRtbx2iji6S1tvpRHPt1b4KiR3uafB+RqrW0P
         nWmOlsFTlMHrjmECMH57hlsODEXh48H0n2/rRjDR9dlFom3tthW/HhQvyZ9OSkPevb
         6mo18xWkTB1HeovhT8Fb9S3jWSb0e4iqC6R739nM=
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
Subject: [RFT v2 05/10] ARM: exynos: Define EINT_WAKEUP_MASK registers for S5Pv210 and Exynos5433
Date:   Mon, 23 Jul 2018 19:52:57 +0200
Message-Id: <20180723175302.22535-6-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180723175302.22535-1-krzk@kernel.org>
References: <20180723175302.22535-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

S5Pv210 and Exynos5433/Exynos7 have different address of
EINT_WAKEUP_MASK register.  Rename existing S5P_EINT_WAKEUP_MASK to
avoid confusion and add new ones.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Tomasz Figa <tomasz.figa@gmail.com>
Cc: Sylwester Nawrocki <snawrocki@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 arch/arm/mach-exynos/suspend.c              | 2 +-
 include/linux/soc/samsung/exynos-regs-pmu.h | 6 +++++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-exynos/suspend.c b/arch/arm/mach-exynos/suspend.c
index 0ec52f442b97..991938e19e17 100644
--- a/arch/arm/mach-exynos/suspend.c
+++ b/arch/arm/mach-exynos/suspend.c
@@ -272,7 +272,7 @@ static int exynos5420_cpu_suspend(unsigned long arg)
 static void exynos_pm_set_wakeup_mask(void)
 {
 	/* Set wake-up mask registers */
-	pmu_raw_writel(exynos_get_eint_wake_mask(), S5P_EINT_WAKEUP_MASK);
+	pmu_raw_writel(exynos_get_eint_wake_mask(), EXYNOS_EINT_WAKEUP_MASK);
 	pmu_raw_writel(exynos_irqwake_intmask & ~(1 << 31), S5P_WAKEUP_MASK);
 }
 
diff --git a/include/linux/soc/samsung/exynos-regs-pmu.h b/include/linux/soc/samsung/exynos-regs-pmu.h
index 66dcb9ec273a..eb0d240df7a7 100644
--- a/include/linux/soc/samsung/exynos-regs-pmu.h
+++ b/include/linux/soc/samsung/exynos-regs-pmu.h
@@ -42,7 +42,7 @@
 #define EXYNOS_SWRESET				0x0400
 
 #define S5P_WAKEUP_STAT				0x0600
-#define S5P_EINT_WAKEUP_MASK			0x0604
+#define EXYNOS_EINT_WAKEUP_MASK			0x0604
 #define S5P_WAKEUP_MASK				0x0608
 #define S5P_WAKEUP_MASK2				0x0614
 
@@ -180,6 +180,9 @@
 #define S5P_CORE_WAKEUP_FROM_LOCAL_CFG		(0x3 << 8)
 #define S5P_CORE_AUTOWAKEUP_EN			(1 << 31)
 
+/* Only for S5Pv210 */
+#define S5PV210_EINT_WAKEUP_MASK	0xC004
+
 /* Only for EXYNOS4210 */
 #define S5P_CMU_CLKSTOP_LCD1_LOWPWR	0x1154
 #define S5P_CMU_RESET_LCD1_LOWPWR	0x1174
@@ -641,6 +644,7 @@
 					 | EXYNOS5420_KFC_USE_STANDBY_WFI3)
 
 /* For EXYNOS5433 */
+#define EXYNOS5433_EINT_WAKEUP_MASK				(0x060C)
 #define EXYNOS5433_USBHOST30_PHY_CONTROL			(0x0728)
 #define EXYNOS5433_PAD_RETENTION_AUD_OPTION			(0x3028)
 #define EXYNOS5433_PAD_RETENTION_MMC2_OPTION			(0x30C8)
-- 
2.14.1

