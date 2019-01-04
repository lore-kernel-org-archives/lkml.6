Return-Path: <SRS0=JLMu=PM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A034C43387
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA118218FF
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Jan 2019 20:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546634692;
	bh=Mii981Hesl6QbbzHdXP8lhR58X9wAbatmYZrH0QvsEk=;
	h=Date:From:To:Subject:References:In-Reply-To:List-ID:From;
	b=jbqMUXMGIO55bLHyGDm6/qb8164GaQlTfuhvqGrpoqwrkiKvPRjgwx5oXCR0SC9dr
	 bzWxkjlwQO4Ii+dZ2BCeurZo7lGTZET242Wmx/SkTvueiasVtFUA7jXjfZBfeA8aq9
	 OLT2v4MXCH7TRg36aopZE91+jJXJwTFde7UDSqPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbfADUov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Jan 2019 15:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726009AbfADUov (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jan 2019 15:44:51 -0500
Received: from localhost (unknown [104.132.1.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75B0221872;
        Fri,  4 Jan 2019 20:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546634690;
        bh=Mii981Hesl6QbbzHdXP8lhR58X9wAbatmYZrH0QvsEk=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=dXParMymsqrryZ9TbnC8whTm1tAd6Fyp1/cpEjp4s6TS27rNV3/eCMQvBW26cFE/S
         JOJSyrkDaVoDc5jJ8Mlc/FKKIuEn6HAagS12VwoQpU3OMBuWdH5bmjnHemfMKJo2xj
         plTF9A1EauJbEHh4GuhbEE2FChI14o3HnlX+B6CE=
Date:   Fri, 4 Jan 2019 12:44:49 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] f2fs: export FS_NOCOW_FL flag to user
Message-ID: <20190104204449.GD57873@jaegeuk-macbookpro.roam.corp.google.com>
References: <20190104041945.31802-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190104041945.31802-1-jaegeuk@kernel.org>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This exports pin_file status to user.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
v2:
 - use F2FS_NOCOW_FL (aka FS_NOCOW_FL)

 fs/f2fs/f2fs.h | 3 ++-
 fs/f2fs/file.c | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 12fabd6735dd..9286ec381453 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2301,11 +2301,12 @@ static inline void f2fs_change_bit(unsigned int nr, char *addr)
 #define F2FS_EXTENTS_FL			0x00080000 /* Inode uses extents */
 #define F2FS_EA_INODE_FL	        0x00200000 /* Inode used for large EA */
 #define F2FS_EOFBLOCKS_FL		0x00400000 /* Blocks allocated beyond EOF */
+#define F2FS_NOCOW_FL			0x00800000 /* Do not cow file */
 #define F2FS_INLINE_DATA_FL		0x10000000 /* Inode has inline data. */
 #define F2FS_PROJINHERIT_FL		0x20000000 /* Create with parents projid */
 #define F2FS_RESERVED_FL		0x80000000 /* reserved for ext4 lib */
 
-#define F2FS_FL_USER_VISIBLE		0x304BDFFF /* User visible flags */
+#define F2FS_FL_USER_VISIBLE		0x30CBDFFF /* User visible flags */
 #define F2FS_FL_USER_MODIFIABLE		0x204BC0FF /* User modifiable flags */
 
 /* Flags we can manipulate with through F2FS_IOC_FSSETXATTR */
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ae2b45e75847..0d461321edfc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1651,6 +1651,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
 		flags |= F2FS_ENCRYPT_FL;
 	if (f2fs_has_inline_data(inode) || f2fs_has_inline_dentry(inode))
 		flags |= F2FS_INLINE_DATA_FL;
+	if (is_inode_flag_set(inode, FI_PIN_FILE))
+		flags |= F2FS_NOCOW_FL;
 
 	flags &= F2FS_FL_USER_VISIBLE;
 
-- 
2.19.0.605.g01d371f741-goog

