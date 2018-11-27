Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 742C8C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4303F21104
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 14:19:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4303F21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbeK1BRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 20:17:52 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44169 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbeK1BRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 20:17:52 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gReDI-0001rE-9H; Tue, 27 Nov 2018 14:19:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd/pp: fix spelling mistake "dependancy" -> "dependency"
Date:   Tue, 27 Nov 2018 14:19:43 +0000
Message-Id: <20181127141943.27110-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are spelling mistakes in PP_ASSERT_WITH_CODE messages, fix these.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
index 88f6b35ea6fe..5dcd21d29dbf 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/smu7_hwmgr.c
@@ -269,7 +269,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
 					hwmgr->dyn_state.mvdd_dependency_on_mclk);
 
 		PP_ASSERT_WITH_CODE((0 == result),
-				"Failed to retrieve SVI2 MVDD table from dependancy table.",
+				"Failed to retrieve SVI2 MVDD table from dependency table.",
 				return result;);
 	}
 
@@ -288,7 +288,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
 			result = phm_get_svi2_voltage_table_v0(&(data->vddci_voltage_table),
 					hwmgr->dyn_state.vddci_dependency_on_mclk);
 		PP_ASSERT_WITH_CODE((0 == result),
-				"Failed to retrieve SVI2 VDDCI table from dependancy table.",
+				"Failed to retrieve SVI2 VDDCI table from dependency table.",
 				return result);
 	}
 
@@ -317,7 +317,7 @@ static int smu7_construct_voltage_tables(struct pp_hwmgr *hwmgr)
 				table_info->vddc_lookup_table);
 
 		PP_ASSERT_WITH_CODE((0 == result),
-			"Failed to retrieve SVI2 VDDC table from dependancy table.", return result;);
+			"Failed to retrieve SVI2 VDDC table from dependency table.", return result;);
 	}
 
 	tmp = smum_get_mac_definition(hwmgr, SMU_MAX_LEVELS_VDDC);
-- 
2.19.1

