Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AF4C282DA
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A56621726
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BSbZ005k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731045AbfBAQri (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:47:38 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42698 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730974AbfBAQr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:47:26 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201164725euoutp01971d2db3a3387a13a692ce675744a185~-S1m-quj91970719707euoutp015
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 16:47:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201164725euoutp01971d2db3a3387a13a692ce675744a185~-S1m-quj91970719707euoutp015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549039645;
        bh=GE+bl6k1FIrWZyz5fhXcNfc9BA8rEl/CAbCBj0X1tsU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BSbZ005k6i6KpAOSukUNpyHUVNolx5Mw9P2h+xZCfMbfEUp6xCTPMheF8Ubkz3ueV
         O9VSABWvbYHlgXU3RTUv//7rfsExuCg8Lu5bAd0hbHswuGdJVF1ugisQRmQq0xkfGn
         ft7CHuwpJi6CkiYfCJrKKVoTmqdY5axsn6XJvOPY=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201164724eucas1p27667b4421bd318d2a5404ba7e7c3edbc~-S1lfFN5A2692626926eucas1p22;
        Fri,  1 Feb 2019 16:47:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 4C.FD.04294.B18745C5; Fri,  1
        Feb 2019 16:47:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190201164723eucas1p1ec009489584e1c85fd0d62270796e003~-S1ko624P0639206392eucas1p1L;
        Fri,  1 Feb 2019 16:47:23 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190201164722eusmtrp24c530abdf5435a2b8ccc7288d7ce73f8~-S1kZ7XcN0866308663eusmtrp2k;
        Fri,  1 Feb 2019 16:47:22 +0000 (GMT)
X-AuditID: cbfec7f4-835ff700000010c6-6f-5c54781be095
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 46.29.04284.A18745C5; Fri,  1
        Feb 2019 16:47:22 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201164722eusmtip260af2de1ad4fc7d769441ffbe05e8b24~-S1jpbhfE0078200782eusmtip2i;
        Fri,  1 Feb 2019 16:47:22 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>,
        Russell King <linux@armlinux.org.uk>,
        Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v4 8/8] ARM: exynos_defconfig: enable DMC driver
