Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB08FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A32B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 14:56:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="lgzNCo3a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A32B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727155AbeJPWrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 18:47:31 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:39212 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbeJPWrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 18:47:31 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181016145639euoutp0224774edee02cd761d54ba6966e91ce22~eHqEP1eso0414504145euoutp02c
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 14:56:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181016145639euoutp0224774edee02cd761d54ba6966e91ce22~eHqEP1eso0414504145euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1539701799;
        bh=Utc5er4Zxe7vWuFo+3uwuF1I9+UvTJV8mbYc0op2+nw=;
        h=From:To:Cc:Subject:Date:References:From;
        b=lgzNCo3aJTAmdaCPqQNYEoJuCH0PXGSZvF5i1vrJQ2cgi9RCnoJHHj+ewikzoFzU0
         4s9eqZf9xPKEAWLVJPFWF2W3dTZenJ9y2n4vvQoLrjNq7VHtZeAF1rIU5II6GmjOiO
         TLgddvby2beblnFlXMf69hu+9tGspvQb/BtDuNLE=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181016145638eucas1p28141a2eb71c0b9d988c96bb13c36e83c~eHqDfnJ932133821338eucas1p2G;
        Tue, 16 Oct 2018 14:56:38 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 7A.21.04806.62CF5CB5; Tue, 16
        Oct 2018 15:56:38 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F;
        Tue, 16 Oct 2018 14:56:37 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20181016145637eusmtrp290f955e10bfa0cc113817d97336e4d67~eHqCY2pZI3061930619eusmtrp2E;
        Tue, 16 Oct 2018 14:56:37 +0000 (GMT)
X-AuditID: cbfec7f5-34dff700000012c6-6f-5bc5fc2614ff
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id A8.AA.04128.52CF5CB5; Tue, 16
        Oct 2018 15:56:37 +0100 (BST)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181016145637eusmtip2853e0e9e2984f1cc262c80072ba0c3c2~eHqB3sHFu2833228332eusmtip2H;
        Tue, 16 Oct 2018 14:56:37 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 00/11] thermal: add new flag irq-mode for trip point
Date:   Tue, 16 Oct 2018 16:56:11 +0200
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA0VSW0hTYRzvO2eX43B2Ot6+zIZODA2ahQYHupAgdJ66CmFmOvM4JZ224zSj
        aMvLNtERhSYaanmLIS3nsGlepm2tKZpazBR7iCzQyoemZOGlHbbq7Xf9/76HD0OJx9wwLFde
        RCvk0jwxT8DpffXrzYF9G/bUg+qOCLK73sglF60aQDa595LNtkku2fzOxSXnVeGk6ZMHPKps
        45Bv+x/ySHeNDZDts9MIWTFo45OLH/W8E0Kqq6kLUH0NH/hU68ASQpkMOh614BrgUT1tt6lW
        /X0uNbIygFB6swFQbpPojOCi4GgWnZdbTCvijmcIcsZnYwungq7X2ecQFdjcWQX8MIgnwHpn
        P1IFBBiBPwHwebkaeMkqgDOfrT7HDWBjhYr7t2KsfcrxGp0AOq0u5F9lYczsIRjGwyXQYrjG
        6kF4I4DuoVY+S1DcCeB8Zy/CngrEk+DvJQ2PxRw8GjoMP4F3QgTnJnUoW4B4Bx/ecU2grCHE
        i2Hf5grPG0qClu4KXyEQLjvMfC8Oh9t9zYgXM3BCa/Dlb0KN0+LLHIEvHdNc9qUoHguN/XFe
        ORG+WGGnMA8OgO+/72Jl1APv9T7wyUKorSS86Rhorp7yDYXAzq4633EKur/VclhM4GlQOzLG
        vwtEDf+3WgAwgFBayeTLaCZeTpdIGGk+o5TLJFcK8k3A83PGtxxrFjC0kTkKcAyI/YXrs7ZU
        gistZkrzRwHEUHGQUDZjTyWEWdLSG7SiIF2hzKOZUbAH44hDhR1N3akELpMW0VdpupBW/HUR
        zC9MBU6lzESWx+eJalqIs8HVJWmyuaKE9qgOfcy2Ys1Irn5JTr+sVJizNYMlmSlf1yPbd0RM
        7K67pY7WEotVPxLPVVZEZ2+pA3UX0MlL8mMpUmvlFn+hLOrwSflpEDLVyKwmZzY8G1n37zLo
        zpPLkuE5y2vG1jNdWDbs2LJnBASnizlMjvTQflTBSP8As/YRHDUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJLMWRmVeSWpSXmKPExsVy+t/xe7qqf45GG3St1bTYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFrcaZCw2PQYyFrYtYbG4vGsOm8Xn3iOMFkuvX2SyaN17hN3iycM+
        NgdejzXz1jB67Jx1l91j8Z6XTB6bVnWyedy5tofNY/OSeo/FfZNZPQ6+28Pk0bdlFaPH501y
        AVxRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehmn
        r2sWXBCpmHb0JlMD41/+LkZODgkBE4n1U9exdDFycQgJLGWUOL5yPTNEQkxi0r7t7BC2sMSf
        a11sEEWfGCXW3LzE2MXIwcEmoCexY1UhSFxEYD6jxNFNl8GKmAUuM0p0T9sD1i0s4CLx62U7
        G4jNIqAqcXzVd0YQm1fAS+L68wOsEBvkJG6e62SewMizgJFhFaNIamlxbnpusZFecWJucWle
        ul5yfu4mRmCwbzv2c8sOxq53wYcYBTgYlXh4f1w/Ei3EmlhWXJl7iFGCg1lJhDf90tFoId6U
        xMqq1KL8+KLSnNTiQ4ymQMsnMkuJJucDIzGvJN7Q1NDcwtLQ3Njc2MxCSZz3vEFllJBAemJJ
        anZqakFqEUwfEwenVANjn1Evz8UlDfpsBxdnPNk2v+C4l7Ve/Ou2Nd7Ru8zvrbOxnGdhpbyB
        ee++6fxdnf3LrmYs/FDF12+j5+nJ0bnXmb/kkML/G7ofI8NXLeLdMrPq+fnNzkv1nuqvXttR
        uGbO4zv5yy/1f4n1nfDCRfzYxf5P23s/Gr1Irdixl0Mn/pn7ZzWv/W/WKrEUZyQaajEXFScC
        AN8UtZ6MAgAA
