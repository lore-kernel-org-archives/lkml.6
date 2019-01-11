Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F3A9C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:22:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EB32084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 13:22:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="MH5nJhRW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732605AbfAKNW0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 08:22:26 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:54716 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731776AbfAKNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 08:22:26 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190111132224euoutp014cb48ff672b120693dc64063860cfbf6~4zfmqpO6p1050210502euoutp01O
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jan 2019 13:22:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190111132224euoutp014cb48ff672b120693dc64063860cfbf6~4zfmqpO6p1050210502euoutp01O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1547212944;
        bh=kq/fTYQTX1pjln2P5kjdINOYXJPcsI/rnIGYEcWLDTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MH5nJhRWrE36oLL4seiZiPScq5ptAyhU7xdcSOkVIIokr4AerRUIAF6ZPjMYCrwQK
         H3wvXCpl5BwCxzZ3GdbfpEl3zvQuvLkK53qWcuyvlfL5WBL2VEjyMSPOMyduyEhXmv
         2kffjthTjcqwkZ4aS8qAJj2eyUCqPm/PqgWtIq7I=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190111132223eucas1p2c8752ef0287a2dc0078c49d7b10759ae~4zfl942L11513615136eucas1p2c;
        Fri, 11 Jan 2019 13:22:23 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 65.A5.04441.F88983C5; Fri, 11
        Jan 2019 13:22:23 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190111132222eucas1p1d80caf8ba30422bc5fe1a1fac4cf48e8~4zflGB_fZ0261602616eucas1p13;
        Fri, 11 Jan 2019 13:22:22 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190111132222eusmtrp17c53cf777520156eaa450ab8740d60f0~4zfk3gMrD2207722077eusmtrp16;
        Fri, 11 Jan 2019 13:22:22 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-16-5c38988f6e68
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id E8.46.04284.E88983C5; Fri, 11
        Jan 2019 13:22:22 +0000 (GMT)
Received: from localhost (unknown [106.120.51.46]) by eusmtip1.samsung.com
        (KnoxPortal) with ESMTPA id
        20190111132222eusmtip1f34f5d08e180d699683e979c77454904~4zfku1sWy1230712307eusmtip1H;
        Fri, 11 Jan 2019 13:22:22 +0000 (GMT)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>,
        Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        Otto Sabart <ottosabart@seberm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v5.1 RESEND] dt-bindings: hwrng: Add Samsung Exynos 5250+
 True RNG bindings
