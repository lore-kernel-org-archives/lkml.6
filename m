Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54546C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:17:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010392173A
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 14:17:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 010392173A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732561AbeHNRFQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 13:05:16 -0400
Received: from mout.gmx.net ([212.227.17.21]:39935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728458AbeHNRFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 13:05:15 -0400
Received: from localhost.localdomain ([113.116.48.118]) by mail.gmx.com
 (mrgmx101 [212.227.17.174]) with ESMTPSA (Nemesis) id
 0MMoU7-1foEQ840Pn-008azB; Tue, 14 Aug 2018 16:17:24 +0200
From:   Chengguang Xu <cgxu519@gmx.com>
To:     jack@suse.com, tytso@mit.edu, adilger.kernel@dilger.ca,
        jaegeuk@kernel.org, yuchao0@huawei.com, shaggy@kernel.org,
        hubcap@omnibond.com, martin@omnibond.com
Cc:     devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        jfs-discussion@lists.sourceforge.net,
        Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 1/5] ext2: cache NULL when both default_acl and acl are NULL
Date:   Tue, 14 Aug 2018 22:16:30 +0800
Message-Id: <20180814141634.5471-1-cgxu519@gmx.com>
X-Mailer: git-send-email 2.17.1
X-Provags-ID: V03:K1:2WbEhHm/f5/YRIu+1B5GoBcF3lj65bsJ70kBq7dc/htuJR6XTcV
 xs6b/qR30/HU6zx8FmQqSb9jo4j19Xg0uARb/NMm61ZgwWhiFt1vGMYEkMKymm8jKd0kI9z
 nFA5jngE/wGRViFKH7a2XRkxqgrczP1iFGdhOtEKoYIfcKzVIFdfmEbAp2mPzqjYfXKCIf/
 Y8JFJXBUxZldZDKa9qEhg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:P1E7NggGjNs=:/bE7EyY45yGU26R6LqHgPz
 YP9Zh4q8Ww0Uva/XCjSFwjH6im6BtDjy/bOPSvI9XR4SpNHaKGdCl3I3F2vJZaO1saiVhGNzC
 kbrJEqHPCYtm9t8U9yulA/qejiDtcKlZ8fkNQXzOmQ/kPNOdZs/qCxD7rt5HcdLLsssN03fBl
 TdZbibSG0sBan/8dQ5TmalTpXm0tWdTYpb68dxXs2wDNIydc/09FyOFsA9LyNxeqdZimJcYOZ
 X7a0dtMH8fZk4TlDtQr/JDeo2WmB0ce1aS9jpgXuNYcMdvqekJJPxFWROgvb4rHVnbAAPRRpf
 kiqoMtWnl9W3hPdXDO2aOkqgwgW7jLT1/wVakGw/AcC32DvLR+Ykq0CC1KH38ii1Eya0ulXGg
 liIro4OZE0vcXx3rjaaFiE+UIFueE5OwuywWg+kNWqMwS6kkGEkdHG3otwwQmUnA39tQyfOOa
 EluIj7mDeYVqsfYMuTornOKpiGmk5y5McCgxh3nL8hqXP8ZWFn/hCvFCbIGvRQSbZL6Z1WIS6
 B2lcv/hHG7it5RRT1FClQwCzqOwvydAzhEqTZZZcr1y21Vrpj1d7OXHJQKC0nDHcB6YJA9MeU
 OhZxbeVOm0fC/J4M/J5Y5Tf5RToqUJEwZJd+qSn2lpAEdWlxUguLaYNu1R+ClQiRdDT+O/K3f
 RplrAa04imt8oiuNpzXAHU1eavyD28P7phTBCqLkPe6dLzGkGNvxOSrrk4OwAjnXDo4ht7Jc/
 zprIDBvTeBW0DfjfFBuvxr3PhhMzMKozmvaMfxz0isMK/TmTx750AmibRR8=
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
 fs/ext2/acl.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext2/acl.c b/fs/ext2/acl.c
index 224c04abb2e5..74411e8ea507 100644
--- a/fs/ext2/acl.c
+++ b/fs/ext2/acl.c
@@ -262,5 +262,8 @@ ext2_init_acl(struct inode *inode, struct inode *dir)
 			error = __ext2_set_acl(inode, acl, ACL_TYPE_ACCESS);
 		posix_acl_release(acl);
 	}
+	if (!default_acl && !acl)
+		cache_no_acl(inode);
+
 	return error;
 }
-- 
2.17.1

