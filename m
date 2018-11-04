Return-Path: <SRS0=jXQK=NP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D5BECDE44
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2DB4204FD
	for <linux-kernel@archiver.kernel.org>; Sun,  4 Nov 2018 13:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ch90Ae+F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2DB4204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730142AbeKDXHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 4 Nov 2018 18:07:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:44604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730094AbeKDXHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Nov 2018 18:07:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C23E82086C;
        Sun,  4 Nov 2018 13:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541339527;
        bh=YaoUgCpi/wc4IKFUwxJq8trqVhzsCK5rQEkdIeluVWQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ch90Ae+FgK/AwyrvKkZWrvmMhcnTqyjre2ZL+ODR4o+Z/eE7WX/y6kcC+38SZKPhz
         wMYFUAgJcNsTfiAE97g5XenhHJVxxuiTSBIOkqEMblvp6VO7SWKU+owo7Gkb4K2QZR
         n1BppJ6WZaIOeyMXIH9oKS/aeKjaGMXDFUvJQz3g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 21/57] drm/amdgpu/powerplay: fix missing break in switch statements
Date:   Sun,  4 Nov 2018 08:51:08 -0500
Message-Id: <20181104135144.88324-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181104135144.88324-1-sashal@kernel.org>
References: <20181104135144.88324-1-sashal@kernel.org>
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
index fbe3ef4ee45c..924788772b07 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2268,11 +2268,13 @@ static uint32_t ci_get_offsetof(uint32_t type, uint32_t member)
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
index 18048f8e2f13..40df5c2706cc 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -2330,6 +2330,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU73_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2339,6 +2340,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU73_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 9299b93aa09a..302ca7745723 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -2236,11 +2236,13 @@ static uint32_t iceland_get_offsetof(uint32_t type, uint32_t member)
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
index 7dabc6c456e1..697c8d92bd53 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -2618,6 +2618,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU72_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2627,6 +2628,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU72_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 57420d7caa4e..59113fdd1c1c 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -2184,6 +2184,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU75_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2193,6 +2194,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU75_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
-- 
2.17.1

