Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5364AC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:35:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19C8D205C9
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 14:35:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19C8D205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbeHaSnB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 14:43:01 -0400
Received: from mout.gmx.net ([212.227.17.22]:35483 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727430AbeHaSnB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 14:43:01 -0400
Received: from localhost.localdomain ([113.87.91.43]) by mail.gmx.com
 (mrgmx102 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Lm6IP-1fMPpD2kBl-00Zbyi; Fri, 31 Aug 2018 16:34:51 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH v2 4/5] jfs: cache NULL when both default_acl and acl are NULL
Date:   Fri, 31 Aug 2018 22:33:51 +0800
Message-Id: <20180831143352.22970-4-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180831143352.22970-1-cgxu519@gmx.com>
References: <20180831143352.22970-1-cgxu519@gmx.com>
X-Provags-ID: V03:K1:d9aJYmZgvM9aGdD5VTaWAHOHVZIrp6b9beQG8hwubkJPXUUJFnX
 TFuaJ2rexYmgfriQJskD3lhUBbemZQEJCXh7Mue2sNXhyCEDT6JqQw+vCd6YKZMYWnX5Rtd
 C0rQ+A++QtokeBrtu5hmVQTw73Ue1X2yWBL5KdJwf6uOrPZTKQ5vG9fTe/siQSdGGDWMkYC
 2j7tJutR28N/tr4wWcswg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3IIO8lkx4pk=:htnvixdrZjP0wM2z2Ot9XI
 UDFczgEHAkig7fi20exlEoT2+jyIqQTnAyn7Bsa2gF2e4ODAKiQrY22vTSzs6W0los3+p02l1
 IgFJyde7HaBS3sjJGv1Cci+ZLAvLqKqPPezGtuIN5FN4H8kpDvH+xYj2iZNYKPKxMYC9PlYOn
 QDoafAuQPrlKTObO6/3AuOnphmnrtTPyyxKiyHbVdyasnM0809DddzDQPGmSUiRSMN05X8Bez
 qlAuFPbpqoTntgdLhux3UkfT4VTINY4eyvYgS8seCWwhb5pRxztnRJHNTr9u2nPvCOF+cE/Cy
 rI1E28lJgdGbVOvIX+SmLGtsh1Yyswi9MS8GbNfaf8nxUY0SyHGxD7PVYPuxpOXI0rTUCYC2C
 D+5DTddNK/cjWHrEcgcXXCllVEFCcJo3kjZT2bS+L5rYDs70CGg3VFpUAUHFLYP5vUYV+KOcU
 ct7ib4gfdAExd9f5R9VcnEyZpbueKvCmoxzle9zAcEcoln2kTUOLTcD6ZePuuK97XdKuhj2LG
 l14sOo/70D/q3w//TKNlHDLy16RYzERPfdNR1+yHffMnG+U48lulwmTW6eoPb7raljRO5GsqF
 01xL4hp2N1DBTbcgIhYPUItdCt4B9VTqY3n6hRL9pn3NX+rUuoqh3jvZ/Eavunrl5iJ03Wjws
 fVZydnTYVn/h1L9tYdyZRMl6f+gRLVD4fU/mkx5IPjdZ3TjUXMPKUtHiyvfsua/TDxx15pa+w
 giGbSUsMPaFuPcbfIcpUZ/MR0MKB6zono9RyO+4dAU9gBVeTpFs5cKzJY40=
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

 fs/jfs/acl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/jfs/acl.c b/fs/jfs/acl.c
index 2e71b6e7e646..8c06a6ea862d 100644
--- a/fs/jfs/acl.c
+++ b/fs/jfs/acl.c
@@ -146,12 +146,16 @@ int jfs_init_acl(tid_t tid, struct inode *inode, struct inode *dir)
 	if (default_acl) {
 		rc = __jfs_set_acl(tid, inode, ACL_TYPE_DEFAULT, default_acl);
 		posix_acl_release(default_acl);
+	} else {
+		inode->i_default_acl = NULL;
 	}
 
 	if (acl) {
 		if (!rc)
 			rc = __jfs_set_acl(tid, inode, ACL_TYPE_ACCESS, acl);
 		posix_acl_release(acl);
+	} else {
+		inode->i_acl = NULL;
 	}
 
 	JFS_IP(inode)->mode2 = (JFS_IP(inode)->mode2 & 0xffff0000) |
-- 
2.17.1

