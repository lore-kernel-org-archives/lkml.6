Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754176AbeEOPUI (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 11:20:08 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:4122 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752425AbeEOPUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 11:20:06 -0400
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH] iio: adc: stm32-dfsdm: include stm32-dfsdm-adc.h
Date: Tue, 15 May 2018 17:19:17 +0200
Message-ID: <1526397557-31389-1-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.45]
X-ClientProxiedBy: SFHDAG5NODE3.st.com (10.75.127.15) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-15_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following sparse warnings:
  CHECK   drivers/iio/adc/stm32-dfsdm-adc.c
symbol 'stm32_dfsdm_get_buff_cb' was not declared. Should it be static?
symbol 'stm32_dfsdm_release_buff_cb' was not declared. Should it be static?

BTW, move interrupt.h to sort headers alphabetically.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-adc.c       | 4 ++--
 include/linux/iio/adc/stm32-dfsdm-adc.h | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index 1b78bec..31462ae 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -8,11 +8,11 @@
 
 #include <linux/dmaengine.h>
 #include <linux/dma-mapping.h>
-#include <linux/interrupt.h>
+#include <linux/iio/adc/stm32-dfsdm-adc.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/hw-consumer.h>
-#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/interrupt.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
diff --git a/include/linux/iio/adc/stm32-dfsdm-adc.h b/include/linux/iio/adc/stm32-dfsdm-adc.h
index e7dc7a5..0da298b 100644
--- a/include/linux/iio/adc/stm32-dfsdm-adc.h
+++ b/include/linux/iio/adc/stm32-dfsdm-adc.h
@@ -9,6 +9,8 @@
 #ifndef STM32_DFSDM_ADC_H
 #define STM32_DFSDM_ADC_H
 
+#include <linux/iio/iio.h>
+
 int stm32_dfsdm_get_buff_cb(struct iio_dev *iio_dev,
 			    int (*cb)(const void *data, size_t size,
 				      void *private),
-- 
1.9.1
