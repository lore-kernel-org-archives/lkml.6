Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F28C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8BB31208B3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 23:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qG38GQPr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BB31208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbeH1DEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 23:04:23 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:46708 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727459AbeH1DEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 23:04:22 -0400
Received: by mail-ed1-f65.google.com with SMTP id k14-v6so421276edr.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 16:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tgDsHqthJUHVff+zw07Gpl4T3uKuQ3i1iMq6FEr0hO8=;
        b=qG38GQPrdLDF/1RbNdLYPA2yIjEabmcSIaN8GiWIsKn+POJBSYUNPb9z49LT9BWNfP
         c7mQG/9j6VU92wROddZMpo6H+yuXj4Lp8MRDj2jCsr6kv4hXh+mjTjlKmdGXEGnen9VW
         hiWlY+X2PP6Z6Q6ScRVJLRM31DNG3EeCQx1Qt5fTZpORSPgg5z4zpmcM9WMNaykEE/rV
         Ty9M8smYqHXLvnArXRsmwRxBmjufFPPvZOWSW8Glpj79j/DZYKw00fp2vkmrVlXcM6im
         B3PRWz/JJBXvkbnS3FyodXk1xIxS/zYruK5qqDk8B9jWtcQ3epYmKpH9iDVyXGpx7oyW
         G0+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tgDsHqthJUHVff+zw07Gpl4T3uKuQ3i1iMq6FEr0hO8=;
        b=hDxKsvaUpmKeYitHsiNjAOl7Ga/vKogp+4PkhqObCCL9pheMazogpOWY/VhxYO/7rc
         q9cUltY2e9IgkfLRciiZw768eAjXjVwRAzrpJqT9Oh18Z8T+mNyy+Mrhh+XrPsag8WRy
         Pj0QLrFs57YvYfiL1trK/uwo4mLwsMuIoAj4EoP1zs2oj/MHKdv3byjvzgeRjKfq9aM+
         6GUNX0fYUAPEWRQBYkGQP0jxjts4biFzOqZMgC4vH94MECuu6zOADXrjH6lWHXopuaqy
         /ZC/BmoRvIGq2D8VGW/gUfU2tOyxmLjmDoYTO5NGNPYmWVakM3gzgIeWSXb1CyO8rPkZ
         Bx5Q==
X-Gm-Message-State: APzg51Df3fSoyoT1owYWPz8DzO3NherNzIDuc8bCBSAfOMGds4Ifyqq2
        vZdnDYYSCz3hihl8xXuh3Q==
X-Google-Smtp-Source: ANB0VdbwmbHjDS0x0Z4c7xNQpSpeA/gfWE0A4BWX/lnnuSW4NE+e15LIZ/cj+BkNxryEzxPCV6AYeQ==
X-Received: by 2002:a50:eacb:: with SMTP id u11-v6mr19731049edp.7.1535411735423;
        Mon, 27 Aug 2018 16:15:35 -0700 (PDT)
Received: from localhost.localdomain (nat4-minsk-pool-46-53-177-92.telecom.by. [46.53.177.92])
        by smtp.gmail.com with ESMTPSA id u3-v6sm173918edo.44.2018.08.27.16.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Aug 2018 16:15:34 -0700 (PDT)
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH 04/13] proc: rename "p" variable in proc_map_files_readdir()
Date:   Tue, 28 Aug 2018 02:14:54 +0300
Message-Id: <20180827231503.26899-4-adobriyan@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20180827231503.26899-1-adobriyan@gmail.com>
References: <20180827231503.26899-1-adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use "mfi", add "const" and move structure definition closer while I'm at it.

Note: moving "struct map_files_info info;" declaration to the scope
where it is used bloats the code by ~90 bytes. I'm not sure what's
going on.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---
 fs/proc/base.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index f96babf3cffc..17666bd61ac8 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2014,12 +2014,6 @@ static int map_files_get_link(struct dentry *dentry, struct path *path)
 	return rc;
 }
 
-struct map_files_info {
-	unsigned long	start;
-	unsigned long	end;
-	fmode_t		mode;
-};
-
 /*
  * Only allow CAP_SYS_ADMIN to follow the links, due to concerns about how the
  * symlinks may be used to bypass permissions on ancestor directories in the
@@ -2119,6 +2113,12 @@ static const struct inode_operations proc_map_files_inode_operations = {
 	.setattr	= proc_setattr,
 };
 
+struct map_files_info {
+	unsigned long	start;
+	unsigned long	end;
+	fmode_t		mode;
+};
+
 static int
 proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 {
@@ -2128,7 +2128,6 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	unsigned long nr_files, pos, i;
 	struct flex_array *fa = NULL;
 	struct map_files_info info;
-	struct map_files_info *p;
 	int ret;
 
 	ret = -ENOENT;
@@ -2196,16 +2195,17 @@ proc_map_files_readdir(struct file *file, struct dir_context *ctx)
 	mmput(mm);
 
 	for (i = 0; i < nr_files; i++) {
+		const struct map_files_info *mfi;
 		char buf[4 * sizeof(long) + 2];	/* max: %lx-%lx\0 */
 		unsigned int len;
 
-		p = flex_array_get(fa, i);
-		len = snprintf(buf, sizeof(buf), "%lx-%lx", p->start, p->end);
+		mfi = flex_array_get(fa, i);
+		len = snprintf(buf, sizeof(buf), "%lx-%lx", mfi->start, mfi->end);
 		if (!proc_fill_cache(file, ctx,
 				      buf, len,
 				      proc_map_files_instantiate,
 				      task,
-				      (void *)(unsigned long)p->mode))
+				      (void *)(unsigned long)mfi->mode))
 			break;
 		ctx->pos++;
 	}
-- 
2.16.4

