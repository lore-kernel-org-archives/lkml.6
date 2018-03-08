Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936029AbeCHQ4k (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 11:56:40 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:41854 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S934328AbeCHQyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 11:54:53 -0500
From: <gabriel.fernandez@st.com>
To: <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
CC: <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <gabriel.fernandez.st@gmail.com>, <olivier.bideau@st.com>,
        Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: [PATCH v2 00/12] Introduce STM32MP1 clock driver
Date: Thu, 8 Mar 2018 17:53:53 +0100
Message-ID: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.47]
X-ClientProxiedBy: SFHDAG5NODE1.st.com (10.75.127.13) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-08_10:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v2:
  - Don't use MFD, use existing binding of STM32 RCC.
  - Rework Peripheral and Kernel clocks
  - cosmetic changes

This patch-set introduces clock driver for STM32MP157 based on Arm Cortex-A7.
The driver patch is split in several patches (by kind of clock) to facilitate
code reviewing.

Gabriel Fernandez (12):
  dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings
  clk: stm32mp1: Introduce STM32MP1 clock driver
  clk: stm32mp1: add MP1 gate for hse/hsi/csi oscillators
  clk: stm32mp1: add Source Clocks for PLLs
  clk: stm32mp1: add PLL clocks
  clk: stm32mp1: add Post-dividers for PLL
  clk: stm32mp1: add Sub System clocks
  clk: stm32mp1: add Kernel timers
  clk: stm32mp1: add Peripheral & Kernel Clocks
  clk: stm32mp1: add RTC clock
  clk: stm32mp1: add MCO clocks
  clk: stm32mp1: add Debug clocks

 .../devicetree/bindings/clock/st,stm32mp1-rcc.txt  |   60 +
 drivers/clk/Kconfig                                |    6 +
 drivers/clk/Makefile                               |    1 +
 drivers/clk/clk-stm32mp1.c                         | 2117 ++++++++++++++++++++
 include/dt-bindings/clock/stm32mp1-clks.h          |  254 +++
 5 files changed, 2438 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/st,stm32mp1-rcc.txt
 create mode 100644 drivers/clk/clk-stm32mp1.c
 create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h

-- 
1.9.1
