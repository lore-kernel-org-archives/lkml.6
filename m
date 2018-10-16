Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A82C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 944622145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="pYRMY15Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944622145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727526AbeJPWsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:48:22 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:57225 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727335AbeJPWrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:39 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145649euoutp01dd4142eb5f5acdb131ce1314fe033c61~eHqNUbdLh0565605656euoutp01W
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20181016145649euoutp01dd4142eb5f5acdb131ce1314fe033c61~eHqNUbdLh0565605656euoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701809;
        bh=L5Sb/ZLzlpOiDv5hLen/XRBTb288danQReW3wRWro1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pYRMY15YGUrGnDTwKJ1aZUiYrEyGHxksJ51GBm4dQEsUjnTx1iYuATO2PhNuTdPiO
         kvsWUbBctlqLK4NJ1F5rVfC3Xn4vQioOU5Jz4LbhdluynxJHu7SDniKH5IhefKPbNn
         MdKe4xKC7BqHd82HWwt9uxPV1MT7bCXLKjpwRMYE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016145648eucas1p297686e627a910be675b7512fe654b96a~eHqMhkdIX0770807708eucas1p23;
        Tue, 16 Oct 2018 14:56:48 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 86.C2.04441.03CF5CB5; Tue, 16
        Oct 2018 15:56:48 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145647eucas1p206c068806214535da339588d77cbdfa5~eHqLYh2dR2135021350eucas1p2K;
        Tue, 16 Oct 2018 14:56:47 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016145647eusmtrp21dffceae8154169cfb7895d936ec1442~eHqLJnVPb3061930619eusmtrp2W;
        Tue, 16 Oct 2018 14:56:47 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-cf-5bc5fc30908e
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 9F.AA.04128.E2CF5CB5; Tue, 16
        Oct 2018 15:56:47 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145646eusmtip23755d3b877dda4c4502ba9ebc737f7d3~eHqKhgvCj2834528345eusmtip2F;
        Tue, 16 Oct 2018 14:56:46 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 06/11] DT: arm64: exynos: add support for thermal trip
 irq-mode
Date:   Tue, 16 Oct 2018 16:56:17 +0200
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0WSa0hTYRjHec/ZuThcvq2LT1ZGq6AiLaMPB7QwMDqQVEJfSiGnHbTy1k5a
        dsGVmJfWyowUK52YGcMwLzmTqTWndrF5KZZd7LZRmSXoCjSk8nRmffs//+f5Pf+Hl5cl1c1U
        ALs/5bCgS9EmaWiloqlr0hG0bqozet2jDj+urqSW4tz3chFX5lnMldsdFFf+zElx510jJNfb
        e5vhXuoXcfWuaavizHUF97TlKs15ztkRV/W8n+ByWu0M535vpMP9+JqyGsTfLR1i+ErrMMHX
        m/Np/rXTSvMN17P4SmMRxd8ftRK8sdGMeE994E7lHmXYPiFpf4agW7spVpnoar9EpznDj+pd
        dqRH/cEFyIcFvAFyP7uJAqRk1fgmgp7Wt5RcfEdgslUwcuFB8E5/hZhBWnseMZJW42oELc6V
        /wiHq5MuQCxL42BoNh+S/Ln4CgJPW+XfTSQuJKCw+iMl0XNwFFgfVhASoMArwHgqQA4IhBeO
        fFLSPngbvBw0kRIL2MGApT1bITVUOAPaLIWkDETAtb5+RtZz4Et3o1cvgt93y71Xi/Akz0zL
        +gTkPmz2zoRCR3c/Jd1A4lVQ27JWtjfDcOF7RrIBz4LBb7Mlm5yWF5uKSdlWQd4ZtTy9EhoN
        fd6g+VBdc9m7nIfRs1+Q/DxlCG7oh5gLaEnp/zATQmbkL6SLyQmCGJIiHAkWtcliekpCcHxq
        cj2a/k+Pf3WPN6MfA3E2hFmk8VVNPLdHqylthpiZbEPAkpq5qoSBzmi1ap8285igS92rS08S
        RBtayCo0/qobZXXRapygPSwcFIQ0QTfTJVifAD2KsXqiOjS8m4/cnbvG8WrXnRelmskxY3bN
        0CejauJ4z9WiefGUoSFyDRp4N7sbxSzodW3OCLlveDCetCVq19jGuKzT20vaU5cPluhD5xfb
        cNz6pRuCfi6z5EREvFH57hhR4q1hsTpDlaLLFE9kf31SUXXSHwwXb32wTPkcSOsb0yjERG3I
        alInav8ASgig70sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7r6f45GG/T+ZLTYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFv2PXzNbnD+/gd3iVoOMxabHQKGFbUtYLC7vmsNm8bn3CKPF0usX
        mSxa9x5ht3jysI/Ngd9jzbw1jB47Z91l91i85yWTx6ZVnWwed67tYfPYvKTeY3HfZFaPg+/2
        MHn0bVnF6PF5k1wAV5SeTVF+aUmqQkZ+cYmtUrShhZGeoaWFnpGJpZ6hsXmslZGpkr6dTUpq
        TmZZapG+XYJexuP9U9gKrjlUNDw+wtjAeFGvi5GTQ0LARGLvmVPsILaQwFJGiQf7QiDiYhKT
        9m1nh7CFJf5c62LrYuQCqvnEKLHh/lHGLkYODjYBPYkdqwpB4iIC8xkljm66DFbELDCXSWJl
        w3ImkG5hAX+JzS9vsYE0sAioSvQ1SoGEeQW8JFZ+Xwm1QE7i5rlOZhCbU8Bb4taNBcwg5UJA
        NRcXM05g5FvAyLCKUSS1tDg3PbfYSK84Mbe4NC9dLzk/dxMjMFq2Hfu5ZQdj17vgQ4wCHIxK
        PLw/rh+JFmJNLCuuzD3EKMHBrCTCm37paLQQb0piZVVqUX58UWlOavEhRlOgkyYyS4km5wMj
        Oa8k3tDU0NzC0tDc2NzYzEJJnPe8QWWUkEB6YklqdmpqQWoRTB8TB6dUA+M0r6xD/aubujX3
        zPH6GduxmCX6s/rHryVN+d5KU9ev2pr80pTzje/kAOnM+U0Hg9f9FQ8sVFnR8fV0aJLS2jnK
        ylfecLNfebX8roCzHKenmr7gBnGTvxNZmzl35G73jPt6QixeiuHZxK73VcK8XipPppo9ebpv
        X/aSaM8cqZbvk0V2qqx73KzEUpyRaKjFXFScCAAoqjGUrAIAAA==
