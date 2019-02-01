Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28312C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1971218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 16:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VdYrhELh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730906AbfBAQrX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 11:47:23 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:42621 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730138AbfBAQrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 11:47:20 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190201164718euoutp01586bb2f99ef4d1db0a1e52cf4894671a~-S1ggM6xh1970719707euoutp01q
        for <linux-kernel@vger.kernel.org>; Fri,  1 Feb 2019 16:47:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190201164718euoutp01586bb2f99ef4d1db0a1e52cf4894671a~-S1ggM6xh1970719707euoutp01q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1549039638;
        bh=6uQKtEbSrA2rR2vaPlBS82mIq9Rpuo3fLggusB/LfQs=;
        h=From:To:Cc:Subject:Date:References:From;
        b=VdYrhELhV7WKjroeFt6v3/wTBVSFdUVyl2tpKPH0KPhBI2ALo9aLp2n63XoiP8/i5
         U1uJ3Lv0AxHX6bvnLwqrbIBO/cyaH2sV/ueqJ0RiaT868LHU48h0vm/p4+gVAkV1hQ
         Fx1fJW//cnhfmr5Gw2N7R/s1ztUXMB2NcatUH3pQ=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20190201164718eucas1p2eae9a125dcf8fb84b114ee3941910955~-S1f5JRY60986009860eucas1p2J;
        Fri,  1 Feb 2019 16:47:18 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 8A.E3.04441.518745C5; Fri,  1
        Feb 2019 16:47:17 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20190201164717eucas1p2ddf83cd5b7a5f53fdb866eeb8e991c71~-S1fO9CXq0986009860eucas1p2I;
        Fri,  1 Feb 2019 16:47:17 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20190201164717eusmtrp1028c772ddbc16ef0dfe0d01a95920352~-S1fAJrFP3167231672eusmtrp1R;
        Fri,  1 Feb 2019 16:47:17 +0000 (GMT)
X-AuditID: cbfec7f2-5c9ff70000001159-ce-5c5478150491
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 81.29.04284.418745C5; Fri,  1
        Feb 2019 16:47:17 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20190201164716eusmtip220009bb485aaeb491cac28f1526b62e9~-S1ea_rub0105101051eusmtip2Y;
        Fri,  1 Feb 2019 16:47:16 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v4 0/8] Exynos5 Dynamic Memory Controller driver
Date:   Fri,  1 Feb 2019 17:46:44 +0100
Message-Id: <1549039612-28905-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42LZduzneV3RipAYg63TDCw2zljPanH9y3NW
        i/lHzrFa9D9+zWxx/vwGdouzTW/YLW41yFhc3jWHzeJz7xFGixnn9zFZrD1yl93iduMKNovD
        b9pZHXg9Nq3qZPM4+G4Pk0ffllWMHp83yQWwRHHZpKTmZJalFunbJXBlHLvSy1rwTaTiwMOZ
        bA2Mr/m7GDk5JARMJCY132TvYuTiEBJYwShx4eFqRgjnC6PE9g8PmSCcz4wSyxedYoFp6Tgx
        iQUisZxRYsbWdna4luXdE9m6GDk42AT0JHasKgRpEBGolrhzfT8zSA2zwFtGiZk3v4BNEhZw
        kNi47BATiM0ioCpxY8UBZhCbV8BLYufFaewQ2+Qkbp7rBGuWEPjNJrFvzVSohIvE5UPn2SBs
        YYlXx7dAxWUkTk/ugTq1WOJsxyqomhqJ9pM7oGqsJQ4fv8gKciizgKbE+l36EGFHiaZDrSwg
        YQkBPokbbwVBwsxA5qRt05khwrwSHW1CENUaElt6LjBB2GISy9fAXOwh8X3zXbDhQgKxEk3L
        UiYwys1CWLWAkXEVo3hqaXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYOI4/e/4px2MXy8lHWIU
        4GBU4uHd8CsoRog1say4MvcQowQHs5IIr1NWSIwQb0piZVVqUX58UWlOavEhRmkOFiVx3mqG
        B9FCAumJJanZqakFqUUwWSYOTqkGxvUPtHhb2Dvq1HtCe21cbF/Ir72rvev43hrWsMt51z+L
        WzB8UE+e6i/M+t+w9KzhbcEd+/S/zlhmUbj4J9PONXPurYqpkNnj/KqE59StF28ulkx98HdR
        3xLnkrbIJi6fa1UsN2Ru/5A3tNm6u9jjy9xkre6PSWLNc/6/lBEWDE3jfzlBeFKujhJLcUai
        oRZzUXEiANawIV4YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrLLMWRmVeSWpSXmKPExsVy+t/xe7qiFSExBrP3MllsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOHall7Xgm0jFgYcz2RoYX/N3MXJySAiYSHScmMTS
        xcjFISSwlFGi9eVONoiEmMSkfdvZIWxhiT/Xutggij4xStw8v4W5i5GDg01AT2LHqkKQGhGB
        eon+N5fAapgFvjNKHHoygREkISzgILFx2SEmEJtFQFXixooDzCA2r4CXxM6L06AWyEncPNfJ
        PIGRZwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzAoN127OfmHYyXNgYfYhTgYFTi4d3w
        KyhGiDWxrLgy9xCjBAezkgivU1ZIjBBvSmJlVWpRfnxRaU5q8SFGU6DlE5mlRJPzgRGVVxJv
        aGpobmFpaG5sbmxmoSTOe96gMkpIID2xJDU7NbUgtQimj4mDU6qBsYTFNufvgeshNnUKjCeL
        zd8odceoWuZW3GrNWXDzbPn6doUvrU7mv4Qqrjrtvnr7zr8rMdNT1kwNbyjldHvowyJhVs5l
        nVcpdSfDzWBmgMdelxWlt5mMIwsURd0jlsnseXDsR0Xz7I/hNbIB1a0GsZ5XEncdfaR37zZz
        tuPVGMu5x9YlucYqsRRnJBpqMRcVJwIAJmBc0HACAAA=
