Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE9DC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E47E42086A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IhSZOU22"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47E42086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbeKTCyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:54:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:52070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730070AbeKTCyn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:54:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 319B82086A;
        Mon, 19 Nov 2018 16:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645036;
        bh=Xbf1OjgZvl9v7nzubpX5mwMg2V7njap1tG/OGZ5LWms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IhSZOU22ku3krQo4WULWvV/aCKLp91mSTEjkQRTjXLlcj12YgR2Psz6Jiy3IjZdad
         +O//ry5VF/ij0nU6Ym1vR4HCrHAuQuNkFkMKLnh8wAH2Xco8fhMFmh9QpXKGZIGU62
         DXJM9AXuo5JEh3PsL+FpB2ATeEojIvKpX9krvgyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huang Rui <ray.huang@amd.com>,
        Colin Ian King <colin.king@canonical.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 012/205] drm/amdgpu/powerplay: fix missing break in switch statements
Date:   Mon, 19 Nov 2018 17:25:19 +0100
Message-Id: <20181119162619.328081409@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c      |    2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c    |    2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c |    2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c   |    2 ++
 drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c   |    2 ++
 5 files changed, 10 insertions(+)

--- a/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/ci_smumgr.c
@@ -2268,11 +2268,13 @@ static uint32_t ci_get_offsetof(uint32_t
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
--- a/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/fiji_smumgr.c
@@ -2330,6 +2330,7 @@ static uint32_t fiji_get_offsetof(uint32
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU73_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2339,6 +2340,7 @@ static uint32_t fiji_get_offsetof(uint32
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU73_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
--- a/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/iceland_smumgr.c
@@ -2236,11 +2236,13 @@ static uint32_t iceland_get_offsetof(uin
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
--- a/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/tonga_smumgr.c
@@ -2618,6 +2618,7 @@ static uint32_t tonga_get_offsetof(uint3
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU72_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2627,6 +2628,7 @@ static uint32_t tonga_get_offsetof(uint3
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU72_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;
--- a/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
+++ b/drivers/gpu/drm/amd/powerplay/smumgr/vegam_smumgr.c
@@ -2184,6 +2184,7 @@ static uint32_t vegam_get_offsetof(uint3
 		case DRAM_LOG_BUFF_SIZE:
 			return offsetof(SMU75_SoftRegisters, DRAM_LOG_BUFF_SIZE);
 		}
+		break;
 	case SMU_Discrete_DpmTable:
 		switch (member) {
 		case UvdBootLevel:
@@ -2193,6 +2194,7 @@ static uint32_t vegam_get_offsetof(uint3
 		case LowSclkInterruptThreshold:
 			return offsetof(SMU75_Discrete_DpmTable, LowSclkInterruptThreshold);
 		}
+		break;
 	}
 	pr_warn("can't get the offset of type %x member %x\n", type, member);
 	return 0;


