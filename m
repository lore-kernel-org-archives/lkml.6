Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 689A1C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E77B520644
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 13:50:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="mwDARhWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E77B520644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbeJOVgU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 17:36:20 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57395 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726499AbeJOVgU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 17:36:20 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181015135056euoutp0184f0ae1723bb7867f4a00f28af3af0e9~dzHZ05Ow51779517795euoutp01Y
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 13:50:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181015135056euoutp0184f0ae1723bb7867f4a00f28af3af0e9~dzHZ05Ow51779517795euoutp01Y
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539611456;
        bh=Gm0C69trxVMoJDON1Jonkjlvfh9C+/oiS8Qkx4Fi+B8=;
        h=To:Cc:From:Subject:Date:References:From;
        b=mwDARhWWW1LMCDDRNP4mFHRHsOxS7FlmYtpo9GWh8Uum6d5a5kkryM3s1cymnnnLW
         1RTnbPyZ+B5rNjwsPJ5TYdSTdhQ5Lagrd2ed3fVj+Q3D4KV+u3dQhlfVsoJBy3pOAv
         1CCmlYeWQWXbQIiWCTm21BBUu6vFVhpdvG3BrI9o=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181015135056eucas1p23b4dc7c6425e1abd16f52a303d03bd2b~dzHZOOlQC0056600566eucas1p2V;
        Mon, 15 Oct 2018 13:50:56 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id C5.6C.04294.F3B94CB5; Mon, 15
        Oct 2018 14:50:55 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677~dzHYfFW2j0676906769eucas1p2c;
        Mon, 15 Oct 2018 13:50:55 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181015135055eusmtrp27dd002fe3df5e2f4bcc03a6f388b04c5~dzHYQpVDJ0360603606eusmtrp2s;
        Mon, 15 Oct 2018 13:50:55 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-4f-5bc49b3f5cca
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 59.1C.04128.E3B94CB5; Mon, 15
        Oct 2018 14:50:55 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181015135054eusmtip1da44b949469a0afdf338c5a8aa8c1f1d~dzHX5o-lG0081300813eusmtip1l;
        Mon, 15 Oct 2018 13:50:54 +0000 (GMT)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v2] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
Date:   Mon, 15 Oct 2018 15:50:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprLKsWRmVeSWpSXmKPExsWy7djP87r2s49EG3w5YmSxccZ6Vov+x6+Z
        Lc6f38BusenxNVaLy7vmsFnMOL+PyeLQ1L2MDuwel69dZPbYtKqTzWPzknqPvi2rGD0+b5IL
        YI3isklJzcksSy3St0vgypgw4TdzwUfxik/7nzE2ME4U6WLk5JAQMJHo3PuGtYuRi0NIYAWj
        xKbDa1kgnC+MEm1/VzNCOJ+BMtMWMncxcoC1fL5TAxFfzihx4d8CZgjnPaPEgfN7WUHmigho
        Slz/+x1sLrPAK0aJhtl7mUASbAJWEhPbVzGC2MICCRKz731mA7FZBFQlpm7sYAHZICoQIdF/
        Rh0kzCsgKHFy5hMWEJtZQF5i+9s5YMskBLrZJU4f+8AMUVQmsWXLVUaI61wkFj/gg/hNWOLV
        8S3sELaMxP+d85kgeqczSrz5tZQFwlnPKLHmzDEmiCpricPHL7KCDGIG+mD9Ln2IsKPEjmcT
        oebzSdx4KwhxD5/EpG3ToYHCK9HRJgRRrSaxYdkGNpi1XTtXMkPYHhIty6eD2UICsRIrDq1h
        nsCoMAvJl7OQfDkL4YYFjMyrGMVTS4tz01OLjfJSy/WKE3OLS/PS9ZLzczcxAhPN6X/Hv+xg
        3PUn6RCjAAejEg+vAM+RaCHWxLLiytxDjBIczEoivBIhh6KFeFMSK6tSi/Lji0pzUosPMUpz
        sCiJ8y6btzFaSCA9sSQ1OzW1ILUIJsvEwSnVwDhlRsLjVKMJhzKW+VZelZJjYxC+4nBd7cbW
        cLeYrp55zMEWRtsPXHYSSuWcvXJX0FGuC/ffmbPcNp8pmu995drBhVdCd6/VD9GI/lhQvTM1
        IUpEU2oJV7et2oeu/gPGrrx7mDm+ORl7mCsvO+/33Ej1tULlXMF0sV+f10UbHG79PuVm/WZ/
        VyWW4oxEQy3mouJEAFd0TJkwAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupikeLIzCtJLcpLzFFi42I5/e/4XV372UeiDXpdLTbOWM9q0f/4NbPF
        +fMb2C02Pb7GanF51xw2ixnn9zFZHJq6l9GB3ePytYvMHptWdbJ5bF5S79G3ZRWjx+dNcgGs
        UXo2RfmlJakKGfnFJbZK0YYWRnqGlhZ6RiaWeobG5rFWRqZK+nY2Kak5mWWpRfp2CXoZEyb8
        Zi74KF7xaf8zxgbGiSJdjBwcEgImEp/v1HQxcnEICSxllNi1qZMFIi4jcXx9WRcjJ5ApLPHn
        WhcbRM1bRonjHz+xgSREBDQlrv/9zgqSYBZ4xSixZ+J5RpAEm4CVxMT2VWC2sECCxOx7n8Ea
        eAXsJB4fO8UEYrMIqEpM3djBAmKLCkRI3HoIYfMKCEqcnPkEzGYWUJf4M+8SM4QtL7H97Rzm
        CYz8s5CUzUJSNgtJ2QJG5lWMIqmlxbnpucVGesWJucWleel6yfm5mxiB8bDt2M8tOxi73gUf
        YhTgYFTi4RXgORItxJpYVlyZe4hRgoNZSYRXIuRQtBBvSmJlVWpRfnxRaU5q8SFGU6DDJzJL
        iSbnA2M1ryTe0NTQ3MLS0NzY3NjMQkmc97xBZZSQQHpiSWp2ampBahFMHxMHp1QDo/g/IaGy
        f9vOP7b1mGAjeFn33dW9p7Uy+i/lOJ9NN+nZcql3ucf6OfpKp3n0FVOYYmP/xzXHl89gsT3d
        /2d9iPJWvnL9X7rPH9ad8wmy27T/xwrppyceB3N3BEyPL/gVxde7KnHZgfQLWlev6v252bb5
        jtQrk6dmj398+H7uj1m/zH71wx8mayixFGckGmoxFxUnAgA1ay4WnQIAAA==
