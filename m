Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752528AbeERPZR (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:25:17 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:54162 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1750882AbeERPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:25:10 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>
CC: <rdunlap@infradead.org>, <sfr@canb.auug.org.au>, <gerald.baeza@st.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <linux-next@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 0/2] Fix STM32 PWM capture build with COMPILE_TEST
Date: Fri, 18 May 2018 17:24:02 +0200
Message-ID: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG7NODE1.st.com (10.75.127.19) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build issue has been identified when COMPILE_TEST=y and MFD_STM32_TIMERS=n:
https://lkml.org/lkml/2018/5/17/825
- First patch introduces a stub routine in mfd header file
- Sub-sequent patch solves warning in pwm-stm32 with these configs

Fabrice Gasnier (2):
  mfd: stm32-timers: fix pwm-stm32 linker issue with COMPILE_TEST
  pwm: stm32: initialize raw local variables

 drivers/pwm/pwm-stm32.c          |  2 +-
 include/linux/mfd/stm32-timers.h | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

-- 
1.9.1
