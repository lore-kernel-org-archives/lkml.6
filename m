Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbeDJMmp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:42:45 -0400
Received: from mailout3.samsung.com ([203.254.224.33]:57282 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751178AbeDJMmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:42:43 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180410124241epoutp034b181d0652d7669442f607944479d436~kE6JAMMh-0547905479epoutp03f
X-AuditID: b6c32a47-0fbff70000000fe8-24-5accb14101b9
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>
Cc: Eric Anholt <eric@anholt.net>, Stefan Wahren <stefan.wahren@i2se.com>,
        Markus Mayer <mmayer@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Heiko Stuebner <heiko@sntech.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>, Keerthy <j-keerthy@ti.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Jun Nie <jun.nie@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 00/17] thermal: enable/check sensor after its setup is
 finished
Date: Tue, 10 Apr 2018 14:41:54 +0200
Message-id: <1523364131-31059-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAAzWSa0hTYRjHfbdzzo7D6eko+epIY6WS5Oyi8lYSClaHyqjoQwysRh7UdCo7
        all9sClmgpdQsMRbXiJmIo45zaaZus3mUkQTSUss0zSawkSxkmoe/fZ7+P+ey4eHFNJ/MF8y
        KTWDVacqU2SEGDP0H4gIiW6zKQ61j3igtietOJp3WABqKTJhqHZ8Ake9D8YA+vvlB46sHRoB
        yqusx1Dj3KwIjXVVEchRNABQlX1KhOZmiwn0Xe+NdC8mCbTRVYOh7s8OELWL0SybCaZy5j3B
        vKr8JGLaP4YzDcZFAaPTPiKY6QkjwRTl2gmmWK8FTMdEjZAZrFjHGMtkh4Bx6PwuShTiyHg2
        JSmLVYeevCFOnDL2EumW4DvWsk8gByz5FwJXElJhsMdaLCwEYpKmOgEsGZoR8cU6gLnDJuGO
        1WhuFvDBawAXm+q3rV8A/jTatiyCOg4fP9SCQkCSXtQ5qH9JOh0h9RSDK9POSSTpSV2Cpjza
        iRgVAB1LtLNTQjHQbjfg/C4/+M5chjtbIfWbgN9Wx3GnD6kYOKjdyzuecMmiF/EshfPaNsD7
        uQCudRq3jy4F0NhK83wC9ltGtxYIKXdY0L8p4mdKYEE+zSMDi+tSeTsabsw5CCfTVBx8NvAB
        LwU+dcBFC3az6ZwqgeWOpB+Vc0oVl5maIL+ZptKBrZ8IPtMJDMPn+wBFApmbpPTtkILGlVlc
        tqoPQFIo85KktNgUtCRemX2XVaddV2emsFwfkJKYzFuSE/s/ohKUGWwyy6az6p1UQLr65oDY
        W8agLEZTErMQW5JvkCbe62kwBzXnnqqpsuIH7y90jkhHl/dc0QRG5n8tvzrqs65Nep7Vgbrc
        9NUr/lXdRJyHNSA6rQC6l5vCKyJOi23ja7UyY1ezS2jTmxL5hfDVqfLsfaubAdeOteNDctXZ
        xtH9l28HRmnyk8OqQ+btC9UyjEtUHg4WqjnlPzHRo8oPAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFLMWRmVeSWpSXmKPExsVy+t9jAV2HjWeiDD41s1hsnLGe1eLZ5+OM
        Fmt7j7JYzL9yjdXiQONlRov/j16zWpza3sRk0TJrEYvFkicP2S0u75rDZvG59wijxZx3t9kt
        njzsY7N4sUXcYtOKG2wWP3fNY7HYe+8zo4OgR9P7Y2wes+6fZfPYOesuu8fWW6Yei/e8ZPLY
        tKqTzePOtT1sHr3N79g8+rasYvTYfm0es8eJ6d9ZPI7f2M7k8XmTXABvFJdNSmpOZllqkb5d
        AlfG7T0H2AqOa1WcmnyXsYHxlXwXIyeHhICJxJJjq5m6GLk4hAR2Mko8/7SMFSQhJPCLUeLg
        cTYQm03ASmJi+yrGLkYODhEBb4ktazhA6pkFZrJItE19yghSIyzgL3Hs8Bd2kBoWAVWJz6+E
        QMK8Ah4S795tY4XYJSdx8thk1gmMXAsYGVYxSqYWFOem5xYbFRjlpZbrFSfmFpfmpesl5+du
        YgSG8LbDWv07GB8viT/EKMDBqMTDO+Hg6Sgh1sSy4srcQ4wSHMxKIrw5a89ECfGmJFZWpRbl
        xxeV5qQWH2KU5mBREuflzz8WKSSQnliSmp2aWpBaBJNl4uCUamCU71m52XvZed2XJtHPEi1r
        2z9xJj6vTPk72XHDUuE92YttWy7se7155bWdiyYFXQjtUK8qEqv3jGw3V9MLeXQ5vyXUqPx3
        UKOvdcarZ74fHA5e/WlYEmt++mboxN9Xt9w3NBN6XvT3oKel0Oys1Acdh7rvvjxy2O22FPeR
        vR/sY13Tf65dH8ylxFKckWioxVxUnAgAhMR9eF0CAAA=
X-CMS-MailID: 20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14
X-RootMTR: 20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14
References: <CGME20180410124240epcas2p25c8979583c41f147ac34c49faf30aa14@epcas2p2.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

