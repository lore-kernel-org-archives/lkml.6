Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44419C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F41C21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727508AbfBSHvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:51:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:5116 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725787AbfBSHvj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:51:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Feb 2019 23:51:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,387,1544515200"; 
   d="scan'208";a="147958391"
Received: from joy-optiplex-7040.sh.intel.com ([10.239.13.9])
  by fmsmga001.fm.intel.com with ESMTP; 18 Feb 2019 23:51:37 -0800
From:   Yan Zhao <yan.y.zhao@intel.com>
To:     intel-gvt-dev@lists.freedesktop.org, alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yulei Zhang <yulei.zhang@intel.com>
Subject: [PATCH 6/8] drm/i915/gvt: Apply g2h adjustment to buffer start gma for dmabuf
Date:   Tue, 19 Feb 2019 02:46:23 -0500
Message-Id: <20190219074623.14305-1-yan.y.zhao@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190219074242.14015-1-yan.y.zhao@intel.com>
References: <20190219074242.14015-1-yan.y.zhao@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yulei Zhang <yulei.zhang@intel.com>

Adjust the buffer start gma in dmabuf for display in host domain.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/dmabuf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/dmabuf.c b/drivers/gpu/drm/i915/gvt/dmabuf.c
index 51ed99a37803..e96c655c40bc 100644
--- a/drivers/gpu/drm/i915/gvt/dmabuf.c
+++ b/drivers/gpu/drm/i915/gvt/dmabuf.c
@@ -293,6 +293,9 @@ static int vgpu_get_plane_info(struct drm_device *dev,
 		return -EFAULT;
 	}
 
+	/* Apply g2h adjust to buffer start gma for display */
+	intel_gvt_ggtt_gmadr_g2h(vgpu, info->start, &info->start);
+
 	return 0;
 }
 
-- 
2.17.1

