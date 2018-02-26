Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbeBZXJc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 18:09:32 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:46118 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751539AbeBZXJa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 18:09:30 -0500
X-Google-Smtp-Source: AH8x225Z6SBBJvoYUP7QYYJ4BQCwjlIewzQ8CKPecVlXf+zNT6WyhFTro9hwVG6vjDau+nfqG5QapA==
From: Guenter Roeck <linux@roeck-us.net>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] mm: Provide consistent declaration for num_poisoned_pages
Date: Mon, 26 Feb 2018 15:09:25 -0800
Message-Id: <1519686565-8224-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

clang reports the following compile warning.

In file included from mm/vmscan.c:56:
./include/linux/swapops.h:327:22: warning:
	section attribute is specified on redeclared variable [-Wsection]
extern atomic_long_t num_poisoned_pages __read_mostly;
                     ^
./include/linux/mm.h:2585:22: note: previous declaration is here
extern atomic_long_t num_poisoned_pages;
                     ^

Let's use __read_mostly everywhere.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Cc: Matthias Kaehlcke <mka@chromium.org>
---
 include/linux/mm.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index ad06d42adb1a..bd4bd59f02c1 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2582,7 +2582,7 @@ extern int get_hwpoison_page(struct page *page);
 extern int sysctl_memory_failure_early_kill;
 extern int sysctl_memory_failure_recovery;
 extern void shake_page(struct page *p, int access);
-extern atomic_long_t num_poisoned_pages;
+extern atomic_long_t num_poisoned_pages __read_mostly;
 extern int soft_offline_page(struct page *page, int flags);
 
 
-- 
2.7.4
