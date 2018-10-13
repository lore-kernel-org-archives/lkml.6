Return-Path: <SRS0=sHJz=MZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAAA6C28CF8
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:15:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A77C20865
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Oct 2018 16:15:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A77C20865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com.cn
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbeJMXxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Oct 2018 19:53:14 -0400
Received: from mail78-59.sinamail.sina.com.cn ([219.142.78.59]:45158 "HELO
        mail78-59.sinamail.sina.com.cn" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1726362AbeJMXxO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Oct 2018 19:53:14 -0400
Received: from unknown (HELO localhost.localdomain.localdomain)([171.223.32.124])
        by sina.com with ESMTP
        id 5BC21A1900001282; Sat, 14 Oct 2018 00:15:27 +0800 (CST)
X-Sender: penghao122@sina.com.cn
X-Auth-ID: penghao122@sina.com.cn
X-SMAIL-MID: 242104394989
From:   Peng Hao <penghao122@sina.com.cn>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, pasha.tatashin@oracle.com,
        osalvador@suse.de, linux-kernel@vger.kernel.org,
        Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH] mm/sparse: remove a check that compare if unsigned variable is negative
Date:   Sat, 13 Oct 2018 12:15:19 -0400
Message-Id: <1539447319-5383-1-git-send-email-penghao122@sina.com.cn>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


From: Peng Hao <peng.hao2@zte.com.cn>

In all use locations for for_each_present_section_nr, variable
section_nr is unsigned. It is unnecessary to test if it is negative.

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 mm/sparse.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/mm/sparse.c b/mm/sparse.c
index 10b07ee..a6f9f22 100644
--- a/mm/sparse.c
+++ b/mm/sparse.c
@@ -196,8 +196,7 @@ static inline int next_present_section_nr(int section_nr)
 }
 #define for_each_present_section_nr(start, section_nr)		\
 	for (section_nr = next_present_section_nr(start-1);	\
-	     ((section_nr >= 0) &&				\
-	      (section_nr <= __highest_present_section_nr));	\
+	     section_nr <= __highest_present_section_nr;	\
 	     section_nr = next_present_section_nr(section_nr))
 
 static inline unsigned long first_present_section_nr(void)
-- 
1.8.3.1


