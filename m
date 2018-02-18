Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751353AbeBRIOz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 03:14:55 -0500
Received: from foss.arm.com ([217.140.101.70]:50854 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751163AbeBRIOy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 03:14:54 -0500
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>
Cc: Ofir Drang <ofir.drang@arm.com>, linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2] checkpatch: add Crypto ON_STACK to declaration_macros
Date: Sun, 18 Feb 2018 08:13:55 +0000
Message-Id: <1518941636-4484-1-git-send-email-gilad@benyossef.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the crypto API *_ON_STACK to $declaration_macros.

Resolves the following false warning:

WARNING: Missing a blank line after declarations
+			int err;
+			SHASH_DESC_ON_STACK(desc, ctx_p->shash_tfm);

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 3d40403..7d632645 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -791,7 +791,8 @@ our $FuncArg = qr{$Typecast{0,1}($LvalOrFunc|$Constant|$String)};
 our $declaration_macros = qr{(?x:
 	(?:$Storage\s+)?(?:[A-Z_][A-Z0-9]*_){0,2}(?:DEFINE|DECLARE)(?:_[A-Z0-9]+){1,6}\s*\(|
 	(?:$Storage\s+)?[HLP]?LIST_HEAD\s*\(|
-	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(
+	(?:$Storage\s+)?${Type}\s+uninitialized_var\s*\(|
+	(?:SKCIPHER_REQUEST|SHASH_DESC|AHASH_REQUEST)_ON_STACK\s*\(
 )};
 
 sub deparenthesize {
-- 
2.7.4