Date:   Fri, 11 Jan 2019 14:21:39 +0100
Message-Id: <20190111132139.12333-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <CAL_JsqKt-ujsB-t9A=4dEAjqrvcquUG+qF3tFg1YCqmup_5wcw@mail.gmail.com>
MIME-Version: 1.0
Organization: Samsung R&D Institute Poland
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFKsWRmVeSWpSXmKPExsWy7djP87r9MyxiDPY84LaYf+Qcq8Xs+49Z
        LM6f38BucfPQCkaLy7vmsFnMOL+PyeLV+RdsFq17j7Bb/N+zg92B02PTqk42jy+rrjF79G1Z
        xeixZ+FLFo/Pm+QCWKO4bFJSczLLUov07RK4Mv7c+8dW8JOzYs2UOewNjFs4uhg5OSQETCQO
        bN3P2sXIxSEksIJR4vW5fVDOF0aJ27O2QjmfGSXeN15nhWk53XuVGSKxnFGi5dNrdgjnOaPE
        lx39LCBVbAKOEv1LT4B1iAioSGx4fgusg1ngPJPE9TOH2UASwgKxErcmXgArYhFQleg5MJsd
        xOYVsJb4vvAcO8Q6eYnzvevAbE6BQInVhzoZIWoEJU7OfAK2jF9AS2JN03UwmxmovnnrbLBl
        EgKH2CUuzlrFAjHIRaJtcTvUD8ISr45vgVogI3F6cg9UTbnEjxt9rBDNLYwSiyd0QhVZS/xZ
        NRHoag6gDZoS63fpQ4QdJXa+OskCEpYQ4JO48VYQ4gY+iUnbpjNDhHklOtqEIKpVJNb174Ha
        JCXR+2oF4wRGpVlIvpmF5INZCLsWMDKvYhRPLS3OTU8tNsxLLdcrTswtLs1L10vOz93ECExB
        p/8d/7SD8eulpEOMAhyMSjy8Hb7mMUKsiWXFlbmHGCU4mJVEeE/nWcQI8aYkVlalFuXHF5Xm
        pBYfYpTmYFES561meBAtJJCeWJKanZpakFoEk2Xi4JRqYGyKm9q+orKwv8hi7dF10k+Xlhit
        lX9bZKAYkzDj7pEpl+MFq+0Yf9/6vbw8csUt8Xt+TL6RWxxn+e9u7s8VTXx/UsDpp+N2u4Av
        IR8n5Ijs0GLWWSmZGfHyKt9N+az8ptzC+wGty/kObK+amVn9r1HPdqHZ19narfVaD3T6v728
        f6Hw9IMMNiWW4oxEQy3mouJEAMT2Zl49AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOIsWRmVeSWpSXmKPExsVy+t/xu7p9MyxiDC5c5LOYf+Qcq8Xs+49Z
        LM6f38BucfPQCkaLy7vmsFnMOL+PyeLV+RdsFq17j7Bb/N+zg92B02PTqk42jy+rrjF79G1Z
        xeixZ+FLFo/Pm+QCWKP0bIryS0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJS
        czLLUov07RL0Mv7c+8dW8JOzYs2UOewNjFs4uhg5OSQETCRO915lBrGFBJYySsx94djFyAEU
        l5JYOTcdokRY4s+1LjaIkqeMEv87fUBsNgFHif6lJ1hBbBEBFYkNz28BjeHiYBa4yiSx4O5E
        dpCEsEC0xKP7E5lAbBYBVYmeA7PB4rwC1hLfF55jh1ggL3G+dx2YzSkQKLH6UCcjxDIeiVcb
        9jNC1AtKnJz5hAXkNmYBdYn184RAwvwCWhJrmq6zgNjMQGOat85mnsAoNAtJxyyEjllIqhYw
        Mq9iFEktLc5Nzy021CtOzC0uzUvXS87P3cQIjLRtx35u3sF4aWPwIUYBDkYlHt4OX/MYIdbE
        suLK3EOMEhzMSiK8p/MsYoR4UxIrq1KL8uOLSnNSiw8xmgK9OZFZSjQ5H5gE8kriDU0NzS0s
        Dc2NzY3NLJTEec8bVEYJCaQnlqRmp6YWpBbB9DFxcEo1MFpemL9XL33R/Yvf7xaq3+OaMGXS
        sZur2Y8mnoi7luBUJ8qZfbAumjHW2DnxrqZy/dOIBSc+XA/N2XL+XvmnezUvaqyVc99vc955
        6dFE50SJdZKzrz0NlJhqb+WTJtduwprHGcdh9fyIZc9V/j8vGjfHSJ9yeL98T87LQ1tCXn74
        4a+4yeZclJcSS3FGoqEWc1FxIgDATkvAygIAAA==
X-CMS-MailID: 20190111132222eucas1p1d80caf8ba30422bc5fe1a1fac4cf48e8
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190111132222eucas1p1d80caf8ba30422bc5fe1a1fac4cf48e8
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190111132222eucas1p1d80caf8ba30422bc5fe1a1fac4cf48e8
References: <CGME20190111132222eucas1p1d80caf8ba30422bc5fe1a1fac4cf48e8@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the True Random Number Generator
found on Samsung Exynos 5250+ SoCs.

Acked-by: Rob Herring <robh@kernel.org>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
---
 .../bindings/rng/samsung,exynos5250-trng.txt    | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt

diff --git a/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
new file mode 100644
index 000000000000..5a613a4ec780
--- /dev/null
+++ b/Documentation/devicetree/bindings/rng/samsung,exynos5250-trng.txt
@@ -0,0 +1,17 @@
+Exynos True Random Number Generator
+
+Required properties:
+
+- compatible  : Should be "samsung,exynos5250-trng".
+- reg         : Specifies base physical address and size of the registers map.
+- clocks      : Phandle to clock-controller plus clock-specifier pair.
+- clock-names : "secss" as a clock name.
+
+Example:
+
+	rng@10830600 {
+		compatible = "samsung,exynos5250-trng";
+		reg = <0x10830600 0x100>;
+		clocks = <&clock CLK_SSS>;
+		clock-names = "secss";
+	};
-- 
2.20.1

