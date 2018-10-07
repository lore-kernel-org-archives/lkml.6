Return-Path: <SRS0=94iy=MT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E6A4C6787E
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9A652087D
	for <linux-kernel@archiver.kernel.org>; Sun,  7 Oct 2018 23:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="s7KcqLSk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9A652087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727879AbeJHGgz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 02:36:55 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39088 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbeJHGgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 02:36:54 -0400
Received: by mail-qt1-f193.google.com with SMTP id e22-v6so12207557qto.6
        for <linux-kernel@vger.kernel.org>; Sun, 07 Oct 2018 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SirJKoIx7jx+/pssoW2lLhRdFGwvChtL7wsaf8VCkus=;
        b=s7KcqLSkLP+qRHfimjzLwOelTUPpT0wv7eas2oxkAp6osSzgiJWwW6mWSeCFfQBR8f
         msZrPPdx9LsEf+0Uo/8BVMIenM1om3l1JrLF36KZMhcbzUZnDjr+GvFVvUWF4WfjlDXI
         j/8RvuoZ7b+k8sBZP46klM5tkJe8Z3JQ60gHq7Y/dA4ynx4Vy3ukpAmG9/bCxWkrIZBQ
         XL8OlJA3SJnb+VMX3pfusT+i21Z7X/SDjSq/3pNx8ZHIE3bNTwpaFd6CEV6KT2tKgc3h
         J6aEfXHsGusUP9I1D9KYU6L7efssZO06MZoweNghwSp89TLUEeK16jqo3a6XbPO8/7Ci
         duWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SirJKoIx7jx+/pssoW2lLhRdFGwvChtL7wsaf8VCkus=;
        b=LetArYEM5uym5BudfZ6flnHr0ag3l/eye+XpiAxr5F2fpryDwJBs7V2pYGvtTDxfuP
         VRukRE3DNpyfkPlHRGtdcm7y92c41NDvxtrEHA0vkF6QQY2YyF/T/PzKuVRwAa/Y++Cw
         n8F+PUnAxSLYeDv7Ui0O4Mmd+TBfg+MZo8nN00zeVoqPh2w0RibZ/0sRULWq55n6+7QG
         JNGKMdpbr9clmNbC30vV7tSJh7z7+hjLi0IBbfpQxye5j0qrWQ9Dh27loE6npj7QMpaa
         3VUd/lOb8nbyBma7POaheXN3fy1l98Yd+u18N+SkzdMcMIBtFH55S8fsoNlnQ4D5Ksfx
         kv7g==
X-Gm-Message-State: ABuFfojqExoVBMpRJkkmV9/vB4LE1NGKPP03yZLHp+3GKckD/4lLwjHL
        bZO/W0PpVLxb8+IdYJoUvFiHIw==
X-Google-Smtp-Source: ACcGV62lA9uiNUFVD7kbZjRDe2qIoenLZX8rRGgqUIsqGmsWS9a44IOl3n7Xr7X6CdzfTYq1FrTfyQ==
X-Received: by 2002:aed:31e7:: with SMTP id 94-v6mr17397237qth.134.1538954881301;
        Sun, 07 Oct 2018 16:28:01 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-35-153-175-159.compute-1.amazonaws.com. [35.153.175.159])
        by smtp.gmail.com with ESMTPSA id x38-v6sm6793915qtc.39.2018.10.07.16.27.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 07 Oct 2018 16:28:00 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     devel@lists.orangefs.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hubcap@omnibond.com
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 05/19] orangefs: hold i_lock during inode_getattr
Date:   Sun,  7 Oct 2018 23:27:22 +0000
Message-Id: <20181007232736.3780-6-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181007232736.3780-1-martin@omnibond.com>
References: <20181007232736.3780-1-martin@omnibond.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This should be a no-op now.  When inode writeback works, this will
prevent a getattr from overwriting inode data while an inode is
transitioning to dirty.

Signed-off-by: Martin Brandenburg <martin@omnibond.com>
---
 fs/orangefs/inode.c          |  4 ++--
 fs/orangefs/orangefs-utils.c | 33 +++++++++++++++++++++++----------
 2 files changed, 25 insertions(+), 12 deletions(-)