Message-Id: <20181016145647eucas1p206c068806214535da339588d77cbdfa5~eHqLYh2dR2135021350eucas1p2K@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145647eucas1p206c068806214535da339588d77cbdfa5
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145647eucas1p206c068806214535da339588d77cbdfa5
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145647eucas1p206c068806214535da339588d77cbdfa5
References: <1539701782-26852-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20181016145647eucas1p206c068806214535da339588d77cbdfa5@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds support for new flash which indicates
that trip point triggers irq when temperature is met.
Exynos5433 supports 8 trip point which will trigger irq.
Above that number other trip points should be registered
without 'irq-mode' flag.
That will force the thermal framework to start polling
the temperature sensor under configured conditions and
handle the trip point.

Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi | 105 ++++++++++++++++---------
 1 file changed, 70 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
index fe3a0b1..c4330f6 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi
@@ -17,37 +17,44 @@ thermal-zones {
 			atlas0_alert_0: atlas0-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_1: atlas0-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_2: atlas0-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_3: atlas0-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_4: atlas0-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_5: atlas0-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas0_alert_6: atlas0-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 
@@ -98,37 +105,44 @@ thermal-zones {
 			atlas1_alert_0: atlas1-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_1: atlas1-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_2: atlas1-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_3: atlas1-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_4: atlas1-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_5: atlas1-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			atlas1_alert_6: atlas1-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
@@ -141,37 +155,44 @@ thermal-zones {
 			g3d_alert_0: g3d-alert-0 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_1: g3d-alert-1 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_2: g3d-alert-2 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_3: g3d-alert-3 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_4: g3d-alert-4 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_5: g3d-alert-5 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			g3d_alert_6: g3d-alert-6 {
 				temperature = <100000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
@@ -184,37 +205,44 @@ thermal-zones {
 			apollo_alert_0: apollo-alert-0 {
 				temperature = <65000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_1: apollo-alert-1 {
 				temperature = <70000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_2: apollo-alert-2 {
 				temperature = <75000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_3: apollo-alert-3 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_4: apollo-alert-4 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_5: apollo-alert-5 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			apollo_alert_6: apollo-alert-6 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 
@@ -255,37 +283,44 @@ thermal-zones {
 			isp_alert_0: isp-alert-0 {
 				temperature = <80000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_1: isp-alert-1 {
 				temperature = <85000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_2: isp-alert-2 {
 				temperature = <90000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_3: isp-alert-3 {
 				temperature = <95000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_4: isp-alert-4 {
 				temperature = <100000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_5: isp-alert-5 {
 				temperature = <105000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 			isp_alert_6: isp-alert-6 {
 				temperature = <110000>;	/* millicelsius */
 				hysteresis = <1000>;	/* millicelsius */
-				type = "active";
+				type = "passive";
+				irq-mode;
 			};
 		};
 	};
-- 
2.7.4

