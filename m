Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EBCC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:35:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BF1620661
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:35:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BF1620661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728170AbeHaSmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:42:52 -0400
Received: from mout.gmx.net ([212.227.17.20]:33395 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbeHaSmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:42:52 -0400
Received: from localhost.localdomain ([113.87.91.43]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MFz0E-1gAcMO2lEc-00EuCl; Fri, 31 Aug 2018 16:34:43 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 3/5] f2fs: cache NULL when both default_acl and acl are NULL
Date:   Fri, 31 Aug 2018 22:33:50 +0800
Message-Id: <20180831143352.22970-3-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831143352.22970-1-cgxu519@gmx.com>
References: <20180831143352.22970-1-cgxu519@gmx.com>
X-Provags-ID: V03:K1:/RhIefOZh0aHUfkOO7kYl866M+kqajmHl/a2nk4GhGQFjF1yikE
 6FST6HiQocFxG3mwO0MrtndZVnOroLf0hI0g0TOqXzTYlikSrk4Netk43uoC+EF86O/r9Nm
 L3qqfKShDqes55tNjJVnGXibEGhbNZ5sSrDDWUacCGpKHsDOih+KrwzqusLK3xzgDvhNCEA
 9SYSdHfn5er+98aaF0rvA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:OR6dWIJQlQA=:az9MlUgmHuFKt1/DsYiomh
 nNugJjofuypj//0I2bBCTnequOPLBaKo1X53Npersd7VMd5HLF8o1O3mJNDN6L7Bd3P2eXhrN
 fya9WDaOFLaHJM/0voSSDBV0ftIPAM4RQKRluOWZmBOlSfiRXkjn/rjFx2swLC0ZX0Q9r99hG
 zha6UgP6vxVKLqSQffsqBpA29UhrAMDTLhf9AQwX57vEGKQWIWSxxqk0DOqfiOBRkd60i4bXX
 KVPNkOd1nJ3/q/SEM9ZLHiqz9Mip3gODDS8tvV/OXfiL+n8Jji8hMBxGL00x7q8MT9xLquz78
 2WQBggEmNdRlFIoj8TqNITrdUxITjS2ZUXbJDUcHetdFYCS/DHt3sPRZduci+Bw40ZbekyzBJ
 EH+mYEDdEwQC2Cj4b1Exi0JI9DPPVVd0V8J7ZaIY6ltmhoWOINDTyyR0h7qiJttKX7kHUyI+/
 LgCxrcERGERsEyco3TpL4x54Qyr5cyFCp7PqpDrP11Ai4SslPdSEpivBt4yb57NRWCXWL8F+5
 9yXllGXExJwY2mOGEoZDIN5voa1Lb+VybxINeZwTQ1BseGzJ/hB/RLdTpcyrsUnwfH7noTNCw
 NVQ+EYC62snsYwNrmE+ns5ul6tAX21WBZ/zKZVB14tcSZFo8WZz9mUDJi5D7mVlDIgBYRD+mt
 WyE+ZB/AzaErC7JUQ/dXreeSBFxpX2wtNe/SKmgF976vqOjsS8m2iG6k7MJPfkFN7pHUj2qbO
 dRyIHbJehW25vHSgin5Fa9BqYfI5mohUfrmuj5B8tekchmOB4pNkz6HMgtY=
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

 fs/f2fs/acl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 111824199a88..80aabdf92659 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -394,12 +394,16 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 		error = __f2fs_set_acl(inode, ACL_TYPE_DEFAULT, default_acl,
 				       ipage);
 		posix_acl_release(default_acl);
+	} else {
+		inode->i_default_acl = NULL;
 	}
 	if (acl) {
 		if (!error)
 			error = __f2fs_set_acl(inode, ACL_TYPE_ACCESS, acl,
 					       ipage);
 		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
 	}
 
 	return error;
-- 
2.17.1

