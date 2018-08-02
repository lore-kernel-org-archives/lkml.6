Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E94AC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:34:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1D8A20BF3
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 06:34:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1D8A20BF3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zoho.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbeHBIXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 04:23:48 -0400
Received: from sender2-pp-o92.zoho.com.cn ([163.53.93.251]:25814 "EHLO
        sender1.zoho.com.cn" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726156AbeHBIXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 04:23:48 -0400
Received: from localhost.localdomain.localdomain (45.62.52.41 [45.62.52.41]) by mx.zoho.com.cn
        with SMTPS id 1533191606755967.5943860410273; Thu, 2 Aug 2018 14:33:26 +0800 (CST)
From:   oceanhe@zoho.com.cn
To:     dan.j.williams@intel.com, ross.zwisler@linux.intel.com,
        vishal.l.verma@intel.com, dave.jiang@intel.com, rjw@rjwysocki.net,
        lenb@kernel.org
Cc:     linux-nvdimm@lists.01.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ocean He <hehy1@lenovo.com>
Subject: [PATCH] ACPI: nfit: remove redundant assignment if nfit_mem found
Date:   Thu,  2 Aug 2018 02:33:11 -0400
Message-Id: <1533191591-20453-1-git-send-email-oceanhe@zoho.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-ZohoCNMailClient: External
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

When nfit_mem is found via list_for_each_entry, it has already been
assigned valid value. There is no need to assign it again in the following
codes.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/acpi/nfit/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index 7c47900..85dde54 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1048,9 +1048,7 @@ static int __nfit_mem_init(struct acpi_nfit_desc *acpi_desc,
 				break;
 			}
 
-		if (found)
-			nfit_mem = found;
-		else {
+		if (!found) {
 			nfit_mem = devm_kzalloc(acpi_desc->dev,
 					sizeof(*nfit_mem), GFP_KERNEL);
 			if (!nfit_mem)
-- 
1.8.3.1


