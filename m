Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66BEC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DE8C2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 11:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbfACLgK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 06:36:10 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46945 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729827AbfACLgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 06:36:10 -0500
X-UUID: 7c5534607db249c0a3932566773ac61a-20190103
X-UUID: 7c5534607db249c0a3932566773ac61a-20190103
Received: from mtkcas09.mediatek.inc [(172.21.101.178)] by mailgw02.mediatek.com
        (envelope-from <miles.chen@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 926742912; Thu, 03 Jan 2019 19:36:03 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1395.4; Thu, 3 Jan 2019 19:36:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 3 Jan 2019 19:36:02 +0800
From:   Miles Chen <miles.chen@mediatek.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
CC:     <linux-kernel@vger.kernel.org>, <wsd_upstream@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Miles Chen <miles.chen@mediatek.com>
Subject: [PATCH] tools/vm/page_owner: use page_owner_sort in the use example
Date:   Thu, 3 Jan 2019 19:36:01 +0800
Message-ID: <1546515361-8317-1-git-send-email-miles.chen@mediatek.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The example in comment does not useable because the output
binary is named "page_owner_sort", not "sort".

Also add a reference to Documentation/vm/page_owner.rst

Signed-off-by: Miles Chen <miles.chen@mediatek.com>
---
 tools/vm/page_owner_sort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/vm/page_owner_sort.c b/tools/vm/page_owner_sort.c
index 18fc112b65cd..d3a8755c039c 100644
--- a/tools/vm/page_owner_sort.c
+++ b/tools/vm/page_owner_sort.c
@@ -5,7 +5,9 @@
  * Example use:
  * cat /sys/kernel/debug/page_owner > page_owner_full.txt
  * grep -v ^PFN page_owner_full.txt > page_owner.txt
- * ./sort page_owner.txt sorted_page_owner.txt
+ * ./page_owner_sort page_owner.txt sorted_page_owner.txt
+ *
+ * See Documentation/vm/page_owner.rst
 */
 
 #include <stdio.h>
-- 
2.18.0

