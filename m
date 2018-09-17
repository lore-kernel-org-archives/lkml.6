Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2731ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:13:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C95D2147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:13:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="PGW1nLpL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C95D2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbeIRBkG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:06 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:44478 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728440AbeIRBkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:05 -0400
Received: by mail-qt0-f195.google.com with SMTP id k38-v6so16530266qtk.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQJrmfmQzy1NQnq9IhQnNhxsGAaV9Gwc/1CV5rAU3w4=;
        b=PGW1nLpLwqPGObmuu1DlqEJ1dWSLgmK7N2UCLDBot0dAg96v1VVaf3gVLZ1sXgKjMq
         D6HKihGoPRfgLzmRgilgTsFMqcaocHxpP+EidVn6Q1ZrnoYBtBtB6QvSjJIUqPjWH5ij
         XdT4kjOfvlXLZXOJ3aAfc+H5BdjaZb3QiXt8lJmHduqcH0pO2/bVYWLqjqK1yKwETZni
         BsxkJQxmOtyOrt3/v61HmyoCwOWxb7bGh5gHdyZmVz5ZOYM7LThObc/Qt+0wzqA34n/F
         awYttyx5D1aVEMwwfe/dpnbHx/R5633j07uaWFzsTY90nCAt8HPJ4SqGdTXLnhaTaAem
         sUiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQJrmfmQzy1NQnq9IhQnNhxsGAaV9Gwc/1CV5rAU3w4=;
        b=dylDH8XM94o6DodvODJ7y1tt6oqcK07zSe/ANJSm1XoCMVI8ZBpTpSizSHp4XhNt0P
         zOJAHKq6IRCr+sFLqnVySs/rLsXC9VrPspL0+5LdGDnA8sdSokC8h1xEbVC2m0jaYgpK
         rD+PDn8fKX1hNvVLZjJSR6uJJwNRku8W5MQLhYwG8r6x0lbi3xHV0oiC6G42cvCH7eCW
         OiJHA+59dqpxLSLeaEokY0+om+r2dNxJP6cLZsz2BRrg82f7Cb6RsnYhQnlBcfTICf1L
         YWPJaES4UCcVP/BXxrTrLHbrowlfTbBflsXz1j5fQ3XGEhEOu3PJg4ZA1d1XpqKB+sHu
         2ayg==
X-Gm-Message-State: APzg51ARranQkBZ3dtpgcHHrdhLiPNnX/+pPZejnQX07te1wZjKdAUBA
        UeKR1BdLbJQxWtngx/1tw0MTTGhf0oM=
X-Google-Smtp-Source: ANB0VdbjRwV9bSUoeSzwuJl6BMgk9Jz0ZCQ94uV5XMSi/ic7nbrjeTYwCuOEfEgwZh++mWkMWA903Q==
X-Received: by 2002:ac8:232b:: with SMTP id a40-v6mr19117336qta.40.1537215073488;
        Mon, 17 Sep 2018 13:11:13 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:12 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 02/17] orangefs: do not invalidate attributes on inode create
Date:   Mon, 17 Sep 2018 20:10:39 +0000
Message-Id: <20180917201054.3530-3-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
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

