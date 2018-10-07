Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F35F6C6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B27822087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="LyJU634F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27822087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbeJHGg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:36:56 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:35496 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727087AbeJHGgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:36:55 -0400
Received: by mail-qk1-f194.google.com with SMTP id v68-v6so4054934qka.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=25x1TXO92NJ1RfYyzi6wHRI6Xxe6kJwbyYTzNCFH9OI=;
        b=LyJU634F6IBEaY61vXqVOzhqwKl3WZ7dhTMzu9z+J/aelG1hlDMy07tEwUQ6gZ92qL
         zycKhs9r8EfUTstoWf1lDqmmHhC/+UrbEIiXchL+ifWVyHXSko9MiBIEcFpadVXdnKVn
         6XxcHtKacaDYdncaju5ilLPP2geWjNZ0GoH4BPWkpjGe/2/VzK0z5K9aCBKT0XBYnjxA
         7jia0eyZ5F9WbefZl+Mw6o4oT/Y3z8nfMxB09XWti/heqjswtQkkyvYviBrkDNmLLFUT
         YamTKWSaLRHDTv3uB0M6/zhj++iEbUBMIBNT9FPOS3e+d9EAca8Nw7rHS7gQpW2za+bD
         DfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=25x1TXO92NJ1RfYyzi6wHRI6Xxe6kJwbyYTzNCFH9OI=;
        b=WBUki82VY7uFRYTnd7+L7qk34EOevAoRbBg/mv4eFjr1Cyo+yqHOAQ3I7nfrL9SsdQ
         Xu1BZexqVyTAIvvJWDog/42p7NhH3HVXt/USx0/bVPBF1w7VASy/kdHXTe0eQbISU59n
         +WaHOZ+vQ+/+qVKg5Uir8Y06box64NzpE4wRY5q/dhHniKV8ONdWuU67FSIorDPKoXwH
         duc0gQbG3nQDvRmaVcuUjhTH195eZ7Cw8TKR+5d8GIniIXufEMQI2tyyqZBVOEht6b24
         Kx/2kH9D8/wxXK0PWuchTbnFtLOkm59y7Mn+QjEpf2DrfUQsSQzA97iAqtv9CqN3ZJqJ
         u57A==
X-Gm-Message-State: ABuFfohTGtUFGkQ8dMGytq/iQ1Vh2msi39qBi/sGWZM2l5btipIKSGfn
        /MHDKWne9pE56Pye9iEVe9Tnqg==
X-Google-Smtp-Source: ACcGV62g+/d6rTqzaYeZvdP5OTL9BApGk9lSWC24dYzt8RDnS6U923CasI1zwHa2tAcLS3R6EEwQhw==
X-Received: by 2002:a37:f8f:: with SMTP id 15-v6mr16840518qkp.300.1538954882569;
        Sun, 07 Oct 2018 16:28:02 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:01 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 06/19] orangefs: set up and use backing_dev_info
Date:   Sun,  7 Oct 2018 23:27:23 +0000
Message-Id: <20181007232736.3780-7-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
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

