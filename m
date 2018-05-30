Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968797AbeE3JJd (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:09:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968739AbeE3JJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:09:13 -0400
From: Jessica Yu <jeyu@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jessica Yu <jeyu@kernel.org>
Subject: [PATCH 3/3] modsign: print module name along with error message
Date: Wed, 30 May 2018 11:08:30 +0200
Message-Id: <20180530090830.20737-4-jeyu@kernel.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180530090830.20737-1-jeyu@kernel.org>
References: <20180530090830.20737-1-jeyu@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is useful to know which module failed signature verification, so
print the module name along with the error message.

Signed-off-by: Jessica Yu <jeyu@kernel.org>
---
 kernel/module.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/module.c b/kernel/module.c
index ae824a6f1a03..8670585eb5f7 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -2807,7 +2807,7 @@ static int module_sig_check(struct load_info *info, int flags,
 		reason = "Loading of module with unavailable key";
 	decide:
 		if (sig_enforce) {
-			pr_notice("%s is rejected\n", reason);
+			pr_notice("%s: %s is rejected\n", info->name, reason);
 			return -EKEYREJECTED;
 		}
 
-- 
2.16.3
