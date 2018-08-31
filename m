Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D298FC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:34:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9041B20661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:34:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9041B20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbeHaSmj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:42:39 -0400
Received: from mout.gmx.net ([212.227.17.20]:33709 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbeHaSmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:42:39 -0400
Received: from localhost.localdomain ([113.87.91.43]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0M8JyQ-1fj9X11ySY-00vyDL; Fri, 31 Aug 2018 16:34:34 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 2/5] ext4: cache NULL when both default_acl and acl are NULL
Date:   Fri, 31 Aug 2018 22:33:49 +0800
Message-Id: <20180831143352.22970-2-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831143352.22970-1-cgxu519@gmx.com>
References: <20180831143352.22970-1-cgxu519@gmx.com>
X-Provags-ID: V03:K1:SLY8f5eIZO+8dRz4on4iY3kojrelTqPTtbHPK3e8lBKsVwRwECK
 UKQO8kegZEdPQ64sKhO1UIbk5JyYGKa+F4rmWSbg9aohgtVv6waGHXL2fpYUTxFQYNNhWuS
 KOpsK2AR28IZZBdqSWDnKx7Cop4PPqeQ1mp9LUBRFQNuQRGGIsKKox7u8PoWFJQ543tOE2z
 sKJMMbs8qnbcWYWnwdIHg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hftw/YjyDXw=:tiCCninlfF8FCnZmAZKd5Z
 s/+fpXokK0+4OiXw4vWdvkT/iMpJETTb1W430P1OjCiFbHEWMjQA8AUGth+iKdNIkizjjjtcN
 WxulhuP19Ug2Yb1dCZDfvwVJjHY6lPhIScUF98RXMdHxpLczS+PKoDsjhogGjCYsatZxrlQLL
 LirwTOMrYyK3s0jluqZsl7SfuwrYQxBGNYPucq6nzBqUjhL0HhahPTIiW5BRPVwkK2tun7DkP
 v2zaBH8m1jR4rp0GEjTP4aQvNJzLUGB/jcjfZhGn02wQaJgJUxc7NCg0MQaNUvDpUvHqk1HMG
 H/NeAivYjb9ByKgqIpQLqd/v+LTc2iJHNNEvwgNdbfiD25029ba2G+qDl/ezupyogee/L7iEc
 yxeIjcdqy4rRf29PmWxq4Kif2w0sbP0v6OA/YtZNzPuQRvHaP9fiDdtzEUbOwevwiuxeudZPf
 c/SAYiyIltzZI0UiPvyp8eJ/y2K9xxnAXtKiRj5GhmxVm4vzyunFM7e3bm7XT/OGDN+Y+0UwI
 WSiymNn2PUssYzifCJaU4U7TlJ6f6Md1YPpwrDDa5T5haq3rMjiDcjkt3LTtRd2zHXmT8PnvD
 7jmPFbSyscic+DEbaDmnIQFEGi8s0+Y+7JuXOYuDJldWn9oIv5ZTp3O62wPMTLUicm+0W2Ri8
 fk3cKBML2GJqlYcvz8FMHckovpHNB+xUlutKeo4h7b4kN3QzJFWLUMOsskcp09Joh+lBnRASO
 81ziiDBk5W61U2ByWuXheHPegP3z5E+lxUovuJRIlpJtIfAKJp0+ZgnPlq4=
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

 fs/ext4/acl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index fb50f9aa6ead..c1d570ee1d9f 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -284,12 +284,16 @@ ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 		error = __ext4_set_acl(handle, inode, ACL_TYPE_DEFAULT,
 				       default_acl, XATTR_CREATE);
 		posix_acl_release(default_acl);
+	} else {
+		inode->i_default_acl = NULL;
 	}
 	if (acl) {
 		if (!error)
 			error = __ext4_set_acl(handle, inode, ACL_TYPE_ACCESS,
 					       acl, XATTR_CREATE);
 		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
 	}
 	return error;
 }
-- 
2.17.1

