Return-Path: <SRS0=sqHT=JP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4225AC43141
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D956725163
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jun 2018 16:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="JImYHc5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D956725163
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936898AbeF2QPS (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jun 2018 12:15:18 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:51569 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934510AbeF2QPO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jun 2018 12:15:14 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180629161512euoutp01274241a6731b828acd9204e45e0cc706~8raiH1ccE0735407354euoutp01Z;
        Fri, 29 Jun 2018 16:15:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180629161512euoutp01274241a6731b828acd9204e45e0cc706~8raiH1ccE0735407354euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1530288912;
        bh=LV4qjpyppQI3S5u54GnH2yvmWkcbmG5aFxTaBmrSmDE=;
        h=From:To:Cc:Subject:Date:In-reply-to:References:From;
        b=JImYHc5hP769A9NwwPAUwRvzkpJbY+ULwnOsXHaksBA3r70ARZDz+pZVrqCLy5RFs
         ReQjr50cLsH8pC7pV/+GqpA7h/hVxETiMOi/X/aIhUNO5dPB3hEtKH3/v78w2neD+p
         JJ3hZEPmH8tRR1l0RUcuvFU6a+LVCoMmVJ1ziTIs=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180629161511eucas1p1717d6bee612d5d432817f7e557c08e34~8rahUECx20212002120eucas1p1l;
        Fri, 29 Jun 2018 16:15:11 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id A8.5E.10409.F0B563B5; Fri, 29
        Jun 2018 17:15:11 +0100 (BST)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20180629161511eucas1p15243a8acfdace1bf28969b4351913cc7~8ragpja_72421524215eucas1p1b;
        Fri, 29 Jun 2018 16:15:11 +0000 (GMT)
X-AuditID: cbfec7f5-b5fff700000028a9-ef-5b365b0f5983
Received: from eusync3.samsung.com ( [203.254.199.213]) by
        eusmgms2.samsung.com (EUCPMTA) with SMTP id 18.8C.04183.F0B563B5; Fri, 29
        Jun 2018 17:15:11 +0100 (BST)
Received: from amdc3058.localnet ([106.120.53.102]) by eusync3.samsung.com
        (Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May  5
        2014)) with ESMTPA id <0PB30012ZEHAUZ30@eusync3.samsung.com>; Fri, 29 Jun
        2018 17:15:11 +0100 (BST)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc:     Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] thermal: enable/check sensor after its setup is
 finished
