Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753679AbeE3FGX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 01:06:23 -0400
Received: from [180.169.226.26] ([180.169.226.26]:48180 "EHLO mail.iauto.com"
        rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750934AbeE3FGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 01:06:22 -0400
X-Spam-Flag: NO
X-Spam-Score: -2
From: kuangrufan@iauto.com
To: linux-kernel@vger.kernel.org
Cc: Kuang Rufan <kuangrufan@iauto.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        devel@driverdev.osuosl.org
Subject: [PATCH] ANDROID: binder: rename parameter to resolve name collision.
Date: Wed, 30 May 2018 12:58:14 +0800
Message-Id: <20180530045814.49504-1-kuangrufan@iauto.com>
X-Mailer: git-send-email 2.15.1 (Apple Git-101)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kuang Rufan <kuangrufan@iauto.com>

both bind.c & binder_alloc.c define the same kernel parameter 'debug_mask',
rename the one in binder_alloc.c to 'alloc_debug_mask'.

Signed-off-by: Kuang Rufan <kuangrufan@iauto.com>
---
 drivers/android/binder_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
index 5a426c877dfb..3850dab493d4 100644
--- a/drivers/android/binder_alloc.c
+++ b/drivers/android/binder_alloc.c
@@ -42,7 +42,7 @@ enum {
 };
 static uint32_t binder_alloc_debug_mask;
 
-module_param_named(debug_mask, binder_alloc_debug_mask,
+module_param_named(alloc_debug_mask, binder_alloc_debug_mask,
 		   uint, 0644);
 
 #define binder_alloc_debug(mask, x...) \
-- 
2.15.1 (Apple Git-101)
