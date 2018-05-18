Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752539AbeERPZT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:25:19 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:4103 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751197AbeERPZK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:25:10 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <lee.jones@linaro.org>, <thierry.reding@gmail.com>
CC: <rdunlap@infradead.org>, <sfr@canb.auug.org.au>, <gerald.baeza@st.com>,
        <alexandre.torgue@st.com>, <mcoquelin.stm32@gmail.com>,
        <linux-next@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 2/2] pwm: stm32: initialize raw local variables
Date: Fri, 18 May 2018 17:24:04 +0200
Message-ID: <1526657044-14879-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
References: <1526657044-14879-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG1NODE3.st.com (10.75.127.3) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-18_06:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This removes build warning when COMPILE_TEST=y and MFD_STM32_TIMERS=n
in drivers/pwm/pwm-stm32.c. In function 'stm32_pwm_capture' 'raw_prd' and
'raw_dty' may be used uninitialized in this function
[-Wmaybe-uninitialized]

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pwm/pwm-stm32.c b/drivers/pwm/pwm-stm32.c
index 60bfc07..09383c6 100644
--- a/drivers/pwm/pwm-stm32.c
+++ b/drivers/pwm/pwm-stm32.c
@@ -170,7 +170,7 @@ static int stm32_pwm_capture(struct pwm_chip *chip, struct pwm_device *pwm,
 	unsigned long long prd, div, dty;
 	unsigned long rate;
 	unsigned int psc = 0, icpsc, scale;
-	u32 raw_prd, raw_dty;
+	u32 raw_prd = 0, raw_dty = 0;
 	int ret = 0;
 
 	mutex_lock(&priv->lock);
-- 
1.9.1
