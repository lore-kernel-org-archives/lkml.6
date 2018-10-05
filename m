Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E84C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76A522087D
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 12:43:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76A522087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbeJETlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Oct 2018 15:41:51 -0400
Received: from mga06.intel.com ([134.134.136.31]:8943 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727701AbeJETlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Oct 2018 15:41:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2018 05:43:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.54,344,1534834800"; 
   d="scan'208";a="97687780"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Oct 2018 05:43:15 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: [GIT PULL 02/16] stm class: Clarify configfs root type/operations names
Date:   Fri,  5 Oct 2018 15:42:52 +0300
Message-Id: <20181005124306.54870-3-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
References: <20181005124306.54870-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current naming of stp-policy root type and group ops is confusing,
rename them for better readability.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/stm/policy.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwtracing/stm/policy.c b/drivers/hwtracing/stm/policy.c
index 15d35d891643..530448bd5a34 100644
--- a/drivers/hwtracing/stm/policy.c
+++ b/drivers/hwtracing/stm/policy.c
@@ -311,7 +311,7 @@ static const struct config_item_type stp_policy_type = {
 };
 
 static struct config_group *
-stp_policies_make(struct config_group *group, const char *name)
+stp_policy_make(struct config_group *group, const char *name)
 {
 	struct config_group *ret;
 	struct stm_device *stm;
@@ -368,12 +368,12 @@ stp_policies_make(struct config_group *group, const char *name)
 	return ret;
 }
 
-static struct configfs_group_operations stp_policies_group_ops = {
-	.make_group	= stp_policies_make,
+static struct configfs_group_operations stp_policy_root_group_ops = {
+	.make_group	= stp_policy_make,
 };
 
-static const struct config_item_type stp_policies_type = {
-	.ct_group_ops	= &stp_policies_group_ops,
+static const struct config_item_type stp_policy_root_type = {
+	.ct_group_ops	= &stp_policy_root_group_ops,
 	.ct_owner	= THIS_MODULE,
 };
 
@@ -381,7 +381,7 @@ static struct configfs_subsystem stp_policy_subsys = {
 	.su_group = {
 		.cg_item = {
 			.ci_namebuf	= "stp-policy",
-			.ci_type	= &stp_policies_type,
+			.ci_type	= &stp_policy_root_type,
 		},
 	},
 };
-- 
2.19.0

