Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF162C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938E920837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 938E920837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727416AbeH3TRV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:17:21 -0400
Received: from bran.ispras.ru ([83.149.199.196]:19925 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727331AbeH3TRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:17:21 -0400
Received: from ubuntu.intra.ispras.ru (ultra.intra.ispras.ru [10.10.2.144])
        by smtp.ispras.ru (Postfix) with ESMTP id 227CA203C8;
        Thu, 30 Aug 2018 18:14:41 +0300 (MSK)
From:   Pavel Zemlyanoy <zemlyanoy@ispras.ru>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Cc:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH 6/6] staging: erofs: fix 1 warning and 9 checks
Date:   Thu, 30 Aug 2018 18:14:02 +0300
Message-Id: <1535642042-5336-6-git-send-email-zemlyanoy@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change the logic, it only
corrects the formatting and checkpatch checks by
braces {} should be used on all arms of this statement,
unbalanced braces around else statement and warning by
braces {} are not necessary for any arm of this statement.

The patch fixes 9 checks of type:
"Check: braces {} should be used on all arms of this statement";
"Check: Unbalanced braces around else statement";

and 1 warning of type:
"WARNING: braces {} are not necessary for any arm of this statement".

Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>
---
 drivers/staging/erofs/unzip_vle_lz4.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index f285a50..1a42865 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -80,9 +80,9 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 			}
 		}
 
-		if (!righthalf)
+		if (!righthalf) {
 			src = NULL;
-		else {
+		} else {
 			src = mirrored[i] ? percpu_data + i * PAGE_SIZE :
 				kmap_atomic(compressed_pages[i]);
 
@@ -137,11 +137,12 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
 
 		if (pages[i]) {
-			if (ret < 0)
+			if (ret < 0) {
 				SetPageError(pages[i]);
-			else if (clusterpages == 1 && pages[i] == compressed_pages[0])
+			} else if (clusterpages == 1 &&
+				   pages[i] == compressed_pages[0]) {
 				memcpy(vin + pageofs, vout + pageofs, j);
-			else {
+			} else {
 				void *dst = kmap_atomic(pages[i]);
 
 				memcpy(dst + pageofs, vout + pageofs, j);
@@ -184,9 +185,9 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 			memcpy(vin + PAGE_SIZE * i, t, PAGE_SIZE);
 			kunmap_atomic(t);
 		}
-	} else if (clusterpages == 1)
+	} else if (clusterpages == 1) {
 		vin = kmap_atomic(compressed_pages[0]);
-	else {
+	} else {
 		vin = erofs_vmap(compressed_pages, clusterpages);
 	}
 
@@ -198,11 +199,10 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 	if (!overlapped) {
 		if (clusterpages == 1)
 			kunmap_atomic(vin);
-		else {
+		else
 			erofs_vunmap(vin, clusterpages);
-		}
-	} else
+	} else {
 		preempt_enable();
-
+	}
 	return ret;
 }
-- 
2.7.4

