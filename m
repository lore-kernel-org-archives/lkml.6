Return-Path: <SRS0=mdhE=KU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E089C46470
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:20:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C648A21899
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Aug 2018 15:20:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1KtoY7m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C648A21899
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726680AbeHERZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Aug 2018 13:25:43 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44426 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbeHERZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Aug 2018 13:25:43 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so7269174lfb.11
        for <linux-kernel@vger.kernel.org>; Sun, 05 Aug 2018 08:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JELoMQRI+xsNZaRvhrGZCWpaqTv6jbTv5XLiXxwcexQ=;
        b=g1KtoY7mC320vvTijnmFkrRODChO+bVJVmkB4Syk7ITTbPITQ76vc9pD89VjruhDIF
         z28Urookno4OqYu33H+efTiojwijytgvUF5hwTPHECV8b05gcxqPdN1dcAZe6qeMxkGO
         JvW+/4x7ynXC4rAwsPC/YcW5Sz5GSmSkXES6NjgHIrw4NAmguza6b+FueWBGgNgxQD1g
         5/7LwMHkXF/ujTnQnWlXvLmFNOxcEarY2nT3XaQT2umUwgeeRepFJ2DdLOjk6GYXBhwm
         tENHKqjhG5NLHoChcEqwfvY2NA1vdXTw8GHozQnn9u8kByfGXRzeZdrvfNMbovFahl33
         rFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=JELoMQRI+xsNZaRvhrGZCWpaqTv6jbTv5XLiXxwcexQ=;
        b=fiA4InkvSs75gZVTquwK9SjDoqaAsAnfK/Uj3g30IJpavdX3Wi+tlKGlsDfx4Br0iB
         /5ldDt86lrMyuE5D2u7fl7IqHooaCaPDXq3qFWIXyirbU2yPS55p406uSxzNwFrvfMPT
         CfHA2A+6lTlS6iD65CFljX0iTh21UuxxWmkYfZi2oHpVrQq+/PrUxgDM6W9sj1fpx+0H
         xNZYKwC2bBOcifwZvZM3OAKunxTgPtTSh/c+kRjfuSiWl/UeQVWz9R5IEmEiFOY5UM0L
         ZNEGT3qdH47lx1jYHijgJpuHnPA/ZrAAao0SlJx2+7QFmgntvBddqkZEf1SrC13OKdEF
         MSsA==
X-Gm-Message-State: AOUpUlHLphwlRo3yZIM0pBlUxsNec3V3EOC8w+WKvKWotGdZUyt9+pDg
        MA1Ruje9CweqxjbvCRYhzUI=
X-Google-Smtp-Source: AAOMgpdl0PjjPhuhOg8ah1KeiqnEkenZ6SgWO4j8EUm8ub8i5MAfqLnVfrDjURPqjIQrrv8gRvcq7Q==
X-Received: by 2002:ac2:428f:: with SMTP id m15-v6mr9498330lfh.52.1533482445405;
        Sun, 05 Aug 2018 08:20:45 -0700 (PDT)
Received: from Dankpad.localdomain ([212.3.193.74])
        by smtp.gmail.com with ESMTPSA id b3-v6sm1692911lfg.43.2018.08.05.08.20.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Aug 2018 08:20:44 -0700 (PDT)
From:   =?UTF-8?q?Kristaps=20=C4=8Civkulis?= <kristaps.civkulis@gmail.com>
To:     gaoxiang25@huawei.com, yuchao0@huawei.com,
        gregkh@linuxfoundation.org, linux-erofs@lists.ozlabs.org,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: erofs: fix if assignment style issue
Date:   Sun,  5 Aug 2018 18:21:01 +0300
Message-Id: <20180805152101.11657-1-kristaps.civkulis@gmail.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix coding style issue "do not use assignment in if condition"
detected by checkpatch.pl.

Signed-off-by: Kristaps Čivkulis <kristaps.civkulis@gmail.com>
---
 drivers/staging/erofs/unzip_vle.c |  3 ++-
 drivers/staging/erofs/xattr.c     | 16 ++++++++--------
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
index 1030ca5c2dc3..45b1255f5a22 100644
--- a/drivers/staging/erofs/unzip_vle.c
+++ b/drivers/staging/erofs/unzip_vle.c
@@ -702,7 +702,8 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
 	/* can be used for verification */
 	map->m_llen = offset + cur - map->m_la;
 
-	if ((end = cur) > 0)
+	end = cur;
+	if (end > 0)
 		goto repeat;
 
 	/* FIXME! avoid the last relundant fixup & endio */
diff --git a/drivers/staging/erofs/xattr.c b/drivers/staging/erofs/xattr.c
index 6b9685fa601c..0e9cfeccdf99 100644
--- a/drivers/staging/erofs/xattr.c
+++ b/drivers/staging/erofs/xattr.c
@@ -288,8 +288,8 @@ static int inline_getxattr(struct inode *inode, struct getxattr_iter *it)
 
 	remaining = ret;
 	while (remaining) {
-		if ((ret = xattr_foreach(&it->it,
-			&find_xattr_handlers, &remaining)) >= 0)
+		ret = xattr_foreach(&it->it, &find_xattr_handlers, &remaining);
+		if (ret >= 0)
 			break;
 	}
 	xattr_iter_end(&it->it, true);
@@ -321,8 +321,8 @@ static int shared_getxattr(struct inode *inode, struct getxattr_iter *it)
 			it->it.blkaddr = blkaddr;
 		}
 
-		if ((ret = xattr_foreach(&it->it,
-			&find_xattr_handlers, NULL)) >= 0)
+		ret = xattr_foreach(&it->it, &find_xattr_handlers, NULL);
+		if (ret >= 0)
 			break;
 	}
 	if (vi->xattr_shared_count)
@@ -512,8 +512,8 @@ static int inline_listxattr(struct listxattr_iter *it)
 
 	remaining = ret;
 	while (remaining) {
-		if ((ret = xattr_foreach(&it->it,
-			&list_xattr_handlers, &remaining)) < 0)
+		ret = xattr_foreach(&it->it, &list_xattr_handlers, &remaining);
+		if (ret < 0)
 			break;
 	}
 	xattr_iter_end(&it->it, true);
@@ -544,8 +544,8 @@ static int shared_listxattr(struct listxattr_iter *it)
 			it->it.blkaddr = blkaddr;
 		}
 
-		if ((ret = xattr_foreach(&it->it,
-			&list_xattr_handlers, NULL)) < 0)
+		ret = xattr_foreach(&it->it, &list_xattr_handlers, NULL);
+		if (ret < 0)
 			break;
 	}
 	if (vi->xattr_shared_count)
-- 
2.18.0

