Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752584AbeDEKBF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 06:01:05 -0400
Received: from ozlabs.org ([103.22.144.67]:32969 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751487AbeDEKA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 06:00:59 -0400
From: Michael Ellerman <mpe@ellerman.id.au>
To: yamada.masahiro@socionext.com
Cc: akpm@linux-foundation.org, joe@perches.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] lib: Make SECTION_MISMATCH_WARN_ONLY depend on DEBUG_SECTION_MISMATCH
Date: Thu,  5 Apr 2018 20:00:55 +1000
Message-Id: <20180405100055.26585-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.14.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_SECTION_MISMATCH_WARN_ONLY says to turn the errors enabled by
CONFIG_DEBUG_SECTION_MISMATCH into warnings. As such there's no need
to set the former if the latter is not enabled.

Currently there's no connection between the two, meaning we can end up
with this slightly confusing situation:

  # CONFIG_DEBUG_SECTION_MISMATCH is not set
  CONFIG_SECTION_MISMATCH_WARN_ONLY=y

So make CONFIG_SECTION_MISMATCH_WARN_ONLY depend on
CONFIG_DEBUG_SECTION_MISMATCH.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 lib/Kconfig.debug | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 64155e310a9f..39209e951010 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -337,6 +337,7 @@ config DEBUG_SECTION_MISMATCH
 
 config SECTION_MISMATCH_WARN_ONLY
 	bool "Make section mismatch errors non-fatal"
+	depends on DEBUG_SECTION_MISMATCH
 	default y
 	help
 	  If you say N here, the build process will fail if there are any
-- 
2.14.1
