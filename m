Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED39EC282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B46DD222C6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 18:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Rnv6qFrV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731932AbfBLSFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 13:05:55 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:40243 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731911AbfBLSFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 13:05:52 -0500
Received: from epcas1p1.samsung.com (unknown [182.195.41.45])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20190212180550epoutp01ddab7d48f35b37991e003dc1f293df05~CsANrxs0c1898118981epoutp01u;
        Tue, 12 Feb 2019 18:05:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20190212180550epoutp01ddab7d48f35b37991e003dc1f293df05~CsANrxs0c1898118981epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549994750;
        bh=J2fEmrpa9P+9AF6G1uzK4HmVkrvrdiclGfzK5O2Xtxk=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=Rnv6qFrVAlFyMyFiYkcJu7E6nZ35F2JXSEMQFVFa2AciVqY4jwtqiLwn6iNXVwJRi
         84t3ByJaFJMysy7fjAgS3DbOYBk4vY7G4ekxe7A/ORzMMF6ifNltJbEUPrYGwjOOMo
         QM1Ord+n0yCLaUlEvn2jnaztDZL1YwDM6XfLJw+A=
Received: from epsmges1p1.samsung.com (unknown [182.195.42.53]) by
        epcas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190212180550epcas1p162903ddb8396924783c2032cb17286f6~CsANbKwlT0083900839epcas1p1t;
        Tue, 12 Feb 2019 18:05:50 +0000 (GMT)
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
        epsmges1p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        30.CF.04074.EFA036C5; Wed, 13 Feb 2019 03:05:50 +0900 (KST)
Received: from epsmgms2p1new.samsung.com (unknown [182.195.42.142]) by
        epcas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190212180549epcas1p20b5cc51ba13fb934056196d1b89d67ab~CsANCKXWQ0631306313epcas1p2U;
        Tue, 12 Feb 2019 18:05:49 +0000 (GMT)
X-AuditID: b6c32a35-27fff70000000fea-e7-5c630afea74f
Received: from epmmp2 ( [203.254.227.17]) by epsmgms2p1new.samsung.com
        (Symantec Messaging Gateway) with SMTP id A7.11.04015.DFA036C5; Wed, 13 Feb
        2019 03:05:49 +0900 (KST)
Received: from AMDC3061.digital.local ([106.116.147.40]) by mmp2.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PMT0024XRJ2FB10@mmp2.samsung.com>; Wed, 13 Feb 2019
        03:05:49 +0900 (KST)
From:   Sylwester Nawrocki <s.nawrocki@samsung.com>
To:     broonie@kernel.org
Cc:     lgirdwood@gmail.com, krzk@kernel.org, sbkim73@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: [PATCH v2 20/21] ARM: dts: exynos5422-odroidxu3: Add support for
 secondary DAI
Date:   Tue, 12 Feb 2019 19:03:41 +0100
Message-id: <20190212180342.32040-21-s.nawrocki@samsung.com>
X-Mailer: git-send-email 2.20.1
In-reply-to: <20190212180342.32040-1-s.nawrocki@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNIsWRmVeSWpSXmKPExsWy7bCmnu4/ruQYg3k97BZXLh5istg4Yz2r
        xdSHT9gszp/fwG7x7UoHk8XlXXPYLGac38dksfbIXXaLw2/aWS0urvjC5MDlseFzE5vHzll3
        2T02repk8+jbsorR4/MmuQDWKC6blNSczLLUIn27BK6MH9O+Mxfs56g48qyLuYHxA1sXIyeH
        hICJxNl3x4FsLg4hgR2MEqfvH4ZyvjNKtF/+xwJT9aythRUisQEocWgGO4Tzi1GipWcK2Cw2
        AUOJ3qN9jCC2iICYxO05ncwgRcwCLUwSc+YuZQZJCAtEShydfgnMZhFQlZgxczWYzStgI7Fy
        Asw6eYnzvevYQWxOoPizhd9YIGoEJX5MvgdmMwPVHLzyHKr+AJvEubm+ELaLxNzXPUBxDiBb
        WuLSUVuIcLXEru3dYPdICHQAHX1hOzNEwlri8PGLrBAz+STefe1hhejllehoE4Io8ZDYvfEB
        M8TD/YwSc259Y5vAKDULyUmzkJy0gJFpFaNYakFxbnpqsWGBoV5xYm5xaV66XnJ+7iZGcJRr
        me5gnHLO5xCjAAejEg/viqNJMUKsiWXFlbmHGCU4mJVEeNOYk2OEeFMSK6tSi/Lji0pzUosP
        MUpzsCiJ8653cI4REkhPLEnNTk0tSC2CyTJxcEo1MObfq/UrDFq2bHIIN+us08sCFDeZuks6
        r3o3ndPYeirDu9o1/eJrDb03Te7uDJ9txvbi2b91bX+MJuxPOGg6mTH7hYCy6dIJzBd/nrFd
        1SvE7hV7ac6Z28svbxK/u1eiN2VCks4q6dVRZao7Lk8TXVjytcP2sm7Nq3N8q66l1d4I8H3M
        5+h2UF6JpTgj0VCLuag4EQDtK2Cd7gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNLMWRmVeSWpSXmKPExsVy+t9jQd2/XMkxBsem6llcuXiIyWLjjPWs
        FlMfPmGzOH9+A7vFtysdTBaXd81hs5hxfh+Txdojd9ktDr9pZ7W4uOILkwOXx4bPTWweO2fd
        ZffYtKqTzaNvyypGj8+b5AJYo7hsUlJzMstSi/TtErgyfkz7zlywn6PiyLMu5gbGD2xdjJwc
        EgImEs/aWli7GLk4hATWMUoc6XzKCOH8YpS4OOs7E0gVm4ChRO/RPkYQW0RATOL2nE5mkCJm
        gSYmiV23L7KDJIQFIiWOTr/EDGKzCKhKzJi5GszmFbCRWDnhHwvEOnmJ873rwOo5geLPFn4D
        inMAbbOWuLLJFqJcUOLH5Htg5cxA5QevPGeZwMg3C0lqFpLUAkamVYySqQXFuem5xUYFhnmp
        5XrFibnFpXnpesn5uZsYgUG87bBW3w7G+0viDzEKcDAq8fCuOJoUI8SaWFZcmXuIUYKDWUmE
        N405OUaINyWxsiq1KD++qDQntfgQozQHi5I47+28Y5FCAumJJanZqakFqUUwWSYOTqkGxsij
        4bne8iazWNb87aifkbd0d5SzreQkD5fda/8kJ/zM8MpvkvXy+WaaMfc0R/h7nqa06YzT3z8N
        WurvIvPmYVPWA4Mt0b9OzvXd1btm3UrpVlX9nJJJ77ef1yt+/Ts2baPQim2F05ZtPxV9Wezo
        r5N3ioVKPAsZ/3Gk68hzTt2Yk5wnXnvzjhJLcUaioRZzUXEiAJ6UDwReAgAA
X-CMS-MailID: 20190212180549epcas1p20b5cc51ba13fb934056196d1b89d67ab
CMS-TYPE: 101P
X-CMS-RootMailID: 20190212180549epcas1p20b5cc51ba13fb934056196d1b89d67ab
References: <20190212180342.32040-1-s.nawrocki@samsung.com>
        <CGME20190212180549epcas1p20b5cc51ba13fb934056196d1b89d67ab@epcas1p2.samsung.com>
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

