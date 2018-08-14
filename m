Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBF6C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085AE2172D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:18:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 085AE2172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732727AbeHNRF2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:05:28 -0400
Received: from mout.gmx.net ([212.227.17.21]:50249 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbeHNRF1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:05:27 -0400
Received: from localhost.localdomain ([113.116.48.118]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MOBOi-1fmIMG0eQe-005Zmc; Tue, 14 Aug 2018 16:17:45 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 4/5] jfs: cache NULL when both default_acl and acl are NULL
Date:   Tue, 14 Aug 2018 22:16:33 +0800
Message-Id: <20180814141634.5471-4-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814141634.5471-1-cgxu519@gmx.com>
References: <20180814141634.5471-1-cgxu519@gmx.com>
X-Provags-ID: V03:K1:rFT9OJLTD5YX3u8WgsumqfTElBTL6IWEdsGpYGKSnCTaTeUn12d
 2VaHQwFRFSx0wGaCnH5vm644dlg+v74VbC4sZFjl42WETQzFiHgh4RkUd45rmAaefsvCcxs
 hvcnsyEERyv99M17p+5dJ0LudNhlYufLx//z5McIVz9sfK6fKwwVczDbtSyLz1pM2VirWR7
 FD8QkJ17EgZtE7KTlvEQg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:faAfP3zc69I=:toXgGeQGVhQ8uFI51XScnF
 P8QQwv5vuTmeif+RMp2MiyL3CIgYQjQAZ2owBfZ0qxZGku8Z7oR+w//4YB/Zh2XzRys60FWPW
 zKh3a+LBoE2GFOP8TG1t9fGIVd6BekuwNUQODFjm1eTqQU7izxN2slTpT3VKCablmreOQ/Hoz
 fuNw0y0m5/lbpKMZo457fSFNBUheNft9ZhRqRIFB6E0fvAezH88/Y7DhvjB/WqXmpaMg2AhnJ
 /EkztpU0WDiXD9ImJQP6sndEs+q4IqsrEq9YGLSggahsG2md7QuB9g+gDY66MFHucLJUfBRSs
 XN+2AMMRK/mhW7gAJFFG6wd/QO/8FM7VttYnSs3A/0xPeg8/jz9zM7h4sWUeiPr1kTyuE0zfk
 4Dbs+dN8BOHz5r9pq6HNhLq1yDkq0PfhpXi37aA8yfjpf9tej0xGtxfj9ugmPNdbCWH0D8KWc
 QToOAGJDzUzpAq+L2IIRw8wr1m3eFEkqkRHQ+/0k6Xu1JWto28EkOiv85dDdccHFT181bYHZm
 wDrB3Z5vDeF3ZY4PWKfSyhccgVHURuh3IPoLcN9XapttsK8gBmFh3pI1o2DROIKAE/z4a4eYD
 QkVKQdpqrlmvd2My6nvX83zNa/T/aK3Jmcl777RNrmx2I/qNerqB0CM+V6rc9qaVlHKhDUa0r
 q1cHnxVzzQd2NbCUBxUIqLV+2X2vW1+EdbtpA3GTS1fIEqztwQBAbTANa1VXwLh48DGf3nKkg
 NEA3DBzJF6Ll1f47ENfOppRhFglWvq+iBSw2vK6K60dKdWy0BjBq253dlbw=
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
 fs/jfs/acl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index 2e71b6e7e646..15b9a9b74d72 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -154,6 +154,9 @@ int jfs_init_acl(tid_t tid, struct inode *inode, struct inode *dir)
 		posix_acl_release(acl);
 	}
 
+	if (!default_acl && !acl)
+		cache_no_acl(inode);
+
 	JFS_IP(inode)->mode2 = (JFS_IP(inode)->mode2 & 0xffff0000) |
 			       inode->i_mode;
 
-- 
2.17.1

