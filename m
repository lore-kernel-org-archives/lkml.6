Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752329AbeBFOuA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 09:50:00 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48780 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751424AbeBFOtx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 09:49:53 -0500
From: Colin King <colin.king@canonical.com>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] kasan: remove redundant initialization of variable 'real_size'
Date: Tue,  6 Feb 2018 14:49:50 +0000
Message-Id: <20180206144950.32457-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.15.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variable real_size is initialized with a value that is never read,
it is re-assigned a new value later on, hence the initialization is
redundant and can be removed.

Cleans up clang warning:
lib/test_kasan.c:422:21: warning: Value stored to 'real_size' during
its initialization is never read

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/test_kasan.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_kasan.c b/lib/test_kasan.c
index a808d81b409d..dba0ffd45fd7 100644
--- a/lib/test_kasan.c
+++ b/lib/test_kasan.c
@@ -419,7 +419,7 @@ static noinline void __init kasan_stack_oob(void)
 static noinline void __init ksize_unpoisons_memory(void)
 {
 	char *ptr;
-	size_t size = 123, real_size = size;
+	size_t size = 123, real_size;
 
 	pr_info("ksize() unpoisons the whole allocated chunk\n");
 	ptr = kmalloc(size, GFP_KERNEL);
-- 
2.15.1
