Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99355C43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F22424526
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 15:41:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F22424526
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934295AbeFVPjo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 11:39:44 -0400
Received: from ns.mm-sol.com ([37.157.136.199]:46446 "EHLO extserv.mm-sol.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933908AbeFVPeE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 11:34:04 -0400
Received: from mms-0439.qualcomm.mm-sol.com (unknown [37.157.136.206])
        by extserv.mm-sol.com (Postfix) with ESMTPSA id 49E134F887;
        Fri, 22 Jun 2018 18:33:59 +0300 (EEST)
From:   Todor Tomov <todor.tomov@linaro.org>
To:     mchehab@kernel.org, sakari.ailus@linux.intel.com,
        hans.verkuil@cisco.com, laurent.pinchart+renesas@ideasonboard.com,
        linux-media@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>
Subject: [PATCH 11/32] media: camss: vfe: Fix to_vfe() macro member name
Date:   Fri, 22 Jun 2018 18:33:20 +0300
Message-Id: <1529681621-9682-12-git-send-email-todor.tomov@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
References: <1529681621-9682-1-git-send-email-todor.tomov@linaro.org>
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