Message-Id: <20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677~dzHYfFW2j0676906769eucas1p2c@eucas1p2.samsung.com>
X-CMS-MailID: 20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677
References: <CGME20181015135055eucas1p2fdb917790b3690dd52ee7b9aa19ea677@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Samsung PM Suspend debug" feature (controlled by SAMSUNG_PM_DEBUG
config option) is not working properly (debug messages are not
displayed after resume) on Exynos platforms because GPIOs restore
code is not implemented.

Add PLAT_S3C24XX, ARCH_S3C64XX and ARCH_S5PV210 dependencies to
SAMSUNG_PM_DEBUG config option to hide it on Exynos platforms.
Then convert Exynos code to not require <plat/pm-common.h>
header (use pr_debug() directly instead of S3C_PMDBG() macro and
remove redundant s3c_pm_*() calls).

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
v2:
- convert Exynos code to not require <plat/pm-common.h> header

Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
needed s3c_pm_check_*() calls".

 arch/arm/mach-exynos/suspend.c |   14 ++++----------
 arch/arm/plat-samsung/Kconfig  |    3 ++-
 2 files changed, 6 insertions(+), 11 deletions(-)

Index: b/arch/arm/mach-exynos/suspend.c
===================================================================
--- a/arch/arm/mach-exynos/suspend.c	2018-10-15 15:11:15.296187842 +0200
+++ b/arch/arm/mach-exynos/suspend.c	2018-10-15 15:22:54.656205454 +0200
@@ -30,8 +30,6 @@
 #include <asm/smp_scu.h>
 #include <asm/suspend.h>
 
-#include <plat/pm-common.h>
-
 #include "common.h"
 
 #define REG_TABLE_END (-1U)
@@ -490,11 +488,9 @@ static int exynos_suspend_enter(suspend_
 {
 	int ret;
 
-	s3c_pm_debug_init();
-
-	S3C_PMDBG("%s: suspending the system...\n", __func__);
+	pr_debug("%s: suspending the system...\n", __func__);
 
-	S3C_PMDBG("%s: wakeup masks: %08x,%08x\n", __func__,
+	pr_debug("%s: wakeup masks: %08x,%08x\n", __func__,
 			exynos_irqwake_intmask, exynos_get_eint_wake_mask());
 
 	if (exynos_irqwake_intmask == -1U
@@ -504,7 +500,6 @@ static int exynos_suspend_enter(suspend_
 		return -EINVAL;
 	}
 
-	s3c_pm_save_uarts();
 	if (pm_data->pm_prepare)
 		pm_data->pm_prepare();
 	flush_cache_all();
@@ -517,12 +512,11 @@ static int exynos_suspend_enter(suspend_
 
 	if (pm_data->pm_resume_prepare)
 		pm_data->pm_resume_prepare();
-	s3c_pm_restore_uarts();
 
-	S3C_PMDBG("%s: wakeup stat: %08x\n", __func__,
+	pr_debug("%s: wakeup stat: %08x\n", __func__,
 			pmu_raw_readl(S5P_WAKEUP_STAT));
 
-	S3C_PMDBG("%s: resuming the system...\n", __func__);
+	pr_debug("%s: resuming the system...\n", __func__);
 
 	return 0;
 }
Index: b/arch/arm/plat-samsung/Kconfig
===================================================================
--- a/arch/arm/plat-samsung/Kconfig	2018-10-15 15:16:22.804195586 +0200
+++ b/arch/arm/plat-samsung/Kconfig	2018-10-15 15:16:22.800195586 +0200
@@ -238,7 +238,8 @@ comment "Power management"
 
 config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
-	depends on PM && DEBUG_KERNEL
+	depends on DEBUG_KERNEL
+	depends on PM && (PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210)
 	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
