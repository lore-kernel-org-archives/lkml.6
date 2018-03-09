Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751486AbeCIG6m (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 01:58:42 -0500
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:20011 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751028AbeCIG6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 01:58:13 -0500
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
Subject: [PATCH RESEND 1/2] clk: stm32: END_PRIMARY_CLK should be declare after CLK_SYSCLK
Date: Fri, 9 Mar 2018 07:57:30 +0100
Message-ID: <1520578651-28849-2-git-send-email-gabriel.fernandez@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
References: <1520578651-28849-1-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG5NODE2.st.com (10.75.127.14) To SFHDAG4NODE2.st.com
 (10.75.127.11)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-03-09_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gabriel Fernandez <gabriel.fernandez@st.com>

Update of END_PRIMARY_CLK was missed, it should be after CLK_SYSCLK
hsi and sysclk are overwritten by gpioa and gpiob.

Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
Tested-by: Philippe Cornu <philippe.cornu@st.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/clock/stm32fx-clock.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/dt-bindings/clock/stm32fx-clock.h b/include/dt-bindings/clock/stm32fx-clock.h
index 49bb3c2..4d523b0 100644
--- a/include/dt-bindings/clock/stm32fx-clock.h
+++ b/include/dt-bindings/clock/stm32fx-clock.h
@@ -33,11 +33,11 @@
 #define CLK_SAI2		11
 #define CLK_I2SQ_PDIV		12
 #define CLK_SAIQ_PDIV		13
-
-#define END_PRIMARY_CLK		14
-
 #define CLK_HSI			14
 #define CLK_SYSCLK		15
+
+#define END_PRIMARY_CLK		16
+
 #define CLK_HDMI_CEC		16
 #define CLK_SPDIF		17
 #define CLK_USART1		18
-- 
1.9.1
