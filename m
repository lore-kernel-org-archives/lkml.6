Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82FCC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7977F21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727185AbfAXDCe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:02:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:33697 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfAXDCd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:02:33 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0LzKQf-1hHDSp2b5t-014Xmf; Thu, 24 Jan 2019 04:02:31 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 1/2] proc: code cleanup for proc_setup_self()
Date:   Thu, 24 Jan 2019 11:01:49 +0800
Message-Id: <20190124030150.8472-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:LBTHK8iHp6RE2vHh2FoQL5PIh7DnwN/XuhF9Hm/SF2hb7K/CXuE
 guyJg7dV/gVNe0KEcr7UVo3/lY/jL0p5W4Eg9dqSSqeBli4xIy+SjdDGEqJeEl+XEDB1Llt
 h847QasgNN5hnSSfw2ZK4am45gsFg8N7ckZRmYu3k5Xg6Sqylw2im7BCN6srZeB6LZQ+oQV
 wiuesOpYd8k02h4lowytg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:T7M4PX790bg=:VSnhAO2R54jXaL9lP61ZzQ
 6DyMEIO00nGxP/MJwgfVPMsgFeE/YTKteawUzxJHYpt0fINI+4XXEh1gXfrdaudoJKWGDqlfh
 Xt+ZlP1baKKYeIFqoZNPmqRAEV9aJXEd7EIHiZr8LvUiZ4ZeI7dOaCagcFF512kAaCytCpFnJ
 mYjXb9n9dmZVmwNc02/JpRE6JVNYJXzVQvK6jzc97IVgQbvUEYgtTF+QiAfV767p4CVN9SDCc
 69hnOCmI21wZI07vAZ2E01cPLvaw86KyLkvg20B/ZQ4bEYmO76ndTQORbWvPVkM4+gNKPXqa7
 wuq+TVXKvhl9rJuPEpNlfU5LJL7s4ah0wVGdgh4y9ACGniXKJifyY1Zzba0/S/swQ2zsmOcl7
 RD9Ueu7lBdijlobN13/vqFNTZVtcJPYx0hWFOhtsfwgQznX31LFZTGueICFg+LUE90R3o6mY+
 lklLIe0UX8cWdCfQz5wbaR5ijJcVE+LfixgyujuA+0u9NgH4mMe4j2uxBS27T3TGdPlIE478V
 DT/HRNbTflyk7cfj1G9pxQ/L6acdpgwzZLN5g/doXWgVGDO208JBGS7dr3MYL+YeeZ3BpMp4K
 elFdy6IN3oReoueZ9NH5gtqrz9qbEB62RGnNyMsnBNz0x9UyzvqS9kkzDu/lNu8IRQ393/uJK
 ibfV1D1ZEX5bEOt8aUSb87wt20Im54MAgI3uPeEx4RGzyUUYaZqrjP33lgVmhv4+Ti6xOly3A
 3PVBkGdmGQglKi0sBLdsDdQePEC30zyEw/wOe3NLo3ZPLjWe7znBYgCWLB8ASbXeb5mIZ6fSC
 VtASuqz1uybB9juWSbvP5mWzGukCmkxK/G93c5Hn/MKUwirMZmZ28taqFwqOqM4cafugXThkv
 +22vxRh+6RGUgC/j9pfSZ9Fjkroeroul5l8RDpdXMwqGBzhvMWxhp/fEgx01na
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary ERR_PTR()/PTR_ERR() cast in proc_setup_self().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/proc/self.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/self.c b/fs/proc/self.c
index 127265e5c55f..57c0a1047250 100644
--- a/fs/proc/self.c
+++ b/fs/proc/self.c
@@ -38,6 +38,7 @@ int proc_setup_self(struct super_block *s)
 	struct inode *root_inode = d_inode(s->s_root);
 	struct pid_namespace *ns = proc_pid_ns(root_inode);
 	struct dentry *self;
+	int ret = -ENOMEM;
 	
 	inode_lock(root_inode);
 	self = d_alloc_name(s->s_root, "self");
@@ -51,20 +52,19 @@ int proc_setup_self(struct super_block *s)
 			inode->i_gid = GLOBAL_ROOT_GID;
 			inode->i_op = &proc_self_inode_operations;
 			d_add(self, inode);
+			ret = 0;
 		} else {
 			dput(self);
-			self = ERR_PTR(-ENOMEM);
 		}
-	} else {
-		self = ERR_PTR(-ENOMEM);
 	}
 	inode_unlock(root_inode);
-	if (IS_ERR(self)) {
+
+	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/self\n");
-		return PTR_ERR(self);
-	}
-	ns->proc_self = self;
-	return 0;
+	else
+		ns->proc_self = self;
+
+	return ret;
 }
 
 void __init proc_self_init(void)
-- 
2.20.1

