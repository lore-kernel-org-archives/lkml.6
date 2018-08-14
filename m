Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F648C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57E92214F1
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57E92214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731767AbeHNMDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 08:03:05 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:37427 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeHNMDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 08:03:04 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0LeLhV-1gEwcS1sSb-00q9AS; Tue, 14 Aug 2018 11:16:37 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Todor Tomov <todor.tomov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hansverk@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] media: camss: add missing includes
Date:   Tue, 14 Aug 2018 11:13:31 +0200
Message-Id: <20180814091636.1960071-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:npx7b+Dtsv5ytFB47WHxbwCCgjdGTMxx1vHB8UhCTI7HpRxlKEY
 Xs1VDJ1pp0lecLU+Rwaol4+RDmK5YuNCOtGb/AbIFxhFWx/lSQS2DQG/xv0NInZ097XjaT9
 1FPT+2pG24j5AheSpe7FiXK2iLEPrr5CkpPHQgfmmjt8N0TJUNdnTsVhUFuPO32ektQMA97
 bo5SXF0YevO85I2/ecP6A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:f9FyHfzR1JQ=:2hH7d0l6QP9rk7rocxdRxo
 dJ/ukr5dtnue8wXlNWHM7H+ehd0VR9LPZPu/y9AJphh2T5rHIQ9vkzQ81BwtOtBAyTGjKrg+0
 lNfLSvEBrVjtghCSGG+mirVaFo9LqWe72b/bJZIP9WDdFVBXx8DONsifJC0M/EitlHN9gRPh4
 0hR7gxh8EIxqAYk2Z3FXQrJXxtuYfxVx7YZtn5U+UIsTUP+n8CJcSWD4tnt05KkXkQEOM/6AW
 xPYjSjVr8ITXOVMYw3qDrdP71w9vMlfiqCXRpiH2jYIhterI60aAY7UOW2uqhG/3xIyXuK8DH
 kZvoKah/jIpmXBr2DALAaON5Ynja0sghbrqfMBe5S+KMVFY0XTYaDGWpGOx8eUlVKJbQAEPTt
 HfFf0iVOrhSqtw0DQgaxsn0GJ0ioD/yLo61QOetBbMoPVmfptHMVCG3Wn0I63z8FcbJjaDguQ
 Tee8YeyFh5WKkcpiF5XoeB9RV9vQ+IdPTLRk8Xf3tycnagnTz5vd3p+peFkYG+LmLf5dTGQMk
 U5hB287y566JlQpbVfQxDgXF2MkgvXEdpyo4Lwy7GdB28QLORlFIX8xqK5HnNvAYC708U6hCh
 Uj9+xOfvcaiReK637aVqnWRMer6kNsorCRfTySaG53bUmNyAAQT+od6QpXcRKB98dK9VYl/WP
 wCLc/UqtczqUpQB5ath3olBwYydAZNgCrEvjgjUdTYSdsKcreOpvNrlM4s+BeKr/7egA=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple files in this driver fail to build because of missing
header inclusions:

drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c: In function 'csiphy_hw_version_read':
drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c:31:18: error: implicit declaration of function 'readl_relaxed'; did you mean 'xchg_relaxed'? [-Werror=implicit-function-declaration]
drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c: In function 'csiphy_hw_version_read':
drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c:52:2: error: implicit declaration of function 'writel' [-Werror=implicit-function-declaration]
drivers/media/platform/qcom/camss/camss-ispif.c: In function 'msm_ispif_subdev_init':
drivers/media/platform/qcom/camss/camss-ispif.c:1079:16: error: implicit declaration of function 'kcalloc'; did you mean 'kvcalloc'? [-Werror=implicit-function-declaration]

Add the ones that I observed, plus linux/io.h in all other files that
call readl/writel and related interfaces.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: actually add the linux/io.h instances for files that did not show
the error but might still be affected because of the readl/writel usage
---
 drivers/media/platform/qcom/camss/camss-csid.c           | 1 +
 drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c | 1 +
 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 1 +
 drivers/media/platform/qcom/camss/camss-csiphy.c         | 1 +
 drivers/media/platform/qcom/camss/camss-ispif.c          | 2 ++
 drivers/media/platform/qcom/camss/camss-vfe-4-1.c        | 1 +
 drivers/media/platform/qcom/camss/camss-vfe-4-7.c        | 1 +
 7 files changed, 8 insertions(+)

diff --git a/drivers/media/platform/qcom/camss/camss-csid.c b/drivers/media/platform/qcom/camss/camss-csid.c
index 729b31891466..a5ae85674ffb 100644
--- a/drivers/media/platform/qcom/camss/camss-csid.c
+++ b/drivers/media/platform/qcom/camss/camss-csid.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
index c832539397d7..12bce391d71f 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 
 #define CAMSS_CSI_PHY_LNn_CFG2(n)		(0x004 + 0x40 * (n))
 #define CAMSS_CSI_PHY_LNn_CFG3(n)		(0x008 + 0x40 * (n))
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
index bcd0dfd33618..2e65caf1ecae 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
@@ -12,6 +12,7 @@
 
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 
 #define CSIPHY_3PH_LNn_CFG1(n)			(0x000 + 0x100 * (n))
 #define CSIPHY_3PH_LNn_CFG1_SWI_REC_DLY_PRG	(BIT(7) | BIT(6))
diff --git a/drivers/media/platform/qcom/camss/camss-csiphy.c b/drivers/media/platform/qcom/camss/camss-csiphy.c
index 4559f3b1b38c..008afb85023b 100644
--- a/drivers/media/platform/qcom/camss/camss-csiphy.c
+++ b/drivers/media/platform/qcom/camss/camss-csiphy.c
@@ -10,6 +10,7 @@
 #include <linux/clk.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 7f269021d08c..d824c4958c07 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -10,11 +10,13 @@
 #include <linux/clk.h>
 #include <linux/completion.h>
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <media/media-entity.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
index da3a9fed9f2d..174a36be6f5d 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-1.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 
 #include "camss-vfe.h"
diff --git a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
index 4c584bffd179..0dca8bf9281e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe-4-7.c
@@ -9,6 +9,7 @@
  */
 
 #include <linux/interrupt.h>
+#include <linux/io.h>
 #include <linux/iopoll.h>
 
 #include "camss-vfe.h"
-- 
2.18.0

