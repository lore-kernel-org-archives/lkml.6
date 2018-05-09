Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965166AbeEIPqu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:46:50 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:21800 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S965067AbeEIPqp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:46:45 -0400
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
Subject: [PATCH v2 0/3] Introduce STM32MP1 RTC
Date: Wed, 9 May 2018 17:46:07 +0200
Message-ID: <1525880770-22263-1-git-send-email-amelie.delaunay@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.201.20.5]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-09_06:,,
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
Changes in v2:
* One compatible per line in bindings file
* Remove unnecessary comment under rtc_ck as this clock is required for all
* Remove interrupts-extended and add stm32mp1 rtc alarm wakeup interrupt in
  interrupts property description

Amelie Delaunay (3):
  rtc: stm32: rework register management to prepare other version of RTC
  dt-bindings: rtc: update stm32-rtc documentation for stm32mp1 rtc
  rtc: stm32: add stm32mp1 rtc support

 .../devicetree/bindings/rtc/st,stm32-rtc.txt       |  27 +-
 drivers/rtc/rtc-stm32.c                            | 272 ++++++++++++++++-----
 2 files changed, 228 insertions(+), 71 deletions(-)

-- 
2.7.4
