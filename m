Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752830AbeEKIUx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 04:20:53 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:23750 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752733AbeEKIUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 04:20:50 -0400
From: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
To: Wolfram Sang <wsa@the-dreams.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Colin Ian King <colin.king@canonical.com>, <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
Subject: [PATCH] i2c: i2c-stm32f7: fix documentation typo
Date: Fri, 11 May 2018 10:20:25 +0200
Message-ID: <1526026825-2996-1-git-send-email-pierre-yves.mordret@st.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG4NODE1.st.com (10.75.127.10) To SFHDAG5NODE2.st.com
 (10.75.127.14)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-11_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some data structure members were either misspelled or missing.

Fixes: aeb068c572 ("i2c: i2c-stm32f7: add driver")
Fixes: 380b8a85e7 ("i2c: i2c-stm32f7: Add initial SMBus protocols support")
Signed-off-by: Pierre-Yves MORDRET <pierre-yves.mordret@st.com>
---
  Version history:
    v1:
       * Initial
---
---
 drivers/i2c/busses/i2c-stm32f7.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/i2c-stm32f7.c b/drivers/i2c/busses/i2c-stm32f7.c
index 0f87449..62d023e 100644
--- a/drivers/i2c/busses/i2c-stm32f7.c
+++ b/drivers/i2c/busses/i2c-stm32f7.c
@@ -211,11 +211,12 @@ struct stm32f7_i2c_setup {
 
 /**
  * struct stm32f7_i2c_timings - private I2C output parameters
- * @prec: Prescaler value
+ * @node: List entry
+ * @presc: Prescaler value
  * @scldel: Data setup time
  * @sdadel: Data hold time
  * @sclh: SCL high period (master mode)
- * @sclh: SCL low period (master mode)
+ * @scll: SCL low period (master mode)
  */
 struct stm32f7_i2c_timings {
 	struct list_head node;
@@ -237,7 +238,7 @@ struct stm32f7_i2c_timings {
  * @size: type of SMBus protocol
  * @read_write: direction of SMBus protocol
  * SMBus block read and SMBus block write - block read process call protocols
- * @smbus_buff: buffer to be used for SMBus protocol transfer. It will
+ * @smbus_buf: buffer to be used for SMBus protocol transfer. It will
  * contain a maximum of 32 bytes of data + byte command + byte count + PEC
  * This buffer has to be 32-bit aligned to be compliant with memory address
  * register in DMA mode.
-- 
2.7.4
