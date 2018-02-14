Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967144AbeBNKHO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:07:14 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:43419 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S966960AbeBNKFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:05:44 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>,
        <alexandre.torgue@st.com>
CC: <benjamin.gaignard@linaro.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [RESEND PATCH v2 0/8] Add support for PWM input capture on STM32
Date: Wed, 14 Feb 2018 11:04:31 +0100
Message-ID: <1518602679-3064-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-14_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for capture to stm32-pwm driver.
Capture is based on DMAs.
- First two patches are precursor patches
- Subsequent two patches add support for requesting DMAs to MFD core
- Next three patches add support for capture to stm32-pwm driver
- This has been tested on stm32429i-eval board.

---
Resend v2:
- Add collected Acks

Changes in v2:
- Abstract DMA handling from child driver: move it to MFD core
- Rework pwm capture routines to adopt this change
- Comment on optional dma support, beautify DMAs probe

Fabrice Gasnier (8):
  pwm: stm32: fix, remove unused struct device
  pwm: stm32: protect common prescaler for all channels
  dt-bindings: mfd: stm32-timers: add support for dmas
  mfd: stm32-timers: add support for dmas
  pwm: stm32: add capture support
  pwm: stm32: improve capture by tuning counter prescaler
  pwm: stm32: use input prescaler to improve period capture
  ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
 drivers/mfd/stm32-timers.c                         | 215 +++++++++++++++-
 drivers/pwm/pwm-stm32.c                            | 276 ++++++++++++++++++++-
 include/linux/mfd/stm32-timers.h                   |  39 +++
 5 files changed, 547 insertions(+), 6 deletions(-)

-- 
1.9.1
