Return-Path: <SRS0=r9ZY=MB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2775CECE561
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9FF7214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Sep 2018 01:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9FF7214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730762AbeISGs7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Sep 2018 02:48:59 -0400
Received: from mail.bootlin.com ([62.4.15.54]:33547 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726887AbeISGs6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Sep 2018 02:48:58 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 0E758207D4; Wed, 19 Sep 2018 03:13:40 +0200 (CEST)
Received: from localhost (unknown [65.155.82.100])
        by mail.bootlin.com (Postfix) with ESMTPSA id 53CD220703;
        Wed, 19 Sep 2018 03:13:29 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-rtc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH 2/2] rtc: isl1208: don't include core header file
Date:   Wed, 19 Sep 2018 03:13:22 +0200
Message-Id: <20180919011322.3985-2-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180919011322.3985-1-alexandre.belloni@bootlin.com>
References: <20180919011322.3985-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The core header file is reserved for the core, stop including it.

Also reorder includes alphabetically.

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/rtc-isl1208.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-isl1208.c b/drivers/rtc/rtc-isl1208.c
index e1e9434c9972..15094df12985 100644
--- a/drivers/rtc/rtc-isl1208.c
+++ b/drivers/rtc/rtc-isl1208.c
@@ -10,12 +10,11 @@
  *
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/bcd.h>
-#include <linux/rtc.h>
-#include "rtc-core.h"
+#include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/of_irq.h>
+#include <linux/rtc.h>
 
 /* Register map */
 /* rtc section */
-- 
2.19.0