Date:   Fri,  1 Feb 2019 17:46:52 +0100
Message-Id: <1549039612-28905-9-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSe0hTYRzt2713u0qr66z8YWG1sLLwkRR9UNR6EKMHREmBCTnz4nvqrjNf
        1Xr6IEuMcmhoSaQtTZ2mth7ONRUtnWKlmZq4KFBnxaTogdV2J/13fuec33fODz6akDRQ3nSM
        MoVVKRXxUqE72dj+w+K/NC0kLGio1R/XaWsoXPShn8QDM58oXGbuoXDXxF0CX7VOEthiqRXh
        7nNTIjykWYb11jcU7jfcFGJ7vhlhreWZAJuuP0W42jwiwu/OVgrx86lsSuYh73/TR8hLNH2k
        XK/LFcrr75yRt04/EcivNOiQ3K73OSgKdd8aycbHpLKqwG3h7tGlZY+IpAEqbfJXpUiD/pB5
        yI0GZiO0tBQI85A7LWEqEVRfswn4YQbBPXM74gc7gs5WG5pbMf42krxQgaCsyfx/5byunspD
        NC1kAqBZl+xYWMRkwvBAC+HwEMwlAqq/dQocgicjg74KI+HAJOML9dZcZ4KY2Qu3H48SfJoP
        vO3JdWI3Zh/kWJuclYBpF0GdXiviTbuhwNjrusgTJjoaXPwy+POoTMBjDrpzdEIeZ0F2Z7PL
        swWed/Q5SxOMH9QYAnl6B4wP3icdNDALYNDm4aCJf7CwsYjgaTHkXJLw7rXQcLnXFbQEKqpu
        uB6Xw+yXTmcxCVOKoObVoQK0vPh/1i2EdMiLVXMJUSwXrGRPBnCKBE6tjAo4kZigR//+0ovZ
        jplmZPgdYUIMjaTzxbU/D4VJKEUql55gQkAT0kXinbEhYRJxpCI9g1UlHlep41nOhJbSpNRL
        nDlv7JiEiVKksHEsm8Sq5lQB7eatQZvWrwiGYer1xSOb13QF0aNeD42FoctlaSOSXl0VETp6
        euzs7qniwNJzcaHnI4qUp8ZPZh1AMou67fDX05rkDNmuB++vxbcldq1cyP3QLt7v6WtVx10c
        vvnxc7Vds2rPQlmv+EI4Puq2nV79fdqmpcrzI1/GlucbbOu7/Eoicmi7lOSiFRvWESpO8RcD
        CzjHRwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsVy+t/xe7pSFSExBrfbjSw2zljPajH9yWUW
        i+tfnrNazD9yjtXi1KtlzBb9j18zW5w/v4Hd4mzTG3aLWw0yFpseX2O1uLxrDpvF594jjBYz
        zu9jsjg0dS+jxdojd9ktbjeuYLM4/Kad1UHQ4/K1i8wesxsusnhsWtXJ5rF5Sb3HwXd7mDz6
        tqxi9Pi8SS6APUrPpii/tCRVISO/uMRWKdrQwkjP0NJCz8jEUs/Q2DzWyshUSd/OJiU1J7Ms
        tUjfLkEvY978ncwF11krXv9ewd7A+J+li5GTQ0LAROLAnwNANheHkMBSRol1Ez6zQiTEJCbt
        284OYQtL/LnWxQZR9IlR4vKZu0AOBwebgJ7EjlWFIDUiAvUS/W8ugdUwC0xhllg8/w7YIGEB
        B4mLyw8wg9gsAqoSmx93MoLYvAJeEgt332OGWCAncfNcJ5jNKeAt0fF4O1iNEFDNqn8HmCcw
        8i1gZFjFKJJaWpybnltsqFecmFtcmpeul5yfu4kRGCnbjv3cvIPx0sbgQ4wCHIxKPLwbfgXF
        CLEmlhVX5h5ilOBgVhLhdcoKiRHiTUmsrEotyo8vKs1JLT7EaAp01ERmKdHkfGAU55XEG5oa
        mltYGpobmxubWSiJ8543qIwSEkhPLEnNTk0tSC2C6WPi4JRqYIxTajOb86LT8vzf9S0n96zL
        XsuwTnmb8vufB97ELFnjcXOTLpNr8e6DSg3bNuw0dI7d8aIwd2t7OPd2a9kNwVMOPm09Md+c
        1Y5h3dUrq5WdTacoFriumaQmLFZuEnBz5nWp2q3HJj/QEumavNho9e/i7PKkWeXevIunB4d/
        r2P5H8jpqfwnSVuJpTgj0VCLuag4EQCqakeXqgIAAA==
X-CMS-MailID: 20190201164723eucas1p1ec009489584e1c85fd0d62270796e003
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201164723eucas1p1ec009489584e1c85fd0d62270796e003
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164723eucas1p1ec009489584e1c85fd0d62270796e003
References: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190201164723eucas1p1ec009489584e1c85fd0d62270796e003@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable driver for Dynamic Memory Controller dynamic frequency and
voltage scaling in Exynos5422 SoCs.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 arch/arm/configs/exynos_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index d635edf..b5dddcc 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -291,6 +291,7 @@ CONFIG_DEVFREQ_GOV_PERFORMANCE=y
 CONFIG_DEVFREQ_GOV_POWERSAVE=y
 CONFIG_DEVFREQ_GOV_USERSPACE=y
 CONFIG_ARM_EXYNOS_BUS_DEVFREQ=y
+CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ=y
 CONFIG_DEVFREQ_EVENT_EXYNOS_NOCP=y
 CONFIG_EXYNOS_IOMMU=y
 CONFIG_EXTCON=y
-- 
2.7.4

