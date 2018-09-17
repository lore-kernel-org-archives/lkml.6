Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43FAECE564
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FEB02147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="k3uxsS7u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FEB02147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728545AbeIRBkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:08 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:34450 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeIRBkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:07 -0400
Received: by mail-qt0-f193.google.com with SMTP id m13-v6so16591140qth.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGw1o6QDx/+CgZ4reocJk+vycJrwtaL4me+corZ7fp4=;
        b=k3uxsS7um4yVXVLk4qupCtqDbHqsqD4KgZxww/vpDBUKXjBZVkSycb2KK4AYgeFuml
         14Gm1P6TUUdjOwnyEXabOZ6Pb9k6Y/8G91eEFGTk6+eC0YQuhPEsNhZ9JVA3G68G/RuJ
         OX67CusPdg/XlrrgGQMOdpUSEDPf3Y6OFeZ7bpc+YK07oxpt1I34fireJisTZKLEpmdb
         NkyQuI/h2O4ZLmWPFGgXWIaxIgXi8g6f8EDKauIpUPzZU7e3f/N9KTfvBsDeW0u1svNy
         60XOabFUyhFAUZWdaRzFTzfa5pT3isXfru+1N2lVZ2gH3ab9Qqxhnfz05N7fUY1yXO/+
         tCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGw1o6QDx/+CgZ4reocJk+vycJrwtaL4me+corZ7fp4=;
        b=nXLll2FL+f8OYEKJpgf20p3llsdt3IT+zrSbKX+vjw2V+JGUy0ZCCRrA4MdkTl9Qc5
         kZ4CaVR2YUD+5ergwJ5Q4r/03FlnAo8X2AOFuSZKnUgGuNKGMyr0KYUdI6v+0da2Y3pq
         rK0TsEnuOOZvvofzCjfTRuwp3Is5eSLdnF8BzaoctmPZi28wUvizc+hNKUcOG+S8CATw
         yD4l44zyFhpfipyzrNE33SJ9rA8JzTkMhfgEAf4PIMp9OlAcAxOS0IGE9ZNcL171NAJ1
         vWFicZRto6iFjy8tlbt0qQYcKXMBH4BYjxw9hxxVZLYOu2J39ikKGNj/6F6ndZHNKB1b
         ckgA==
X-Gm-Message-State: APzg51BZq+fyfD5Ur9F38NyryR9qotj2jj6cviQQZ3l54FOpZPi5kpCM
        A9joJv4BFsPJQfZInuGeua1Gq3hiFDL9EpUA
X-Google-Smtp-Source: ANB0VdaoU5J2doJFk4LjvaRah5rY+cqb+lEqpZfDrij+ZD1WDO8Gp7lq+9uduPlSyVPV8jE5KW79/g==
X-Received: by 2002:aed:3d48:: with SMTP id h8-v6mr18750308qtf.222.1537215075421;
        Mon, 17 Sep 2018 13:11:15 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:14 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 04/17] orangefs: update attributes rather than relying on server
Date:   Mon, 17 Sep 2018 20:10:41 +0000
Message-Id: <20180917201054.3530-5-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be a no-op now, but once inode writeback works, it'll be
necessary to have the correct attribute in the dirty inode.

Previously the attribute fetch timeout was marked invalid and the server
provided the updated attribute.  When the inode is dirty, the server
cannot be consulted since it does not yet know the pending setattr.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/file.c  | 10 ++--------
 fs/orangefs/namei.c |  7 ++++++-
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/fs/orangefs/file.c b/fs/orangefs/file.c
index 3ab6e5126899..aec17635a50f 100644
--- a/fs/orangefs/file.c
+++ b/fs/orangefs/file.c
@@ -327,14 +327,8 @@ static ssize_t do_readv_writev(enum ORANGEFS_io_type type, struct file *file,
 			file_accessed(file);
 		} else {
 			file_update_time(file);
-			/*
-			 * Must invalidate to ensure write loop doesn't
-			 * prevent kernel from reading updated
-			 * attribute.  Size probably changed because of
-			 * the write, and other clients could update
-			 * any other attribute.
-			 */
-			orangefs_inode->getattr_time = jiffies - 1;
+			if (*offset > i_size_read(inode))
+				i_size_write(inode, *offset);
 		}
 	}
 
diff --git a/fs/orangefs/namei.c b/fs/orangefs/namei.c
index 46b5f06b7e4c..7b82fc09291c 100644
--- a/fs/orangefs/namei.c
+++ b/fs/orangefs/namei.c
@@ -383,6 +383,7 @@ static int orangefs_rename(struct inode *old_dir,
 			unsigned int flags)
 {
 	struct orangefs_kernel_op_s *new_op;
+	struct iattr iattr;
 	int ret;
 
 	if (flags)
@@ -392,7 +393,11 @@ static int orangefs_rename(struct inode *old_dir,
 		     "orangefs_rename: called (%pd2 => %pd2) ct=%d\n",
 		     old_dentry, new_dentry, d_count(new_dentry));
 
-	ORANGEFS_I(new_dentry->d_parent->d_inode)->getattr_time = jiffies - 1;
+	new_dir->i_mtime = new_dir->i_ctime = current_time(new_dir);
+	memset(&iattr, 0, sizeof iattr);
+	iattr.ia_valid |= ATTR_MTIME;
+	orangefs_inode_setattr(new_dir, &iattr);
+	mark_inode_dirty_sync(new_dir);
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_RENAME);
 	if (!new_op)
-- 
2.19.0

