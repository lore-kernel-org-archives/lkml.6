Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeCDGuq (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 01:50:46 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:38002 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751779AbeCDGup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 01:50:45 -0500
X-Google-Smtp-Source: AG47ELsiH6TXQOZ+kLS06Rj0KXVBwtY1kHBGsY2HlJDV43+XiMfjqCBNsNlWm256Vy4cFO5CJgBeWw==
From: Nick Desaulniers <nick.desaulniers@gmail.com>
To: dhowells@redhat.com
Cc: Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <nick.desaulniers@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] certs/blacklist: fix const confusion
Date: Sat,  3 Mar 2018 22:50:37 -0800
Message-Id: <20180304065038.28373-1-nick.desaulniers@gmail.com>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes commit 2be04df5668d ("certs/blacklist_nohashes.c: fix const confusion
in certs blacklist")

Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
---
 certs/blacklist.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/certs/blacklist.h b/certs/blacklist.h
index 150d82da8e99..1efd6fa0dc60 100644
--- a/certs/blacklist.h
+++ b/certs/blacklist.h
@@ -1,3 +1,3 @@
 #include <linux/kernel.h>
 
-extern const char __initdata *const blacklist_hashes[];
+extern const char __initconst *const blacklist_hashes[];
-- 
2.14.1
