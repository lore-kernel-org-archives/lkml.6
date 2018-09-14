Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FORGED_MUA_MOZILLA,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89337ECDFD0
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E5E0206B2
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 13:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="IXvG/XE3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5E0206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=samsung.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbeINSc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 14:32:28 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:55285 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727690AbeINSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 14:32:28 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20180914131758euoutp0167f6998af69d81553f3a27a7820ed9a3~URqxSlRda1016610166euoutp01I
        for <linux-kernel@vger.kernel.org>; Fri, 14 Sep 2018 13:17:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20180914131758euoutp0167f6998af69d81553f3a27a7820ed9a3~URqxSlRda1016610166euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1536931078;
        bh=NxLxuOkDyvLenTcVh/UO3Np/Sl+CHVex2hWn+I5viIg=;
        h=Subject:To:Cc:From:Date:In-Reply-To:References:From;
        b=IXvG/XE3eGI8BUKKEEolG+oOEIpuuK2Lip+n+rFPo2O+L70FqroJYG31PaEP1nB5b
         AEmCCw1Xi+KO8e+mfWh6IZESCpu6YOSI9vccHWTCl7BWwoUa6B0Mpi0i3kbD5mLRNw
         sjCRVwlsP5yN96Hq8D/1cF7gBT5pGnsP8D4iWxzc=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20180914131757eucas1p2b075f1891d08f7e2c3baad28ca9f8bb1~URqwHWTVY2963729637eucas1p2i;
        Fri, 14 Sep 2018 13:17:57 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id 0A.58.04441.505BB9B5; Fri, 14
        Sep 2018 14:17:57 +0100 (BST)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20180914131756eucas1p266c09a2e6c6dc8e303acd1174cd38c5a~URqvRKrwN2497224972eucas1p2u;
        Fri, 14 Sep 2018 13:17:56 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20180914131756eusmtrp270d6a1b475f70c6af52ec90c70c5bdd1~URqu-tyTo1564915649eusmtrp2J;
        Fri, 14 Sep 2018 13:17:56 +0000 (GMT)
X-AuditID: cbfec7f2-5e3ff70000001159-dc-5b9bb505901a
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.DD.04284.305BB9B5; Fri, 14
        Sep 2018 14:17:55 +0100 (BST)
