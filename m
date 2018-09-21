Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B85AECE562
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:37:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E4222147D
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 10:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E4222147D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389876AbeIUQZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 12:25:43 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:13093 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727554AbeIUQZn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 12:25:43 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id BE256B95A51B4;
        Fri, 21 Sep 2018 18:37:22 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.399.0; Fri, 21 Sep 2018 18:37:21 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <broonie@kernel.org>
CC:     <perex@perex.cz>, <bgoswami@codeaurora.org>, <tiwai@suse.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] soc: qcom: qdsp6: remove duplicated include from q6adm.c
Date:   Fri, 21 Sep 2018 18:24:58 +0800
Message-ID: <1537525498-38843-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We include wait.h twice in q6adm.c. it is unnecessary. hence remove
it.  Further, order the include files as alphabet.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 sound/soc/qcom/qdsp6/q6adm.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/qcom/qdsp6/q6adm.c b/sound/soc/qcom/qdsp6/q6adm.c
index 932c3eb..da24251 100644
--- a/sound/soc/qcom/qdsp6/q6adm.c
+++ b/sound/soc/qcom/qdsp6/q6adm.c
@@ -2,25 +2,24 @@
 // Copyright (c) 2011-2017, The Linux Foundation. All rights reserved.
 // Copyright (c) 2018, Linaro Limited
 
-#include <linux/slab.h>
-#include <linux/wait.h>
-#include <linux/kernel.h>
 #include <linux/device.h>
-#include <linux/module.h>
-#include <linux/sched.h>
 #include <linux/jiffies.h>
+#include <linux/kernel.h>
+#include <linux/kref.h>
+#include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_platform.h>
-#include <linux/kref.h>
-#include <linux/wait.h>
-#include <linux/soc/qcom/apr.h>
 #include <linux/platform_device.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/soc/qcom/apr.h>
+#include <linux/wait.h>
 #include <sound/asound.h>
 #include "q6adm.h"
 #include "q6afe.h"
 #include "q6core.h"
-#include "q6dsp-errno.h"
 #include "q6dsp-common.h"
+#include "q6dsp-errno.h"
 
 #define ADM_CMD_DEVICE_OPEN_V5		0x00010326
 #define ADM_CMDRSP_DEVICE_OPEN_V5	0x00010329
-- 
1.7.12.4

