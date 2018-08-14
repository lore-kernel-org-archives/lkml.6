Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45FAEC46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:18:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 051602151D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:18:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 051602151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbeHNRFU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:05:20 -0400
Received: from mout.gmx.net ([212.227.17.21]:44911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbeHNRFT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:05:19 -0400
Received: from localhost.localdomain ([113.116.48.118]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0Lfolq-1gD5P12yOA-00pORo; Tue, 14 Aug 2018 16:17:38 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 3/5] f2fs: cache NULL when both default_acl and acl are NULL
Date:   Tue, 14 Aug 2018 22:16:32 +0800
Message-Id: <20180814141634.5471-3-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814141634.5471-1-cgxu519@gmx.com>
References: <20180814141634.5471-1-cgxu519@gmx.com>
X-Provags-ID: V03:K1:G3TyyYSSFZjaYzygNTTz2CQaqAUa9ExgEsKsyd8WN83uHyIPX6U
 muRccE1QzgF5jFUnYOm6pokyPuCCjzRPSlZFaCMk45DQ/lb3FgUmb+oTRzKPBUwFIaMEqTg
 REHvxsDBvJaAVMooTeU4K27av8etonj0b5HBB7rKaxOZ/3MjG3b2PPZs/gmvgvjW9QfYCKM
 B3GNwNTmmz16gruojFkLg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Q6Sct/CfeIo=:0V2XWAxLXa2x3tgodSevNw
 85fZf5ZaFx58dX0js5Rohw/2cz0k9EOYuoyCoGVZHjrrqx5dK6Bky1J4O3gEJa0anxYvB1Rl9
 AqMiDJJNXhlU/TnyGfOVfQH1rFU9Zs9M9wVddQdPv83eTV/+ZFQGd6vYOJVvDu+re+8XTvIGa
 +8c1gKPv0NhRlj8Y+uWWcGKcI2KCTUyHbWnBGuzFPWvhH2+QPzfde6thHoIJwRAGKagnzXpaM
 mBqGHkkRo+4fvmMQuy7iVP28kt3FUgKL282FruhA51NWarb8JkEtD+Efk/QBBr8VIrUBrqWp/
 sfGI6hgkSYtrlCebUKquKzfYxhk/F076xSmgEX3T0NoNdVkdkxfWzKYOh0J5/t7W9PdpHwPbh
 oQf0KGU+cgXRQTMn3968P71ffuHdVv6AJM+/U1LteJF3EJ+U3r3J7qnFjkYKBYqXrgq3v3JhI
 BoMUAegQaWjikTqq10KIT3vr/TrwO/yQqJnx98+r1+NZXEnscbFHI6dPb+dTpF9OdErjigfCH
 QzWs6fpMIwk2sWaC5UG/4NR+XPTUZTjcBO5upZfSwpMFmJPlwG68ULz9vP1Mv0pt0Miz+eqOJ
 6F9vf4Dg+TVo1TPpXVH1MPBpnuEAjV8kYioAGV3QW3Uk/zUOzFmtZiZWaxqL+SiEHdo/ZW1m2
 uqOFRBg48MBtu5EEevMPylVkWft7QRx9ufTlyy/fh2NOO/h6IgLI1jznlOkjDd8L0aToWTkZH
 8NfZjo0cen/Uwxt2kSoJc5EADbecuLAGpsMc5o2K3uxM8Y5OKkko25KVyM8=
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
 fs/f2fs/acl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index 111824199a88..97ed555316be 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -401,6 +401,8 @@ int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 					       ipage);
 		posix_acl_release(acl);
 	}
+	if (!default_acl && !acl)
+		cache_no_acl(inode);
 
 	return error;
 }
-- 
2.17.1

