Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B2FC4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC57205F4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 01:35:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AC57205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbeIGGNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 02:13:11 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:43620 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbeIGGNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 02:13:10 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.5]) by rmmx-syy-dmz-app09-12009 (RichMail) with SMTP id 2ee95b91d5b523a-1236b; Fri, 07 Sep 2018 09:34:45 +0800 (CST)
X-RM-TRANSID: 2ee95b91d5b523a-1236b
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost.localdomain (unknown[223.105.0.243])
        by rmsmtp-syy-appsvr03-12003 (RichMail) with SMTP id 2ee35b91d5b364b-0d2a5;
        Fri, 07 Sep 2018 09:34:45 +0800 (CST)
X-RM-TRANSID: 2ee35b91d5b364b-0d2a5
From:   Ding Xiang <dingxiang@cmss.chinamobile.com>
To:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] tools: include: Add PTR_ERR_OR_ZERO to err.h
Date:   Fri,  7 Sep 2018 09:34:41 +0800
Message-Id: <1536284082-23466-1-git-send-email-dingxiang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PTR_ERR_OR_ZERO, and tools can use it.

Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
---
 tools/include/linux/err.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/include/linux/err.h b/tools/include/linux/err.h
index 7a8b61a..0946496 100644
--- a/tools/include/linux/err.h
+++ b/tools/include/linux/err.h
@@ -52,4 +52,11 @@ static inline bool __must_check IS_ERR_OR_NULL(__force const void *ptr)
 	return unlikely(!ptr) || IS_ERR_VALUE((unsigned long)ptr);
 }
 
+static inline int __must_check PTR_ERR_OR_ZERO(__force const void *ptr)
+{
+	if (IS_ERR(ptr))
+		return PTR_ERR(ptr);
+	else
+		return 0;
+}
 #endif /* _LINUX_ERR_H */
-- 
1.9.1



