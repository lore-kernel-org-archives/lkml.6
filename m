Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8222ECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579682147A
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 00:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="wxa62eyi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 579682147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727137AbeIOFyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 01:54:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:42466 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeIOFyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 01:54:18 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id w8F0bSuN046772;
        Fri, 14 Sep 2018 19:37:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1536971848;
        bh=xnvtoqichP3Dhx06FPNggRPmID5Dra8hbZBo1afAyZ8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wxa62eyiR2fUtusKklpIVKdeW2otk31u/Q0WCP6hIVgpKRi0SswsnxJgb2SFE4/l2
         F6f/k/9LXNKs0myboMx1ydi8DwhjNTj73LIyMhDx0t2iWve7bDl3aY9rgBs2MayCS/
         NidfudpfBar2xaCXOj/z+Mx/XvAIEAZOYplAQNNE=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bSuN023608;
        Fri, 14 Sep 2018 19:37:28 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Fri, 14
 Sep 2018 19:37:28 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Fri, 14 Sep 2018 19:37:28 -0500
Received: from legion.dal.design.ti.com (legion.dal.design.ti.com [128.247.22.53])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w8F0bRvN010467;
        Fri, 14 Sep 2018 19:37:27 -0500
Received: from localhost (irmo.dhcp.ti.com [128.247.58.153])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id w8F0bRx13347;
        Fri, 14 Sep 2018 19:37:27 -0500 (CDT)
From:   Suman Anna <s-anna@ti.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     Ohad Ben-Cohen <ohad@wizery.com>,
        Loic Pallardy <loic.pallardy@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Suman Anna <s-anna@ti.com>
Subject: [PATCH 3/5] remoteproc: Add missing kernel-doc comment for auto-boot
Date:   Fri, 14 Sep 2018 19:37:23 -0500
Message-ID: <20180915003725.17549-4-s-anna@ti.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180915003725.17549-1-s-anna@ti.com>
References: <20180915003725.17549-1-s-anna@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit ddf711872c9d ("remoteproc: Introduce auto-boot flag")
introduced the auto-boot flag but missed adding the corresponding
kernel-doc comment. Add the same.

Signed-off-by: Suman Anna <s-anna@ti.com>
---
 include/linux/remoteproc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index e3c5d856b6da..75f9ca05b865 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -439,6 +439,7 @@ struct rproc_dump_segment {
  * @cached_table: copy of the resource table
  * @table_sz: size of @cached_table
  * @has_iommu: flag to indicate if remote processor is behind an MMU
+ * @auto_boot: flag to indicate if remote processor should be auto-started
  * @dump_segments: list of segments in the firmware
  */
 struct rproc {
-- 
2.18.0

