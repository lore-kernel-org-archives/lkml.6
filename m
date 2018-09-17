Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90526ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 488EF214EE
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="TjrN6rMd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 488EF214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728594AbeIRBkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:10 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46627 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728550AbeIRBkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:10 -0400
Received: by mail-qt0-f195.google.com with SMTP id l42-v6so16514391qtf.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25x1TXO92NJ1RfYyzi6wHRI6Xxe6kJwbyYTzNCFH9OI=;
        b=TjrN6rMdz3Bv1nEGa3bwy5U+Qodk7Vxn/2uaZjVxQHz/044hXyrg8sVAMBHazfjZIy
         QCGkBg3NeiC9NzlCpIypQmiYEzWkW/RD0sWzzJ2b0O0S32ul0uzooUs31/TT24FH82Wi
         BJL/h4osrZHcez7yNhlFmDTFekZbjx6yOok04qjdHjikw6BAUR9fkfZCbOHZhQqAOv6P
         U6Y13RjFDEi9+db7t8r6oarg80IaZVKOlOS2xQhrM/uodhE991ckjOIj7RNvgR8gOUPj
         uI2PMah2UKIUa1AFqOnLDG44OqPraCDIcqX3U+Zz3ZgX9lm8VgTd2Ad/gDEusaKJJc1w
         HNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25x1TXO92NJ1RfYyzi6wHRI6Xxe6kJwbyYTzNCFH9OI=;
        b=d7FnhZ2p4MbA+RVpsfP5T70zzQa5dzHeXzyCgS+4j356sv50XUcl/ob8e7xuT81+99
         IyZKokr6uRUI5apFDkApfOijrcreu6u2LNfWJKgbVWAtmsSBV+Av14zgEdQ9Q1zCuab+
         WhIFQuuTgWHs1pYnv3Nrlf2ye4h8AoIcY1pPFTLK57A2+lqTOaIHVZcc3pFjntGWNiyr
         S1UVpRUFoeMRy2bgzTfprDGBuGY8hGLN163v239Szaz9waMfeqkaSTaCpLoqZ6gDrLIs
         dLTxuvowr/A4Fk4AZJet1xm50EtQLcKY7LoqtCt6sybFYhLGqDIqF4odE57nnnyTDMKd
         SwzA==
X-Gm-Message-State: APzg51DeQHTKgq6IwMk42tkPwrw+AV424iOnzOhteQuHAHHG2/Vbkeix
        nMXEEPHEUx0Y8AV/H1/JXNAtitCU7+btY7Td
X-Google-Smtp-Source: ANB0VdZ0kZoQCIHmTvNGBvv8INjKMdBZlUN8mgM+i5OxDJew2HdjM0FOQcjtC490MuxVEe3vfTwPGQ==
X-Received: by 2002:ac8:bc4:: with SMTP id p4-v6mr19341333qti.182.1537215077303;
        Mon, 17 Sep 2018 13:11:17 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:16 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 06/17] orangefs: set up and use backing_dev_info
Date:   Mon, 17 Sep 2018 20:10:43 +0000
Message-Id: <20180917201054.3530-7-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/super.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 4c36481208f5..61bec955b285 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -406,15 +406,11 @@ static int orangefs_fill_sb(struct super_block *sb,
 		struct orangefs_fs_mount_response *fs_mount,
 		void *data, int silent)
 {
-	int ret = -EINVAL;
-	struct inode *root = NULL;
-	struct dentry *root_dentry = NULL;
+	int ret;
+	struct inode *root;
+	struct dentry *root_dentry;
 	struct orangefs_object_kref root_object;
 
-	/* alloc and init our private orangefs sb info */
-	sb->s_fs_info = kzalloc(sizeof(struct orangefs_sb_info_s), GFP_KERNEL);
-	if (!ORANGEFS_SB(sb))
-		return -ENOMEM;
 	ORANGEFS_SB(sb)->sb = sb;
 
 	ORANGEFS_SB(sb)->root_khandle = fs_mount->root_khandle;
@@ -437,6 +433,10 @@ static int orangefs_fill_sb(struct super_block *sb,
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 
+	ret = super_setup_bdi(sb);
+	if (ret)
+		return ret;
+
 	root_object.khandle = ORANGEFS_SB(sb)->root_khandle;
 	root_object.fs_id = ORANGEFS_SB(sb)->fs_id;
 	gossip_debug(GOSSIP_SUPER_DEBUG,
@@ -515,6 +515,13 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 		goto free_op;
 	}
 
+	/* alloc and init our private orangefs sb info */
+	sb->s_fs_info = kzalloc(sizeof(struct orangefs_sb_info_s), GFP_KERNEL);
+	if (!ORANGEFS_SB(sb)) {
+		d = ERR_PTR(-ENOMEM);
+		goto free_op;
+	}
+
 	ret = orangefs_fill_sb(sb,
 	      &new_op->downcall.resp.fs_mount, data,
 	      flags & SB_SILENT ? 1 : 0);
-- 
2.19.0

