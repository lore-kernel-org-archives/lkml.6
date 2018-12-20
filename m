Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF62CC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D0CE20989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298203;
	bh=MbRw6wAU7Ure/N+MY4pXFIR/rii9JA4kapFBMTVjfWA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LjNF5vZ0IaBr08Ke+2x4u7Fb/pSk3W0Xuc1E/JzSc7j20tgeAWC3SzTdXKKE+cEBc
	 JjOb+kRecP+pqBVNbPmjolMffLL8GP99Zz8Kf1kr+KjA8CPursjcGMJhuv1Wyy3FR1
	 EmwoAgMRSPozNAfY1g9A1knVDvz6n1yv8Sbry0R4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbeLTJaC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:33362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732832AbeLTJaA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E17BD20989;
        Thu, 20 Dec 2018 09:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298199;
        bh=MbRw6wAU7Ure/N+MY4pXFIR/rii9JA4kapFBMTVjfWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oNv0/LPjZQbDGBrj7c0tKZI0knLL/rdRh9oC30Z7CyJnzY6spcDKNvg8T2JWncCUS
         7D3HcFuqayodIEEEYv2q+8jLhygMKvioGwHIO9dChar+DD6kCUGWuDzp9nB1dOyxGB
         VJ0MQG+i23rsNc8SmkfEZpvJnbfECPAIwRJ+ZpzA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Quan <evan.quan@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 37/67] drm/amd/powerplay: issue pre-display settings for display change event
Date:   Thu, 20 Dec 2018 10:18:49 +0100
Message-Id: <20181220085905.009091856@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 10cb3e6b63bf4266a5198813526fdd7259ffb8be ]

For display config change event only, pre-display config settings are
needed.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c  | 3 +++
 drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c | 2 --
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
index 8994aa5c8cf8..64596029b696 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/hwmgr.c
@@ -365,6 +365,9 @@ int hwmgr_handle_task(struct pp_hwmgr *hwmgr, enum amd_pp_task task_id,
 
 	switch (task_id) {
 	case AMD_PP_TASK_DISPLAY_CONFIG_CHANGE:
+		ret = phm_pre_display_configuration_changed(hwmgr);
+		if (ret)
+			return ret;
 		ret = phm_set_cpu_power_state(hwmgr);
 		if (ret)
 			return ret;
diff --git a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
index 91ffb7bc4ee7..56437866d120 100644
--- a/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
+++ b/drivers/gpu/drm/amd/powerplay/hwmgr/pp_psm.c
@@ -265,8 +265,6 @@ int psm_adjust_power_state_dynamic(struct pp_hwmgr *hwmgr, bool skip,
 	if (skip)
 		return 0;
 
-	phm_pre_display_configuration_changed(hwmgr);
-
 	phm_display_configuration_changed(hwmgr);
 
 	if (hwmgr->ps)
-- 
2.19.1



