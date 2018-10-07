Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 008ECC6787D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEF922087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="zjV0sR13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEF922087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbeJHGgu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:36:50 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43972 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJHGgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:36:50 -0400
Received: by mail-qt1-f193.google.com with SMTP id q41-v6so19224367qtq.10
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQJrmfmQzy1NQnq9IhQnNhxsGAaV9Gwc/1CV5rAU3w4=;
        b=zjV0sR13N0MGDJF8m7GNFE1Wqd58+Pn8ybbY6r3My+IdQfKKVJT/z80Yhkwbd8lP/K
         /aMupOqeDjRWBb6+QrZ4Xdd0K5sgtiumyoFVT8Hts55k9NO62ugUwQR3dOeaQR2xTWK2
         yCwofU6/ALXNrKYk/2cKskitTBltGzgFwBtyHmWSCNjqVQ4N66O9fT+DylrAIOyySgvU
         qRUMQB9V2S6Xrasra4weSXb2Nz2af8YnMe9CD0Pr3tp4JLukF3sDkOCskhbuq+GHnN9O
         mJwqGsLANGnxyY/3X+z9aBc1cWLwB8SrFQG00aV32JkjFkLuYgXMmTbwpyChv+VXSNBG
         DbdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQJrmfmQzy1NQnq9IhQnNhxsGAaV9Gwc/1CV5rAU3w4=;
        b=Cpog8DnNTVwFZTUUewr+zGm3OEcnYMXO4hGtHHwkBLrCkekvNfmnImDQrMKgLLsOOy
         oRltD8yN1mUaYNS67lQwZZAl2r8nU9JlLK/Z9h66ixF26IKRAErJQFlr5kiD1I8p/EyK
         O8oaSC6Mlu2++MbRkgs3h3tABI2B5XpLXlZghlIgaukQgPOwKbQztFxR1zmInV5Xcfjj
         sk1S1YWPVZeHf/ILf1SbPKfYCbom7v1uHHRiuEKin4ipQTkajtnOlWUWfl+rUQ7moEIA
         jM2NUtlQ/zTz+j3IVIOB1yJbc7BvnKWk0rQPIV/4sO2/ZWodGJqPu7OavjkAGEXbqEEB
         gi+Q==
X-Gm-Message-State: ABuFfohvBqDGW9EtYIcjx4gSfC8xUe6eSDIu6DSzj+4KjsmeiSi+Dad6
        ktxYHftTa5rEDkH3aiL32FzjqQ==
X-Google-Smtp-Source: ACcGV60efTyaOD8yhW5i5oGZtynyWPg5CGkE6vZefSAb0MZLnZHLq5og8xNh4dUuGz66S2hr2dXG4A==
X-Received: by 2002:aed:2807:: with SMTP id r7-v6mr17092189qtd.68.1538954877062;
        Sun, 07 Oct 2018 16:27:57 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:27:55 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 02/19] orangefs: do not invalidate attributes on inode create
Date:   Sun,  7 Oct 2018 23:27:19 +0000
Message-Id: <20181007232736.3780-3-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When an inode is created, we fetch attributes from the server.  There is
no need to turn around and invalidate them.

No need to initialize attributes after the getattr either.  Either it'll
be exactly the same, or it'll be something else and wrong.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c | 6 ------
 fs/orangefs/namei.c | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index a7a8d3647ffe..2f1a5f36a103 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -459,12 +459,6 @@ struct inode *orangefs_new_inode(struct super_block *sb, struct inode *dir,
 		goto out_iput;
 
 	orangefs_init_iops(inode);
-
-	inode->i_mode = mode;
-	inode->i_uid = current_fsuid();
-	inode->i_gid = current_fsgid();
-	inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
-	inode->i_size = PAGE_SIZE;
 	inode->i_rdev = dev;
 
 	error = insert_inode_locked4(inode, hash, orangefs_test_inode, ref);
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 625b0580f9be..46b5f06b7e4c 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -77,8 +77,6 @@ static int orangefs_create(struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 	orangefs_set_timeout(dentry);
-	ORANGEFS_I(inode)->getattr_time = jiffies - 1;
-	ORANGEFS_I(inode)->getattr_mask = STATX_BASIC_STATS;
 
 	gossip_debug(GOSSIP_NAME_DEBUG,
 		     "%s: dentry instantiated for %pd\n",
@@ -292,8 +290,6 @@ static int orangefs_symlink(struct inode *dir,
 
 	d_instantiate_new(dentry, inode);
 	orangefs_set_timeout(dentry);
-	ORANGEFS_I(inode)->getattr_time = jiffies - 1;
-	ORANGEFS_I(inode)->getattr_mask = STATX_BASIC_STATS;
 
 	gossip_debug(GOSSIP_NAME_DEBUG,
 		     "Inode (Symlink) %pU -> %pd\n",
@@ -361,8 +357,6 @@ static int orangefs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode
 
 	d_instantiate_new(dentry, inode);
 	orangefs_set_timeout(dentry);
-	ORANGEFS_I(inode)->getattr_time = jiffies - 1;
-	ORANGEFS_I(inode)->getattr_mask = STATX_BASIC_STATS;
 
 	gossip_debug(GOSSIP_NAME_DEBUG,
 		     "Inode (Directory) %pU -> %pd\n",
-- 
2.19.0

