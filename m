Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbeCNQad (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 12:30:33 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:39526 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751452AbeCNQa3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:30:29 -0400
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
Subject: [PATCH v2 0/2] Introduce STM32MP1 Reset driver
Date: Wed, 14 Mar 2018 17:29:59 +0100
Message-ID: <1521045001-30788-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.50]
X-ClientProxiedBy: SFHDAG4NODE3.st.com (10.75.127.12) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-14_08:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

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

 .../devicetree/bindings/reset/st,stm32mp1-rcc.txt  |   6 +
 drivers/reset/Kconfig                              |   6 +
 drivers/reset/Makefile                             |   1 +
 drivers/reset/reset-stm32mp1.c                     | 122 +++++++++++++++++++++
 include/dt-bindings/reset/stm32mp1-resets.h        | 108 ++++++++++++++++++
 5 files changed, 243 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reset/st,stm32mp1-rcc.txt
 create mode 100644 drivers/reset/reset-stm32mp1.c
 create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h

-- 
1.9.1
