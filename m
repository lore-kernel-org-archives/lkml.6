Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeBANqQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 08:46:16 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:47248 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751916AbeBANpr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 08:45:47 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <alexandre.torgue@st.com>
CC: <mark.rutland@arm.com>, <linux@armlinux.org.uk>,
        <mcoquelin.stm32@gmail.com>, <fabrice.gasnier@st.com>,
        <devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: [PATCH 2/3] pwm: stm32: LPTimer: use 3 cells xlate
Date: Thu, 1 Feb 2018 14:44:37 +0100
Message-ID: <1517492678-767-3-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
References: <1517492678-767-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.44]
X-ClientProxiedBy: SFHDAG1NODE1.st.com (10.75.127.1) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-01_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerald Baeza <gerald.baeza@st.com>

STM32 Low-Power Timer supports generic 3 cells pwm to encode
PWM number, period and polarity.

Signed-off-by: Gerald Baeza <gerald.baeza@st.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/pwm/pwm-stm32-lp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-stm32-lp.c b/drivers/pwm/pwm-stm32-lp.c
index 1ac9e43..346b7bd 100644
--- a/drivers/pwm/pwm-stm32-lp.c
+++ b/drivers/pwm/pwm-stm32-lp.c
@@ -203,6 +203,8 @@ static int stm32_pwm_lp_probe(struct platform_device *pdev)
 	priv->chip.dev = &pdev->dev;
 	priv->chip.ops = &stm32_pwm_lp_ops;
 	priv->chip.npwm = 1;
+	priv->chip.of_xlate = of_pwm_xlate_with_flags;
+	priv->chip.of_pwm_n_cells = 3;
 
 	ret = pwmchip_add(&priv->chip);
 	if (ret < 0)
-- 
1.9.1
