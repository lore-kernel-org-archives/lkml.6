Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF491C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EB9020834
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB9020834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727271AbeH3TQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:16:46 -0400
Received: from bran.ispras.ru ([83.149.199.196]:19548 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725893AbeH3TQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:16:46 -0400
Received: from ubuntu.intra.ispras.ru (ultra.intra.ispras.ru [10.10.2.144])
        by smtp.ispras.ru (Postfix) with ESMTP id 6D1DC203B2;
        Thu, 30 Aug 2018 18:14:05 +0300 (MSK)
From:   Pavel Zemlyanoy <zemlyanoy@ispras.ru>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Cc:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH 1/6] staging: erofs: formatting fix in unzip_vle_lz4.c
Date:   Thu, 30 Aug 2018 18:13:57 +0300
Message-Id: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


This patch does not change the logic, it only
corrects the formatting and checkpatch warnings by
adding "int" to the unsigned type.

The patch fixes 11 warnings of the type:
"WARNING: Prefer 'unsigned int' to bare use of 'unsigned'"

Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>
---
 drivers/staging/erofs/unzip_vle_lz4.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index f5b665f..f9e6b78 100644
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
@@ -134,7 +134,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	}
 
 	for (i = 0; i < nr_pages; ++i) {
-		j = min((unsigned)PAGE_SIZE - pageofs, outlen);
+		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
 
 		if (pages[i] != NULL) {
 			if (ret < 0)
@@ -164,14 +164,14 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
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
@@ -206,4 +206,3 @@ int z_erofs_vle_unzip_vmap(struct page **compressed_pages,
 
 	return ret;
 }
-
-- 
2.7.4

