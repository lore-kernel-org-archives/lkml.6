Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 6EECFC5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D649208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 10:22:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D649208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754316AbeFLKWa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 06:22:30 -0400
Received: from mga09.intel.com ([134.134.136.24]:34353 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752659AbeFLKWX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 06:22:23 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 03:22:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,214,1526367600"; 
   d="scan'208";a="66321886"
Received: from hao-dev.bj.intel.com ([10.238.157.61])
  by orsmga002.jf.intel.com with ESMTP; 12 Jun 2018 03:22:21 -0700
From:   Wu Hao <hao.wu@intel.com>
To:     atull@kernel.org, mdf@kernel.org, linux-fpga@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-api@vger.kernel.org, luwei.kang@intel.com,
        yi.z.zhang@intel.com, hao.wu@intel.com
Subject: [PATCH v6 02/29] fpga: mgr: add region_id to fpga_image_info
Date:   Tue, 12 Jun 2018 18:10:16 +0800
Message-Id: <1528798243-2029-3-git-send-email-hao.wu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
References: <1528798243-2029-1-git-send-email-hao.wu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds region_id to fpga_image_info data structure, it
allows driver to pass region id information to fpga-mgr via
fpga_image_info for fpga reconfiguration function.

Signed-off-by: Wu Hao <hao.wu@intel.com>
Acked-by: Moritz Fischer <mdf@kernel.org>
Acked-by: Alan Tull <atull@kernel.org>
---
v3: add one line comment for region_id
v4: add Acked-by from Moritz and Alan.
---
 include/linux/fpga/fpga-mgr.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fpga/fpga-mgr.h b/include/linux/fpga/fpga-mgr.h
index eec7c24..3eb6b9d 100644
--- a/include/linux/fpga/fpga-mgr.h
+++ b/include/linux/fpga/fpga-mgr.h
@@ -77,6 +77,7 @@ enum fpga_mgr_states {
  * @sgt: scatter/gather table containing FPGA image
  * @buf: contiguous buffer containing FPGA image
  * @count: size of buf
+ * @region_id: id of target region
  * @dev: device that owns this
  * @overlay: Device Tree overlay
  */
@@ -89,6 +90,7 @@ struct fpga_image_info {
 	struct sg_table *sgt;
 	const char *buf;
 	size_t count;
+	int region_id;
 	struct device *dev;
 #ifdef CONFIG_OF
 	struct device_node *overlay;
-- 
1.8.3.1

