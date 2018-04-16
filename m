Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753157AbeDPQUM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 12:20:12 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:46218 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752770AbeDPQUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 12:20:10 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <alexandre.torgue@st.com>
CC: <thierry.reding@gmail.com>, <benjamin.gaignard@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <benjamin.gaignard@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: [PATCH v4 0/6] Add support for PWM input capture on STM32
Date: Mon, 16 Apr 2018 18:19:15 +0200
Message-ID: <1523895561-4073-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.122]
X-ClientProxiedBy: GPXDAG5NODE5.st.com (10.75.127.78) To GPXDAG5NODE6.st.com
 (10.75.127.79)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-16_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for capture to stm32-pwm driver.
Capture is based on DMAs.
- First two patches add support for requesting DMAs to MFD core
- Next three patches add support for capture to stm32-pwm driver
- This has been tested on stm32429i-eval board.

---
Changes in v4:
- Lee's comments on patch 2 (mfd: stm32-timers: add support for dmas)
  Add kerneldoc header, better format comments.

Changes in v3:
- Dropped 2 precusor patches applied by Thierry in pwm tree:
  "pwm: stm32: fix, remove unused struct device"
  "pwm: stm32: protect common prescaler for all channels"
- Note: this series applies on top on pwm tree
- Implements Lee's comments on MFD part: rework stm32_timers_dma struct,
  exported routine prototype now use generic device struct, more
  various comments (see patch 2 changelog).

Resend v2:
- Add collected Acks

Changes in v2:
- Abstract DMA handling from child driver: move it to MFD core
- Rework pwm capture routines to adopt this change
- Comment on optional dma support, beautify DMAs probe

Fabrice Gasnier (6):
  dt-bindings: mfd: stm32-timers: add support for dmas
  mfd: stm32-timers: add support for dmas
  pwm: stm32: add capture support
  pwm: stm32: improve capture by tuning counter prescaler
  pwm: stm32: use input prescaler to improve period capture
  ARM: dts: stm32: Enable pwm3 input capture on stm32f429i-eval

 .../devicetree/bindings/mfd/stm32-timers.txt       |  20 ++
 arch/arm/boot/dts/stm32429i-eval.dts               |   3 +
 drivers/mfd/stm32-timers.c                         | 227 +++++++++++++++++-
 drivers/pwm/pwm-stm32.c                            | 257 +++++++++++++++++++++
 include/linux/mfd/stm32-timers.h                   |  44 ++++
 5 files changed, 549 insertions(+), 2 deletions(-)

-- 
1.9.1
