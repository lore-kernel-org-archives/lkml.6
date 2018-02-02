Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752281AbeBBOFU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:05:20 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:51481 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752135AbeBBOEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:04:41 -0500
From: <gabriel.fernandez@st.com>
To: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>
Subject: [PATCH 00/14] Introduce STM32MP1 clock driver
Date: Fri, 2 Feb 2018 15:03:28 +0100
Message-ID: <1517580222-23301-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG6NODE2.st.com (10.75.127.17) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-02_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set introduces clock driver for STM32MP157 based on Arm Cortex-A7.
The driver patch is splitted in several patches (by kind of clock) to facilitate
code reviewing.

Gabriel Fernandez (14):
  dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
  dt-bindings: clock: add STM32MP1 clocks
  clk: stm32mp1: Introduce STM32MP1 clock driver
  clk: stm32mp1: add MP1 gate for osc hse/hsi/csi oscillators
  clk: stm32mp1: add Source Clocks for PLLs
  clk: stm32mp1: add PLL clocks
  clk: stm32mp1: add Post-dividers for PLL
  clk: stm32mp1: add Sub System clocks
  clk: stm32mp1: add Kernel timers
  clk: stm32mp1: add Peripheral clocks
  clk: stm32mp1: add Kernel clocks
  clk: stm32mp1: add RTC clock
  clk: stm32mp1: add MCO clocks
  clk: stm32mp1: add Debug clocks

 .../devicetree/bindings/mfd/st,stm32-rcc.txt       |   85 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-stm32mp1.c                         | 1705 ++++++++++++++++++++
 include/dt-bindings/clock/stm32mp1-clks.h          |  248 +++
 5 files changed, 2045 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mfd/st,stm32-rcc.txt
 create mode 100644 drivers/clk/clk-stm32mp1.c
 create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h

-- 
1.9.1
