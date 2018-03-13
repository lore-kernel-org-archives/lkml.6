Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933447AbeCMQe6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:34:58 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:19026 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933458AbeCMQez (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:34:55 -0400
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
Subject: [PATCH 0/2] Introduce STM32MP1 Reset driver
Date: Tue, 13 Mar 2018 17:34:17 +0100
Message-ID: <1520958859-27911-1-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-13_07:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

This patch-set enables the reset of STM32MP1.
It uses the reset simple driver by introducing the clear register offset
parameter.
STM32MP1 reset IP has a register to assert by writing '1' and another
register to de-assert by writing '1'.
The offset between this two registers is '0x4'.

The patch 'dt-bindings: reset: add STM32MP1 resets' could be squashed
with the patch:
'dt-bindings: Document STM32MP1 Reset Clock Controller (RCC) bindings'
commit 3830681d354f

Gabriel Fernandez (2):
  dt-bindings: reset: add STM32MP1 resets
  reset: simple: Enable stm32mp1 reset driver

 drivers/reset/reset-simple.c                |  27 +++++--
 drivers/reset/reset-simple.h                |   1 +
 include/dt-bindings/reset/stm32mp1-resets.h | 108 ++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+), 6 deletions(-)
 create mode 100644 include/dt-bindings/reset/stm32mp1-resets.h

-- 
1.9.1
