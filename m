Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752001AbeCWJP1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 05:15:27 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:48398 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751668AbeCWJPZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 05:15:25 -0400
X-UUID: cc6d50fc664d4606b6a9bdd37205d8d1-20180323
From: <sean.wang@mediatek.com>
To: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <alexandre.belloni@free-electrons.com>, <eddie.huang@mediatek.com>
CC: <devicetree@vger.kernel.org>, <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Sean Wang <sean.wang@mediatek.com>
Subject: [PATCH v1 00/16] Add support to MT6323 RTC and its power device
Date: Fri, 23 Mar 2018 17:14:57 +0800
Message-ID: <cover.1521794176.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TM-AS-Result: No-9.360600-8.000000-10
X-TMASE-MatchedRID: tTPQr586rYaZCmMjjYK8qYv73wEu0Nx7QCf2rISO3ztcKZwALwMGswBu
        o8M5Nxn4FrGaGuAHjPEZWUxDAlAndMvTk9bUe4riuIwLnB3Aqp1hBfGxmdHCgjUsHjosUACSdE7
        ABQfxM9d4i+oTWG3KCXua1vW9URg3LSTGw1g/Kd5NVr4vdmCpzu0d/wCAHbnoSwcZtVb90bAVWT
        DhfTuSaE4kHnA/WiqEhRAr0eCrd7SvvxILmKK/HBRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7r5Ce
        OaEn8jcDYt4GHyd40F+Nt3NsmbJIGWo4CpyJYPqWClYJu9r4yY=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--9.360600-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23736.004
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Hi,

The series keeps to extend the capability of BPI-R2 board with MT7623 and
the result can as well bring benefits into the other MediaTek PMICs such
as MT6397 or SoCs.

The series sent across mfd, rtc, pm, dt-binding sub-system is for hoping
to let people have a simple cross-reference to know the exact dependency
and why those patches are being split in that way between each one.

Patch 1-3: Add dt-binding to the related devices newly or already
	   supported.
Patch 4-5: Extend driver with the functionality of MT6323 RTC device.
Patch 6-9 and 12-13: Add a few of trivial fixups, cleanups and
	  improvements.
Patch 10-11: It's a preparation for Patch 14 adding a new driver.
Patch 14: Add a new driver for a power-off driver.
Patch 15-16: Update MAINTAINERS with these new files being added.

	Sean

Sean Wang (16):
  dt-bindings: power: reset: mediatek: add bindings for power device
  dt-bindings: rtc: mediatek: add bindings for PMIC RTC
  dt-bindings: mfd: mediatek: add a description for MT6323 RTC
  mfd: mt6397: add MT6323 RTC support into MT6397 driver
  rtc: mediatek: add MT6323 support to RTC driver
  rtc: mediatek: remove unnecessary parentheses
  rtc: mediatek: replace a poll with regmap_read_poll_timeout
  rtc: mediatek: remove unnecessary irq_dispose_mapping
  rtc: mediatek: convert to use device managed functions
  rtc: mediatek: add devm_of_platform_populate
  rtc: mediatek: move the declaration into a globally visible header
    file
  rtc: mediatek: cleanup header files to include
  rtc: mediatek: update license converting to using SPDX identifiers
  power: reset: mediatek: add a power-off driver using PMIC RTC device
  MAINTAINERS: update entry for ARM/Mediatek RTC DRIVER
  MAINTAINERS: add an entry for MediaTek board level shutdown driver

 Documentation/devicetree/bindings/mfd/mt6397.txt   |   4 +-
 .../bindings/power/reset/mt6397-rtc-poweroff.txt   |  24 ++++
 .../devicetree/bindings/rtc/rtc-mt6397.txt         |  39 ++++++
 MAINTAINERS                                        |   9 ++
 drivers/mfd/mt6397-core.c                          |  23 +++-
 drivers/power/reset/Kconfig                        |   9 ++
 drivers/power/reset/Makefile                       |   1 +
 drivers/power/reset/mt6397-rtc-poweroff.c          | 100 ++++++++++++++
 drivers/rtc/rtc-mt6397.c                           | 145 +++++----------------
 include/linux/rtc/mt6397.h                         |  73 +++++++++++
 10 files changed, 314 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/mt6397-rtc-poweroff.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt6397.txt
 create mode 100644 drivers/power/reset/mt6397-rtc-poweroff.c
 create mode 100644 include/linux/rtc/mt6397.h

-- 
2.7.4
