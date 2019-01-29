Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E16CC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53EAF2184D
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 17:55:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="QsznMGgF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbfA2Rza (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 12:55:30 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:45647 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfA2Rz0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 12:55:26 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20190129175524euoutp01d25c07c83ac164b28f3c0b75cb0c4908~_Y1Gxpt4-0755407554euoutp01N
        for <linux-kernel@vger.kernel.org>; Tue, 29 Jan 2019 17:55:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20190129175524euoutp01d25c07c83ac164b28f3c0b75cb0c4908~_Y1Gxpt4-0755407554euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1548784524;
        bh=FItSYnLXOOv6DzxYJ/ACdcxYgPxIwhriECrh/Qd+Wfk=;
        h=From:To:Cc:Subject:Date:References:From;
        b=QsznMGgFKmL/n0Hb73laG0ZtLNX7TYeMJuOrrmH3aZV5V/igu3fXwz9i7odBTlJrv
         KEp/iVWNZ1jr2YAGRU+PcIMnkY1xxeqf5/187LSLTsXrE+GyaKingu3tt42A9ku7V8
         mQxO9GjHSV8+vRIb/L2kAXS5REYdQIO8XNcMg+Wc=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20190129175523eucas1p16dbcb9dd79bef22b8fd64e997813d266~_Y1GDdMWC2431324313eucas1p1P;
        Tue, 29 Jan 2019 17:55:23 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id C7.44.04806.B83905C5; Tue, 29
        Jan 2019 17:55:23 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175522eucas1p121e453739de195625b1f4b04a0b4f298~_Y1FQe_QD0145001450eucas1p1C;
        Tue, 29 Jan 2019 17:55:22 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20190129175522eusmtrp279cdc3c9d187bcbe78e5160ee0646103~_Y1FBtAuJ0424104241eusmtrp2T;
        Tue, 29 Jan 2019 17:55:22 +0000 (GMT)
X-AuditID: cbfec7f5-79db79c0000012c6-21-5c50938b5a66
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id C4.EE.04128.A83905C5; Tue, 29
        Jan 2019 17:55:22 +0000 (GMT)
Received: from AMDC3778.DIGITAL.local (unknown [106.120.51.20]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20190129175521eusmtip162f08e9b3f1f7d3eeb25c40638f59c30~_Y1EbfRyx2140821408eusmtip1v;
        Tue, 29 Jan 2019 17:55:21 +0000 (GMT)
From:   Lukasz Luba <l.luba@partner.samsung.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc:     b.zolnierkie@samsung.com, krzk@kernel.org, kgene@kernel.org,
        cw00.choi@samsung.com, kyungmin.park@samsung.com,
        m.szyprowski@samsung.com, s.nawrocki@samsung.com,
        myungjoo.ham@samsung.com, Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 0/8] Exynos5 Dynamic Memory Controller driver
