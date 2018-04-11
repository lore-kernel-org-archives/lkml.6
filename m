Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753691AbeDKNZ0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 09:25:26 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:41534 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1753271AbeDKNZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 09:25:23 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        <linux-i2c@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH v3 0/6] Add different features for I2C
Date: Wed, 11 Apr 2018 15:24:52 +0200
Message-ID: <1523453098-3758-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.51]
X-ClientProxiedBy: SFHDAG2NODE1.st.com (10.75.127.4) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-11_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Append new I2C STM32F7 feature set. This includes 10 bit support, slave
support, SMBBus protocols support, DMA Support and eventually an I2C release
mechanism.

---
  Version history:
    v1:
        * Initial
    v2:
        * Kbuild test robot issue
        * I2C master recovery mechanism
    v3:
        * Provide more details on what have already been implemented and
          not implemented for SMBus protocols
        * Raise DMA usage threshold
        * s/recovery/release/ throughout the patch. Recovery is really
          something else.
---
Pierre-Yves MORDRET (6):
  i2c: i2c-stm32f7: Add 10-bit address support
  i2c: i2c-stm32f7: Add slave support
  i2c: i2c-stm32f7: Add initial SMBus protocols support
  i2c: i2c-stm32: Add generic DMA API
  i2c: i2c-stm32f7: Add DMA support
  i2c: i2c-stm32f7: Implement I2C release mechanism

 drivers/i2c/busses/Kconfig       |    1 +
 drivers/i2c/busses/Makefile      |    3 +-
 drivers/i2c/busses/i2c-stm32.c   |  153 ++++++
 drivers/i2c/busses/i2c-stm32.h   |   37 ++
 drivers/i2c/busses/i2c-stm32f7.c | 1040 +++++++++++++++++++++++++++++++++++++-
 5 files changed, 1207 insertions(+), 27 deletions(-)
 create mode 100644 drivers/i2c/busses/i2c-stm32.c

-- 
2.7.4
