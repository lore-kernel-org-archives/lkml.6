Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 583AAC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:17:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1B82F2151D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:17:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B82F2151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732629AbeHNRFR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:05:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:39377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbeHNRFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:05:16 -0400
Received: from localhost.localdomain ([113.116.48.118]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Lusmr-1fyPuM0H2X-0104eF; Tue, 14 Aug 2018 16:17:31 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 2/5] ext4: cache NULL when both default_acl and acl are NULL
Date:   Tue, 14 Aug 2018 22:16:31 +0800
Message-Id: <20180814141634.5471-2-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814141634.5471-1-cgxu519@gmx.com>
References: <20180814141634.5471-1-cgxu519@gmx.com>
X-Provags-ID: V03:K1:D0Oo4rCzcfWw6KdCUnd/Ln/zsvTraDWmZ8Mjca/sLBVdS0MqNBj
 427NIlgz1sCovxz+/OeqLZxwjzN8DJwU8iXWiJLl48YNFPG1BBXw6ISv0WUpGgNUPr+4hGO
 nwXLTJtDdbpoF0uXgR7FzUGoRWcLMRXaGM5+RsynsZAZr8r9WoujeQQ4YqV1XtJwKAgjTnR
 rjGr8VNgK5JtFfvtAEQyA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NHkn60ZSxK0=:gh2j5YGnuwU/n75flX5GfJ
 F7juCxsVuy/CiTT+tKX+g83BcpfVm7uBCthHbF29KXNq1d+o6tC/RRpIf6mzMIudumEzb7Zde
 QJsNDTsjMtI0ij9R67wGTz6bIOULbkoVWoLgL+cCBNQxtNsWjeD0Onr0O6aY+Ss/2+MWAZTjd
 gHhZrd0h37mMTNIsNt1Zqk7yi0bQxjWF2uaoS+ZDYoWk9Ppp04V4kZNubbqrGiAQUfVuNjbKJ
 we6PXbMQG0De2N7W6Cmqp8QhQtAWRVXtv5ORJY1tjldI0PPKKkdk6xsdUDfm0NsqenqYHDOg2
 Vp9oNIcsEWhzAzVIVxptHvOGJWZnmWP8xb1d3mKwEG20GFm/q3cGbCE09QDPtckEWSokgXnrb
 p9kanj8H3WEERAAzJ9ZCMMMAsT/SrvhWPyXa5UkogDmIysQd2K1x3B87dp/0c66LFakbqzioL
 ZzebSHln64CkYCQqgMxvEH+JmB2Z1JYeaiQK9muyppru5vHiG37u51/INzCMgrsoMTT64AO5T
 5DlHUG5FAM5v5eWzyTbbewXUKhlCMV459qry/Efb66/ECZSE2lFhIPSb4glV0lDHLrOyKNOB5
 ZEZvkjs5i3Inwo1tLFJpjgkB2kbZQp7CdKLkO8UreBAuLe55EmGInPTu/jdc4xwlGVaLJgHLg
 qCoTbL446Q8KtZjG/Q0tYLcYuS3AO5NEPFQPSlc8itiCgtaidMShCyGVcgMWm0++HpB2efkjc
 gosulZe5t7ZN07LkPpJ40xw+GYKfKBjqWfI1H7qb9eRGjIjlcxz4ULTNktY=
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
 fs/ext4/acl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/acl.c b/fs/ext4/acl.c
index fb50f9aa6ead..69a01d28356d 100644
--- a/fs/ext4/acl.c
+++ b/fs/ext4/acl.c
@@ -291,5 +291,8 @@ ext4_init_acl(handle_t *handle, struct inode *inode, struct inode *dir)
 					       acl, XATTR_CREATE);
 		posix_acl_release(acl);
 	}
+	if (!default_acl && !acl)
+		cache_no_acl(inode);
+
 	return error;
 }
-- 
2.17.1

