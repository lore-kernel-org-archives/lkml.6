Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751324AbeEBSRh (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 14:17:37 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:37950 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750939AbeEBSRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 14:17:25 -0400
X-Google-Smtp-Source: AB8JxZpOxVwrxAqRJCMhUhGh+Q+zbxRUI1TYrI0EID5qyoDbj+C6HDybLTf4oKeK/pR4HsfIX/5byw==
From: Ilya Dryomov <idryomov@gmail.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] iov_iter: fix memory leak in pipe_get_pages_alloc()
Date: Wed,  2 May 2018 20:16:57 +0200
Message-Id: <1525285017-18616-2-git-send-email-idryomov@gmail.com>
X-Mailer: git-send-email 2.4.3
In-Reply-To: <1525285017-18616-1-git-send-email-idryomov@gmail.com>
References: <1525285017-18616-1-git-send-email-idryomov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make n signed to avoid leaking the pages array if __pipe_get_pages()
fails.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 lib/iov_iter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4d5bf40d399d..fdae394172fa 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1102,7 +1102,7 @@ static ssize_t pipe_get_pages_alloc(struct iov_iter *i,
 		   size_t *start)
 {
 	struct page **p;
-	size_t n;
+	ssize_t n;
 	int idx;
 	int npages;
 
-- 
2.4.3
