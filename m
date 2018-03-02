Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1428978AbeCBO7F (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 09:59:05 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:52960 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1428930AbeCBO6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 09:58:30 -0500
X-Google-Smtp-Source: AG47ELsRUyM0lO0Mz6A9hNs73MNbuEpVHlWF2jatSidkfAYzDGcPWRiM+l55ooXyniyoa8qvfuKTuw==
From: srinivas.kandagatla@linaro.org
To: will.deacon@arm.com, robin.murphy@arm.com, bjorn.andersson@linaro.org
Cc: joro@8bytes.org, ohad@wizery.com, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 2/3] rpmsg: core: make rpmsg bus DMA capable
Date: Fri,  2 Mar 2018 14:55:30 +0000
Message-Id: <20180302145531.20463-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
References: <20180302145531.20463-1-srinivas.kandagatla@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Many of the rpmsg clients like audio drivers need to allocate
dma memory. Make this bus DMA capable so that the child devices
can use dma apis.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index e84c71f8d6ab..540a3f3567b8 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -472,6 +472,7 @@ struct bus_type rpmsg_bus = {
 	.uevent		= rpmsg_uevent,
 	.probe		= rpmsg_dev_probe,
 	.remove		= rpmsg_dev_remove,
+	.force_dma	= true,
 };
 EXPORT_SYMBOL(rpmsg_bus);
 
-- 
2.15.1