[devm]_thermal_zone_of_sensor_register() is used to register
thermal sensor by thermal drivers using DeviceTree. Besides
registering sensor this function also immediately enables it
(using ->set_mode method) and then checks it with a update call
to the thermal core (which ends up using ->get_temp method).
For many DT thermal drivers this causes a problem because
[devm]_thermal_zone_of_sensor_register() need to be called in
order to obtain data about thermal trips which are then used to
finish hardware sensor setup (only after which ->get_temp can
be used). The issue has been observed when using Samsung Exynos
thermal driver and fixed internally in the driver in commit
d8efad71e5b6 ("thermal: exynos: Reading temperature makes sense
only when TMU is turned on"). However after this commit there
are now following warnings from the thermal core visible:

[    3.453602] thermal thermal_zone0: failed to read out thermal zone (-22)
[    3.483468] thermal thermal_zone1: failed to read out thermal zone (-22)
[    3.505965] thermal thermal_zone2: failed to read out thermal zone (-22)
[    3.528455] thermal thermal_zone3: failed to read out thermal zone (-22)
[    3.550939] thermal thermal_zone4: failed to read out thermal zone (-22)

This patchset attempts to directly address the thermal core
problem with [devm]_thermal_zone_of_sensor_register() and
affected DT thermal drivers. In order to achieve this sensor
registration, enable and check operations are separated and
corresponding drivers are modified to use the new helpers to
enable and check sensor explicitly.

Tested on Exynos5422 based Odroid-XU3 Lite board (aforementioned
warnings from the thermal core are now gone).

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (17):
  thermal: add thermal_zone_device_toggle() helper
  thermal: separate sensor registration and enable
  thermal: add thermal_zone_device_check() helper
  thermal: do sensor checking explicitly in drivers
  thermal: bcm2835: enable/check sensor after its setup is finished
  thermal: brcmstb: enable/check sensor after its setup is finished
  thermal: hisi_thermal: enable/check sensor after its setup is finished
  thermal: qcom: tsens: enable/check sensor after its setup is finished
  thermal: qoriq: enable/check sensor after its setup is finished
  thermal: rcar_gen3_thermal: enable/check sensor after its setup is
    finished
  thermal: rockchip_thermal: enable/check sensor after its setup is
    finished
  thermal: exynos: enable/check sensor after its setup is finished
  thermal: tegra: enable/check sensor after its setup is finished
  thermal: ti-soc-thermal: enable/check sensor after its setup is
    finished
  thermal: uniphier: enable/check sensor after its setup is
    finished
  thermal: zx2967: enable/check sensor after its setup is finished
  thermal: warn on attempts to read temperature on disabled sensors

 drivers/acpi/thermal.c                             |  5 ++--
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c |  1 -
 drivers/platform/x86/acerhdf.c                     |  6 +++-
 drivers/regulator/max8973-regulator.c              |  3 +-
 drivers/thermal/broadcom/bcm2835_thermal.c         |  3 ++
 drivers/thermal/broadcom/brcmstb_thermal.c         |  3 ++
 drivers/thermal/broadcom/ns-thermal.c              |  3 ++
 drivers/thermal/da9062-thermal.c                   |  7 ++---
 drivers/thermal/db8500_thermal.c                   |  5 +++-
 drivers/thermal/hisi_thermal.c                     | 22 ++++----------
 drivers/thermal/imx_thermal.c                      |  3 +-
 drivers/thermal/int340x_thermal/int3400_thermal.c  |  1 +
 drivers/thermal/intel_bxt_pmic_thermal.c           |  3 +-
 drivers/thermal/intel_soc_dts_iosf.c               |  3 +-
 drivers/thermal/max77620_thermal.c                 |  6 ++--
 drivers/thermal/mtk_thermal.c                      |  3 ++
 drivers/thermal/of-thermal.c                       |  6 ++--
 drivers/thermal/qcom-spmi-temp-alarm.c             |  5 +++-
 drivers/thermal/qcom/tsens.c                       |  6 ++++
 drivers/thermal/qoriq_thermal.c                    |  3 ++
 drivers/thermal/rcar_gen3_thermal.c                |  7 +++--
 drivers/thermal/rcar_thermal.c                     |  8 +++--
 drivers/thermal/rockchip_thermal.c                 | 34 ++++++++++------------
 drivers/thermal/samsung/exynos_tmu.c               |  7 ++++-
 drivers/thermal/st/st_thermal_memmap.c             |  3 +-
 drivers/thermal/tango_thermal.c                    |  5 ++++
 drivers/thermal/tegra/soctherm.c                   |  3 ++
 drivers/thermal/tegra/tegra-bpmp-thermal.c         |  3 ++
 drivers/thermal/thermal-generic-adc.c              |  3 ++
 drivers/thermal/thermal_core.c                     | 14 ++++-----
 drivers/thermal/thermal_helpers.c                  | 33 +++++++++++++++++++++
 drivers/thermal/thermal_sysfs.c                    | 17 +++++++----
 drivers/thermal/ti-soc-thermal/ti-thermal-common.c |  7 ++++-
 drivers/thermal/uniphier_thermal.c                 |  6 +++-
 drivers/thermal/x86_pkg_temp_thermal.c             |  2 +-
 drivers/thermal/zx2967_thermal.c                   |  3 ++
 include/linux/thermal.h                            |  5 ++++
 37 files changed, 173 insertions(+), 84 deletions(-)

-- 
1.9.1
