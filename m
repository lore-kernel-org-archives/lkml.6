Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97BBC4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5A362175B
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 02:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550197920;
	bh=oL+0W1S+ohn9dWDXdMlDCeyO7SU/yWpkBoe7Rdr3Brc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eomG9OOleVYNpGO/Hpws+1nXyMC11zIejOEThIQ9CeRmAggPmYvcx+n6dAdX+xMse
	 rQU7o+tMTs+3ryMuNQvhpTc8mjZ+VMgJE9Dr1doBqye6mCp612a6q+n6frsfZlqZa2
	 qdEHPRE+x5eTPR3B4BFvZHqgVpfEnoR63k9NlMJo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404277AbfBOCMY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 21:12:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:52388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404214AbfBOCMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 21:12:20 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8ABC12229F;
        Fri, 15 Feb 2019 02:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550196740;
        bh=oL+0W1S+ohn9dWDXdMlDCeyO7SU/yWpkBoe7Rdr3Brc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TD/b7ODMYYOn0AGvi5aCXf7RsPtc16+uGEQbNiQwOcY2v2oB7FWeYKh4Q1x7rWMTV
         M1CEZWTABwQcvr+4nsaCo7JxxcelE2TwiyLQkAGmH4grjvqirdoZZYX+RD8ShgsgRW
         WhjYJkrhXcuuXtziVT84YCIuWxNZKm1jzPvCHrE0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Kenneth Feng <kenneth.feng@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 35/65] drm/amd/powerplay: OD setting fix on Vega10
Date:   Thu, 14 Feb 2019 21:10:51 -0500
Message-Id: <20190215021121.177674-35-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190215021121.177674-1-sashal@kernel.org>
References: <20190215021121.177674-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kenneth Feng <kenneth.feng@amd.com>

[ Upstream commit 6d87dc97eb3341de3f7b1efa3156cb0e014f4a96 ]

gfxclk for OD setting is limited to 1980M for non-acg
ASICs of Vega10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../powerplay/hwmgr/vega10_processpptables.c  | 22 ++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
index 16b1a9cf6cf0..743d3c983082 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/vega10_processpptables.c
@@ -32,6 +32,7 @@
 #include "vega10_pptable.h"
 
 #define NUM_DSPCLK_LEVELS 8
+#define VEGA10_ENGINECLOCK_HARDMAX 198000
 
 static void set_hw_cap(struct pp_hwmgr *hwmgr, bool enable,
 		enum phm_platform_caps cap)
@@ -258,7 +259,26 @@ static int init_over_drive_limits(
 		struct pp_hwmgr *hwmgr,
 		const ATOM_Vega10_POWERPLAYTABLE *powerplay_table)
 {
-	hwmgr->platform_descriptor.overdriveLimit.engineClock =
+	const ATOM_Vega10_GFXCLK_Dependency_Table *gfxclk_dep_table =
+			(const ATOM_Vega10_GFXCLK_Dependency_Table *)
+			(((unsigned long) powerplay_table) +
+			le16_to_cpu(powerplay_table->usGfxclkDependencyTableOffset));
+	bool is_acg_enabled = false;
+	ATOM_Vega10_GFXCLK_Dependency_Record_V2 *patom_record_v2;
+
+	if (gfxclk_dep_table->ucRevId == 1) {
+		patom_record_v2 =
+			(ATOM_Vega10_GFXCLK_Dependency_Record_V2 *)gfxclk_dep_table->entries;
+		is_acg_enabled =
+			(bool)patom_record_v2[gfxclk_dep_table->ucNumEntries-1].ucACGEnable;
+	}
+
+	if (powerplay_table->ulMaxODEngineClock > VEGA10_ENGINECLOCK_HARDMAX &&
+		!is_acg_enabled)
+		hwmgr->platform_descriptor.overdriveLimit.engineClock =
+			VEGA10_ENGINECLOCK_HARDMAX;
+	else
+		hwmgr->platform_descriptor.overdriveLimit.engineClock =
 			le32_to_cpu(powerplay_table->ulMaxODEngineClock);
 	hwmgr->platform_descriptor.overdriveLimit.memoryClock =
 			le32_to_cpu(powerplay_table->ulMaxODMemoryClock);
-- 
2.19.1

