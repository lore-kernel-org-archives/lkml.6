Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AEB2C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:06:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 076092229F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:06:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="XWRgIRhS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731947AbfBLSF7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:59 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22645 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731911AbfBLSF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:57 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190212180554epoutp02a26abdd3b65bcf8d76dfe5aa09ec47a6~CsARot5NF2787127871epoutp02C;
        Tue, 12 Feb 2019 18:05:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190212180554epoutp02a26abdd3b65bcf8d76dfe5aa09ec47a6~CsARot5NF2787127871epoutp02C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994754;
        bh=4BtKSXjyFABIOkbv9PZbmRs71Y9FKXhmWxqvv2v/ukY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=XWRgIRhSFizR5aErVwDhtQhpu52/RumtljTJnEbUXWlu5KMfcZ/roeFtb0Zx4vXWO
         vNuSMuy7rtfuTG3Z+ehS/Fz0sDzUAkWRuqpO+o3udUaT6deCmGMe2K5cDFJCkpWpq7
         ljlXNH7Q28Sf00nCaqKE1E3Rl+jpHMh7HQUjQdA8=
Received: from epsmges2p3.samsung.com (unknown [182.195.42.71]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180554epcas2p13facab9c192e3e6788ee074a7737dd2f~CsARI73Hn1897218972epcas2p1p;
        Tue, 12 Feb 2019 18:05:54 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        5A.49.04134.20B036C5; Wed, 13 Feb 2019 03:05:54 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180553epcas2p10fb4f2f465392de8609c127ed3f33ab4~CsAQY2cbs2517825178epcas2p1P;
        Tue, 12 Feb 2019 18:05:53 +0000 (GMT)
X-AuditID: b6c32a47-8abff70000001026-a4-5c630b021f2b
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 8D.30.03689.10B036C5; Wed, 13 Feb
        2019 03:05:53 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:53 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 21/21] ARM: dts: exynos5422-odroidxu4: Add support for
 secondary DAI
Date:   Tue, 12 Feb 2019 19:03:42 +0100
Message-id: <20190212180342.32040-22-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWy7bCmmS4Td3KMwcx3nBZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MK0clC86wV+z9/ImxgXEaWxcjJ4eE
        gIlE7+fbQDYXh5DADkaJqxtPQjnfGSXuT1rHDFM19ec1FojEBkaJplUPGCGcX4wSk7o/MIJU
        sQkYSvQe7QOzRQTEJG7P6WQGKWIWaGGSmDN3KZDDwSEsECnRss0ApIZFQFViRdMCVhCbV8BG
        ounmHBaIbfIS53vXsYPYnEDxZwu/sUDUCEr8mHwPzGYGqjl45TnYRRICB9gk3sy4yQYyX0LA
        RWLfUzeIOdISz1ZtZISwqyV2be9mhqjvYJRoubAd6jVricPHL7JCDOWT6Dj8lx1iDq9ER5sQ
        hOkhcWxRHsS//YwS26a9Yp7AKDULyUmzkJy0gJFpFaNYakFxbnpqsVGBsV5xYm5xaV66XnJ+
        7iZGcIRrue9g3HbO5xCjAAejEg/viqNJMUKsiWXFlbmHGCU4mJVEeNOYk2OEeFMSK6tSi/Lj
        i0pzUosPMUpzsCiJ8z6UnhstJJCeWJKanZpakFoEk2Xi4JRqYNT6vscl89euVMH0L0+tnsmW
        NzRyf97ZkWr18u2DPUn5f0Mnzt5w3cvx1r098VLp2+PmT3uaLXDhxpvJYscZNF59qWR7HPD3
        N3fJvwsq2/OOR22dUrHgLLvbf+3bWovclnhmbv+nuz84rSL8qcoTzheKTtEaDQ9/fZjGI3xX
        Z71Ht3KnWinvWTElluKMREMt5qLiRABFLCEm7AIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJLMWRmVeSWpSXmKPExsVy+t9jQV1G7uQYg60rhC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZV45KFpxhr9j7+RNjA+M0ti5GTg4J
        AROJqT+vsXQxcnEICaxjlFh8u5cZwvnFKLF9xx0WkCo2AUOJ3qN9jCC2iICYxO05nWBFzAJN
        TBK7bl9k72Lk4BAWiJRo2WYAUsMioCqxomkBK4jNK2Aj0XRzDgvENnmJ873r2EFsTqD4s4Xf
        WEBahQSsJa5ssoUoF5T4MfkeWDkzUPnBK89ZJjDyzUKSmoUktYCRaRWjZGpBcW56brFRgVFe
        arlecWJucWleul5yfu4mRmAAbzus1b+D8fGS+EOMAhyMSjy8K44mxQixJpYVV+YeYpTgYFYS
        4U1jTo4R4k1JrKxKLcqPLyrNSS0+xCjNwaIkzsuffyxSSCA9sSQ1OzW1ILUIJsvEwSnVwNgj
        4vhU1seSq2C9wOPJ/u5THU79X6P0xC8xLu24WO/xS3aRzO/udJx5WfP97FW2tM+bA5/P+c5n
        selKEN8iEQtTtneG/VVHvGYfd1M8w7nbNtQvY7nGBUahS1EFAvP6b6u9j3hQ8UpTW59VJLYg
        62zCpXSrPeUexxmaJLdo6ih5n1uQ7uw2V4mlOCPRUIu5qDgRABX47HVcAgAA
X-CMS-MailID: 20190212180553epcas2p10fb4f2f465392de8609c127ed3f33ab4
CMS-TYPE: 102P
X-CMS-RootMailID: 20190212180553epcas2p10fb4f2f465392de8609c127ed3f33ab4
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180553epcas2p10fb4f2f465392de8609c127ed3f33ab4@epcas2p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends DAPM routing and adds secondary CPU DAI entry
to support the secondary audio PCM interface on Odroid XU4.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu4.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu4.dts b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
index 122174ea9e0a..892d389d6d09 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu4.dts
+++ b/arch/arm/boot/dts/exynos5422-odroidxu4.dts
@@ -33,6 +33,8 @@
 		compatible = "samsung,odroid-xu3-audio";
 		model = "Odroid-XU4";
 
+		samsung,audio-routing = "I2S Playback", "Mixer DAI TX";
+
 		assigned-clocks = <&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
 				<&clock CLK_MOUT_USER_MAU_EPLL>,
@@ -58,7 +60,7 @@
 				<196608000>;
 
 		cpu {
-			sound-dai = <&i2s0 0>;
+			sound-dai = <&i2s0 0>, <&i2s0 1>;
 		};
 
 		codec {
-- 
2.20.1

