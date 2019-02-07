Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD75C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10AAE21872
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 17:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="acZJ2Ap5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfBGRCt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 12:02:49 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:63835 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726796AbfBGRCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 12:02:47 -0500
Received: from epcas1p2.samsung.com (unknown [182.195.41.46])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190207170244epoutp01c80b02be00c9a0574b6b80a7c19ce577~BI6sl5Vrt1148811488epoutp01e;
        Thu,  7 Feb 2019 17:02:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190207170244epoutp01c80b02be00c9a0574b6b80a7c19ce577~BI6sl5Vrt1148811488epoutp01e
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549558964;
        bh=J2fEmrpa9P+9AF6G1uzK4HmVkrvrdiclGfzK5O2Xtxk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=acZJ2Ap5Ji9PvsYiMxa7qjLGjAY0bC4dgsEzYo1kgw/AM8rFncCnVmkeL6vbSvCYU
         yuQw6v5cE9jsTM/UdFgRRxhDf5XrNa6eDsH8rvteyYScpDu+nhARtj3SdVNZD3xs7R
         XyVQD6KPuH4UsjQDtyXSNsOVU0FVUnnWuHl5MfXA=
Received: from epsmges1p3.samsung.com (unknown [182.195.42.55]) by
        epcas1p4.samsung.com (KnoxPortal) with ESMTP id
        20190207170244epcas1p487d24a7d4290f14f00ccc97ba06d9584~BI6sSu1Nj1738517385epcas1p45;
        Thu,  7 Feb 2019 17:02:44 +0000 (GMT)
Received: from epcas1p4.samsung.com ( [182.195.41.48]) by
        epsmges1p3.samsung.com (Symantec Messaging Gateway) with SMTP id
        22.E7.04069.4B46C5C5; Fri,  8 Feb 2019 02:02:44 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p3.samsung.com (KnoxPortal) with ESMTP id
        20190207170244epcas1p3f0037d3a98ed63b71e8daf14090befe3~BI6sEIiLK2941329413epcas1p3E;
        Thu,  7 Feb 2019 17:02:44 +0000 (GMT)
X-AuditID: b6c32a37-971ff70000000fe5-a8-5c5c64b4d798
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id 9B.D8.04015.4B46C5C5; Fri,  8 Feb
        2019 02:02:44 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMK00KT6FC5GS70@mmp2.samsung.com>; Fri, 08 Feb 2019
        02:02:44 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     krzk@kernel.org
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH 21/22] ARM: dts: exynos5422-odroidxu3: Add support for
 secondary DAI