Received: from [106.120.53.102] (unknown [106.120.53.102]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20180914131755eusmtip1507a58d4c25374bedf6f13dbb17dd13c~URquIqrn_1059610596eusmtip1a;
        Fri, 14 Sep 2018 13:17:55 +0000 (GMT)
Subject: Re: [PATCH 00/17] thermal: enable/check sensor after its setup is
 finished
To:     Eduardo Valentin <edubezval@gmail.com>
Cc:     Zhang Rui <rui.zhang@intel.com>, Eric Anholt <eric@anholt.net>,
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
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Date:   Fri, 14 Sep 2018 15:17:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
        Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20180910173659.GB4196@localhost.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA02SeUhUURTGu/OWeYpj15fmwaJlaEMpbREuGZYU9YiwDSOaP2rSp0k61Yxr
        IK1kGVpKJj5FzUpLKm1ynKYFzMpp0cpMs9VGh8jcqinCFs3XU/C/75zz++75DlyO4nsYPy7W
        kCAaDfo4LetO19QPPJ3LWAp0QY8tGvLRZUfkcuZ9mhS/aGVI7YFmRIY6uhnyyHpQRQ5LpTQ5
        53SoSfONQpa4Mu8hUtj3Rk2cjiyWfKr2JeYLbSwZuFFEk9vvXWgZFg7217OC1N7ICjbpnVqw
        vA4Wzt7qUgnmimOs8Lb1FitkHupjBWtrESU8yPtJC/Y2q0pwmaes89jiviRKjItNEo2Bodvc
        dzhyXMzu3NAUe10m2o9OBmYgNw7wIvhxswllIHeOxxcQXLdYWaX4jqD3ZQelFC4ETy3t9Kgl
        o/w+JWselyN41BehQP0IirOlYYjjJuAIeNbjITPe2B8ePLeqZIbCJTS8anmikgcsXgzZ6RVI
        1jSeCd+u2BjZ64M3w4mG2XJbg73gYb7z/163Yfxq2QdG1hQOgnulhSN6Klh7CyklWz4H/bnh
        ijcJSn4dZ5T+Crh06qtK0RPgs71arejJMGQr/p8NcB6Cnl/naaWoRHCpoX7EEQJ37U0jL4XB
        gNPFykEBe0Jbr5cSwhNyavIopa2Bo0d4hZ4FVWVV7OiuDNvFEUSArBLDSTRdGnOlNOYyacxl
        JYiqQL5ioik+RjTNN4jJ80z6eFOiIWZe5K54Mxr+g48H7d+uox/Pt9chzCGth2bOtQIdz+iT
        TKnxdQg4SuutqYyQdLwmSp+6VzTu2mpMjBNNdWgSR2t9NZ7+0Toex+gTxJ2iuFs0jk5VnJvf
        fhRuXiqtGmoNXN/LNju6nyTlRHemdbYEBM6h/jh/bjT2BE+Oqi9YkbV6U1gonnHHJ183N2Cz
        2hab9rf294vy0NO1TeduF3dVr19AeK9pOH1WIx+9fMuZL46AsuXUxFpd2J+ai4NBKWtDzr9c
        uXph1fhkn3GV5o0b1ryOm7gn8tgCr32Sljbt0M/3p4wm/T8IIdo5fwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrMIsWRmVeSWpSXmKPExsVy+t/xu7rMW2dHGxxqtrF49vk4o8Xa3qMs
        FvOvXGO1ONB4mdHi/6PXrBantjcxWbTMWsRiseTJQ3aLy7vmsFl87j3CaDHn3W12iycP+9gs
        XmwRt9i04gabxc9d81gs9t77zOgg4NH0/hibx6z7Z9k8ds66y+6x9Zapx+I9L5k8Nq3qZPO4
        c20Pm0dv8zs2j+3X5jF7nJj+ncXj+I3tTB6fN8kF8ETp2RTll5akKmTkF5fYKkUbWhjpGVpa
        6BmZWOoZGpvHWhmZKunb2aSk5mSWpRbp2yXoZTyc9Jm1YKpdxfFDvYwNjBP0uxg5OSQETCS6
        lh9l7mLk4hASWMoo8ailmb2LkQMoISNxfH0ZRI2wxJ9rXWwQNW8ZJVp+PWIBqREWCJW48IYH
        pEZEQEvixKXtTBA1ZxglLv5pBhvKLLCIRWLPv03MIFVsAlYSE9tXMYLYvAJ2Eut2/GAHsVkE
        VCU+rdvJCmKLCkRI3HrYwQJRIyhxcuYTMJsTqHfjsgdgNcwCehI7rv+CsuUltr+dwzyBUXAW
        kpZZSMpmISlbwMi8ilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDCtx37uXkH46WNwYcYBTgY
        lXh4NTbPjhZiTSwrrsw9xCjBwawkwrs+dFa0EG9KYmVValF+fFFpTmrxIUZToCcmMkuJJucD
        k09eSbyhqaG5haWhubG5sZmFkjjveYPKKCGB9MSS1OzU1ILUIpg+Jg5OqQbGhm/Sk1/USDN8
        XGsa+y7njRlLYIB/w6/e+TFPUySaFLXVvBxa2w5ZS0w1/LE3dEq41sfH9hGhqyVN9X3vuyZe
        mvKt2TR6fsLllAfPUzfnMeyecmXpsZfiuptszv1lcZzNPSks8DDHr21GHK4u/VuFf7DJnW7V
        ftPBV2Co5rDyrmCJZZt0WasSS3FGoqEWc1FxIgBRdo3PBgMAAA==
Message-Id: <20180914131756eucas1p266c09a2e6c6dc8e303acd1174cd38c5a~URqvRKrwN2497224972eucas1p2u@eucas1p2.samsung.com>
X-CMS-MailID: 20180914131756eucas1p266c09a2e6c6dc8e303acd1174cd38c5a
X-Msg-Generator: CA
X-RootMTR: 20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
        <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
        <20180910173659.GB4196@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 09/10/2018 07:37 PM, Eduardo Valentin wrote:
> On Tue, Apr 10, 2018 at 02:41:54PM +0200, Bartlomiej Zolnierkiewicz wrote:
>> Hi,
>>
>> [devm]_thermal_zone_of_sensor_register() is used to register
>> thermal sensor by thermal drivers using DeviceTree. Besides
>> registering sensor this function also immediately enables it
>> (using ->set_mode method) and then checks it with a update call
>> to the thermal core (which ends up using ->get_temp method).
> 
> Yeah, pretty much the driver needs to be ready to answer to callbacks
> once it calls thermal_*_register() method.
> 
>> For many DT thermal drivers this causes a problem because
> 
> Can you be more specific? Are you seeing this problem in samsung driver
> or in other drivers too?

We were hitting the issue in exynos driver and we have added
workaround for it in the driver itself (commit 0eb875d88aaa
"thermal: exynos: Reading temperature makes sense only when TMU
is turned on").

After that I did the audit of all DT thermal drivers and found
the issue in majority of them (patches #5-16):

- bcm2835
- brcmstb
- hisi_thermal
- tsens
- qoriq
- rcar_gen3_thermal
- rockchip_thermal
- exynos
- tegra
- ti-soc-thermal
- uniphier
- zx2967

>> [devm]_thermal_zone_of_sensor_register() need to be called in
>> order to obtain data about thermal trips which are then used to
>> finish hardware sensor setup (only after which ->get_temp can
>> be used). The issue has been observed when using Samsung Exynos
> 
> Oh I see, this is because trip info is read by the of thermal thermal
> then, correct?

Yes, some drivers need trip info for sensor configuration.

There is also related issue for drivers that support IRQ
(i.e. exynos and rockchip ones):

- sensor should be enabled only after IRQ handler is requested
  (because otherwise we might get IRQs that we can't handle)

- IRQ handler needs tzd structure which is obtained from
  [devm_]thermal_zone_of_sensor_register()

- after [devm_]thermal_zone_of_sensor_register() call core
  thermal code assumes that sensor is enabled and ready to
  use (the core may call ->get_temp)

>> thermal driver and fixed internally in the driver in commit
>> d8efad71e5b6 ("thermal: exynos: Reading temperature makes sense
>> only when TMU is turned on"). However after this commit there
>> are now following warnings from the thermal core visible:
>>
>> [    3.453602] thermal thermal_zone0: failed to read out thermal zone (-22)
>> [    3.483468] thermal thermal_zone1: failed to read out thermal zone (-22)
>> [    3.505965] thermal thermal_zone2: failed to read out thermal zone (-22)
>> [    3.528455] thermal thermal_zone3: failed to read out thermal zone (-22)
>> [    3.550939] thermal thermal_zone4: failed to read out thermal zone (-22)
>>
>> This patchset attempts to directly address the thermal core
>> problem with [devm]_thermal_zone_of_sensor_register() and
>> affected DT thermal drivers. In order to achieve this sensor
>> registration, enable and check operations are separated and
>> corresponding drivers are modified to use the new helpers to
>> enable and check sensor explicitly.
>>
> 
> Ok. Up to this point I followed that this is a samsung driver issue, not
> we need to change the core to fix adapt to it?

Well, we need core changes (patches #2 and #4) for (IMHO) cleaner and
more straightforward solution (with it the core can have the valid info
about the sensor state all the time).

Alternatively we can add workarounds (like the one we added in exynos
driver) to all affected DT thermal drivers (with this solution sensor
can be disabled while the core will think that it is enabled)..

> And adapting the core should be fine to fit a new use/fix something,
> as long the issue is well described..
> 
>> Tested on Exynos5422 based Odroid-XU3 Lite board (aforementioned
>> warnings from the thermal core are now gone).
>>
>> Best regards,
>> --
>> Bartlomiej Zolnierkiewicz
>> Samsung R&D Institute Poland
>> Samsung Electronics
>>
>>
>> Bartlomiej Zolnierkiewicz (17):
>>   thermal: add thermal_zone_device_toggle() helper
>>   thermal: separate sensor registration and enable
>>   thermal: add thermal_zone_device_check() helper
>>   thermal: do sensor checking explicitly in drivers
>>   thermal: bcm2835: enable/check sensor after its setup is finished
>>   thermal: brcmstb: enable/check sensor after its setup is finished
>>   thermal: hisi_thermal: enable/check sensor after its setup is finished
>>   thermal: qcom: tsens: enable/check sensor after its setup is finished
>>   thermal: qoriq: enable/check sensor after its setup is finished
>>   thermal: rcar_gen3_thermal: enable/check sensor after its setup is
>>     finished
>>   thermal: rockchip_thermal: enable/check sensor after its setup is
>>     finished
>>   thermal: exynos: enable/check sensor after its setup is finished
>>   thermal: tegra: enable/check sensor after its setup is finished
>>   thermal: ti-soc-thermal: enable/check sensor after its setup is
>>     finished
>>   thermal: uniphier: enable/check sensor after its setup is
>>     finished
>>   thermal: zx2967: enable/check sensor after its setup is finished
>>   thermal: warn on attempts to read temperature on disabled sensors
>>
>>  drivers/acpi/thermal.c                             |  5 ++--
>>  drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
>>  drivers/platform/x86/acerhdf.c                     |  6 +++-
>>  drivers/regulator/max8973-regulator.c              |  3 +-
>>  drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
>>  drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
>>  drivers/thermal/broadcom/ns-thermal.c              |  3 ++
>>  drivers/thermal/da9062-thermal.c                   |  7 ++---
>>  drivers/thermal/db8500_thermal.c                   |  5 +++-
>>  drivers/thermal/hisi_thermal.c                     | 22 ++++----------
>>  drivers/thermal/imx_thermal.c                      |  3 +-
>>  drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
>>  drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
>>  drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
>>  drivers/thermal/max77620_thermal.c                 |  6 ++--
>>  drivers/thermal/mtk_thermal.c                      |  3 ++
>>  drivers/thermal/of-thermal.c                       |  6 ++--
>>  drivers/thermal/qcom-spmi-temp-alarm.c             |  5 +++-
>>  drivers/thermal/qcom/tsens.c                       |  6 ++++
>>  drivers/thermal/qoriq_thermal.c                    |  3 ++
>>  drivers/thermal/rcar_gen3_thermal.c                |  7 +++--
>>  drivers/thermal/rcar_thermal.c                     |  8 +++--
>>  drivers/thermal/rockchip_thermal.c                 | 34 ++++++++++------------
>>  drivers/thermal/samsung/exynos_tmu.c               |  7 ++++-
>>  drivers/thermal/st/st_thermal_memmap.c             |  3 +-
>>  drivers/thermal/tango_thermal.c                    |  5 ++++
>>  drivers/thermal/tegra/soctherm.c                   |  3 ++
>>  drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
>>  drivers/thermal/thermal-generic-adc.c              |  3 ++
>>  drivers/thermal/thermal_core.c                     | 14 ++++-----
>>  drivers/thermal/thermal_helpers.c                  | 33 +++++++++++++++++++++
>>  drivers/thermal/thermal_sysfs.c                    | 17 +++++++----
>>  drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 ++++-
>>  drivers/thermal/uniphier_thermal.c                 |  6 +++-
>>  drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
>>  drivers/thermal/zx2967_thermal.c                   |  3 ++
>>  include/linux/thermal.h                            |  5 ++++
>>  37 files changed, 173 insertions(+), 84 deletions(-)

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
