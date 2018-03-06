Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933107AbeCFOof (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 09:44:35 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:38558 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932865AbeCFOoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 09:44:30 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180306144427epoutp03f9ae58b82ef14b841c42bad446360648~ZW-eLlHWz1736017360epoutp03Z
X-AuditID: b6c32a35-891ff70000001031-b1-5a9ea94b85f2
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
Subject: [PATCH 00/12] thermal: exynos: sanitize DeviceTree support
Date: Tue, 06 Mar 2018 15:43:43 +0100
Message-id: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrMIsWRmVeSWpSXmKPExsWy7bCmrq73ynlRBhd7tCw2zljPajH/yDkg
        ceUaq0X/49fMFufPb2C32PQYyL28aw6bxefeI4wWM87vY7I4NHUvo8XS6xeZLFr3HmG3ePKw
        j82B12PNvDWMHpevXWT22DnrLrvH4j0vmTw2repk89i8pN6jb8sqRo/Pm+QCOKK4bFJSczLL
        Uov07RK4Mq6/ucZc0CNdMbX3NWMD4zfRLkZODgkBE4m7006wdjFycQgJ7GCUWLTyGBOE851R
        4srxR+wwVQ1d75khErsZJdpnPGcCSQgJ/GKUuPlHHsRmE7CSmNi+ihHEFhEokZi2qpcRpIFZ
        4CyTxI7t71hAEsICzhJHV84Cs1kEVCVmb/4I1sAr4CHR/OALK8Q2OYmTxyaD3SQhsIFN4sKh
        hYwQCReJ5z96oWxhiVfHtwCdxwFkS0tcOmoLUd/MKPFtxx5miJoJjBJ71gtB2NYSh49fBFvA
        LMAn8e5rDytEL69ERxtUiYdE1513bBC2o8SyDy2MEE/GSmz8f4lpAqPkAkaGVYxiqQXFuemp
        xYYFhnrFibnFpXnpesn5uZsYwVGtZbqDcco5n0OMAhyMSjy8GzzmRgmxJpYVV+YeYpTgYFYS
        4Y3QnxclxJuSWFmVWpQfX1Sak1p8iFGag0VJnDcgwCVKSCA9sSQ1OzW1ILUIJsvEwSnVwHhc
        YouR44PAhH3VEhwXL5s3CJz7lRYZZHJgYsKV78bzNDTnFP53i+kuL8mS3cUq2RK58GAqa2L9
        jFlLDLtYbS4I3XfxWrp/TqMNx8oTXTbpFR6iUx1rMisXf5f4HKhsvTgp1SspdG1XVeDrirbb
        fusP7YlKqtgateCuUFOoVeFy9wpTD/ZqJZbijERDLeai4kQARMiNW+YCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrALMWRmVeSWpSXmKPExsVy+t9jAV3vlfOiDF7+47LYOGM9q8X8I+eA
        xJVrrBb9j18zW5w/v4HdYtNjIPfyrjlsFp97jzBazDi/j8ni0NS9jBZLr19ksmjde4Td4snD
        PjYHXo8189Ywely+dpHZY+esu+wei/e8ZPLYtKqTzWPzknqPvi2rGD0+b5IL4IjisklJzcks
        Sy3St0vgyrj+5hpzQY90xdTe14wNjN9Euxg5OSQETCQaut4zdzFycQgJ7GSUuLXvIBuE84tR
        4tf2c8wgVWwCVhIT21cxgtgiAiUSndNeg8WZBc4ySRz8zwFiCws4SxxdOYsFxGYRUJWYvfkj
        WD2vgIdE84MvrBDb5CROHpvMOoGRawEjwypGydSC4tz03GKjAsO81HK94sTc4tK8dL3k/NxN
        jMBw23ZYq28H4/0l8YcYBTgYlXh4N3jMjRJiTSwrrsw9xCjBwawkwhuhPy9KiDclsbIqtSg/
        vqg0J7X4EKM0B4uSOO/tvGORQgLpiSWp2ampBalFMFkmDk6pBkbhVaw8d5fpzv65LfHA09+/
        mw++n3yBecHCZazJOen77wVN/L9UQmS25kOx+dKRU3R22tk49Ot99/K/ecL974XVsnFBQu91
        tyv+jPqssSVfuXim3yLbFpGPNVzsvI7V38I1XJrbA87vFVh9aEOVY/mkR4xpK6afTshs9XMP
        WbXzzWGRh6wRjixKLMUZiYZazEXFiQAb4IWoMwIAAA==
X-CMS-MailID: 20180306144427epcas1p3bd260e382c61ab5176a50aa95084b542
X-Msg-Generator: CA
CMS-TYPE: 101P
X-CMS-RootMailID: 20180306144427epcas1p3bd260e382c61ab5176a50aa95084b542
X-RootMTR: 20180306144427epcas1p3bd260e382c61ab5176a50aa95084b542
References: <CGME20180306144427epcas1p3bd260e382c61ab5176a50aa95084b542@epcas1p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Values passed through DT properties specific to Exynos thermal
driver ("samsung,*") are SoC (not platform) specific so just
define them in struct exynos_tmu_data instance (or just use
constants where values are identical for all SoCs) and remove
"samsung," DT properties altogether.

The patchset should not cause any functionality changes.  This
means that unless there are some bugs in the patches itself there
should be no behavior changes for the driver (this also includes
lack of changes in the way hardware is accessed by the driver).

Tested on Exynos5422 based Odroid-XU3 Lite board.

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics


Bartlomiej Zolnierkiewicz (12):
  thermal: exynos: remove unused type field from struct
    exynos_tmu_platform_data
  thermal: exynos: remove parsing of samsung,tmu_default_temp_offset
    property
  thermal: exynos: remove parsing of
    samsung,tmu_[first,second]_point_trim properties
  thermal: exynos: remove parsing of samsung,tmu_noise_cancel_mode
    property
  thermal: exynos: remove parsing of samsung,tmu[_min,_max]_efuse_value
    properties
  thermal: exynos: remove parsing of samsung,tmu_reference_voltage
    property
  thermal: exynos: remove parsing of samsung,tmu_gain property
  thermal: exynos: remove parsing of samsung,tmu_cal_type property
  thermal: exynos: remove separate exynos_tmu.h header file
  ARM: dts: remove no longer needed samsung thermal properties
  dt-bindings: thermal: remove no longer needed samsung thermal
    properties
  thermal: exynos: remove separate thermal_exynos.h header file

 .../devicetree/bindings/thermal/exynos-thermal.txt |  23 +--
 arch/arm/boot/dts/exynos3250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi  |  20 ---
 arch/arm/boot/dts/exynos5250.dtsi                  |   2 +-
 arch/arm/boot/dts/exynos5410.dtsi                  |   8 +-
 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi  |  21 ---
 arch/arm/boot/dts/exynos5420.dtsi                  |  10 +-
 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi  |  20 ---
 arch/arm/boot/dts/exynos5440.dtsi                  |   6 +-
 .../dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi |  20 ---
 .../dts/exynos/exynos5433-tmu-sensor-conf.dtsi     |  19 ---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |  10 +-
 .../boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi   |  21 ---
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   2 +-
 drivers/thermal/samsung/exynos_tmu.c               | 181 +++++++++++----------
 drivers/thermal/samsung/exynos_tmu.h               |  75 ---------
 include/dt-bindings/thermal/thermal_exynos.h       |  28 ----
 18 files changed, 124 insertions(+), 346 deletions(-)
 delete mode 100644 arch/arm/boot/dts/exynos4412-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5420-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm/boot/dts/exynos5440-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-g3d-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos5433-tmu-sensor-conf.dtsi
 delete mode 100644 arch/arm64/boot/dts/exynos/exynos7-tmu-sensor-conf.dtsi
 delete mode 100644 drivers/thermal/samsung/exynos_tmu.h
 delete mode 100644 include/dt-bindings/thermal/thermal_exynos.h

-- 
1.9.1
