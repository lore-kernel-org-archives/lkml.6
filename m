Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FA4C282C4
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CE5F21917
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X2sEsIpK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727571AbfBGRCy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:02:54 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:46975 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbfBGRCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:02:53 -0500
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20190207170251epoutp024f250e9dcd5174868bfbdf066908210d~BI6yjA48C0594405944epoutp02L;
        Thu,  7 Feb 2019 17:02:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20190207170251epoutp024f250e9dcd5174868bfbdf066908210d~BI6yjA48C0594405944epoutp02L
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558971;
        bh=4BtKSXjyFABIOkbv9PZbmRs71Y9FKXhmWxqvv2v/ukY=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=X2sEsIpKS6rXIondiO2s2h26PWBV7P/GJIYLFW3fC/qPTgTZk5irdWGTE8P6KEI4p
         Wn6mYIYTw7kLUQbJSjbSIdsDgGzlWsCntP9eo8Y/OP26rTMsM7udhEOJe6BqERFKNM
         S5310aLXDsxYcS+79onPW9ZHU9ntupoW0kVoM6Hg=
Received: from epsmges2p1.samsung.com (unknown [182.195.42.69]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170250epcas2p33d3f59e286f844df3ea271ea9b8c5c26~BI6xfrRia2816128161epcas2p3c;
        Thu,  7 Feb 2019 17:02:50 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        05.A7.04138.9B46C5C5; Fri,  8 Feb 2019 02:02:49 +0900 (KST)
Received: from epsmgms2p2new.samsung.com (unknown [182.195.42.143]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170249epcas2p3ece5f4f132365051527cb0d3a5d80b02~BI6xRxv4t0502405024epcas2p32;
        Thu,  7 Feb 2019 17:02:49 +0000 (GMT)
X-AuditID: b6c32a45-60bff7000000102a-49-5c5c64b98e3a
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p2new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 7C.C8.03689.9B46C5C5; Fri,  8 Feb
        2019 02:02:49 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00KT6FC5GS70@mmp2.samsung.com>; Fri, 08 Feb 2019
        02:02:49 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 22/22] ARM: dts: exynos5422-odroidxu4: Add support for
 secondary DAI
Date:   Thu, 07 Feb 2019 18:02:18 +0100
Message-id: <20190207170218.851-2-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190207170218.851-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7bCmhe7OlJgYg/NLrC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZV45KFpxhr9j7+RNjA+M0ti5GTg4J
        AROJ3XO/s3cxcnEICexglFi1vIkRwvnOKPF97Td2mKrnC3uZIRIbGCUevdkLVfWLUeLtz9eM
        IFVsAoYSvUf7wGwRAWGJe0uXg81lFmhnklh76RozSEJYIEziydV3LF2MHBwsAqoSLefB6nkF
        LCWuf37MArFNXuJ87zqwzZwCVhJrt05kgagRlPgx+R6YzQxUc/DKc6j6PWwSfQ1yELaLRMPL
        lUwQtrTEs1UbGSHsaold27vBPpAQ6GCUaLmwnRkiYS1x+PhFVoihfBIdh/+yg9wmIcAr0dEm
        BFHiITF/cS/Uw72MEtueH2adwCg1C8lNs5DctICRaRWjWGpBcW56arFRgaFecWJucWleul5y
        fu4mRnCMa7nuYJxxzucQowAHoxIP7wXtmBgh1sSy4srcQ4wSHMxKIryyCUAh3pTEyqrUovz4
        otKc1OJDjNIcLErivI+k50YLCaQnlqRmp6YWpBbBZJk4OKUaGNlO1sgsn7rgrvm9JVu92hfv
        sD115dsHpoxXb6+rb+va8Mn450bRzuS5V+TEllw6NOtL+eMvHEvE0pb0Fx91ypoSdNNWNoHP
        Wtqm6uKmxkqG1T7xHe6s/t+Dbtz5oRvu52sc9pjzRye/a3pJRFLLzBQB9lUmPbmzdp8Rmnz5
        0NKGdqXIKcWKXUosxRmJhlrMRcWJACe0U27tAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jQd2dKTExBmtfaFlcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyrhyVLDjDXrH38yfGBsZpbF2MnBwS
        AiYSzxf2MncxcnEICaxjlFh6vpsdwvnFKHHsaRtYFZuAoUTv0T5GEFtEQFji3tLlYEXMAq1M
        Emter2QHSQgLhEk8ufqOpYuRg4NFQFWi5TxYPa+ApcT1z49ZILbJS5zvXQdWzilgJbF260Sw
        uBBQzb1zE1kh6gUlfky+BxZnBqo/eOU5ywRGvllIUrOQpBYwMq1ilEwtKM5Nzy02KjDKSy3X
        K07MLS7NS9dLzs/dxAgM4W2Htfp3MD5eEn+IUYCDUYmH94J2TIwQa2JZcWXuIUYJDmYlEV7Z
        BKAQb0piZVVqUX58UWlOavEhRmkOFiVxXv78Y5FCAumJJanZqakFqUUwWSYOTqkGxlkd574J
        1r62inppZ1idEul889RSbZbbZqtVTD8eC8x08E/Y8Tn2a1Q8x27tlkf/6taZRP3w+vjusKNw
        8f7DwTFX5/7IX9vPLXp/gaM/92GrJ0F8QmGTkyMdtd34C7TeecY6L4/59sNO5N0Hj84Ipmi3
        TbO/bZBcNp1VyK4wVH4F/551/orRSizFGYmGWsxFxYkAzAGNyV0CAAA=
X-CMS-MailID: 20190207170249epcas2p3ece5f4f132365051527cb0d3a5d80b02
CMS-TYPE: 102P
X-CMS-RootMailID: 20190207170249epcas2p3ece5f4f132365051527cb0d3a5d80b02
References: <20190207170218.851-1-s.nawrocki@samsung.com>
        <CGME20190207170249epcas2p3ece5f4f132365051527cb0d3a5d80b02@epcas2p3.samsung.com>
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