Date:   Fri, 29 Jun 2018 18:15:10 +0200
Message-id: <3666866.2CEay15PAX@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
In-reply-to: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sa0hTYRjHeXfOzs6Wq7dp+JJSOCy6TrOSQ0b1IeJURloUlGlOPXjJTdnx
        kkGlZhctxRIdrGFSWTK62nLmnWlbWZY1G2Y1bzEtRT8sMa/V6Sj47ff8n//zPH9eXhKT1QiX
        k/HqFEajVibKCQleZZl4v3FJWGCYf9sTH8rpsgLqYf5LnLrVYRdSTVk2QP3pGxJSraZsAZWj
        u41Td7/3iihbjZ6gXPktgNKPfBFR33sLCGrQ6ElVVnQS1ERNKU7VO1xgF6SzRy0EretuI+gX
        um8i+nnXVvpO3Q8BXWnIJeiv9jqCzr8wQtAmeylGv9KO47S10ySgXZUrQtyOS7bHMInxaYzG
        b0ekJK6uuodIrlKcdjQGZwKzPA+ISQS3oGufJog8ICFlsAKgm8UzBNeQQRdA35pT5k11Hblz
        +j2AsvJ9eJ4C6HN/MMcE3IauXzaAPECSHnA/Mj4guZ0YnMGQWafDOd0dHkHtw24c4nAVyrqa
        xE1K4Vo01Nci4HgZ3IeMDZf/sxjuRVP1o0LesxT9LnLgHGNwJWpoLBbyvAG1WR4B7hSCBhGy
        DrQI+ci7UeGzIYJnd/TTahTx7I1sRVdxfkAL0PBk+VzxGKAHby0C3hWEmq0f5k4sRjeqtBiX
        GkEpunJJxiONCsrU/LvpAcq1GEEh8NYtCKtbEFa3IGwZwAzAk0llVbEMu1nNpCtYpYpNVccq
        opNUleDfj3ozax2rBg3TUWYASSB3k7YfCgyTCZVpbIbKDBCJyT2koZwkjVFmnGE0SSc1qYkM
        awZeJC73lEasOXdcBmOVKcwphklmNPNdASlengnifZ+9DvI1dF8KqDUN+ZeYdikehfdkF5cc
        EBbYQgf7R8TpEj+94uAHYufk1mOHm7WLjoY/CXU69yyJDtB8jG5KHn/anvBT/ms8ysJWvPNY
        XZjoVdhpnx4Y644rD8GZWWdk7XtVZI975vmc++b24oCYiIt2T22r40Tp+q6EpLM5EXKcjVNu
        WodpWOVfiqoXRk0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xq7r80WbRBrOvMFk8+3yc0WJt71EW
        i/lXrrFaHGi8zGjx/9FrVotT25uYLFpmLWKxWPLkIbvF5V1z2Cw+9x5htJjz7ja7xZOHfWwW
        L7aIW2xacYPN4ueueSwWe+99ZnQQ8Gh6f4zNY9b9s2weO2fdZffYesvUY/Gel0wem1Z1snnc
        ubaHzaO3+R2bx/Zr85g9Tkz/zuJx/MZ2Jo/Pm+QCeKK4bFJSczLLUov07RK4MvbseMBWsE2v
        4t5+nwbGQ0pdjJwcEgImEnuudLJ1MXJxCAksYZQ413KIEcL5yyixbvYPNpAqNgEriYntq4AS
        HBwiAt4SW9ZwgNQwC/xllvh9ZzYbSFxYIFTiwhseEJNFQFWisTsfpJNXQFPi9aMjTCC2qICX
        xJZ97WA2p4CnxO+971khVs1jlFjZuI8ZokFQ4sfkeywgNrOAvMS+/VNZIWwtifU7jzNNYOSf
        haRsFpKyWUjKFjAyr2IUSS0tzk3PLTbSK07MLS7NS9dLzs/dxAiMsm3Hfm7Zwdj1LvgQowAH
        oxIP74Ugs2gh1sSy4srcQ4wSHMxKIryBICHelMTKqtSi/Pii0pzU4kOM0hwsSuK85w0qo4QE
        0hNLUrNTUwtSi2CyTBycUg2MrcmPjgt/djXY3XhQ0+wBw/crMVMmnVOZzSFp0mkjYSLCGd+/
        Sqiy+XJLpYhsfq5Ig0mx64awle5Heu1nyi5+5ut7TaD9V7W68IIvtZtZtAwErs7jL21mTIs3
        iNF6G2pYYXepft3k99bL5xe1iOqJLO3bF/fy8+ttfxbk/5Lc5hFrPW/nMk0lluKMREMt5qLi
        RACcr1ttrgIAAA==
X-CMS-MailID: 20180629161511eucas1p15243a8acfdace1bf28969b4351913cc7
X-Msg-Generator: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
        <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, April 10, 2018 02:41:54 PM Bartlomiej Zolnierkiewicz wrote:
