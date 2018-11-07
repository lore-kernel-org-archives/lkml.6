Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E551FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A19D52081D
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 17:10:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BDK9ygP8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A19D52081D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731352AbeKHCli (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 21:41:38 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:57118 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbeKHCli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 21:41:38 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20181107171021euoutp0229c8b7552bd9e13169b2321c8584f9c9~k5rFFOcbH0448104481euoutp028
        for <linux-kernel@vger.kernel.org>; Wed,  7 Nov 2018 17:10:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20181107171021euoutp0229c8b7552bd9e13169b2321c8584f9c9~k5rFFOcbH0448104481euoutp028
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1541610621;
        bh=iFKZQakylMpviaUmUA83uFWro70KslVTwpF9v5ThIbI=;
        h=From:To:Cc:Subject:Date:References:From;
        b=BDK9ygP8Xe3gNHRFYC5XmqbB2BGZu3Z1MVTUoh3k2myQ1xwb1HKN14DSTyY5Zssoi
         YMhuagWTZLVfheMjuzBfaWpeCV/627lVksB/t2MHoIcxPJjoxRU1h7JN08zPIq9R4D
         jzSL5a7JlN7L92ZVvsc424JiKhWQfskhn81Nypag=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20181107171020eucas1p261bf97dcb3947162dd9a8fc6736d3aec~k5rEbzFT52800928009eucas1p23;
        Wed,  7 Nov 2018 17:10:20 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 33.E9.04441.C7C13EB5; Wed,  7
        Nov 2018 17:10:20 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94~k5rDE5Z4v2714327143eucas1p1Q;
        Wed,  7 Nov 2018 17:10:19 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20181107171019eusmtrp14b8f102ab933f2b437022ef1d4737b16~k5rC41y4l2472624726eusmtrp1Z;
        Wed,  7 Nov 2018 17:10:19 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-47-5be31c7c976a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 3F.13.04128.B7C13EB5; Wed,  7
        Nov 2018 17:10:19 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20181107171018eusmtip286bafac1988a4551c134cd1dcb1eefe9~k5rCSAEO_0340803408eusmtip2G;
        Wed,  7 Nov 2018 17:10:18 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Cc:     rui.zhang@intel.com, edubezval@gmail.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, corbet@lwn.net, b.zolnierkie@samsung.com,
        krzk@kernel.org, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 00/11] thermal: add new flag irq-mode for trip point
Date:   Wed,  7 Nov 2018 18:09:42 +0100
Message-Id: <1541610593-28542-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsWy7djPc7o1Mo+jDSZ0KVtsnLGe1eLJgXZG
        i3mfZS3mHznHajH/yjVWi/PnN7Bb3GqQsdj0GMhb2LaExeLyrjlsFp97jzBaLL1+kcmide8R
        dosnD/vYHPg81sxbw+ixc9Zddo/Fe14yeWxa1cnmcefaHjaPzUvqPRb3TWb1OPhuD5NH35ZV
        jB6fN8kFcEVx2aSk5mSWpRbp2yVwZXRf3cRSsESmou1+B1sD4xKxLkZODgkBE4nWqRdYuhi5
        OIQEVjBKfO26zAzhfGGU+Pz1KytIlZDAZ0aJc1+TYTpW7fvGBlG0HCg+p5EFruNSbwtTFyMH
        B5uAnsSOVYUgcRGB2UCT9i1mB3GYBe4wSpyaspgZZJSwgLtEW+s7RhCbRUBVYtqP/SwgNq+A
        l8SKWweYINbJSdw81wl2k4TAOnaJjd8Ps0EkXCQOn7jJCGELS7w6voUdwpaROD25hwXCLpY4
        27EKqr5Gov3kDqgaa4nDxy+yglzKLKApsX6XPogpIeAo8XG1NYTJJ3HjrSBIMTOQOWnbdGaI
        MK9ER5sQxAwNiS09F6COFJNYvmYa1GwPifdTn7BDwi1W4tfC74wTGOVmIaxawMi4ilE8tbQ4
        Nz212DAvtVyvODG3uDQvXS85P3cTIzD1nP53/NMOxq+Xkg4xCnAwKvHwXtj6MFqINbGsuDL3
        EKMEB7OSCG/v6kfRQrwpiZVVqUX58UWlOanFhxilOViUxHmrGR5ECwmkJ5akZqemFqQWwWSZ
        ODilGhiTXU8KHYkTPiXlsD6oen/jGuPSnPq/PzT9bcqbRfKmWJfM4pI8L3zP9dimlepzTv2J
        /3x1u6NgzvFTwWasHQulRbwnmWy0W5x7oOmnkuJFPZX5xborGzwt/3Jn3Nf1yQ9Oen11v8/C
        zv+l8Smqs78WzFeUV67j2jX7yPaw10UfzhvKm87kYVNiKc5INNRiLipOBAA9GluLOQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrHLMWRmVeSWpSXmKPExsVy+t/xe7rVMo+jDdYsY7HYOGM9q8WTA+2M
        FvM+y1rMP3KO1WL+lWusFufPb2C3uNUgY7HpMZC3sG0Ji8XlXXPYLD73HmG0WHr9IpNF694j
        7BZPHvaxOfB5rJm3htFj56y77B6L97xk8ti0qpPN4861PWwem5fUeyzum8zqcfDdHiaPvi2r
        GD0+b5IL4IrSsynKLy1JVcjILy6xVYo2tDDSM7S00DMysdQzNDaPtTIyVdK3s0lJzcksSy3S
        t0vQy+i+uomlYIlMRdv9DrYGxiViXYycHBICJhKr9n1j62Lk4hASWMoocf/3ZjaIhJjEpH3b
        2SFsYYk/17rA4kICn4CKVgZ1MXJwsAnoSexYVQjSKyIwn1Hi6KbLYIOYBZ4xSqyc/pIJpEFY
        wF2irfUdI4jNIqAqMe3HfhYQm1fAS2LFrQNMEAvkJG6e62SewMizgJFhFaNIamlxbnpusZFe
        cWJucWleul5yfu4mRmDYbzv2c8sOxq53wYcYBTgYlXh4NXY8jBZiTSwrrsw9xCjBwawkwtu7
        +lG0EG9KYmVValF+fFFpTmrxIUZToOUTmaVEk/OBMZlXEm9oamhuYWlobmxubGahJM573qAy
        SkggPbEkNTs1tSC1CKaPiYNTqoExtvih8vZ7DSksz6onO/t099+QimGcnfdXZrMPE1vZmtN7
        nY5PTHsVEcOxMl6k8drO119u7jVSWLQue0FtyxJXnT7JBfIH8m9on9nx/b2OzzvFzm2ymeeK
        MjscrHpcnv5RtFq+Z/cn9XclNxsvWZm63/sw+VHOI0N/i+eH/xw3mdeicDVse/MrJZbijERD
        Leai4kQAC05W8ZECAAA=
