Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1417FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:11:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C14A220827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="kVg2jShA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C14A220827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731593AbeKHCmB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:42:01 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54878 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731561AbeKHCmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:42:00 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171043euoutp01e62ea43dbfff7fdc7178620c1c9221e4~k5rZzPIvY2205222052euoutp012
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181107171043euoutp01e62ea43dbfff7fdc7178620c1c9221e4~k5rZzPIvY2205222052euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610643;
        bh=1sKQQ9HBtyWBDeRJiaiW2nZDp0IwV4UD2ezll2nOdGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kVg2jShAzwjxhsQSk25F9sTYR8TgI/GaOQkBvyAqE2XZdVKDmdcmcK/zm3eUFUvON
         z+FwQNw5GWEb6FKo67NufN1KiPyhCZTsDvkSMCxrSZ363BG6B1yqkBYRGkIsffAKir
         qtcUmzRLVB8qLWPMkH2zMmsnyXgs64zsXt1VBbhw=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20181107171042eucas1p136cdbcdf2c359f023001c204ea5b49e3~k5rZFMa2p3085730857eucas1p1b;
        Wed,  7 Nov 2018 17:10:42 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id F6.64.04294.29C13EB5; Wed,  7
        Nov 2018 17:10:42 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171042eucas1p1675eb589f3951e516461a0a775ee87da~k5rYd5JFx2717527175eucas1p1t;
        Wed,  7 Nov 2018 17:10:42 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171042eusmtrp1672314366d4e9e59191de155c267e49f~k5rYR_3Bs2472624726eusmtrp1p;
        Wed,  7 Nov 2018 17:10:42 +0000 (GMT)
X-AuditID: cbfec7f4-84fff700000010c6-c5-5be31c928371
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id BE.23.04128.19C13EB5; Wed,  7
        Nov 2018 17:10:42 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171041eusmtip22e1c5fbf86568bf0ce72853ac8a2b8e8~k5rXmmKT90341503415eusmtip2B;
        Wed,  7 Nov 2018 17:10:41 +0000 (GMT)
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
Subject: [PATCH v2 07/11] arm64: dts: exynos7: add support for thermal trip
 irq-mode
