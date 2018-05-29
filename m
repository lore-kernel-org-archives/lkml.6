Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934914AbeE2OUt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 10:20:49 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:44754 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934789AbeE2OUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 10:20:47 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 01404602A8
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From: Sibi Sankar <sibis@codeaurora.org>
To: architt@codeaurora.org, robdclark@gmail.com, jcrouse@codeaurora.org
Cc: dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH v4 0/3] Cleanup excessive DSI host controller version checks
Date: Tue, 29 May 2018 19:50:30 +0530
Message-Id: <20180529142033.12989-1-sibis@codeaurora.org>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series aims to create and bind dsi host controller helper
functions to functionalities that vary across DSI v2, DSI 6G 1.x and
DSI 6G v2.0+ controllers. These functionalities are currently under
excessive version checks which is now replaced with the corresponding
helper function.

V4:
  None (seems like the unbalanced mutex unlock is already
        fixed now)

V3:
  Removed redundant mode checks in calc_clk_rate_6g/v2
  Removed dev->struct_mutex unlock in tx_buf_alloc_6g
  Use msm_gem_kernel_new in tx_buf_alloc_6g 
  Modified author to first name/last name format

Reviewed-by: Archit Taneja <architt@codeaurora.org>

V2:
  Removes command broadcast support for DSI 6G v2.0+ controllers from
  the patch series and incorporates all the suggested corrections

Sibi Sankar (3):
  drm/msm/dsi: add dsi host helper functions support
  drm/msm/dsi: add implementation for helper functions
  drm/msm/dsi: replace version checks with helper functions

 drivers/gpu/drm/msm/dsi/dsi.h      |  16 ++
 drivers/gpu/drm/msm/dsi/dsi_cfg.c  |  56 ++++-
 drivers/gpu/drm/msm/dsi/dsi_cfg.h  |  12 +
 drivers/gpu/drm/msm/dsi/dsi_host.c | 355 ++++++++++++++++-------------
 4 files changed, 268 insertions(+), 171 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
