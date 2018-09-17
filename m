Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53C8AECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06D852147A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=omnibond-com.20150623.gappssmtp.com header.i=@omnibond-com.20150623.gappssmtp.com header.b="HA5PeBZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06D852147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=omnibond.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728572AbeIRBkJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 21:40:09 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:46625 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728501AbeIRBkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 21:40:08 -0400
Received: by mail-qt0-f196.google.com with SMTP id l42-v6so16514348qtf.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SirJKoIx7jx+/pssoW2lLhRdFGwvChtL7wsaf8VCkus=;
        b=HA5PeBZHtni39+dG2TBUaxi6cZ6ue/ghbULDJLdX2d5F0XKrG+0bYBe2HXNT1VEqla
         RfoVi/pY+wKuXNmgu4mQtzmF2ABOJeAzmKRJpIjMCD5n2x32Hd+s9IutrJJ/saqyWOMF
         MAETIze9Kfx3Kt9B07jMPX514J1YmtcO+uGmzuMoaYu2TlNn2fTPr8lbeULDSXEE4VqA
         YuxiTPu4JXRuuKkFCl0J/YMzQCqTrz7iLoz5trUPuf0+ou1STdU+zM/CbWN2tYL7ZW7k
         5Rf2PkM8JOaq1GE7KY3IOUpu0emqiOqMXw+k4S+M5H+EbiMDbelTmxipG2RqI8fKFtJP
         dzfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SirJKoIx7jx+/pssoW2lLhRdFGwvChtL7wsaf8VCkus=;
        b=ukFxqORkKa71eM4aFNIxX2K9qPGIa2P5+CskebjwLSwsZeKiZtGcGRBp5W2LRgYGjZ
         QoGKg+IFWQuagsS0cUeVKROMrrTuUCh43uMAIWB+fYHvtbklC/7erWt28E5SmEsbmXW1
         L7YRUVh/RNec0NPS3w8ChZ0Z41c8jqgmRoODF95omfeKw+PNfkAtTRUaXDaQ/XTRC5TW
         Cz+uDxlYqJQhxaQ1wvGje58ygXvW4gfhViBUGB0r1csqskMRe6tokg2Fhf6iUUP0VvYb
         JpeYGzupRrDhqSgYaWb7unVW0hFDxV/mD2JeHsEVSKSaZB0UjFB6Rpb5oib4OeeOZexq
         qxYw==
X-Gm-Message-State: APzg51AEfKIEXmfBe/xajZjKhKJrT7e1VogIOhrsUDFKKPeeX/UkL1HZ
        JP9YKvFi6AphGckzCMFThgC/unZBEVlgwHVT
X-Google-Smtp-Source: ANB0Vdb8PxFBZA7BjGXqFjlSF/ei101OAq3oXPlT+RDhY73bkfbnk8gVhhUmomyggj9bcb/Ln4Utcg==
X-Received: by 2002:aed:21ac:: with SMTP id l41-v6mr18389455qtc.293.1537215076397;
        Mon, 17 Sep 2018 13:11:16 -0700 (PDT)
Received: from ip-172-31-22-34.ec2.internal (ec2-18-215-252-133.compute-1.amazonaws.com. [18.215.252.133])
        by smtp.gmail.com with ESMTPSA id n8-v6sm11053480qtk.38.2018.09.17.13.11.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 13:11:15 -0700 (PDT)
From:   Martin Brandenburg <martin@omnibond.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        devel@lists.orangefs.org
Cc:     Martin Brandenburg <martin@omnibond.com>
Subject: [PATCH 05/17] orangefs: hold i_lock during inode_getattr
Date:   Mon, 17 Sep 2018 20:10:42 +0000
Message-Id: <20180917201054.3530-6-martin@omnibond.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917201054.3530-1-martin@omnibond.com>
References: <20180917201054.3530-1-martin@omnibond.com>
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

