Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C8AEC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 188242145D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 16:22:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 188242145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbeJHXfD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 19:35:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36219 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJHXfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 19:35:03 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g9YIe-0004j8-N3; Mon, 08 Oct 2018 16:22:28 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rex Zhu <rex.zhu@amd.com>, Evan Quan <evan.quan@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        David Zhou <David1.Zhou@amd.com>,
        David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/amdgpu/powerplay: fix missing break in switch statements
Date:   Mon,  8 Oct 2018 17:22:28 +0100
Message-Id: <20181008162228.4599-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There are several switch statements that are missing break statements.
Add missing breaks to handle any fall-throughs corner cases.

Detected by CoverityScan, CID#1457175 ("Missing break in switch")

Fixes: 18aafc59b106 ("drm/amd/powerplay: implement fw related smu interface for iceland.")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c      | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c    | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c   | 2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c   | 2 ++
 5 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
index 18643e06bc6f..669bd0c2a16c 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2269,11 +2269,13 @@ static uint32_t ci_get_offsetof(uint32_t type, uint32_t member)
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
index ec14798e87b6..bddd6d09f887 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -2331,6 +2331,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU73_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2340,6 +2341,7 @@ static uint32_t fiji_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU73_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
index 73aa368a454e..2d4c7f167b88 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -2237,11 +2237,13 @@ static uint32_t iceland_get_offsetof(uint32_t type, uint32_t member)
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
index ae8378ed32ee..a2ba5b012866 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -2619,6 +2619,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU72_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2628,6 +2629,7 @@ static uint32_t tonga_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU72_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
diff --git a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
index 3d415fabbd93..9f71512b2510 100644
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -2185,6 +2185,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU75_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2194,6 +2195,7 @@ static uint32_t vegam_get_offsetof(uint32_t type, uint32_t member)
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU75_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
-- 
2.17.1

