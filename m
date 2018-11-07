Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF6C2C46464
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A6D120989
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="SHDKlaYF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A6D120989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731652AbeKHCmC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:42:02 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57233 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731542AbeKHCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:42:02 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171045euoutp02ac2675c66e851108705eb0b8325a4360~k5rbAOLw30522705227euoutp02z
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181107171045euoutp02ac2675c66e851108705eb0b8325a4360~k5rbAOLw30522705227euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610645;
        bh=0WFLEzAw2aavBK3I3OCjzkbVzKlMAaSYdb55506bcLQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SHDKlaYFutykon+xuEEHvsJiXgW30bvazqNpKWALFkyIMVveyYuEUrBWG1DfQ+l/F
         YGXN4BDLjKbcTnYl51OaaRSrunHCOvZQmCnoIKiEuw+T3FRPSzu0bb0qq8nd7b3Acj
         KQd4vvTYJKUajhQnnn2TCa7abSLiRfyUY6PdaoJg=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181107171044eucas1p13ae4deff325bdfcc14ed4cf1c1fea211~k5raMvwvk2318323183eucas1p1H;
        Wed,  7 Nov 2018 17:10:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 38.64.04294.39C13EB5; Wed,  7
        Nov 2018 17:10:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171043eucas1p16be3fa901c7bceb129c70fc81dba6e48~k5rZfeL-_3085730857eucas1p1d;
        Wed,  7 Nov 2018 17:10:43 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171043eusmtrp1c9acb4456537ee03616de44eccab9dca~k5rZTgZXz2472624726eusmtrp1q;
        Wed,  7 Nov 2018 17:10:43 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-c8-5be31c930bb9
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id EF.23.04128.39C13EB5; Wed,  7
        Nov 2018 17:10:43 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171042eusmtip25b8b49cf290ae30058e6ad32c6256fe7~k5rYrNGek0340803408eusmtip2U;
        Wed,  7 Nov 2018 17:10:42 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v2 08/11] arm: dts: exynos4: add support for thermal trip
 irq-mode
Date:   Wed,  7 Nov 2018 18:09:50 +0100
Message-Id: <1541610593-28542-9-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSWUwTQRzGnd3udluoWQqRCSKYRlFMBETBTTAGDSYbfPHBxCgPWmE5lAJ2
        AS2aiCFyVECUoICmYDhba4CKiBxFCpEgSiEQbg9u1ECEIoI1KstWfft933z/YyZDoFIj5kJE
        xcQzyhh5tAwXC+perXXvzXWdDPF5v+hH1eRXYdTUyzRAaSzbqKL2bowq6h/AqNuTX1DKbK4W
        UiPJrpRhct16lFoqoPoaHuKUJasdUPlmI0KVDfYi1M3mdiE1NZ6NB5K0XqMH9IvCd0K6pOkT
        Qht0GTg9NtCE009Lr9Ml2bkY3brQhNDZtTpAWwxuJ8RnxIfCmOioREbpfficOPJHZzUe129/
        pVU/iyWDbyI1EBGQPACT89eAGogJKVkJYMHEkE0sA7i0MGUTFgBzWqwCNSA2SobHdvB+BYDp
        GXPYv4pOaxHgQjjpBet1lzjfiXwAoMVYIuQEShYjcNH6RMANdyRPwlvlRoRjAbkTjva9wTmW
        kMFwenQU4xd0g8PdGSjHIvI41PTNbzSC5IAQTq80CvlQEDQ/L0N5doSfO2ptvivsys0U8MzC
        t+k6nOdrMK2z3pYJgG0dvRi3NUp6wqoGb94+AlfvZCL8jTfDoXkHzkbX8W7dfZS3JTA9Vcqn
        d8PazB6E5y2wQn/P1pyGKx9SUf59NAB+XygHOcC98P+wYgB0wJlJYBURDOsbw1z2YuUKNiEm
        wis0VmEA67+q61fHcj1o+HneBEgCyOwlPc/GQ6SYPJFVKUwAEqjMSZL1eCJEKgmTq5IYZexZ
        ZUI0w5rAVkIgc5Zc3fQxREpGyOOZiwwTxyj/niKEyCUZFBsmkprH6lp+O8SpU7+Gi51HZoJ9
        bzgUXDh2yqqe6zIRdmGBC9sTPcKjjr5uTXJpaNcerK9RaWdKC8usmpTT2jaTr2ZSNBja3NZo
        NzIbiRrtffKW4mr8A+zNqnCdXuXhl05GVLKKcm93l7YUzxb/oLT+1TyG1U7tV2qbd4XLBGyk
        fN8eVMnK/wA2SA0mUQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7qTZR5HG3w7zGWxccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFrQYZi02PgUIL25awWFzeNYfN4nPvEUaLGef3
        MVksvX6RyaJ17xF2iycP+9gcBDzWzFvD6LFz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9FvdN
        ZvU4+G4Pk0ffllWMHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehl/Dq5ga3gCk/FwTXPWRsYv3J2MXJwSAiYSNy8o9LFyMUhJLCUUeLt
        tYtsXYycQHExiUn7trND2MISf651sUEUfWKUOHHmHxNIM5uAnsSOVYUgcRGB+YwSRzddBiti
        FljDJLH10HlGkG5hgSCJM3tvg01lEVCVuH35DJjNK+Al8fT2bVaIDXISN891MoPYnALeEvMu
        vwXbLARU833WerYJjHwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBMbOtmM/t+xg7HoX
        fIhRgINRiYdXY8fDaCHWxLLiytxDjBIczEoivL2rH0UL8aYkVlalFuXHF5XmpBYfYjQFOmoi
        s5Rocj4wrvNK4g1NDc0tLA3Njc2NzSyUxHnPG1RGCQmkJ5akZqemFqQWwfQxcXBKNTDm/98l
        wKgz/cWN8iOCroduOsjwPE9hMFeryMqc5bPIZ0JA+G7p2cn3PxtPnp65zEgm50PO2m5jT52b
        ObEdVx97T8yxd970iP/4XrYb0+92RWzTib20d6bD+U+Fh0N3rLJvm/A7+fIVtysm5QuCV1Tb
        rWVRWJF7Q2Cft0LnZLY6qxtJx4U8TEyVWIozEg21mIuKEwFk1ewKswIAAA==
X-CMS-MailID: 20181107171043eucas1p16be3fa901c7bceb129c70fc81dba6e48
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171043eucas1p16be3fa901c7bceb129c70fc81dba6e48
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171043eucas1p16be3fa901c7bceb129c70fc81dba6e48
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171043eucas1p16be3fa901c7bceb129c70fc81dba6e48@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for new flag which indicates
that trip point triggers IRQ when temperature is met.
Change existing trip points to be expicitly marked with the new flag.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
index 021d9fc..5e07289 100644
--- a/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
+++ b/arch/arm/boot/dts/exynos4-cpu-thermal.dtsi
@@ -17,22 +17,26 @@ thermal-zones {
 			cpu_alert0: cpu-alert-0 {
 				temperature = <70000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_alert1: cpu-alert-1 {
 				temperature = <95000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_alert2: cpu-alert-2 {
 				temperature = <110000>; /* millicelsius */
 				hysteresis = <10000>; /* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			cpu_crit0: cpu-crit-0 {
 				temperature = <120000>; /* millicelsius */
 				hysteresis = <0>; /* millicelsius */
 				type = "critical";
+				irq-mode;
 			};
 		};
 		cooling-maps {
-- 
2.7.4

