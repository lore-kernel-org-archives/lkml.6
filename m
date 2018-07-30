Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB954FD21E1
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8985820873
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 13:44:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8985820873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726847AbeG3PTw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 11:19:52 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54510 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726573AbeG3PTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 11:19:52 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fk8Tf-0001Cz-5o; Mon, 30 Jul 2018 13:44:47 +0000
From:   Colin King <colin.king@canonical.com>
To:     Rob Clark <robdclark@gmail.com>, David Airlie <airlied@linux.ie>,
        Jordan Crouse <jcrouse@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][drm-next] drm/msm/disp/dpu: fix two spelling mistakes
Date:   Mon, 30 Jul 2018 14:44:46 +0100
Message-Id: <20180730134446.8567-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in error messages
"diable" -> "disable"
"cliend" -> "client"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c      | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
index 0bd3eda93e22..0922d3536412 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder.c
@@ -421,7 +421,7 @@ int dpu_encoder_helper_unregister_irq(struct dpu_encoder_phys *phys_enc,
 
 	ret = dpu_core_irq_disable(phys_enc->dpu_kms, &irq->irq_idx, 1);
 	if (ret) {
-		DRM_ERROR("diable failed id=%u, intr=%d, hw=%d, irq=%d ret=%d",
+		DRM_ERROR("disable failed id=%u, intr=%d, hw=%d, irq=%d ret=%d",
 			  DRMID(phys_enc->parent), intr_idx, irq->hw_idx,
 			  irq->irq_idx, ret);
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
index a68f1249388c..a75eebca2f37 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_power_handle.c
@@ -121,7 +121,7 @@ void dpu_power_resource_deinit(struct platform_device *pdev,
 	mutex_lock(&phandle->phandle_lock);
 	list_for_each_entry_safe(curr_client, next_client,
 			&phandle->power_client_clist, list) {
-		pr_err("cliend:%s-%d still registered with refcount:%d\n",
+		pr_err("client:%s-%d still registered with refcount:%d\n",
 				curr_client->name, curr_client->id,
 				curr_client->refcount);
 		curr_client->active = false;
-- 
2.17.1

