Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32EE8C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:35:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EA8C7205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8C7205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728666AbeHaSnK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:43:10 -0400
Received: from mout.gmx.net ([212.227.17.22]:50685 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbeHaSnK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:43:10 -0400
Received: from localhost.localdomain ([113.87.91.43]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MDW9x-1g7bYM0HjJ-00Gq9E; Fri, 31 Aug 2018 16:35:00 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 5/5] orangefs: cache NULL when both default_acl and acl are NULL
Date:   Fri, 31 Aug 2018 22:33:52 +0800
Message-Id: <20180831143352.22970-5-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831143352.22970-1-cgxu519@gmx.com>
References: <20180831143352.22970-1-cgxu519@gmx.com>
X-Provags-ID: V03:K1:uxNQ/XKf2YUz8pgu6glf5JPalPJH5RB8lUUceXOg8ov+qMxkd+/
 p6w5/vuj2q15inLVZBnnYAQLHib/osoBfIhr/ZXmsMZnDbUxuJDNmBnpTph6JMqc2DUsqlG
 yXrN+qGcm66+TnAJE8i9hn4xERkOJetHBmu5eMeBKssFuVvVaxVu/lK7Eo6QUEChoS/eOX1
 Tdzht8mI1z53FHf20IlVQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:4T70T1yxekw=:j6h4KUq6vJXHgnu+rV1KeK
 WApSWJxPfhyh/9+kO16rka9uJEarbyllSKMlR2bG6vthxg7jA0rOClicEIKHczO+tV6WWIl+F
 QgkqnbRzvQVLCr688sKr7RVqOJw6WyKrFw7IVx0usFf0jSkJS00F+/ZZHEYmxlum2VOqbsB79
 louEBzxOokGPRcrskgYppjQ6wRJBOytDqKxAfu4dWxUdDPy0ZPjPlHQXMJBXT2HbmlQ1SSacO
 VS+EjMNZ9T9Un3cPshLC/DfFb6V/G9lfpJ1F0Bwho6kPDL3sXMIVN3TLogZeVrQfTH/Szi/oH
 eH4w5HQ9zKJshJZ+coUYb+12e7HJZdLP36fsTIqhg98jjbiAYVOuaizI9ppzVAxOvo7CGhT9e
 +tfm+DPCH/d9/yOoa7QGah191Ygtws4InIxm/Bz6l1mLGBuWVMxbtiaCXucwcWrkolZW2Kn+N
 d07MChpNjtWYjMxqvIa3TxmmObGg8lCaqrcMXGTWnZlT50z1IzILwrR0ZKPjrnAPTI1z2hQNi
 2AVbYROtSOakpscGLLAn5IbXOeFZO26FKtDl+zU45HeAtGAHlyKDHplOLBRknOk3W0x8TEAbQ
 BiyiADId1bRsdPNoCAoL16VsUzGcw+8rDHjIZCMlEWxtHBHy9w2hszd+yL1qg3Sh+rjAvXqZ9
 IusTVs5H5zxWASzQwdu1m6P9Oc8ObP3XWXgP5oOOypmMcBxFGi4Ll/Sz3ZhtG9YcEW+P4KrQW
 jA4g5/1DBmrzHV5kDy6lYGqKuugvaBaegUad7w/YvFGHso1ysA8/Q1xSqXI=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

default_acl and acl of newly created inode will be initiated
as ACL_NOT_CACHED in vfs function inode_init_always() and later
will be updated by calling xxx_init_acl() in specific filesystems.
Howerver, when default_acl and acl are NULL then they keep the value
of ACL_NOT_CACHED, this patch tries to cache NULL for acl/default_acl
in this case.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
v1->v2:
- Coding style change.

 fs/orangefs/acl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index 10587413b20e..72d2ff17d27b 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -167,12 +167,16 @@ int orangefs_init_acl(struct inode *inode, struct inode *dir)
 		error = __orangefs_set_acl(inode, default_acl,
 					   ACL_TYPE_DEFAULT);
 		posix_acl_release(default_acl);
+	} else {
+		inode->i_default_acl = NULL;
 	}
 
 	if (acl) {
 		if (!error)
 			error = __orangefs_set_acl(inode, acl, ACL_TYPE_ACCESS);
 		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
 	}
 
 	/* If mode of the inode was changed, then do a forcible ->setattr */
-- 
2.17.1

