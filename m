Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8756FC6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 06:35:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C81B25260
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 06:35:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C81B25260
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeGAGfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 02:35:21 -0400
Received: from sender-pp-092.zoho.com ([135.84.80.237]:25331 "EHLO
        sender-pp-092.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751463AbeGAGfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 02:35:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; 
  s=zapps768; d=zoho.com; 
  h=from:to:cc:subject:date:message-id; 
  b=WI4cq10DuNVEtiomUTABhoSdMjlKQ0/dJ2ZXJXTV1t9S+78SUhGF/GMGae2O5Quqm1o8SlJa7HyI
    hskMJU3mPPlGBMm75XM2kWxWdR7wL6oZdTT2AIyDkv8du/KSiAm0  
Received: from YEHS1XR956R00D1.lenovo.com (111.197.253.128 [111.197.253.128]) by mx.zohomail.com
        with SMTPS id 1530425981524952.5109760313196; Sat, 30 Jun 2018 23:19:41 -0700 (PDT)
From:   Huaisheng Ye <yehs2007@zoho.com>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, willy@infradead.org,
        ross.zwisler@linux.intel.com, vishal.l.verma@intel.com,
        jack@suse.com, chengnt@lenovo.com, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        Huaisheng Ye <yehs1@lenovo.com>
Subject: [PATCH 1/3] drivers/dax/super: Add annotation for ops in struct dax_device
Date:   Sun,  1 Jul 2018 14:18:46 +0800
Message-Id: <20180701061848.7036-1-yehs2007@zoho.com>
X-Mailer: git-send-email 2.17.0.windows.1
X-ZohoMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Huaisheng Ye <yehs1@lenovo.com>

There is no annotation for member ops within struct dax_device.
Add it.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
---
 drivers/dax/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/dax/super.c b/drivers/dax/super.c
index 2b2332b..aa6382a 100644
--- a/drivers/dax/super.c
+++ b/drivers/dax/super.c
@@ -161,6 +161,7 @@ enum dax_device_flags {
  * @host: optional name for lookups where the device path is not available
  * @private: dax driver private data
  * @flags: state and boolean properties
+ * @ops: function pointers for direct_access and fs-dax
  */
 struct dax_device {
 	struct hlist_node list;
-- 
1.8.3.1


