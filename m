Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0703C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:40:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 810862073D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 10:40:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 810862073D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbeH3Olx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 10:41:53 -0400
Received: from bran.ispras.ru ([83.149.199.196]:34470 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728311AbeH3Olx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 10:41:53 -0400
Received: from ubuntu.intra.ispras.ru (ultra.intra.ispras.ru [10.10.2.144])
        by smtp.ispras.ru (Postfix) with ESMTP id C1228203B2;
        Thu, 30 Aug 2018 13:40:20 +0300 (MSK)
From:   Pavel Zemlyanoy <zemlyanoy@ispras.ru>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Cc:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] staging: erofs: formatting unzip_vle_lz4.c
Date:   Thu, 30 Aug 2018 13:40:07 +0300
Message-Id: <1535625607-14281-1-git-send-email-zemlyanoy@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes the coding style for unzip_vle_lz4.c,
following the accepted formatting rules.

Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>
---
 drivers/staging/erofs/unzip_vle_lz4.c | 72 ++++++++++++++++++-----------------
 1 file changed, 37 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index f5b665f..34992f2 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
@@ -23,14 +23,14 @@ static struct {
 } erofs_pcpubuf[NR_CPUS];
 
 int z_erofs_vle_plain_copy(struct page **compressed_pages,
-			   unsigned clusterpages,
+			   unsigned int clusterpages,
 			   struct page **pages,
-			   unsigned nr_pages,
+			   unsigned int nr_pages,
 			   unsigned short pageofs)
 {
-	unsigned i, j;
+	unsigned int i, j;
 	void *src = NULL;
-	const unsigned righthalf = PAGE_SIZE - pageofs;
+	const unsigned int righthalf = PAGE_SIZE - pageofs;
 	char *percpu_data;
 	bool mirrored[Z_EROFS_CLUSTER_MAX_PAGES] = { 0 };
 
@@ -42,8 +42,8 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 		struct page *page = pages[i];
 		void *dst;
 
-		if (page == NULL) {
-			if (src != NULL) {
+		if (!page) {
+			if (src) {
 				if (!mirrored[j])
 					kunmap_atomic(src);
 				src = NULL;
@@ -64,14 +64,14 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 		}
 
 		if (i) {
-			if (src == NULL)
-				src = mirrored[i-1] ?
-					percpu_data + (i-1) * PAGE_SIZE :
-					kmap_atomic(compressed_pages[i-1]);
+			if (!src)
+				src = mirrored[i - 1] ?
+					percpu_data + (i - 1) * PAGE_SIZE :
+					kmap_atomic(compressed_pages[i - 1]);
 
 			memcpy(dst, src + righthalf, pageofs);
 
-			if (!mirrored[i-1])
+			if (!mirrored[i - 1])
 				kunmap_atomic(src);
 
 			if (unlikely(i >= clusterpages)) {
@@ -80,19 +80,19 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 			}
 		}
 
-		if (!righthalf)
+		if (!righthalf) {
 			src = NULL;
-		else {
+
+		} else {
 			src = mirrored[i] ? percpu_data + i * PAGE_SIZE :
 				kmap_atomic(compressed_pages[i]);
-
 			memcpy(dst + pageofs, src, righthalf);
 		}
 
 		kunmap_atomic(dst);
 	}
 
-	if (src != NULL && !mirrored[j])
+	if (src && !mirrored[j])
 		kunmap_atomic(src);
 
 	preempt_enable();
@@ -102,14 +102,14 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 extern int z_erofs_unzip_lz4(void *in, void *out, size_t inlen, size_t outlen);
 
 int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
-				  unsigned clusterpages,
+				  unsigned int clusterpages,
 				  struct page **pages,
-				  unsigned outlen,
+				  unsigned int outlen,
 				  unsigned short pageofs,
 				  void (*endio)(struct page *))
 {
 	void *vin, *vout;
-	unsigned nr_pages, i, j;
+	unsigned int nr_pages, i, j;
 	int ret;
 
 	if (outlen + pageofs > EROFS_PERCPU_NR_PAGES * PAGE_SIZE)
@@ -126,7 +126,8 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	vout = erofs_pcpubuf[smp_processor_id()].data;
 
 	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
-		clusterpages * PAGE_SIZE, outlen);
+				clusterpages * PAGE_SIZE,
+				outlen);
 
 	if (ret >= 0) {
 		outlen = ret;
@@ -134,14 +135,15 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	}
 
 	for (i = 0; i < nr_pages; ++i) {
-		j = min((unsigned)PAGE_SIZE - pageofs, outlen);
+		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
 
-		if (pages[i] != NULL) {
-			if (ret < 0)
+		if (pages[i]) {
+			if (ret < 0) {
 				SetPageError(pages[i]);
-			else if (clusterpages == 1 && pages[i] == compressed_pages[0])
+			} else if (clusterpages == 1 &&
+					   pages[i] == compressed_pages[0]) {
 				memcpy(vin + pageofs, vout + pageofs, j);
-			else {
+			} else {
 				void *dst = kmap_atomic(pages[i]);
 
 				memcpy(dst + pageofs, vout + pageofs, j);
@@ -164,14 +166,14 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 }
 
 int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
-			   unsigned clusterpages,
+			   unsigned int clusterpages,
 			   void *vout,
-			   unsigned llen,
+			   unsigned int llen,
 			   unsigned short pageofs,
 			   bool overlapped)
 {
 	void *vin;
-	unsigned i;
+	unsigned int i;
 	int ret;
 
 	if (overlapped) {
@@ -181,29 +183,29 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 		for (i = 0; i < clusterpages; ++i) {
 			void *t = kmap_atomic(compressed_pages[i]);
 
-			memcpy(vin + PAGE_SIZE *i, t, PAGE_SIZE);
+			memcpy(vin + PAGE_SIZE * i, t, PAGE_SIZE);
 			kunmap_atomic(t);
 		}
-	} else if (clusterpages == 1)
+	} else if (clusterpages == 1) {
 		vin = kmap_atomic(compressed_pages[0]);
-	else {
+	} else {
 		vin = erofs_vmap(compressed_pages, clusterpages);
 	}
 
 	ret = z_erofs_unzip_lz4(vin, vout + pageofs,
-		clusterpages * PAGE_SIZE, llen);
+				clusterpages * PAGE_SIZE,
+				llen);
 	if (ret > 0)
 		ret = 0;
 
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

