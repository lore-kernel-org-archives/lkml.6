Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B56DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C9F72081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="KOkNLO6o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C9F72081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbeKHCmD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:42:03 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57284 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731600AbeKHCmD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:42:03 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171046euoutp023e7b72e4e4841ec54b27743aa6a2407c~k5rb85M340522705227euoutp021
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181107171046euoutp023e7b72e4e4841ec54b27743aa6a2407c~k5rb85M340522705227euoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610646;
        bh=7wpBMAvXa5tM9FimGk9u449eww/CHKCAsVOJ9u7rXVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KOkNLO6oTv1v1T9weJCHKvsvJilNNgZwS6JY/n3EfT9H0CQGMAACPm979yozKrZBM
         IGr0KRMF5vxi/7oroezUmNrvNm14Bue42ktTz0wADRAoI1ytpJHRIn5SL95punBtp1
         cvoiF0utgWVBNojGIYwEJL07xQE3BKutI0o8Jcrw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181107171045eucas1p2095285d9bc3eb48dfcccb75a45883f64~k5rbUXkRQ2800528005eucas1p2R;
        Wed,  7 Nov 2018 17:10:45 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 49.64.04294.59C13EB5; Wed,  7
        Nov 2018 17:10:45 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171044eucas1p198434e21cf21ee754302615a6a8f3c20~k5rahNs_f2903729037eucas1p1h;
        Wed,  7 Nov 2018 17:10:44 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171044eusmtrp1b841c5c4c0a7094f01931a88ad14016e~k5raVGZNv2472724727eusmtrp1n;
        Wed,  7 Nov 2018 17:10:44 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-ca-5be31c9552e5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id F0.33.04128.49C13EB5; Wed,  7
        Nov 2018 17:10:44 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171043eusmtip2645b143696bfc3435d82bcf4f59368da~k5rZtA12x0341503415eusmtip2C;
        Wed,  7 Nov 2018 17:10:43 +0000 (GMT)
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
Subject: [PATCH v2 09/11] arm: dts: exynos5420: add support for thermal trip
 irq-mode
Date:   Wed,  7 Nov 2018 18:09:51 +0100
Message-Id: <1541610593-28542-10-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+85lO04Xpyn54S1ZhF3IS0geKCJJ4kB0sYIgoVp5UMup7ehq
        KmR4X2p5F8u5UHPMiZeWzGupw1GS97xmaDPISq1mf4QmbZ6J//2+532e54WXj0BFnbgbERUT
        z8hiJNFingBr6fs7cLjYwxzmPzxKUE1lDTi18CYTUCqLJ1VpHMCpyrFxnHps/o5Sg4ONfGo6
        xYNqNlul5xnVGDXa9oxHWXKNgCob7EKomolhhErvNPKphfk83kmS1ql0gG4tn+XTVR2LCN2s
        zebRH8c7ePTL6gd0VV4hTncvdyB0nl4LaEuz1wXBVcHxcCY6Ss7I/E7cEER2lqp5cWbH+wbL
        CpoC+hyUwIGAZCBcrhlAlEBAiEgNgOs/unHusQpgkabaPrEAaMiYAVuRd6kf+NygFkCNWbsd
        eT1fgCkBQfBIX2jQ3rXpLuRTAC1dVZsJlFQj8NdaPWarciavwN+LlYiNMXIfLFTX8W1hIXkG
        ZmtOc9u84NRANmpjB6usGl3a7IHkCB/Opo7xOFMInOwqsrMz/GbS8zn2gP2FORjHLHyfpbV7
        kmHmW4Pdcwz2moZx216UPAAb2vxsCMlg2FoLOdwJJ5d22cyoFQtaSlFOFsKsDBHXsR/qc4YQ
        jnfDWl2JvZuGow0jKHcdFYDKpj/YE7CnfHuXGgAtcGUSWGkEwx6JYe75shIpmxAT4XsrVtoM
        rJ+qf8O0agBt6zd7AEkAsZNw6NV8mAiXyFmFtAdAAhW7CHPrPoeJhOESRSIji70uS4hm2B7g
        TmBiV2HSjrkwERkhiWfuMEwcI9uaIoSDWwo46mkKLgYVa9fcPynSyxVTJWNuTsly5Wpifl9S
        Hq3rR9cetppqdMvlJY4RF796+hR7z4ScvdQUlSYICNJPBB2aKGq5Hdog8m/8t2Bq++K9d649
        85F+Y9qxHV8B2ulzgT+9X0iK6iPzXZ3Xu1vk56cr0jw2LMWhRrLX03gq/bKPGGMjJQEHURkr
        +Q8bBdV6UAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAIsWRmVeSWpSXmKPExsVy+t/xe7pTZB5HG1x5LWixccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFrQYZi02PgUIL25awWFzeNYfN4nPvEUaLGef3
        MVksvX6RyaJ17xF2iycP+9gcBDzWzFvD6LFz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9FvdN
        ZvU4+G4Pk0ffllWMHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehl7J2+gK3gMXfFjs/vmRsYj3F2MXJySAiYSJxqvsrexcjFISSwlFFi
        5sJ/zBAJMYlJ+7azQ9jCEn+udbFBFH1ilGh538zSxcjBwSagJ7FjVSFIXERgPqPE0U2XwYqY
        BdYwSWw9dJ4RpFtYIFTi0qKlYFNZBFQlJi9YzQ7SzCvgLdG5wg1igZzEzXOdYCWcQOF5l9+C
        LRYS8JL4Pms92wRGvgWMDKsYRVJLi3PTc4uN9IoTc4tL89L1kvNzNzECY2fbsZ9bdjB2vQs+
        xCjAwajEw6ux42G0EGtiWXFl7iFGCQ5mJRHe3tWPooV4UxIrq1KL8uOLSnNSiw8xmgLdNJFZ
        SjQ5HxjXeSXxhqaG5haWhubG5sZmFkrivOcNKqOEBNITS1KzU1MLUotg+pg4OKUaGPt3NP0P
        m8Ds6h/J99mh0TiijGuTYsfEGpPtWsf27Uur25gis0xxf59W5WnzBg6v15NeFW88ox70V/0t
        Q7/1uS8LH+3ev/xFrILKgpx2R4uI/RXzvjAkOy+qUli1Pi+Ml/HOl+QFEnNf2q9a/nFL94V7
        B59/XMp2t9zpWtxr/dM5Og12dkYGJ5VYijMSDbWYi4oTAV7BuY2zAgAA
X-CMS-MailID: 20181107171044eucas1p198434e21cf21ee754302615a6a8f3c20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171044eucas1p198434e21cf21ee754302615a6a8f3c20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171044eucas1p198434e21cf21ee754302615a6a8f3c20
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171044eucas1p198434e21cf21ee754302615a6a8f3c20@eucas1p1.samsung.com>
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
 arch/arm/boot/dts/exynos5420-trip-points.dtsi | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-trip-points.dtsi b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
index a67a3807..9e16970 100644
--- a/arch/arm/boot/dts/exynos5420-trip-points.dtsi
+++ b/arch/arm/boot/dts/exynos5420-trip-points.dtsi
@@ -11,21 +11,25 @@ trips {
 	cpu-alert-0 {
 		temperature = <85000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-1 {
 		temperature = <103000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-2 {
 		temperature = <110000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
-		type = "active";
+		type = "passive";
+		irq-mode;
 	};
 	cpu-crit-0 {
 		temperature = <120000>; /* millicelsius */
 		hysteresis = <0>; /* millicelsius */
 		type = "critical";
+		irq-mode;
 	};
 };
-- 
2.7.4

