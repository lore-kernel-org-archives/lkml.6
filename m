Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D294C6778C
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E061423E90
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 13:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E061423E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754117AbeGENjw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 09:39:52 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:41326 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753733AbeGENdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 09:33:21 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 38DFACD53;
        Thu,  5 Jul 2018 16:33:17 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH v2 11/34] media: camss: vfe: Fix to_vfe() macro member name
Date:   Thu,  5 Jul 2018 16:32:42 +0300
Message-Id: <1530797585-8555-12-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
References: <1530797585-8555-1-git-send-email-todor.tomov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the member name which is "line" instead of the pointer argument.

Signed-off-by: Todor Tomov <todor.tomov@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index 256dc2d..51ad3f8 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -30,7 +30,7 @@
 	((const struct vfe_line (*)[]) &(ptr_line[-(ptr_line->id)]))
 
 #define to_vfe(ptr_line)	\
-	container_of(vfe_line_array(ptr_line), struct vfe_device, ptr_line)
+	container_of(vfe_line_array(ptr_line), struct vfe_device, line)
 
 #define VFE_0_HW_VERSION		0x000
 
-- 
2.7.4

