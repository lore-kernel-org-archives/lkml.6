Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeBWMxA (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 07:53:00 -0500
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:21966 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751399AbeBWMwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 07:52:01 -0500
From: Fabrice Gasnier <fabrice.gasnier@st.com>
To: <jic23@kernel.org>
CC: <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@st.com>,
        <fabrice.gasnier@st.com>, <linux-iio@vger.kernel.org>,
        <lars@metafoo.de>, <knaack.h@gmx.de>, <pmeerw@pmeerw.net>,
        <benjamin.gaignard@linaro.org>, <arnaud.pouliquen@st.com>
Subject: [PATCH 1/7] iio: adc: stm32-dfsdm: fix compatible data use
Date: Fri, 23 Feb 2018 13:50:55 +0100
Message-ID: <1519390261-25453-2-git-send-email-fabrice.gasnier@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
References: <1519390261-25453-1-git-send-email-fabrice.gasnier@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.46]
X-ClientProxiedBy: SFHDAG4NODE2.st.com (10.75.127.11) To SFHDAG5NODE3.st.com
 (10.75.127.15)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-23_04:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix use of compatible data: stm32h7 regmap configuration is statically
used. Rather use regmap_cfg from compatible data.

Fixes: bed73904e76f ("IIO: ADC: add stm32 DFSDM core support")

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 6290332..0635f93 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -274,7 +274,7 @@ static int stm32_dfsdm_probe(struct platform_device *pdev)
 
 	dfsdm->regmap = devm_regmap_init_mmio_clk(&pdev->dev, "dfsdm",
 						  dfsdm->base,
-						  &stm32h7_dfsdm_regmap_cfg);
+						  dev_data->regmap_cfg);
 	if (IS_ERR(dfsdm->regmap)) {
 		ret = PTR_ERR(dfsdm->regmap);
 		dev_err(&pdev->dev, "%s: Failed to allocate regmap: %d\n",
-- 
1.9.1
