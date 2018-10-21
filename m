Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2B65ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D3AC20658
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 11:13:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D3AC20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727493AbeJUT10 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 15:27:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14100 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727086AbeJUT1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 15:27:25 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 24B0D14DA6C20;
        Sun, 21 Oct 2018 19:13:24 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Sun, 21 Oct 2018
 19:13:17 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rex.zhu@amd.com>, <evan.quan@amd.com>, <christian.koenig@amd.com>,
        <David1.Zhou@amd.com>, <airlied@linux.ie>, <Hawking.Zhang@amd.com>,
        <ray.huang@amd.com>
CC:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <amd-gfx@lists.freedesktop.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amd/powerplay: remove duplicated includes
Date:   Sun, 21 Oct 2018 18:39:58 +0800
Message-ID: <20181021103958.12892-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove some duplicated include.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/powerplay/inc/hwmgr.h               | 1 -
 drivers/gpu/drm/amd/powerplay/inc/smu7_common.h         | 4 ----
 drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c | 1 -
 drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c     | 1 -
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c     | 1 -
 5 files changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
index e5a60aa..07d180ce 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/hwmgr.h
@@ -28,7 +28,6 @@
 #include "hardwaremanager.h"
 #include "hwmgr_ppt.h"
 #include "ppatomctrl.h"
-#include "hwmgr_ppt.h"
 #include "power_state.h"
 #include "smu_helper.h"
 
diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h b/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
index 65eb630..94bf7b6 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu7_common.h
@@ -40,10 +40,6 @@
 #include "bif/bif_5_0_d.h"
 #include "bif/bif_5_0_sh_mask.h"
 
-
-#include "bif/bif_5_0_d.h"
-#include "bif/bif_5_0_sh_mask.h"
-
 #include "dce/dce_10_0_d.h"
 #include "dce/dce_10_0_sh_mask.h"
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
index 872d382..2b2c266 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/polaris10_smumgr.c
@@ -44,7 +44,6 @@
 
 #include "smu7_hwmgr.h"
 #include "hardwaremanager.h"
-#include "ppatomctrl.h"
 #include "atombios.h"
 #include "pppcielanes.h"
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
index d0eb8ab..d111dd4 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/smu10_smumgr.c
@@ -29,7 +29,6 @@
 #include "rv_ppsmc.h"
 #include "smu10_driver_if.h"
 #include "smu10.h"
-#include "ppatomctrl.h"
 #include "pp_debug.h"
 
 
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 9f71512..1e69300 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -40,7 +40,6 @@
 
 #include "smu7_hwmgr.h"
 #include "hardwaremanager.h"
-#include "ppatomctrl.h"
 #include "atombios.h"
 #include "pppcielanes.h"
 
-- 
1.8.3.1


