Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2943FC282C0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3DC421872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 03:02:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfAXDCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 22:02:38 -0500
Received: from mout.gmx.net ([212.227.17.22]:60221 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726864AbfAXDCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 22:02:38 -0500
Received: from localhost.localdomain ([218.18.229.179]) by mail.gmx.com
 (mrgmx103 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MCL6r-1guzkI0aIr-0097nx; Thu, 24 Jan 2019 04:02:35 +0100
From:   Chengguang Xu <cgxu519@gmx.com>
To:     adobriyan@gmail.com, akpm@linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 2/2] proc: code cleanup for proc_setup_thread_self()
Date:   Thu, 24 Jan 2019 11:01:50 +0800
Message-Id: <20190124030150.8472-2-cgxu519@gmx.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124030150.8472-1-cgxu519@gmx.com>
References: <20190124030150.8472-1-cgxu519@gmx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Gpau29f7AOcimbau3zLEJ0aZFY5WvThJ2/VStMTdj5lgB80KDSQ
 zHMmtErOQHtz3i59j7/RxrMLNMoviccssqWmRXezMnQMT0wx5wrGq5OhflpUH9vMyK48zRF
 dfLwNJEWXRRdtYBG+vTkM/0IWkW+XBSjGp7dSO9ssooKjXCvSr0zbYBuvs0hWYosT5kdi+e
 oYq1psl8Kjvqz1Y7/TE7w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3rCGPSGjReI=:u8TvCPexPUVez+VdTLSBpV
 SUh4HlMnIaV49t9PRos0/Qlhn2K1sQSyC0ZGoI8n5WHzjr7akWvxkJsElQWjgMbpeZONlA8a7
 SKIo+hNeCQNUJuht6uZQ+Ze3Vm2LsNjXo0OB9XILGzq715uTMP4oj3upHtInUr+cquZNI+P6J
 iieJ6BbNmegdUzBeenw124GaLm44sgRnzVFsHu22A0e270WIKeEKi+83T+eNms3rrGfsZXxGg
 QyYEuH00hPaB+VeQopS1DeP0ILGftH/lNHmEOIxV4mEr6nh6lFqy3kYpPxL/hnpI6HFrvp5Cy
 7plDqBrbLCL1cjacXJX3Kupee+KcJxUCrFbleEfDrQYjaUEvdulSV18ic78jPovXvlcHR+7q/
 8VWD3WQdtV93IT1pSfAiqqexnvv4NUMGNJ8chbreLBO+790+fK0tUKSemyxEx8WEysePvReNc
 r70oNkvirI7uOVQ/IgN851ZpXanfJJiscHcHfPt6aL0wwFZOLvah1IgbYy/z1XjUuf9YOF2g4
 V4cdfXANPmPvZSfhwX12H0lJ12bgEZF7XHzCKR7EgHRo9HH/2v5kJ18NPmQB9jVMaSz82cvEp
 BqThSL1gPfp57qQL0Zxst5A29SDV+r1tGgSzCgNS4B45mMfGXz9wrx3InTNJP6opGeImioTJb
 S84M0+xO9WHz4r7TW60/We/qkoOwqLt1/2pAUu9pgl7+FTERThfSNGaiJIEWIc9g7EfE8LF5y
 ToeBmvnGEgCfqS0QtMR3BggilbFPFyE3912992UupUKeeut7sYIlR2LFPSth+w3rdNZPERuSM
 ShS17BqHj/ep/NvBvdFiM+Q/LqKpXVlLInZDp4p093ZoTsSOJuMnHqzmjb2skWj2TtMHtDXsU
 Lyp+FcSwvND/0APcKsYxo775dTrzMEe6DaIfzJ9RIB/yIKnTdufbGi/tyjfPZA
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary ERR_PTR()/PTR_ERR() cast in
proc_setup_thread_self().

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/proc/thread_self.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/fs/proc/thread_self.c b/fs/proc/thread_self.c
index b905010ca9eb..f61ae53533f5 100644
--- a/fs/proc/thread_self.c
+++ b/fs/proc/thread_self.c
@@ -38,6 +38,7 @@ int proc_setup_thread_self(struct super_block *s)
 	struct inode *root_inode = d_inode(s->s_root);
 	struct pid_namespace *ns = proc_pid_ns(root_inode);
 	struct dentry *thread_self;
+	int ret = -ENOMEM;
 
 	inode_lock(root_inode);
 	thread_self = d_alloc_name(s->s_root, "thread-self");
@@ -51,20 +52,19 @@ int proc_setup_thread_self(struct super_block *s)
 			inode->i_gid = GLOBAL_ROOT_GID;
 			inode->i_op = &proc_thread_self_inode_operations;
 			d_add(thread_self, inode);
+			ret = 0;
 		} else {
 			dput(thread_self);
-			thread_self = ERR_PTR(-ENOMEM);
 		}
-	} else {
-		thread_self = ERR_PTR(-ENOMEM);
 	}
 	inode_unlock(root_inode);
-	if (IS_ERR(thread_self)) {
+
+	if (ret)
 		pr_err("proc_fill_super: can't allocate /proc/thread_self\n");
-		return PTR_ERR(thread_self);
-	}
-	ns->proc_thread_self = thread_self;
-	return 0;
+	else
+		ns->proc_thread_self = thread_self;
+
+	return ret;
 }
 
 void __init proc_thread_self_init(void)
-- 
2.20.1