X-CMS-MailID: 20190201164717eucas1p2ddf83cd5b7a5f53fdb866eeb8e991c71
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190201164717eucas1p2ddf83cd5b7a5f53fdb866eeb8e991c71
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190201164717eucas1p2ddf83cd5b7a5f53fdb866eeb8e991c71
References: <CGME20190201164717eucas1p2ddf83cd5b7a5f53fdb866eeb8e991c71@eucas1p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v4 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scalling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.
The patch set is based on tag: v5.0-rc4

changes:
v4:
- removed unneeded DPLL and G3D clocks IDs
- changed names of parent clocks for mout_mx_mspll_ccore_phy_p
  and added one more parent: mout_sclk_epll
- removed 933Mhz and 138MHz from the BPLL ratio table
v3:
- in DTS align to proper indent the clocks and clock-names entries
v2:
- changed file name exynos5-dmc.c -> exynos5422-dmc.c
  and related entries in other files
- changed dt-binding file name
- changed config entry to CONFIG_ARM_EXYNOS5422_DMC_DEVFREQ
- removed sysfs and print info messages (print only one line)
- removed function exynos5_read_chip_info and compact code
- changed dt-binding patch and move it up in the patch set
- new entries in MAINTAINERS are added with the driver c code
- clean-up in DTS file: renamed nodes to 'ppmu' and 'memory-controller',
  entries moved to suggested location (before nocp nodes or after),
  moved according to alfabetical order, compacted clocks names with right indent.

Regards,
Lukasz Luba

Lukasz Luba (8):
  clk: samsung: add needed IDs for DMC clocks in Exynos5420
  clk: samsung: add new clocks for DMC for Exynos5422 SoC
  clk: samsung: add BPLL rate table for Exynos 5422 SoC
  drivers: devfreq: add DMC driver for Exynos5422
  dt-bindings: devfreq: add Exynos5422 DMC device description
  DT: arm: exynos: add DMC device for exynos5422
  drivers: devfreq: events: add Exynos PPMU new events
  ARM: exynos_defconfig: enable DMC driver

 .../devicetree/bindings/devfreq/exynos5422-dmc.txt |  106 ++
 MAINTAINERS                                        |    8 +
 arch/arm/boot/dts/exynos5420.dtsi                  |   78 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   22 +
 arch/arm/configs/exynos_defconfig                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   59 +-
 drivers/devfreq/Kconfig                            |   13 +
 drivers/devfreq/Makefile                           |    1 +
 drivers/devfreq/event/exynos-ppmu.c                |    6 +
 drivers/devfreq/exynos5422-dmc.c                   | 1274 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             |   16 +-
 11 files changed, 1578 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
 create mode 100644 drivers/devfreq/exynos5422-dmc.c

-- 
2.7.4

