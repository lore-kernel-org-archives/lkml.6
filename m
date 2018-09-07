Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 892A7C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:10:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2768120861
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 09:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=verdurent-com.20150623.gappssmtp.com header.i=@verdurent-com.20150623.gappssmtp.com header.b="H+jLhHyu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2768120861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=verdurent.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbeIGNuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 09:50:02 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:37229 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727704AbeIGNuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 09:50:02 -0400
Received: by mail-oi0-f65.google.com with SMTP id p84-v6so26014396oic.4
        for <linux-kernel@vger.kernel.org>; Fri, 07 Sep 2018 02:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=verdurent-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=LYrc8IKn7rSv/p3ceJbS3mXhFV2T5pWwm2SJNHKqeFk=;
        b=H+jLhHyu+W+ABq8HYW86DD8aLNzHUdDPDEUs587+pP3d9nDl41mc1WYfM8pon533MW
         KotlJjss3uPGN9wV75BTWY0lN2tr9X0zufo7dCAvBrTxaHaWFI1/oX7kA3J5NqNxyhH7
         CChJKpaHDyV9yVJSaqmI05P+9EDcIKEFKsC26LkHpbEL8/OkCE2816BclFfJFReUE6Sk
         3IL4rJ+ze9vtGq/IlM6YvI2foDkBAEFH/QufY0cuRYdq2MflA1aJKhBMIIYKp1Mbstig
         BrUUhWyqru3/gvGErQyO3ySWnTvZW0e59pDyPSfsj/wY0VsBv1yWrF0bMDb3GMA6M9/d
         RcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=LYrc8IKn7rSv/p3ceJbS3mXhFV2T5pWwm2SJNHKqeFk=;
        b=k6E4D3sb2SyC4tMlCh6XUhNt1kXt4x+m9hwBazhiYVkrmoZC+EheFnajtObh6bF1JM
         Y9aGhKxEv83f1D6PEhgo5QRWlNOHLd8a0ncotl+9+QRSF0WINa8JjkC0tCxUG2024rZD
         vMib29Jf4GHDVqX8pEGlaY25jRh28UQiLEO8KrDZ0Zm20LBsT5nIPxhHy6/5VTbz8pne
         QfMSxm0kxeDXx38EnXOE5vCSKggbiplxgNQ57s1jjjVR+gNr9w2vvmx1z+jMzua600aX
         0xFqt5+jBoVq5PcTNmu95FklkFBiNhGIbk3cEnlB89gwoKBd98jIVxzaTgdKx4HxzxYX
         IOug==
X-Gm-Message-State: APzg51CVYeOUzOd4nt7aal+TnYse4j1iyrNXv8tNdLu/2ALL8sPPRb0J
        IqBzh8a1G2Kea4kv7yFYnNaEnxvcsy2pnbdNhnC7JA==
X-Google-Smtp-Source: ANB0VdZcir0YTuCU78imbf6L3sHCU77egD7rwmKxe6c1SBIGk8J6PByHksOAugWhtmDAnh2020o0MzrZU88rY2sFbOc=
X-Received: by 2002:aca:a6d4:: with SMTP id t81-v6mr6821424oij.113.1536311401722;
 Fri, 07 Sep 2018 02:10:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:684a:0:0:0:0:0 with HTTP; Fri, 7 Sep 2018 02:10:00 -0700 (PDT)
In-Reply-To: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
 <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
From:   Amit Kucheria <amit.kucheria@verdurent.com>
Date:   Fri, 7 Sep 2018 14:40:00 +0530
Message-ID: <CAHLCerM21eVkxigVN7vJvSCOfbyc2ow+R16LCA8QJ724b1+9xQ@mail.gmail.com>
Subject: Re: [PATCH 00/17] thermal: enable/check sensor after its setup is finished
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Eric Anholt <eric@anholt.net>,
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
        Shawn Guo <shawnguo@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bartlomiej,

Do you have an updated version of this patchset on 4.19-rc1 somewhere
that I can look at? I might be seeing this issue on the QCom TSENS
driver and would like to verify.

Regards,
Amit

On Tue, Apr 10, 2018 at 6:11 PM, Bartlomiej Zolnierkiewicz
<b.zolnierkie@samsung.com> wrote:
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
>
> --
> 1.9.1
