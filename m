Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeEQMFT (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 08:05:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:55971 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752065AbeEQMFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 08:05:16 -0400
From: Amelie Delaunay <amelie.delaunay@st.com>
To: Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
CC: <linux-rtc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Amelie Delaunay <amelie.delaunay@st.com>
Subject: [PATCH v3 0/4] Introduce STM32MP1 RTC
Date: Thu, 17 May 2018 14:04:22 +0200
Message-ID: <1526558666-24243-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-17_05:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces STM32MP1 RTC.
On STM32MP1:
- two clocks are needed, plck and rtc_ck;
- to wakeup the system, a wakeup alarm interrupt is needed;
- some registers or bits have moved, but the operation is the same;
- the Backup Domain Protection (DBP) is not managed by RTC driver.

---
Changes in v3:
* Move cleanup changes in a separate patch
* Replace regs and evts by pointers to ensure no copy is made
* Set all registers offset as u16 instead of u8 and u16
* Fix Kbuild smatch warning:
  drivers/rtc/rtc-stm32.c:827 stm32_rtc_probe()
  warn: always true condition '(regs.verr != ~0) => (0-u16max != (-1))'

Changes in v2:
* One compatible per line in bindings file
* Remove unnecessary comment under rtc_ck as this clock is required for all
* Remove interrupts-extended and add stm32mp1 rtc alarm wakeup interrupt in
  interrupts property description

Amelie Delaunay (4):
  rtc: stm32: fix misspelling and misalignment issues
  rtc: stm32: rework register management to prepare other version of RTC
  dt-bindings: rtc: update stm32-rtc documentation for stm32mp1 rtc
  rtc: stm32: add stm32mp1 rtc support

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  27 +-
 drivers/rtc/rtc-stm32.c                            | 273 ++++++++++++++++-----
 2 files changed, 229 insertions(+), 71 deletions(-)

-- 
2.7.4
