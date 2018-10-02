Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B07C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44A0620645
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 07:57:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="A//5Obzl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A0620645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727369AbeJBOjA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 10:39:00 -0400
Received: from mailout1.samsung.com ([203.254.224.24]:19732 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727194AbeJBOjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 10:39:00 -0400
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20181002075700epoutp01c23a1032d1c77bd53be7c59eaf760c2d~Zu5qtdM4-1175311753epoutp01k;
        Tue,  2 Oct 2018 07:57:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20181002075700epoutp01c23a1032d1c77bd53be7c59eaf760c2d~Zu5qtdM4-1175311753epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538467020;
        bh=91plPAmqQwxbjQj7FX9mW7RKtFQSoqO31xP7UoooijQ=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=A//5Obzlp4UT1ch+GedsEW6a37EgvDtfZP2vIgW+9Xi1NL4xC25JCCXyij0slpGw+
         qyifuAgIDilIRUm9z1X8aDI3or/eumaRSrPUJM6e2WGMVbJJMnhSpLYHKmIXTXOhJg
         cZhx5IHPuQ7ltmP2ltdG3WRvI3nghb4Y+mvsOago=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20181002075700epcas2p4bc8c4eed3e5f2c6fab544e5406c1d1b5~Zu5qc2r-q1453414534epcas2p40;
        Tue,  2 Oct 2018 07:57:00 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        2D.96.04072.CC423BB5; Tue,  2 Oct 2018 16:57:00 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20181002075700epcas2p1e1650ae02c1d6b1bfb946b146d4ce223~Zu5qRZBGQ1000510005epcas2p1b;
        Tue,  2 Oct 2018 07:57:00 +0000 (GMT)
X-AuditID: b6c32a47-5cfff70000000fe8-b1-5bb324cc8818
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D8.74.03633.CC423BB5; Tue,  2 Oct 2018 16:57:00 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from localhost ([106.116.147.110]) by mmp1.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0PFY000PLOQYIR70@mmp1.samsung.com>; Tue, 02 Oct 2018 16:57:00
        +0900 (KST)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH] dt-bindings: hwrng: Add Samsung Exynos 5250+ True RNG
 bindings
Date:   Tue, 02 Oct 2018 09:56:33 +0200
Message-id: <20181002075633.25658-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.19.0
In-reply-to: <CAL_JsqLoZfU+DMxHJg7ZqD06dgcsxiDbYYW99x8H4C0sOwdiiw@mail.gmail.com>
Organization: Samsung R&D Institute Poland
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWy7bCmue4Zlc3RBhcvSlnMvv+YxeLmoRWM
        Fpd3zWGzmHF+H5NF694j7A6sHptWdbJ5fFl1jdmjb8sqRo/Pm+QCWKK4bFJSczLLUov07RK4
        Mj5vvsZUMIez4sLeFtYGxofsXYwcHBICJhLvzuR1MXJxCAnsYJS4tHQZC4TznVFi6dtm1i5G
        TrCiKzc/sEIkdjNK/Ft0jh0kwSsgKPFj8j0WkEnMAvISRy5lg4SZBTQltu5ezw5R/45R4nXn
        A7BBbAKOEv1LT4DZIgIqEhue32IGKWIWOMIo8WfJTrCEsECgxMqPd8AWsAioSrw4foENYpm1
        xIuDFxghLpKXmHV6GhOIzSkQLLHwD8QCfgEtiTVN18FekBDYwyZxc/tldogGF4nPPcugbGGJ
        V8e3QNnSEs9WbYQaWi7x40YfK0RzC6PE4gmdUEXWEn9WTWSD+I1PouPwX2jg8Up0tAlBlHhI
        nDp0GOrlJYwSN07sYpnAKDsLKZRmIUJpFlIoLWBkXsUollpQnJueWmxUYKxXnJhbXJqXrpec
        n7uJEZwGtNx3MG4753OIUYCDUYmHl0F+U7QQa2JZcWXuIUYJDmYlEd7/oUAh3pTEyqrUovz4
        otKc1OJDjNIcLErivA+l50YLCaQnlqRmp6YWpBbBZJk4OKUaGNc1bl20QnjtpT1tXdV/9poa
        8c3u59dSujWlTln/f/LUsFppxeWxyb7phw029yyX2Mt1xGrLRA+JGUHhjI8Mps5aOXNZkuvd
        TsXzyY4K2yIefMxp1vL27H1/bfaFM5+VNxtvKO/t9ozX9Z8hymzQFatbd9pDfydjm4qg1OHd
        Z2PnnTdlcHTYpcRSnJFoqMVcVJwIAG3Xl9v/AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t9jAd0zKpujDd5P4raYff8xi8XNQysY
        LS7vmsNmMeP8PiaL1r1H2B1YPTat6mTz+LLqGrNH35ZVjB6fN8kFsERx2aSk5mSWpRbp2yVw
        ZXzefI2pYA5nxYW9LawNjA/Zuxg5OSQETCSu3PzA2sXIxSEksJNR4uTUpcwgCV4BQYkfk++x
        dDFycDALyEscuZQNEmYWUJeYNG8RM0T9O0aJRRcOM4Ik2AQcJfqXnmAFsUUEVCQ2PL8FVsQs
        cAxo6PG7YAlhAX+J5idn2EBsFgFViRfHL7BBLLOWeHHwAiPERfISs05PYwJZzCkQLHGi3wsk
        LCQQIHH/zgImEJtfQEtiTdN1lgmMArOQnDoL4dRZSE5dwMi8ilEytaA4Nz232KjAKC+1XK84
        Mbe4NC9dLzk/dxMjMJi3Hdbq38H4eEn8IUYBDkYlHl4G+U3RQqyJZcWVuYcYJTiYlUR4/4cC
        hXhTEiurUovy44tKc1KLDzFKc7AoifPy5x+LFBJITyxJzU5NLUgtgskycXBKNTCq7xBkftxW
        YKnrytLN2Hq3Oc/cwMfy0HHD+VOf7kmfeCfu0DLO+U82fd/CzX+Gb/vlE7+qu38y3DrzbN0q
        q081awsyrcSOq+r+6NPZEe5zPcQ107A7tnFG/hl9U9bJVzpyapYIZap+i7RwtJKoL0hlq0sp
        4+TYPOPnVFO7Azpb1HZs5Ck5E63EUpyRaKjFXFScCACsiGW5YgIAAA==
X-CMS-MailID: 20181002075700epcas2p1e1650ae02c1d6b1bfb946b146d4ce223
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20181002075700epcas2p1e1650ae02c1d6b1bfb946b146d4ce223
References: <CAL_JsqLoZfU+DMxHJg7ZqD06dgcsxiDbYYW99x8H4C0sOwdiiw@mail.gmail.com>
        <CGME20181002075700epcas2p1e1650ae02c1d6b1bfb946b146d4ce223@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding documentation for the True Random Number Generator
found on Samsung Exynos 5250+ SoCs.

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
2.19.0

