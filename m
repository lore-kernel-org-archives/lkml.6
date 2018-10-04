Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561F7C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D51121470
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 07:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nJJA1+9i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D51121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbeJDOim (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 10:38:42 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:47508 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbeJDOil (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 10:38:41 -0400
Received: from epcas1p3.samsung.com (unknown [182.195.41.47])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20181004074641epoutp025fdf3ad3dc5a83434faf2e9b6fcb8a96~aWDPAB5l71101511015epoutp02r;
        Thu,  4 Oct 2018 07:46:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20181004074641epoutp025fdf3ad3dc5a83434faf2e9b6fcb8a96~aWDPAB5l71101511015epoutp02r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1538639202;
        bh=NjhQdx0aoidxJjW1SUy4wzpJrZ3jgeMoOpJYL/KdG4U=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=nJJA1+9iHprSjK3lKnnJ02Ez5hPsP+yXsTjbvrhApbTAN9bGUT4hFtJmUvKSsNoHs
         SmZRFYBO1nyjGUWh2JaQpLv3vBfIXVdHYWX/Jz0cHBnAHRMm6blMs6mjK5nvjdGEmf
         gdXqnmUH6Z6asUlW6w3IO83fMRTUFUMfKBhBjAtk=
Received: from epsmges1p2.samsung.com (unknown [182.195.42.54]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181004074641epcas1p25903a7c1b6629210c4673fc73c6e6e23~aWDOx4KNK1895018950epcas1p2v;
        Thu,  4 Oct 2018 07:46:41 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        16.25.04078.165C5BB5; Thu,  4 Oct 2018 16:46:41 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181004074641epcas1p287225c19a28c713327725d089068f960~aWDOm4pHm0909909099epcas1p2D;
        Thu,  4 Oct 2018 07:46:41 +0000 (GMT)
X-AuditID: b6c32a36-b25ff70000000fee-21-5bb5c5619282
Received: from epmmp1.local.host ( [203.254.227.16]) by
        epsmgms2p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        FC.2D.03743.165C5BB5; Thu,  4 Oct 2018 16:46:41 +0900 (KST)
MIME-version: 1.0
Content-transfer-encoding: 8BIT
Content-type: text/plain; charset="UTF-8"
Received: from localhost ([106.116.147.110]) by mmp1.samsung.com (Oracle
        Communications Messaging Server 7.0.5.31.0 64bit (built May  5 2014)) with
        ESMTPA id <0PG200HMWDLRQV00@mmp1.samsung.com>; Thu, 04 Oct 2018 16:46:41
        +0900 (KST)
From:   =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Joe Perches <joe@perches.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        =?UTF-8?q?=C5=81ukasz=20Stelmach?= <l.stelmach@samsung.com>
Subject: [PATCH v5.1] dt-bindings: hwrng: Add Samsung Exynos 5250+ True RNG
 bindings
Date:   Thu, 04 Oct 2018 09:45:57 +0200
Message-id: <20181004074557.10472-1-l.stelmach@samsung.com>
X-Mailer: git-send-email 2.19.0
In-reply-to: <20181002075633.25658-1-l.stelmach@samsung.com>
Organization: Samsung R&D Institute Poland
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWy7bCmnm7i0a3RBqumaVvMvv+YxeLmoRWM
        Fpd3zWGzmHF+H5NF694j7A6sHptWdbJ5fFl1jdmjb8sqRo/Pm+QCWKK4bFJSczLLUov07RK4
        MvYf4C7Yx1XRcecVUwPjM44uRk4OCQETiecLf7B1MXJxCAnsYJS4/+EzM4TznVFiffthdpiq
        n//vs0IkdjNKXJ6+mgUkwSsgKPFj8j0gm4ODWUBe4silbJAws4CmxNbd69kh6t8xSvxftRms
        nk3AUaJ/6QlWEFtEQEViw/NbYNuYBY4wSvxZshMsISwQJnH25iEwm0VAVWLn8Q2MEMusJZpm
        bmODuEheYtbpaUwgNqeAjcSJZbPB4vwCWhJrmq6zgAyVENjBJjHjYBcjRIOLxNeGGSwQtrDE
        q+Nb2EGulhCQlrh01BYiXC7x40YfK0RvC6PE4gmdUO9bS/xZNZEN4jU+iXdfe1ghenklOtqE
        IEwPiS9r4yEe7meUWPPmOdsERtlZSGE0CxFGs5DCaAEj8ypGsdSC4tz01GLDAiO94sTc4tK8
        dL3k/NxNjOAUoGW2g3HROZ9DjAIcjEo8vB3vtkQLsSaWFVfmHmKU4GBWEuE1XLA1Wog3JbGy
        KrUoP76oNCe1+BCjNAeLkjjvE6m50UIC6YklqdmpqQWpRTBZJg5OqQbGRXY6f0LihLbvNdq4
        Y+mWvMaw9lchDRNcC1qL83/9/nU55ET4lI9qKpnb/O1OKCgK/Fhf8qZ1WyJn3vcG1eDah0mO
        Zs1/9iez/n17t7D8gZaZxBan0BSlRR0fzu06aPiOgVPAOjicg7Njtb3jRz7xelbJNw84mH4y
        eVy3ePDpe2lG3Xcx6SolluKMREMt5qLiRACeXVgV/QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPLMWRmVeSWpSXmKPExsVy+t9jAd3Eo1ujDb52yljMvv+YxeLmoRWM
        Fpd3zWGzmHF+H5NF694j7A6sHptWdbJ5fFl1jdmjb8sqRo/Pm+QCWKK4bFJSczLLUov07RK4
        MvYf4C7Yx1XRcecVUwPjM44uRk4OCQETiZ//77N2MXJxCAnsZJRY/baLCSTBKyAo8WPyPZYu
        Rg4OZgF5iSOXskHCzALqEpPmLWKGqH/HKNG47h0rSIJNwFGif+kJMFtEQEViw/NbYEXMAscY
        JU4evwuWEBYIkzh78xCYzSKgKrHz+AZGiGXWEk0zt7FBXCQvMev0NLAjOAVsJE4smw0WFwKq
        mdv7iQXE5hfQkljTdJ1lAqPALCS3zkK4dRaSWxcwMq9ilEwtKM5Nzy02KjDMSy3XK07MLS7N
        S9dLzs/dxAgM5m2Htfp2MN5fEn+IUYCDUYmHt+Pdlmgh1sSy4srcQ4wSHMxKIryGC7ZGC/Gm
        JFZWpRblxxeV5qQWH2KU5mBREue9nXcsUkggPbEkNTs1tSC1CCbLxMEp1cDo9PvHZdsjx7QK
        Uyex5AatXOnWrGai/PGmxHbHRRleJSy3F5Z/PXyGJaNHPeRSkAJTqGuw7VVzQ+2vM4U5vjw5
        4Su6tCMmyS6r8enD8ielAS7Nfk4xhjk975ZHsC0L/SB+0JNjVfx7wdNvdR0nT5rEZG+c/5iN
        IXRj8qWXITo/H8j52j3afk+JpTgj0VCLuag4EQDQzUdvYgIAAA==
X-CMS-MailID: 20181004074641epcas1p287225c19a28c713327725d089068f960
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20181004074641epcas1p287225c19a28c713327725d089068f960
References: <20181002075633.25658-1-l.stelmach@samsung.com>
        <CGME20181004074641epcas1p287225c19a28c713327725d089068f960@epcas1p2.samsung.com>
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

This time with proper tags, as requested.

Kind regards,
ŁS

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

