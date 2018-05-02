Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751069AbeEBSRZ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:17:25 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:42062 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750800AbeEBSRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:17:24 -0400
X-Google-Smtp-Source: AB8JxZpaycpmLCdbJ2mPuub+fAC/8abIxeifOgSfCuWGDfSPjPf/wuhzA9dB4UB8DkBsST6Qsz/tHg==
From: Ilya Dryomov <idryomov@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] iov_iter: fix return type of __pipe_get_pages()
Date: Wed,  2 May 2018 20:16:56 +0200
Message-Id: <1525285017-18616-1-git-send-email-idryomov@gmail.com>
X-Mailer: git-send-email 2.4.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It returns -EFAULT and happens to be a helper for pipe_get_pages()
whose return type is ssize_t.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 970212670b6a..4d5bf40d399d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1012,7 +1012,7 @@ unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
 }
 EXPORT_SYMBOL(iov_iter_gap_alignment);
 
-static inline size_t __pipe_get_pages(struct iov_iter *i,
+static inline ssize_t __pipe_get_pages(struct iov_iter *i,
 				size_t maxsize,
 				struct page **pages,
 				int idx,
-- 
2.4.3