X-CMS-MailID: 20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94
References: <CGME20181107171019eucas1p1fcb1f44e00265434548d901479f2ea94@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This patch set adds a new flag and mechanism in thermal trip points in
DT.  The old implementation in thermal zone in DT sets the same
configuration for all internal trip points. It does not work for all
HW.  There are SoCs which support IRQs for some trip points (i.e.
Exynos 4 has 4 trip points with IRQs). For additional one defined
inside the thermal zone there is a need of 'polling'. When developer
adds polling mode settings inside the thermal zone, all the trip
points will be registered for polling, even those supporting IRQs,
which does not make sense. Thus, developers create workarounds, which
are confusing for some other developers.  To workaround, 
people declare some trip points as 'active' (those with IRQ support).
It allows to bypass polling mode in thermal framework applied for 
all thermal zone's trip points.

Thermal framework defines 4 types of trip points. The 'passive' means
passive cooling using DVFS, 'active' is designed for fan and other
devices actively changing the outside conditions. Therefore, a workaround
mentioned earlier is confusing when someone does not know about the
framework limitations.

This patch set tries to solve the issue by adding one flag inside the
trip point: 'irq-mode;'.  The trip point 'passive' declared in DT with
explicit flag 'irq-mode;' will not register itself as polling mode.
Thermal framework will skip it during scheduling next read out work.
The old global-polling-mode-configuration-inside-thermal-zone is still
valid.  Patch set does not break existing design for trip points which
do not have 'irq-mode' flag - they will use polling.

As an example please check patch #10 for Exynos4 SoC family, where there
is 4 HW supported trip points and there is a need of 6. The rest 2 are
declared as 'passive' without 'irq-mode;' flag, which means polling
mode needed for them.

Patch #1 is a small cleanup in thermal framework.

Change log:
v2
- changed description in cover letter
- change commit messages according to Krzysztof comments
- rebase on top of current mainline (v4.20-rc1)

Regards,
Lukasz Luba

Lukasz Luba (11):
  thermal: remove unused function parameter
  thermal: add irq-mode configuration for trip point
  thermal: add new sysfs file for irq-mode
  Doc: thermal: new irq-mode for trip point
  Doc: DT: thermal: new irq-mode for trip point
  arm64: dts: exynos5433: add support for thermal trip irq-mode
  arm64: dts: exynos7: add support for thermal trip irq-mode
  arm: dts: exynos4: add support for thermal trip irq-mode
  arm: dts: exynos5420: add support for thermal trip irq-mode
  arm: dts: exynos5422: add support for thermal trip irq-mode
  arm: dts: exynos5410: add support for thermal trip irq-mode

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

