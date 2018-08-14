Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB139C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:12:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC8621719
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 09:12:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC8621719
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbeHNL60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 07:58:26 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:42623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728314AbeHNL60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 07:58:26 -0400
Received: from wuerfel.lan ([109.193.40.16]) by mrelayeu.kundenserver.de
 (mreue101 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MNc8Q-1fmjQB2wHa-007A4z; Tue, 14 Aug 2018 11:12:01 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Todor Tomov <todor.tomov@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hans Verkuil <hansverk@cisco.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] media: camss: add missing includes
Date:   Tue, 14 Aug 2018 11:11:30 +0200
Message-Id: <20180814091200.1851395-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
X-Provags-ID: V03:K1:f7lxtpe9G6PfP7XR+CxXCWu3wroQ08vmx/oyZ0sKVCvuGKmyBjo
 yfc3VvPlVBU2Z2YAvn6jEc1sP010mevVxQm7e89B+sUecdmimevFqgyOifE9qNl3QI0Aky5
 T5XRflpF98VnQgtbV55US9uAV0UL/Vs+oWFeUtw/NQEzXzcxxtE7OI2isPtiMn29WUqu5rp
 F40UN4aZrp+IWrkB6z35A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:X/NS0EWDqnU=:bHEebYYPGFeqz8ajnR1cZE
 7g93uw/S27EsiCekI1YnX4SN3DjtNY8LvZHMUpu8I9FiFSz6rsBz/lYK6vUIgkno1tby2RuND
 e9M/LRhnx18j4nmT8PI2aydrxgN5pDByfhAObyS+1eZtpvP4Ukiea7RMb79kB5cPh/Q8Qq1hR
 QNKOWu16xHEei1+17Trl1Cr5Qq2RIhrxdDI6vp0gp0YMh5lbkSv7zfjAijvPGSkv2vhf0xesW
 0yJqvweR+VQDgZIGiqFxJccw7cRNyASWuoHxGgsExCe/t5EmA9bL6vc42w39/9HgzeAcyog+q
 FDjHtBPCObtcTWM1cwikdEZKzHUr3SMVQLHPjF7MWFsPGoyUnCalB2gF+DXLPdanZk06SLvz+
 1V69GIDmEQVMueDMfn7ngjo8cOgYiBzmoqODv1KStu/z+RMMOF9KfvHuNKcSaQRLSmEqAwdJh
 jTY030l2Y7jbANFCL+K6SlyzQAFRhHvIxbamEcShTzV+GYAIWQB4PJp8H8cWMIgO75oHFO/P7
 eMP0jtm5692IOX/GchhamtB4+USdNrbovPERckpFwX/lSNomFByswQ+KU6kuZceMEvkhhjhqY
 azSgrfgjR+e6cE7WtqV9YixgVQGdBvAOWCFHIgz/o4RvQGXEKgQfoB/CEvRsKrj79QKGqCzds
 BDXjLuc+R4UBo4/AhV6xYW22kV+EjDUR8Qt3KA23XmihJOfddtU120J/AUTBNQ8agpdA=
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
 drivers/media/platform/qcom/camss/camss-csiphy-2ph-1-0.c | 1 +
 drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c | 1 +
 drivers/media/platform/qcom/camss/camss-ispif.c          | 1 +
 3 files changed, 3 insertions(+)

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
diff --git a/drivers/media/platform/qcom/camss/camss-ispif.c b/drivers/media/platform/qcom/camss/camss-ispif.c
index 7f269021d08c..fa5f9373879e 100644
--- a/drivers/media/platform/qcom/camss/camss-ispif.c
+++ b/drivers/media/platform/qcom/camss/camss-ispif.c
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
+#include <linux/slab.h>
 #include <media/media-entity.h>
 #include <media/v4l2-device.h>
 #include <media/v4l2-subdev.h>
-- 
2.18.0

