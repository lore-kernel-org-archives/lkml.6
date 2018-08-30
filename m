Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A12C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A9BD205F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 15:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9BD205F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbeH3TRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 15:17:09 -0400
Received: from bran.ispras.ru ([83.149.199.196]:19781 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725836AbeH3TRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 15:17:09 -0400
Received: from ubuntu.intra.ispras.ru (ultra.intra.ispras.ru [10.10.2.144])
        by smtp.ispras.ru (Postfix) with ESMTP id 6CB35203B2;
        Thu, 30 Aug 2018 18:14:30 +0300 (MSK)
From:   Pavel Zemlyanoy <zemlyanoy@ispras.ru>
To:     Gao Xiang <gaoxiang25@huawei.com>, Chao Yu <yuchao0@huawei.com>
Cc:     Pavel Zemlyanoy <zemlyanoy@ispras.ru>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-erofs@lists.ozlabs.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH 2/6] staging: erofs: formatting fix to NULL comparison
Date:   Thu, 30 Aug 2018 18:13:58 +0300
Message-Id: <1535642042-5336-2-git-send-email-zemlyanoy@ispras.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
References: <1535642042-5336-1-git-send-email-zemlyanoy@ispras.ru>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch does not change the logic, it only
corrects the formatting and checkpatch checks by
to NULL comparison.

The patch fixes 5 checks of type:
"Comparison to NULL could be written".

Signed-off-by: Pavel Zemlyanoy <zemlyanoy@ispras.ru>
---
 drivers/staging/erofs/unzip_vle_lz4.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle_lz4.c b/drivers/staging/erofs/unzip_vle_lz4.c
index f9e6b78..54da72a 100644
--- a/drivers/staging/erofs/unzip_vle_lz4.c
+++ b/drivers/staging/erofs/unzip_vle_lz4.c
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
@@ -64,7 +64,7 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 		}
 
 		if (i) {
-			if (src == NULL)
+			if (!src)
 				src = mirrored[i-1] ?
 					percpu_data + (i-1) * PAGE_SIZE :
 					kmap_atomic(compressed_pages[i-1]);
@@ -92,7 +92,7 @@ int z_erofs_vle_plain_copy(struct page **compressed_pages,
 		kunmap_atomic(dst);
 	}
 
-	if (src != NULL && !mirrored[j])
+	if (src && !mirrored[j])
 		kunmap_atomic(src);
 
 	preempt_enable();
@@ -136,7 +136,7 @@ int z_erofs_vle_unzip_fast_percpu(struct page **compressed_pages,
 	for (i = 0; i < nr_pages; ++i) {
 		j = min((unsigned int)PAGE_SIZE - pageofs, outlen);
 
-		if (pages[i] != NULL) {
+		if (pages[i]) {
 			if (ret < 0)
 				SetPageError(pages[i]);
 			else if (clusterpages == 1 && pages[i] == compressed_pages[0])
-- 
2.7.4

