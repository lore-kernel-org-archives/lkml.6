Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23285C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9EC72151D
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:18:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9EC72151D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732760AbeHNRFf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:05:35 -0400
Received: from mout.gmx.net ([212.227.17.22]:46955 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbeHNRFf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:05:35 -0400
Received: from localhost.localdomain ([113.116.48.118]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MfRnb-1fVT7t3fWF-00P1wT; Tue, 14 Aug 2018 16:17:51 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 5/5] orangefs: cache NULL when both default_acl and acl are NULL
Date:   Tue, 14 Aug 2018 22:16:34 +0800
Message-Id: <20180814141634.5471-5-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180814141634.5471-1-cgxu519@gmx.com>
References: <20180814141634.5471-1-cgxu519@gmx.com>
X-Provags-ID: V03:K1:BhOPBB45She6oJeWlmpCdGqDSbI8TyNuOHvnSC5HNcIIncvOzG/
 JTK+S7R8iPNvQAxBvwGITz58MAlbBUxOxh22HKn6nIZvHYBBLXIf8WwCot63jAWjh0XiWXc
 gRGiQ/OddweveN6gn2aA9+4VM7y715GaxPlvn0SeffSIuC4GAMR6zvrJHmaXvS/ui9UD4HU
 7ou4lwyyzT2JwGEIiEsnw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9P1WXlxYrBs=:i6ckKiby2rugs80mUEcnZy
 SJJIQRflKSCSOGi8vK539y6WXEHfLrBuncUMFm2OhStQV5mNaMlUXWtvWUFyvYTzgXwgUZ2Pk
 AWhoC4poFZlqGubtBHMC/n2pQqM3Fx2MlqpZ2kmMuFOsq4yCzAJMGnOm3UFL4TrTQvtLDp5tX
 inC+vo0V4mQ5AfX8Zhd/hf8mpP4mjfUull5BYLamUVgED5/7x1WsTlBX1QIT7tTCARx88LxBU
 ZAZ5AA0bRIfWfKT3oYRSktG0A9/jV8QbHcuj+rBVlP82ctvVlE80NJIKawAoVIJCDiLoXxVm/
 I1WhbPCkyXb1air/8A7i8o3ieRL03vW2j+fII55HOLDMv3x+d1ewE74OSmxSZ+XRUAYoPlDZi
 GyiOLugl3OtWrPOSgZywXi7rrLKdQCotBWaY0yaxIvAQOHa23zkh9Y3hCld7gu8u4xl2/bvmX
 nkG+l2zh5/TuZZaubuEbI5tedmLprcmTMIszotTf59VsaIax6uTE7IaXxRIatXtWGjESQXD9C
 8SZUAmzOSmmEGGkv849f4/hUvXuWX4lc8SE0PrYx3GwuTZKewSZk3+TwSHvB8DnyRewF/wPGa
 Y/JkEfVu9UVyBsg7LpU+yzKQnnzPP3tUdyR+u53h0H2p7lY+zzEYXdWN+Myx6zyAcTqEQX09H
 rSWVJrwGlzwDEGbbpNCcjehThX3KgLWD9qbX3s82cvAf+WwMlKi5QgvfTceypou270VPSAxri
 M68CxdYijMVB5rUWItEPsoct9cFSJfdbDA9JFoNhW/X5QJv7EfJ6wm9GbzQ=
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
 fs/orangefs/acl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/orangefs/acl.c b/fs/orangefs/acl.c
index 10587413b20e..e3b043a263bc 100644
--- a/fs/orangefs/acl.c
+++ b/fs/orangefs/acl.c
@@ -175,6 +175,9 @@ int orangefs_init_acl(struct inode *inode, struct inode *dir)
 		posix_acl_release(acl);
 	}
 
+	if (!default_acl && !acl)
+		cache_no_acl(inode);
+
 	/* If mode of the inode was changed, then do a forcible ->setattr */
 	if (mode != inode->i_mode) {
 		memset(&iattr, 0, sizeof iattr);
-- 
2.17.1

