Return-Path: <SRS0=j7Hi=ME=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13C28C433F4
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:54:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C55852150F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Sep 2018 14:54:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C55852150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=windriver.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728967AbeIVUsD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Sep 2018 16:48:03 -0400
Received: from mail1.windriver.com ([147.11.146.13]:40944 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728614AbeIVUsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Sep 2018 16:48:03 -0400
Received: from ALA-HCB.corp.ad.wrs.com ([147.11.189.41])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id w8MErt8E017391
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sat, 22 Sep 2018 07:53:55 -0700 (PDT)
Received: from pek-lpg-core2.corp.ad.wrs.com (128.224.153.41) by
 ALA-HCB.corp.ad.wrs.com (147.11.189.41) with Microsoft SMTP Server id
 14.3.408.0; Sat, 22 Sep 2018 07:53:54 -0700
From:   <zhe.he@windriver.com>
To:     <akpm@linux-foundation.org>, <mhocko@suse.com>, <vbabka@suse.cz>,
        <pasha.tatashin@oracle.com>, <mgorman@techsingularity.net>,
        <aaron.lu@intel.com>, <osalvador@suse.de>,
        <iamjoonsoo.kim@lge.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <zhe.he@windriver.com>
Subject: [PATCH v2 2/2] mm/page_alloc: Add KBUILD_MODNAME
Date:   Sat, 22 Sep 2018 22:53:33 +0800
Message-ID: <1537628013-243902-2-git-send-email-zhe.he@windriver.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1537628013-243902-1-git-send-email-zhe.he@windriver.com>
References: <1537628013-243902-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: He Zhe <zhe.he@windriver.com>

Add KBUILD_MODNAME to make prints more clear.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Cc: akpm@linux-foundation.org
Cc: mhocko@suse.com
Cc: vbabka@suse.cz
Cc: pasha.tatashin@oracle.com
Cc: mgorman@techsingularity.net
Cc: aaron.lu@intel.com
Cc: osalvador@suse.de
Cc: iamjoonsoo.kim@lge.com
---
v2:
Split the addition of KBUILD_MODNAME out

 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index f34cae1..ead9556 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -14,6 +14,8 @@
  *          (lots of bits borrowed from Ingo Molnar & Andrew Morton)
  */
 
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+
 #include <linux/stddef.h>
 #include <linux/mm.h>
 #include <linux/swap.h>
-- 
2.7.4

