Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932375AbeCSH0b (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 03:26:31 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:11179 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932073AbeCSH0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 03:26:23 -0400
From: <gabriel.fernandez@st.com>
To: Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>, <gabriel.fernandez@st.com>
CC: <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <gabriel.fernandez.st@gmail.com>, Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>,
        Michael Turquette <mturquette@baylibre.com>, <sboyd@kernel.org>,
        Gabriel Fernandez <gabriel.fernandez@st.com>
Subject: [PATCH v3 0/2] Introduce STM32MP1 Reset driver
Date: Mon, 19 Mar 2018 08:25:49 +0100
Message-ID: <1521444351-29550-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG3NODE2.st.com (10.75.127.8) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-19_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

v3:
remove unused includes
fix status ops
fix from Fengguang Wu
	for Kbuild test robot: symbol 'stm32_reset_ops' was not declared. Should it be static?
use 'builtin_platform_driver' instead 'postcore_initcall'

v2:
Don't use reset-simple driver but a custom reset driver.
add dt-binding documentation.

This patch-set enables the reset of STM32MP1.
STM32MP1 reset IP has a register to assert by writing '1' and another
register to de-assert by writing '1'.

The patch 'dt-bindings: reset: add STM32MP1 resets' could be squashed
with the patch:
'dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings'
commit 3830681d354f

Gabriel Fernandez (2):
  dt-bindings: reset: add STM32MP1 resets
  reset: stm32mp1: Enable stm32mp1 reset driver

 .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |   6 ++
 drivers/reset/Kconfig                              |   6 ++
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-stm32mp1.c                     | 115 +++++++++++++++++++++
 include/dt-bindings/reset/stm32mp1-resets.h        | 108 +++++++++++++++++++
 5 files changed, 236 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32mp1-rcc.txt
 create mode 100644 drivers/reset/reset-stm32mp1.c
 create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h

-- 
1.9.1