diff --git a/fs/orangefs/inode.c b/fs/orangefs/inode.c
index 067fd7111103..ec3996a61f92 100644
--- a/fs/orangefs/inode.c
+++ b/fs/orangefs/inode.c
@@ -253,8 +253,8 @@ int orangefs_getattr(const struct path *path, struct kstat *stat,
 	struct inode *inode = path->dentry->d_inode;
 
 	gossip_debug(GOSSIP_INODE_DEBUG,
-		     "orangefs_getattr: called on %pd\n",
-		     path->dentry);
+		     "orangefs_getattr: called on %pd mask %u\n",
+		     path->dentry, request_mask);
 
 	ret = orangefs_inode_getattr(inode,
 	    request_mask & STATX_SIZE ? ORANGEFS_GETATTR_SIZE : 0);
diff --git a/fs/orangefs/orangefs-utils.c b/fs/orangefs/orangefs-utils.c
index 76f18a3494c7..d44cbe96719a 100644
--- a/fs/orangefs/orangefs-utils.c
+++ b/fs/orangefs/orangefs-utils.c
@@ -280,12 +280,17 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	loff_t inode_size;
 	int ret, type;
 
-	gossip_debug(GOSSIP_UTILS_DEBUG, "%s: called on inode %pU\n", __func__,
-	    get_khandle_from_ino(inode));
+	gossip_debug(GOSSIP_UTILS_DEBUG, "%s: called on inode %pU flags %d\n",
+	    __func__, get_khandle_from_ino(inode), flags);
 
+	spin_lock(&inode->i_lock);
 	/* Must have all the attributes in the mask and be within cache time. */
-	if (!flags && time_before(jiffies, orangefs_inode->getattr_time))
+	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
+	    inode->i_state & I_DIRTY) {
+		spin_unlock(&inode->i_lock);
 		return 0;
+	}
+	spin_unlock(&inode->i_lock);
 
 	new_op = op_alloc(ORANGEFS_VFS_OP_GETATTR);
 	if (!new_op)
@@ -306,13 +311,23 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	if (ret != 0)
 		goto out;
 
+	spin_lock(&inode->i_lock);
+	/* Must have all the attributes in the mask and be within cache time. */
+	if ((!flags && time_before(jiffies, orangefs_inode->getattr_time)) ||
+	    inode->i_state & I_DIRTY) {
+		gossip_debug(GOSSIP_UTILS_DEBUG, "%s: in cache or dirty\n",
+		    __func__);
+		ret = 0;
+		goto out_unlock;
+	}
+
 	if (!(flags & ORANGEFS_GETATTR_NEW)) {
 		ret = orangefs_inode_is_stale(inode,
 		    &new_op->downcall.resp.getattr.attributes,
 		    new_op->downcall.resp.getattr.link_target);
 		if (ret) {
 			ret = -ESTALE;
-			goto out;
+			goto out_unlock;
 		}
 	}
 
@@ -328,19 +343,15 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 			inode->i_size = inode_size;
 			inode->i_blkbits = ffs(new_op->downcall.resp.getattr.
 			    attributes.blksize);
-			spin_lock(&inode->i_lock);
 			inode->i_bytes = inode_size;
 			inode->i_blocks =
 			    (inode_size + 512 - inode_size % 512)/512;
-			spin_unlock(&inode->i_lock);
 		}
 		break;
 	case S_IFDIR:
 		if (flags) {
 			inode->i_size = PAGE_SIZE;
-			spin_lock(&inode->i_lock);
 			inode_set_bytes(inode, inode->i_size);
-			spin_unlock(&inode->i_lock);
 		}
 		set_nlink(inode, 1);
 		break;
@@ -353,7 +364,7 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 			    ORANGEFS_NAME_MAX);
 			if (ret == -E2BIG) {
 				ret = -EIO;
-				goto out;
+				goto out_unlock;
 			}
 			inode->i_link = orangefs_inode->link_target;
 		}
@@ -363,7 +374,7 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 		/* XXX: ESTALE?  This is what is done if it is not new. */
 		orangefs_make_bad_inode(inode);
 		ret = -ESTALE;
-		goto out;
+		goto out_unlock;
 	}
 
 	inode->i_uid = make_kuid(&init_user_ns, new_op->
@@ -387,6 +398,8 @@ int orangefs_inode_getattr(struct inode *inode, int flags)
 	orangefs_inode->getattr_time = jiffies +
 	    orangefs_getattr_timeout_msecs*HZ/1000;
 	ret = 0;
+out_unlock:
+	spin_unlock(&inode->i_lock);
 out:
 	op_release(new_op);
 	return ret;
-- 
2.19.0

