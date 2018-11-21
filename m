Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73944C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:18:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC78206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 23:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9Ga3Gek"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC78206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388033AbeKVJzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:55:03 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39058 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731891AbeKVJzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:55:03 -0500
Received: by mail-pl1-f194.google.com with SMTP id 101so1279671pld.6;
        Wed, 21 Nov 2018 15:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KTUlimrN3hBQLhtQyfMo5z9bGQ6mYGhq2327qcBo28A=;
        b=B9Ga3GekweGvqDUclkGa7vRf/82MElNWVAxw4AjRUidEtIcw+eazlaaaZYEKbU5DHS
         kXlv6ilzB5H7cbweEnDJTNYa5xGyMlfx2mgyuRg/MZksuz9xFJwMrQ2XIiv3GeECB+6x
         QeBbntUTlALDVOJgUEeAzlaR+Tt/2JhE2VND9RgcIKc8S0Ox5AjvvS4wVXVgX61CR0TT
         ql7LLgvWNGE0M6EM9tBhhixmbRPuxt3b1aB+HKx1Cr6Ll1z7FG7d6lCSTgRhX263NVFh
         34xFzGAlbWhKMKDcJhpTZO7v3qLCjM5ZuSKY0dNh722MCm8+YU89xvZB+YPvC3h7cE9H
         epyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KTUlimrN3hBQLhtQyfMo5z9bGQ6mYGhq2327qcBo28A=;
        b=EDRFAihmvVCnsMQn3iN6rJDUcbx6gK3BCPIaeKnUxkAAEeLNGims57Plpm7HCcuVXz
         DKe/gCPA8upWEc8Tj8oM7fWrAW3mH+qRkjij4CyG++YhwxLWVOCuxnO7QXMQsoY5HIll
         XOQguMRq1zxhvd7ktlTs9t/qJe/2xi7QCP7iYshWcRX+KFJri2YHOS/cFcCP9Go9NeIs
         T7PXjBMY8HZ0h1o/zfUTD1RMls+ISLN1BPLnZGsMDOHBA8kT23x3D9YFqrwT9gfQ+4cs
         hRj+ALGkGQumNCXXh+BdjxTy2rCPAnnyjz1F/VxCx7aCcqGJZrO3oxrpbxTSwgSFAoj/
         R66g==
X-Gm-Message-State: AA+aEWZ5NZfmW59/Q1SIV3SXKlq02IuxwAPh+iQwWc+FNojiYb6m2sot
        eV4bvQlhFuHSGcmK3hYnFvVoI3Jq
X-Google-Smtp-Source: AFSGD/UKTcKX+AZiCrVqKqqvYxpmngAMlEZbgNwk/OpCkJtFZS9tRy3KyxJxNDkWVNQnTf+QIFUfDw==
X-Received: by 2002:a17:902:7c82:: with SMTP id y2mr8644693pll.33.1542842312820;
        Wed, 21 Nov 2018 15:18:32 -0800 (PST)
Received: from myunghoj-Precision-5530 (cpe-76-88-98-70.san.res.rr.com. [76.88.98.70])
        by smtp.gmail.com with ESMTPSA id 12sm4529550pgd.35.2018.11.21.15.18.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Nov 2018 15:18:32 -0800 (PST)
Date:   Wed, 21 Nov 2018 15:18:30 -0800
From:   Myungho Jung <mhjungk@gmail.com>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] fuse: Add bad inode check in fuse_destroy_inode()
Message-ID: <20181121231827.GA9573@myunghoj-Precision-5530>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

make_bad_inode() sets inode->i_mode to S_IFREG if I/O error is detected
in fuse_do_getattr()/fuse_do_setattr(). If the inode is not a regular
file, write_files and queued_writes in fuse_inode are not initialized
and have NULL or invalid pointers written by other members in a union.
So, list_empty() returns false in fuse_destroy_inode(). Add
is_bad_inode() to check if make_bad_inode() was called.

Reported-by: syzbot+b9c89b84423073226299@syzkaller.appspotmail.com
Signed-off-by: Myungho Jung <mhjungk@gmail.com>
---
 fs/fuse/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 0b94b23b02d4..073865371f9b 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -115,7 +115,7 @@ static void fuse_i_callback(struct rcu_head *head)
 static void fuse_destroy_inode(struct inode *inode)
 {
 	struct fuse_inode *fi = get_fuse_inode(inode);
-	if (S_ISREG(inode->i_mode)) {
+	if (S_ISREG(inode->i_mode) && !is_bad_inode(inode)) {
 		WARN_ON(!list_empty(&fi->write_files));
 		WARN_ON(!list_empty(&fi->queued_writes));
 	}
-- 
2.17.1