Date:   Wed,  7 Nov 2018 18:09:49 +0100
Message-Id: <1541610593-28542-8-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSe0hTYRjG+3Z2tuNy+TWlXtSMFqEGzcwuJ5UwEDqVf0hQRIK28qSSTt1R
        ywySvF8rjSYaU1FTlpdaZipT0rwg3i9ZmYKlmBkGOSvEajnPrP9+7/M+7/O+fHwUIWsh7akw
        VQyrVinD5SKJsKFrZXBfnuNMwP7X0wr6aUEdSc++TEO01riDLu4YIOnisXGSvjPzhaAHB5+I
        6YlER1o/syaVppYL6dHmhyLamNOB6ILBVgFd8WZYQKe0dIjp2Q+5Ih/MVGurEdNUOCVmygyf
        BYxelyFiJscNIuZZ+S2mLDefZNq+GgRMbr0OMUa9k7/kgsQ7mA0Pi2PVbscuSkJfGCtR1Heb
        67WpVaJENGCdiawowAchv7aHyEQSSoarEKz2lZB8sYzg/VK+pWNEUFv0m9gYmU/LFppZhisR
        5Lb6/Zu4P2JYG6coEVZAoy7arNvhIgTG1jKxuSBwiQC+rdYIzSZbfA7GCrzNQUK8B+Ya0tdD
        pfgUfNQuWpY5wbuBjHW2wqdBO7q4ngN4RAxJ+iqSN/mCZqDUwraw0F0v5tkRevP5SwFz0J+u
        E/F8E9J6Gi0eL3jVPbx+NIFdoa7ZjZePw5+sNrFZBrwF3i5uNcvEGuY1aAhelkJ6qox3u0B9
        9pCA521QWf3AEs5AztdJAf88WgSdpnnyLtpZ+H9ZCUI6tJ2N5SJCWO6Air2m4JQRXKwqRHE5
        MkKP1j5V75/u5UbU/OtSO8IUkltLh55/CJCRyjguPqIdAUXI7aQ5jz8GyKTByvgbrDoySB0b
        znLtyIESyrdLEzZNB8hwiDKGvcqyUax6oyugrOwTkUulIfAIWWrj6tzSldxp0q76CZMmDX4e
        HEwyKy3IeWEMn4muKI49sgVNo/TsT/a3rWy6DknPs00TyQrNyJJm1O6HJsFE9q+eNI2fbXPw
        GHKvm+o9eq/idspmU4V//ULNlUe7C3+emAsKjPLy+eTlHaoSZ7nsStUd9vXsq/MclQu5UKX7
        XkLNKf8C5Q9ULVADAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIIsWRmVeSWpSXmKPExsVy+t/xe7qTZB5HG6z+x2ixccZ6VosnB9oZ
        LeZ9lrWYf+Qcq8X8K9dYLfofv2a2OH9+A7vFrQYZi02PgUIL25awWFzeNYfN4nPvEUaLGef3
        MVksvX6RyaJ17xF2iycP+9gcBDzWzFvD6LFz1l12j8V7XjJ5bFrVyeZx59oeNo/NS+o9FvdN
        ZvU4+G4Pk0ffllWMHp83yQVwRenZFOWXlqQqZOQXl9gqRRtaGOkZWlroGZlY6hkam8daGZkq
        6dvZpKTmZJalFunbJehlbP+8nLHgK3/FurYVbA2M53i6GDk5JARMJF6097B0MXJxCAksZZRY
        u7afESIhJjFp33Z2CFtY4s+1LjaIok+MEo/eXgMq4uBgE9CT2LGqECQuIjCfUeLopstgRcwC
        a5gkth46DzZJWCBEYsb0fcwgNouAqsSzbR0sIDavgJfEo3lvmSE2yEncPNcJZnMKeEvMu/wW
        bLMQUM33WevZJjDyLWBkWMUoklpanJueW2ykV5yYW1yal66XnJ+7iREYPduO/dyyg7HrXfAh
        RgEORiUeXo0dD6OFWBPLiitzDzFKcDArifD2rn4ULcSbklhZlVqUH19UmpNafIjRFOioicxS
        osn5wMjOK4k3NDU0t7A0NDc2NzazUBLnPW9QGSUkkJ5YkpqdmlqQWgTTx8TBKdXAmLNvpiJ/
        yP8dneJTl725uslocdyDhZ8rcg3CFjG+vZ3Hu6Uv79rFkgv3sqfdOBZ5tWTxbKN/DV03N9be
        vlHvdNVA8ZbbQQk78Q1sp99mJxwT67F5qDFzmUL5eaM5lStMOn0V9ujIm6bcvSz6VV05TY1X
        o4l54lWGzYHBVU0yN+yDSsQPVNW5KLEUZyQaajEXFScCAI54qLO0AgAA
X-CMS-MailID: 20181107171042eucas1p1675eb589f3951e516461a0a775ee87da
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171042eucas1p1675eb589f3951e516461a0a775ee87da
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171042eucas1p1675eb589f3951e516461a0a775ee87da
References: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181107171042eucas1p1675eb589f3951e516461a0a775ee87da@eucas1p1.samsung.com>
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
 arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
index d3301b8..39185af 100644
--- a/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos7-trip-points.dtsi
@@ -11,40 +11,48 @@ trips {
 		temperature = <75000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-1 {
 		temperature = <80000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-2 {
 		temperature = <85000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-3 {
 		temperature = <90000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-4 {
 		temperature = <95000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-5 {
 		temperature = <100000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-alert-6 {
 		temperature = <110000>; /* millicelsius */
 		hysteresis = <10000>; /* millicelsius */
 		type = "passive";
+		irq-mode;
 	};
 	cpu-crit-0 {
 		temperature = <115000>; /* millicelsius */
 		hysteresis = <0>; /* millicelsius */
 		type = "critical";
+		irq-mode;
 	};
 };
-- 
2.7.4

