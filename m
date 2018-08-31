Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C537CC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C8712083A
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C8712083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbeHaSmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:42:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:51071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbeHaSmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:42:35 -0400
Received: from localhost.localdomain ([113.87.91.43]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0M8pKi-1g3Un32scm-00C9K1; Fri, 31 Aug 2018 16:34:22 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 1/5] ext2: cache NULL when both default_acl and acl are NULL
Date:   Fri, 31 Aug 2018 22:33:48 +0800
Message-Id: <20180831143352.22970-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:zJ61drPWzc+dm1JwAfmJn2MH0FhX2Y4YI1twJEzNLBXtS2M87tH
 iTJVvPFqE0PIZ5+oXMDTZMwo/emuhgY/uBOzf0AWz4x5+zkskaCN4f+CXJi1+w/CY8/mfS9
 wkiojIe0befJcQwS46HI5GmeuqC3kE3NWh3El6XRbmArxcy9OQ5jbnHII88Wh6sqz84OA0p
 7Eqj00PbdUmLWlDE4n5DQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:VRFLwQTDSOQ=:BTchpu3/rQZLzWXzfrlqIj
 5NF8iZe3AiXKdPLBrR8inXP/w/VgClRkoMlEslk5/EGkIry6GDEcZHZCiWxj5zuEhTLXfZ/8H
 j5wvyVpjP1TLEc7pbWa0EQM1aIvM+EvVJh1+CfZWnskAEiuMAUQL8hHMwRb8S5nZh7LtwZngV
 168qcTNSSd/7SHpIvtB9O62HuWnBzvxFLfejOAnQm4Zwt+4OgZVA+1Pn8sdzLHg9m7hvNdHrG
 S5xMXTZRO6hQkTyel1pfaITNVLiisssj7aY9abHzA6n08/9XIX6oGI17OYVp7nhmY8Ibe4asJ
 oSeTwz1MjDNjhZi+LJtFTP2SmjrDS8nIRI/yZAf7Qvj2FnPkJ6AHkEpmglE+HJ2yAXp34uJ1W
 k6NZnFlqngURpcDqFJokNjXtQ9mNQkGNxSvxiTxRoy58HuGA+BJiYdx/8sR2MMWVUIaz+UIGr
 F7na9o3Jqp8dr2EgxVzG1uaaHt8AVFzXoyHPNzccfDLEdROwEnUeckpVMdJ5t2upG2gdg52Z3
 aDQ0Ad06L9hAxbdx7rMyYNAz74ZKXAPlooWT+KOz6oz4YBUYGsxQ5CjtqwFGq8T/y+OFF4CV7
 e504cgwxX7lsLcpDVhQ54cVXNcULu7ydTTsixnJfht8gN2HyCPWjG9gxmt/us82ToL5h+rE/I
 oiQV2Hnf6O0QU0gtpjbLySbIHT0hwSqWRQihTIYKOk06rdFDg4AP8r9eJd5HpqXCGCLwBRyoB
 Al5QAatRxZxIheSvMQrsdYTlcdZKpQZFvsNoYFL3FsklwkLbGhyon5dnZRg=
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

 fs/ext2/acl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index 224c04abb2e5..cf4c77f8dd08 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -256,11 +256,15 @@ ext2_init_acl(struct inode *inode, struct inode *dir)
 	if (default_acl) {
 		error = __ext2_set_acl(inode, default_acl, ACL_TYPE_DEFAULT);
 		posix_acl_release(default_acl);
+	} else {
+		inode->i_default_acl = NULL;
 	}
 	if (acl) {
 		if (!error)
 			error = __ext2_set_acl(inode, acl, ACL_TYPE_ACCESS);
 		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
 	}
 	return error;
 }
-- 
2.17.1

