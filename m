Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033789AbeBOPM7 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 10:12:59 -0500
Received: from agrajag.zerfleddert.de ([88.198.237.222]:40860 "EHLO
        agrajag.zerfleddert.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033584AbeBOPM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 10:12:57 -0500
Date: Thu, 15 Feb 2018 16:12:55 +0100
From: Tobias Jordan <Tobias.Jordan@elektrobit.com>
To: Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: sil2reviews@lists.osadl.org
Subject: [PATCH] remoteproc: qcom: Fix potential device node leaks
Message-ID: <20180215151255.xhe7gzxnwippv3gp@agrajag.zerfleddert.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing of_node_put()s at two places for device nodes returned by
of_parse_phandle().

Fixes: 051fb70fd4ea ("remoteproc: qcom: Driver for the self-authenticating
 Hexagon v5")
Signed-off-by: Tobias Jordan <Tobias.Jordan@elektrobit.com>
---
 drivers/remoteproc/qcom_q6v5_pil.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pil.c b/drivers/remoteproc/qcom_q6v5_pil.c
index 8e70a627e0bb..cbbafdcaaecb 100644
--- a/drivers/remoteproc/qcom_q6v5_pil.c
+++ b/drivers/remoteproc/qcom_q6v5_pil.c
@@ -1083,6 +1083,7 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 		dev_err(qproc->dev, "unable to resolve mba region\n");
 		return ret;
 	}
+	of_node_put(node);
 
 	qproc->mba_phys = r.start;
 	qproc->mba_size = resource_size(&r);
@@ -1100,6 +1101,7 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
 		dev_err(qproc->dev, "unable to resolve mpss region\n");
 		return ret;
 	}
+	of_node_put(node);
 
 	qproc->mpss_phys = qproc->mpss_reloc = r.start;
 	qproc->mpss_size = resource_size(&r);
-- 
2.11.0
