Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD09EECDE2B
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 830692087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="KlUvieqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 830692087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727757AbeJHGgx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:36:53 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45508 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJHGgx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:36:53 -0400
Received: by mail-qk1-f195.google.com with SMTP id m8-v6so11075064qka.12
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bGw1o6QDx/+CgZ4reocJk+vycJrwtaL4me+corZ7fp4=;
        b=KlUvieqFVX4pGEiHu8n9kbfBuWAiaWw/xooAFJWm/F5AF/nSIXr+X2+LuJAM6avOD/
         FJ4uT09on8uXCHkLwkjeVMInjyq/rpIPeLlPtNUp9/sYQvWsv4kGC7ggPlcxTMShNCE6
         alKyIeEwh9x7yL5qxSj9h4+zD4zmK33F4C5KowNdLwvX8IyPiyqfRghOnxwrI+NeXAy9
         8oSWGGk6D9I2DCZqoZO3R7wgOJeIybly2/jy1hN/XbgCP5HsnSrRWL9zzz0FpDAqK+JN
         f2wUP22rP+rxkLFjO7qoOd5sJK+fxpQo65YaMJFLQs3VH0O1QFr+rZiWsFgs25LBH45s
         BcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bGw1o6QDx/+CgZ4reocJk+vycJrwtaL4me+corZ7fp4=;
        b=exXuh8zbsr14qMn4ja2glynafumpGX6WQdXVNGmWK9GUmH9Nl2Ki0IOxWeEKkdrK7k
         tLv/LvJdKln2xcj6WNv8TlL4esC6xUYylaqIKbdooC8tTwGw1q1kuPjMiw4jzUtnKuQX
         cO9nT8WpS8Rb4tCI4l894rf03vXAz/KuHvS/F2v8ovbucbIkoMftxg6fzrS7TCrGS2TO
         Q2BYVS+JiIHje01PRa3VBzPMWwAW+C2C7vewtPkTk+agmfW5iyoJ/sm4c5VD4Zy5ioea
         CitACirQxlL07APWF4hteuo5zfW53vosv3/YuU5wrChhcYTGvS93cCJh0EwMehasJpYl
         i9uQ==
X-Gm-Message-State: ABuFfojI6ZK/oECxQIWLZYzN1/kiyWBLIv7zQSl7GrCuv5VqVzxmH9Rl
        TuZZNCz3uzygyzfwTpmKV/HT8w==
X-Google-Smtp-Source: ACcGV60kbpirfZ2NRrOLfK5DBadQsJvueQ5Tm5U9z2sdGDIAnKqHl6lz18H6hd/VQ8RMPJ+qjOTXIQ==
X-Received: by 2002:a37:d95d:: with SMTP id u90-v6mr17226198qki.244.1538954879831;
        Sun, 07 Oct 2018 16:27:59 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.27.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:27:58 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 04/19] orangefs: update attributes rather than relying on server
Date:   Sun,  7 Oct 2018 23:27:21 +0000
Message-Id: <20181007232736.3780-5-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
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