Message-Id: <20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485~eHqCoEO-42133821338eucas1p2F@eucas1p2.samsung.com>
X-CMS-MailID: 20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485
References: <CGME20181016145637eucas1p2dfa78042b9fd4fd27af7cc8537b7f485@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set adds new flag and mechanism in thermal trip point in DT.
The current situation with 'passive' (passive cooling - DVFS)
trip point is that it enables polling mode in thermal framework.
If the device supports irqs fired when the desired temerature is met,
thermal framwork should be notifed from driver's irq routine.
This is sufficent and there is no need of polling.
As a workaround, people declare trip point as 'active'
(active cooling, i.e. fan) to bypass polling mode setup in thermal
framework.

With this patch set trip point 'passive' declared in DT with explicit flag:
'irq-mode;' will not register itself as polling mode.

A good example is Exynos4 SoC family, where there is 4 HW supported
trip points and there is a need of 6. The rest 2 are declared as 'passive'
without 'irq-mode;' flag, thus polling needed.

It does not break existing design for trip points which do not have 'irq-mode'
flag - they will use polling.

For consistency this flag should be added to all trip point types('active',
'passive', 'hot', 'critical') when need (meaning, when irq will notify thermal
framework).

Regards,
Lukasz Luba

Lukasz Luba (11):
  thermal: remove unused function parameter
  thermal: add irq-mode configuration for trip point
  thermal: add new sysfs file for irq-mode
  Doc: thermal: new irq-mode for trip point
  Doc: DT: thermal: new irq-mode for trip point
  DT: arm64: exynos: add support for thermal trip irq-mode
  DT: arm64: exynos7: add support for thermal trip irq-mode
  DT: arm: exynos4: add support for thermal trip irq-mode
  DT: arm: exynos: add support for thermal trip irq-mode
  DT: arm: exynos: add support for thermal trip irq-mode
  DT: arm: exynos: add support for thermal trip irq-mode

 .../devicetree/bindings/thermal/thermal.txt        |   7 ++
 Documentation/thermal/sysfs-api.txt                |   9 ++
 arch/arm/boot/dts/exynos4-cpu-thermal.dtsi         |  10 +-
 arch/arm/boot/dts/exynos5410-odroidxu.dts          |  10 +-
 arch/arm/boot/dts/exynos5420-trip-points.dtsi      |  10 +-
 arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi |  40 +++++---
 arch/arm64/boot/dts/exynos/exynos5433-tmu.dtsi     | 105 ++++++++++++++-------
 .../arm64/boot/dts/exynos/exynos7-trip-points.dtsi |   8 ++
 drivers/thermal/of-thermal.c                       |  17 ++++
 drivers/thermal/thermal_core.c                     |  16 ++--
 drivers/thermal/thermal_sysfs.c                    |  53 ++++++++++-
 include/linux/thermal.h                            |   5 +
 12 files changed, 226 insertions(+), 64 deletions(-)

-- 
2.7.4

