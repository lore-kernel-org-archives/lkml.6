Return-Path: <SRS0=v2je=OV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48DF1C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:01:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDD4A20849
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Dec 2018 12:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="UCEg6gBm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDD4A20849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=posteo.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbeLLMBO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 07:01:14 -0500
Received: from mout01.posteo.de ([185.67.36.65]:45299 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbeLLMBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 07:01:13 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout01.posteo.de (Postfix) with ESMTPS id E21DE160060
        for <linux-kernel@vger.kernel.org>; Wed, 12 Dec 2018 13:01:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1544616070; bh=rq6d8+6g3Gbbmqo4/YPcR5ItRs1in69PjuXtyU1Zxk4=;
        h=From:To:Cc:Subject:Date:From;
        b=UCEg6gBmtyLGFzSahPWe6zpciX+y2Y7CmoRRAa/pdkMsdJ1PsIRAVhChHmaeqNnCU
         AlSZHB0y7RAwlZYzj0UbJ5P3VVcZJSlj8bhmh2dIsUZOC8tZlGj16JVOv2qZV9Q11L
         1NYg11uKI9a4UTw+jQ3ceini92GTewdO4NI5XZq/1I7QL0FnHFQf1cpt9+Ua/OmFfo
         dNqbGlCkjaQPwEvmgubrLE9oOznysBsz1UXJxyfUrUMSrsy4tdrTn/hIvKvYVyelFF
         djqjOD7sjqFtWXxumBEhsipbAkPzbBnWwiLfAd1YkTbXI2JT4RLjQYFUyKO+RZVS7R
         pebVVwulpPpAw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 43FFl75YPLz6tmK;
        Wed, 12 Dec 2018 13:01:07 +0100 (CET)
From:   Aaron Strahlberger <aaron.strahlberger@posteo.de>
To:     Gao Xiang <gaoxiang25@huawei.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Chao Yu <yuchao0@huawei.com>, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        linux-kernel@i4.cs.fau.de,
        Aaron Strahlberger <aaron.strahlberger@posteo.de>,
        Julius Wiedmann <julius.wiedmann@fau.de>,
        Dominik Huber <domi250@gmx.de>
Subject: [PATCH v2] staging:erofs: Fix alignment issues
Date:   Wed, 12 Dec 2018 13:00:53 +0100
Message-Id: <20181212120053.16002-1-aaron.strahlberger@posteo.de>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
References: <0ed9f3e7-9081-4a8a-06b0-e5ad14e2c872@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix of `CHECK: Alignment should match open parenthesis` issues, reported by
checkpatch.pl

Signed-off-by: Aaron Strahlberger <aaron.strahlberger@posteo.de>
Signed-off-by: Julius Wiedmann <julius.wiedmann@fau.de>
Signed-off-by: Dominik Huber <domi250@gmx.de>
---
 drivers/staging/erofs/dir.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/erofs/dir.c b/drivers/staging/erofs/dir.c
index e44ca93dcdc6..e1955703ab8f 100644
--- a/drivers/staging/erofs/dir.c
+++ b/drivers/staging/erofs/dir.c
@@ -24,8 +24,8 @@ static const unsigned char erofs_filetype_table[EROFS_FT_MAX] = {
 };
 
 static int erofs_fill_dentries(struct dir_context *ctx,
-	void *dentry_blk, unsigned int *ofs,
-	unsigned int nameoff, unsigned int maxsize)
+			       void *dentry_blk, unsigned int *ofs,
+			       unsigned int nameoff, unsigned int maxsize)
 {
 	struct erofs_dirent *de = dentry_blk;
 	const struct erofs_dirent *end = dentry_blk + nameoff;
@@ -69,8 +69,8 @@ static int erofs_fill_dentries(struct dir_context *ctx,
 #endif
 
 		if (!dir_emit(ctx, de_name, de_namelen,
-					le64_to_cpu(de->nid), d_type))
-			/* stoped by some reason */
+			      le64_to_cpu(de->nid), d_type))
+			/* stopped by some reason */
 			return 1;
 		++de;
 		*ofs += sizeof(struct erofs_dirent);
@@ -104,9 +104,9 @@ static int erofs_readdir(struct file *f, struct dir_context *ctx)
 		nameoff = le16_to_cpu(de->nameoff);
 
 		if (unlikely(nameoff < sizeof(struct erofs_dirent) ||
-			nameoff >= PAGE_SIZE)) {
+			     nameoff >= PAGE_SIZE)) {
 			errln("%s, invalid de[0].nameoff %u",
-				__func__, nameoff);
+			      __func__, nameoff);
 
 			err = -EIO;
 			goto skip_this;
-- 
2.19.2