Date:   Thu, 07 Feb 2019 18:02:17 +0100
Message-id: <20190207170218.851-1-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWy7bCmge6WlJgYg7XbJC2uXDzEZLFxxnpW
        i6kPn7BZnD+/gd3i25UOJovLu+awWcw4v4/JYu2Ru+wWh9+0s1pcXPGFyYHLY8PnJjaPnbPu
        sntsWtXJ5tG3ZRWjx+dNcgGsUVw2Kak5mWWpRfp2CVwZP6Z9Zy7Yz1Fx5FkXcwPjB7YuRk4O
        CQETiYdPLjN3MXJxCAnsYJRY1fKXFcL5zihx89EuRpiq2dM/QSU2MEp0LH3FBuH8YpTY8qiF
        FaSKTcBQovdoH1iHiICwxL2ly9lBipgF2pkk1l66xgySEBYIk/h5eSlYA4uAqsTR71/YQWxe
        AUuJY7duQ62Tlzjfuw4qLijxY/I9FhCbGSh+8MpzFpChEgIr2CT6X3ewQzS4SOx8+xcowQFk
        S0tcOmoLEa6W2LW9mxmivoNRouXCdmaIhLXE4eMXWSGG8km8+9rDCtHLK9HRJgRR4iGx+9JK
        sL1CArESe44uZZrAKDkLyUmzkJy0gJFpFaNYakFxbnpqsWGBsV5xYm5xaV66XnJ+7iZGcDRr
        me9g3HDO5xCjAAejEg+vhl5MjBBrYllxZe4hRgkOZiURXtkEoBBvSmJlVWpRfnxRaU5q8SFG
        aQ4WJXHe9Q7OMUIC6YklqdmpqQWpRTBZJg5OqQZGxlTDDoGK4tx1a69lxZ+04OT1Tzf59ZyX
        18TwSGeu8Zlbu5WZbT6dma088dmtZV/v2dyNudm72UuI1adT+tjCnvKDATmSpxmDC8/rKFpV
        FO/q3pWpt9qgXsUl+HQ0S0Wuqv39WRZz6k6cenxv65U7hhtFTlmeiMuNT+417dk43+6wXJbf
        vwYlluKMREMt5qLiRABX5U014gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrCLMWRmVeSWpSXmKPExsVy+t9jQd0tKTExBsuecFpcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyfkz7zlywn6PiyLMu5gbGD2xdjJwc
        EgImErOnf2LtYuTiEBJYxygxafklRgjnF6PExRfHmEGq2AQMJXqP9jGC2CICwhL3li5nByli
        FmhlkljzeiU7SEJYIEzi5+WlrCA2i4CqxNHvX8DivAKWEsdu3WaEWCcvcb53HVRcUOLH5Hss
        IDYzUPzglecsExh5ZiFJzUKSWsDItIpRMrWgODc9t9iowDAvtVyvODG3uDQvXS85P3cTIzAs
        tx3W6tvBeH9J/CFGAQ5GJR7eC9oxMUKsiWXFlbmHGCU4mJVEeGUTgEK8KYmVValF+fFFpTmp
        xYcYpTlYlMR5b+cdixQSSE8sSc1OTS1ILYLJMnFwSjUw2pvzz9zbvVHSMs6HN3NR6qNliRHT
        drxqbj8vwml841rQA6nLK/vyPHpnvmF5uo0t1/Xpc1fjr2senGE/4pFWzeC9c+mT5JZLJZme
        ie4d6nFV+ka9joKr3c1W2O79HrXi09Pnf5h1+lb2Pf780jHNO3bN5/v+Zz6w8hev9TzU+Evd
        VnRtJe9hJZbijERDLeai4kQATZHs7EcCAAA=
X-CMS-MailID: 20190207170244epcas1p3f0037d3a98ed63b71e8daf14090befe3
CMS-TYPE: 101P
X-CMS-RootMailID: 20190207170244epcas1p3f0037d3a98ed63b71e8daf14090befe3
References: <CGME20190207170244epcas1p3f0037d3a98ed63b71e8daf14090befe3@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends DAPM routing and adds secondary CPU DAI entry
to support the secondary audio PCM interface on Odroid XU3.

Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
---
 arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
index e84544b220b9..51a843bd65ed 100644
--- a/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
+++ b/arch/arm/boot/dts/exynos5422-odroidxu3-audio.dtsi
@@ -24,7 +24,9 @@
 			"Headphone Jack", "MICBIAS",
 			"IN1", "Headphone Jack",
 			"Speakers", "SPKL",
-			"Speakers", "SPKR";
+			"Speakers", "SPKR",
+			"I2S Playback", "Mixer DAI TX",
+			"HiFi Playback", "Mixer DAI TX";
 
 		assigned-clocks = <&clock CLK_MOUT_EPLL>,
 				<&clock CLK_MOUT_MAU_EPLL>,
@@ -51,7 +53,7 @@
 				<196608000>;
 
 		cpu {
-			sound-dai = <&i2s0 0>;
+			sound-dai = <&i2s0 0>, <&i2s0 1>;
 		};
 		codec {
 			sound-dai = <&hdmi>, <&max98090>;
-- 
2.20.1

