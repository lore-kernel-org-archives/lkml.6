Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADCDC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:21:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2848E20849
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 09:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2848E20849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbeLKJVt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 04:21:49 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726117AbeLKJVp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 04:21:45 -0500
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6514DCF262DED;
        Tue, 11 Dec 2018 17:21:42 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.408.0; Tue, 11 Dec 2018
 17:21:36 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>,
        <ebiederm@xmission.com>, <riel@surriel.com>,
        <keescook@chromium.org>, <guro@fb.com>,
        <marcos.souza.org@gmail.com>, <sfr@canb.auug.org.au>,
        <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH v2 -next] input: keyboard: remove duplicated include from mtk-pmic-keys.c
Date:   Tue, 11 Dec 2018 17:21:31 +0800
Message-ID: <20181211092131.23272-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

alphabetise the header files and remove duplicated include
file linux/kernel.h

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
v2: alphabetise the header files
---
 drivers/input/keyboard/mtk-pmic-keys.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/input/keyboard/mtk-pmic-keys.c b/drivers/input/keyboard/mtk-pmic-keys.c
index 02c67a1..8e6ebab 100644
--- a/drivers/input/keyboard/mtk-pmic-keys.c
+++ b/drivers/input/keyboard/mtk-pmic-keys.c
@@ -14,18 +14,17 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/kernel.h>
 #include <linux/input.h>
 #include <linux/interrupt.h>
-#include <linux/platform_device.h>
 #include <linux/kernel.h>
-#include <linux/of.h>
-#include <linux/of_device.h>
-#include <linux/regmap.h>
 #include <linux/mfd/mt6323/registers.h>
-#include <linux/mfd/mt6397/registers.h>
 #include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6397/registers.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
 
 #define MTK_PMIC_PWRKEY_RST_EN_MASK	0x1
 #define MTK_PMIC_PWRKEY_RST_EN_SHIFT	6
-- 
2.7.4