Date:   Tue, 29 Jan 2019 18:55:06 +0100
Message-Id: <1548784514-26649-1-git-send-email-l.luba@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LZduznOd3uyQExBi92CVhsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgieKySUnNySxLLdK3S+DKOD3LsOCOUMX+/jPM
        DYwdfF2MnBwSAiYSa2/uZOli5OIQEljBKLF9yxxGCOcLo8TFtU+ZIZzPjBK3Xp9mhGlpfvqG
        DcQWEljOKLFhVTBcx9Kv54E6ODjYBPQkdqwqBKkREaiWuHN9P9ggZoG3jBIzb35hAUkICzhI
        LH9zDGwoi4CqxM59P8BsXgEvibPN/VDL5CRunutkhrC/s0k8PC4CYbtI7D3WzgRhC0u8Or6F
        HcKWkfi/cz5UvFjibMcqNgi7RqL95A6oGmuJw8cvsoLcySygKbF+lz5E2FFiwcdp7CBhCQE+
        iRtvBUHCzEDmpG3TmSHCvBIdbUIQ1RoSW3ouQC0Sk1i+ZhrUcA+JedufsUNCJ1bi9OGjLBMY
        5WYh7FrAyLiKUTy1tDg3PbXYOC+1XK84Mbe4NC9dLzk/dxMjMGmc/nf86w7GfX+SDjEKcDAq
        8fAyBAfECLEmlhVX5h5ilOBgVhLhNfztHyPEm5JYWZValB9fVJqTWnyIUZqDRUmct5rhQbSQ
        QHpiSWp2ampBahFMlomDU6qB8aD3XpcahZw3EmrcVTt/if0NvL388WqPGSvnMC38IPpqhfPv
        8lWv5ujv1mHfdipbmaW4xt75+J3ZpxK7lP8X6EvNtvv45IZUzf05Rybc45n2bdZJ8c3PPsUv
        ti14f83nzC2Jpgqtp3y2ruavJz1R5lO5r2t+cubcO2E2Vd9exFSvXik74evs1EdKLMUZiYZa
        zEXFiQAgnT8fFgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDLMWRmVeSWpSXmKPExsVy+t/xu7pdkwNiDK60SFlsnLGe1eL6l+es
        FvOPnGO16H/8mtni/PkN7BZnm96wW9xqkLG4vGsOm8Xn3iOMFjPO72OyWHvkLrvF7cYVbBaH
        37SzOvB6bFrVyeZx8N0eJo++LasYPT5vkgtgidKzKcovLUlVyMgvLrFVija0MNIztLTQMzKx
        1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOD3LsOCOUMX+/jPMDYwdfF2MnBwSAiYSzU/fsHUx
        cnEICSxllPi/azkLREJMYtK+7ewQtrDEn2tdUEWfGCU6zq5j7mLk4GAT0JPYsaoQpEZEoF6i
        /80lsBpmge+MEoeeTGAESQgLOEgsf3MMzGYRUJXYue8HmM0r4CVxtrmfEWKBnMTNc53MExh5
        FjAyrGIUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAgM2W3Hfm7Zwdj1LvgQowAHoxIPL0NwQIwQ
        a2JZcWXuIUYJDmYlEV7D3/4xQrwpiZVVqUX58UWlOanFhxhNgZZPZJYSTc4HxlNeSbyhqaG5
        haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQZGyye7dnW9yp83SbP0w8ogB/0P
        E35/kX9zZIP/snvNcnobGOyeSfzv3OW3eModlaeTDa1frf6Qxcr1cfp1QY17n6YeS08+ERoh
        IWjedvLUxNlfq5cunFQZt1zVKfiLyp5VBoxspycyvt70fYbuQwM2lXW7mq0cvc3dVq8NmTdX
        x+aGpFC46OU7vkosxRmJhlrMRcWJAAjIjwdvAgAA
X-CMS-MailID: 20190129175522eucas1p121e453739de195625b1f4b04a0b4f298
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20190129175522eucas1p121e453739de195625b1f4b04a0b4f298
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20190129175522eucas1p121e453739de195625b1f4b04a0b4f298
References: <CGME20190129175522eucas1p121e453739de195625b1f4b04a0b4f298@eucas1p1.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is v2 of the patch set which adds support of Dynamic Memory Controller
for Exynos5422 SoC.
The driver supports Dynamic Voltage and Frequency Scalling
for the DMC and DRAM. It also provides needed timings for different
speed operations of the DRAM memory.
The patch set is based on tag: v5.0-rc4

changes:
v1->v2:
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
 arch/arm/boot/dts/exynos5420.dtsi                  |   69 ++
 arch/arm/boot/dts/exynos5422-odroid-core.dtsi      |   22 +
 arch/arm/configs/exynos_defconfig                  |    1 +
 drivers/clk/samsung/clk-exynos5420.c               |   63 +-
 drivers/devfreq/Kconfig                            |   13 +
 drivers/devfreq/Makefile                           |    1 +
 drivers/devfreq/event/exynos-ppmu.c                |    6 +
 drivers/devfreq/exynos5422-dmc.c                   | 1274 ++++++++++++++++++++
 include/dt-bindings/clock/exynos5420.h             |   18 +-
 11 files changed, 1575 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/exynos5422-dmc.txt
 create mode 100644 drivers/devfreq/exynos5422-dmc.c

-- 
2.7.4

