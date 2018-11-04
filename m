Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF78AC32789
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7CDC20869
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zKm4LyHq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7CDC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730812AbeKDXIF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:08:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:46470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730780AbeKDXIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:08:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DE5E7208A3;
        Sun,  4 Nov 2018 13:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339580;
        bh=4BIOBQbfyO1AfqlM46AQIYIPAhABs0auS3qxAof0+5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKm4LyHq+oT8uy1CgnhIhYbvb4SatKWMYz3wGHwYBMQwtPyZWl33zAJ5zhZYqCWXs
         cA217WI2f2kGBf5QheMZ3u1QZ7dWmNhx2MGnwYJ7zKsyObHiRAOHijtabS0E5B0I2u
         ao7IHe+FosGiVl/+e/B26V0dxspGBJAtpk4UN0O8=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 18/45] drm/amdgpu/powerplay: fix missing break in switch statements
Date:   Sun,  4 Nov 2018 08:52:13 -0500
Message-Id: <20181104135240.88431-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135240.88431-1-sashal@kernel.org>
References: <20181104135240.88431-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit 14b284832e7dea6f54f0adfd7bed105548b94e57 ]

There are several switch statements that are missing break statements.
Add missing breaks to handle any fall-throughs corner cases.

Detected by CoverityScan, CID#1457175 ("Missing break in switch")

Fixes: 18aafc59b106 ("drm/amd/powerplay: implement fw related smu interface for iceland.")
Acked-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c      | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c    | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c   | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c   | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 2d4ec8ac3a08..0b3ea7e9b805 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2303,11 +2303,13 @@ static uint32_t ci_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU7_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU7_Discrete_DpmTable, LowSclkInterruptT);
 		}
+		break;
 	}
 	pr_debug("can't get the offset of type %x member %x\n", type, member);
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
index 53df9405f43a..bb616a530d3c 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -2372,6 +2372,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU73_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2383,6 +2384,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU73_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 415f691c3fa9..c15e15e657b8 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -2246,11 +2246,13 @@ static uint32_t iceland_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU71_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU71_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
index 782b19fc2e70..a5b7a4484700 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -2667,6 +2667,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU72_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2678,6 +2679,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU72_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 2de48959ac93..52834334bd53 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -2267,6 +2267,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU75_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2278,6 +2279,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU75_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
-- 
2.17.1