> Hi,
> 
> [devm]_thermal_zone_of_sensor_register() is used to register
> thermal sensor by thermal drivers using DeviceTree. Besides
> registering sensor this function also immediately enables it
> (using ->set_mode method) and then checks it with a update call
> to the thermal core (which ends up using ->get_temp method).
> For many DT thermal drivers this causes a problem because
> [devm]_thermal_zone_of_sensor_register() need to be called in
> order to obtain data about thermal trips which are then used to
> finish hardware sensor setup (only after which ->get_temp can
> be used). The issue has been observed when using Samsung Exynos
> thermal driver and fixed internally in the driver in commit
> d8efad71e5b6 ("thermal: exynos: Reading temperature makes sense
> only when TMU is turned on"). However after this commit there
> are now following warnings from the thermal core visible:
> 
> [    3.453602] thermal thermal_zone0: failed to read out thermal zone (-22)
> [    3.483468] thermal thermal_zone1: failed to read out thermal zone (-22)
> [    3.505965] thermal thermal_zone2: failed to read out thermal zone (-22)
> [    3.528455] thermal thermal_zone3: failed to read out thermal zone (-22)
> [    3.550939] thermal thermal_zone4: failed to read out thermal zone (-22)
> 
> This patchset attempts to directly address the thermal core
> problem with [devm]_thermal_zone_of_sensor_register() and
> affected DT thermal drivers. In order to achieve this sensor
> registration, enable and check operations are separated and
> corresponding drivers are modified to use the new helpers to
> enable and check sensor explicitly.
> 
> Tested on Exynos5422 based Odroid-XU3 Lite board (aforementioned
> warnings from the thermal core are now gone).
> 
> Best regards,
> --
> Bartlomiej Zolnierkiewicz
> Samsung R&D Institute Poland
> Samsung Electronics
> 
> 
> Bartlomiej Zolnierkiewicz (17):
>   thermal: add thermal_zone_device_toggle() helper
>   thermal: separate sensor registration and enable
>   thermal: add thermal_zone_device_check() helper
>   thermal: do sensor checking explicitly in drivers
>   thermal: bcm2835: enable/check sensor after its setup is finished
>   thermal: brcmstb: enable/check sensor after its setup is finished
>   thermal: hisi_thermal: enable/check sensor after its setup is finished
>   thermal: qcom: tsens: enable/check sensor after its setup is finished
>   thermal: qoriq: enable/check sensor after its setup is finished
>   thermal: rcar_gen3_thermal: enable/check sensor after its setup is
>     finished
>   thermal: rockchip_thermal: enable/check sensor after its setup is
>     finished
>   thermal: exynos: enable/check sensor after its setup is finished
>   thermal: tegra: enable/check sensor after its setup is finished
>   thermal: ti-soc-thermal: enable/check sensor after its setup is
>     finished
>   thermal: uniphier: enable/check sensor after its setup is
>     finished
>   thermal: zx2967: enable/check sensor after its setup is finished
>   thermal: warn on attempts to read temperature on disabled sensors
> 
>  drivers/acpi/thermal.c                             |  5 ++--
>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
>  drivers/platform/x86/acerhdf.c                     |  6 +++-
>  drivers/regulator/max8973-regulator.c              |  3 +-
>  drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
>  drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
>  drivers/thermal/broadcom/ns-thermal.c              |  3 ++
>  drivers/thermal/da9062-thermal.c                   |  7 ++---
>  drivers/thermal/db8500_thermal.c                   |  5 +++-
>  drivers/thermal/hisi_thermal.c                     | 22 ++++----------
>  drivers/thermal/imx_thermal.c                      |  3 +-
>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
>  drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
>  drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
>  drivers/thermal/max77620_thermal.c                 |  6 ++--
>  drivers/thermal/mtk_thermal.c                      |  3 ++
>  drivers/thermal/of-thermal.c                       |  6 ++--
>  drivers/thermal/qcom-spmi-temp-alarm.c             |  5 +++-
>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>  drivers/thermal/qoriq_thermal.c                    |  3 ++
>  drivers/thermal/rcar_gen3_thermal.c                |  7 +++--
>  drivers/thermal/rcar_thermal.c                     |  8 +++--
>  drivers/thermal/rockchip_thermal.c                 | 34 ++++++++++------------
>  drivers/thermal/samsung/exynos_tmu.c               |  7 ++++-
>  drivers/thermal/st/st_thermal_memmap.c             |  3 +-
>  drivers/thermal/tango_thermal.c                    |  5 ++++
>  drivers/thermal/tegra/soctherm.c                   |  3 ++
>  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
>  drivers/thermal/thermal-generic-adc.c              |  3 ++
>  drivers/thermal/thermal_core.c                     | 14 ++++-----
>  drivers/thermal/thermal_helpers.c                  | 33 +++++++++++++++++++++
>  drivers/thermal/thermal_sysfs.c                    | 17 +++++++----
>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 ++++-
>  drivers/thermal/uniphier_thermal.c                 |  6 +++-
>  drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
>  drivers/thermal/zx2967_thermal.c                   |  3 ++
>  include/linux/thermal.h                            |  5 ++++
>  37 files changed, 173 insertions(+), 84 deletions(-)

Gentle ping.

Eduardo/Rui, do you see any issues with this patchset that should
be addressed before posting refreshed version?

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics

