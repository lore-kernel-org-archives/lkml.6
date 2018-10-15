Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96046C04AA5
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:50:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D26F208D9
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 15:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="czYMUjDL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D26F208D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbeJOXfy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 19:35:54 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:55772 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOXfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 19:35:53 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181015155003euoutp02a5d9ebb129cbe87384afcfa9f650fda5~d0vZ7oofh1533615336euoutp02U
        for <linux-kernel@vger.kernel.org>; Mon, 15 Oct 2018 15:50:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181015155003euoutp02a5d9ebb129cbe87384afcfa9f650fda5~d0vZ7oofh1533615336euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539618603;
        bh=hh1KGglSPI+vJNV3+yd7Y2Prn40j1RzSrpL5baAiIzk=;
        h=To:Cc:From:Subject:Date:References:From;
        b=czYMUjDLVcFYW/bw0nWhvrhS+pdl+cM8eikGF24jq54WXG2PABeoEibC/LQ6ozvcM
         UDRl8GSoTILPASx3ucioIOICU5F7AB9Mx3U8C5B86FQTG2SO0dK8PDDuNLEIJ6e58m
         nxKWxQ6XSUOROgUaUMFh34wbJCuS/uOIV9Arzagk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181015155002eucas1p1610decd6fd934c87354180bb0a13e9ce~d0vZHbZtN2443224432eucas1p1Q;
        Mon, 15 Oct 2018 15:50:02 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id EE.EC.04806.A27B4CB5; Mon, 15
        Oct 2018 16:50:02 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37~d0vYKtP7-2027420274eucas1p2g;
        Mon, 15 Oct 2018 15:50:01 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181015155001eusmtrp1b6e6ae42b2b79b602c44d006c7047f02~d0vX8JV5c3173531735eusmtrp1M;
        Mon, 15 Oct 2018 15:50:01 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-9e-5bc4b72ad01b
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 6A.FB.04128.927B4CB5; Mon, 15
        Oct 2018 16:50:01 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20181015155001eusmtip19debc16b922c833233933c1cf37494fc~d0vXkVCAf3225232252eusmtip1C;
        Mon, 15 Oct 2018 15:50:01 +0000 (GMT)
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Kukjin Kim <kgene@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH v3] ARM: SAMSUNG: limit SAMSUNG_PM_DEBUG config option to
 non-Exynos platforms
Date:   Mon, 15 Oct 2018 17:50:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsWy7djP87pa249EG/RPUrLYOGM9q0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZHFo6l5GB3aPy9cuMntsWtXJ5rF5Sb1H35ZVjB6fN8kF
        sEZx2aSk5mSWpRbp2yVwZZz/K1bwT7zi26l1TA2MM0S6GDk5JARMJO4c+8/axcjFISSwglHi
        yK9fjBDOF0aJCyf7WCCcz4wSU7/dY+5i5ABrWTrLCCK+nFFi0YbDTBDOe0aJ/78OMoPMFRHQ
        lLj+9zvYXGaBV4wSDbP3MoEk2ASsJCa2r2IEsYUFEiSmXD8ONpVFQFXixw8/EFNUIEKi/4w6
        SAWvgKDEyZlPWEBsZgF5ie1v5zCDjJQQaGeXuHfsKQtEUZnEiuYtjBD/uEicmv6dCcIWlnh1
        fAs7hC0jcXpyDwtE83RGiTe/lkI56xkl1pw5BtVhLXH4+EVWkCuYgT5Yv0sfIuwo8eHgLCaI
        7/kkbrwVhDiIT2LStunQQOGV6GgTgqhWk9iwbAMbzNqunSuZIWwPiZZ/p8FOFhKIlbj/4gzL
        BEaFWUjenIXkzVkINyxgZF7FKJ5aWpybnlpsnJdarlecmFtcmpeul5yfu4kRmGZO/zv+dQfj
        vj9JhxgFOBiVeHgFeI5EC7EmlhVX5h5ilOBgVhLh7dkEFOJNSaysSi3Kjy8qzUktPsQozcGi
        JM67bN7GaCGB9MSS1OzU1ILUIpgsEwenVAOj1guTHEefVvuryY2OL29v//Tao/Dw5fNr6j7o
        vl6YdbwzsF/O5mObc1GSatQL3ZWXLh+Ie5BYtd5mHf/EhdIZcccaqppkMkJea23L7HKo7t2+
        cMeNZXw50/o03k3ed0vid3tYfaj8nemTDF2Dpl/6ZfDzzJqlszO/LDnx7nSqlcySKx9FPEqO
        KbEUZyQaajEXFScCAOFMdYwvAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkkeLIzCtJLcpLzFFi42I5/e/4XV3N7UeiDWY/krHYOGM9q0X/49fM
        FufPb2C32PT4GqvF5V1z2CxmnN/HZHFo6l5GB3aPy9cuMntsWtXJ5rF5Sb1H35ZVjB6fN8kF
        sEbp2RTll5akKmTkF5fYKkUbWhjpGVpa6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZZz/
        K1bwT7zi26l1TA2MM0S6GDk4JARMJJbOMupi5OIQEljKKDFr7wlGiLiMxPH1ZV2MnECmsMSf
        a11sEDVvGSUeb93CCJIQEdCUuP73OytIglngFaPEnonnwRJsAlYSE9tXgdnCAgkSU64fZwax
        eQXsJA4svcgGsoBFQFXixw8/kLCoQITErYcdLBAlghInZz4Bs5kF1CX+zLvEDGHLS2x/O4d5
        AiP/LCRls5CUzUJStoCReRWjSGppcW56brGRXnFibnFpXrpecn7uJkZgNGw79nPLDsaud8GH
        GAU4GJV4eAV4jkQLsSaWFVfmHmKU4GBWEuHt2QQU4k1JrKxKLcqPLyrNSS0+xGgKdPdEZinR
        5HxgpOaVxBuaGppbWBqaG5sbm1koifOeN6iMEhJITyxJzU5NLUgtgulj4uCUamA8WVE2a5NV
        LZNu+pGdmTpK/8KeH+RYNIlPKMtegvmT64wdsnkrrlY3Re2sW/TpmbzgoxM9FvMPyL5feujP
        v45K7kXJPK/P31UyaDY9q7iz7YCtS8oDiXWrDl50MWnP2VDqtzZe7InCR/96oc/7/hv7sh66
        q/r977WQldm7kibWnPk0kc9iWfZWJZbijERDLeai4kQARxtNMpwCAAA=
Message-Id: <20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37~d0vYKtP7-2027420274eucas1p2g@eucas1p2.samsung.com>
X-CMS-MailID: 20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37
References: <CGME20181015155001eucas1p249f539be47eaff0d10ddc74e1f681b37@eucas1p2.samsung.com>
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
v3:
- don't move PM to the line below in Kconfig

v2:
- convert Exynos code to not require <plat/pm-common.h> header

Should by applied on top of "[PATCH] ARM: EXYNOS: remove no longer
needed s3c_pm_check_*() calls".

 arch/arm/mach-exynos/suspend.c |   14 ++++----------
 arch/arm/plat-samsung/Kconfig  |    1 +
 2 files changed, 5 insertions(+), 10 deletions(-)

Index: b/arch/arm/mach-exynos/suspend.c
===================================================================
--- a/arch/arm/mach-exynos/suspend.c	2018-10-15 17:39:54.628412461 +0200
+++ b/arch/arm/mach-exynos/suspend.c	2018-10-15 17:39:54.624412461 +0200
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
--- a/arch/arm/plat-samsung/Kconfig	2018-10-15 17:39:54.628412461 +0200
+++ b/arch/arm/plat-samsung/Kconfig	2018-10-15 17:40:35.416413489 +0200
@@ -239,6 +239,7 @@ comment "Power management"
 config SAMSUNG_PM_DEBUG
 	bool "Samsung PM Suspend debug"
 	depends on PM && DEBUG_KERNEL
+	depends on PLAT_S3C24XX || ARCH_S3C64XX || ARCH_S5PV210
 	depends on DEBUG_EXYNOS_UART || DEBUG_S3C24XX_UART || DEBUG_S3C2410_UART
 	help
 	  Say Y here if you want verbose debugging from the PM Suspend and
