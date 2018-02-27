Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751964AbeB0Tsa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 14:48:30 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:33152 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751716AbeB0Ts2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 14:48:28 -0500
Date: Tue, 27 Feb 2018 11:48:28 -0800
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sparse doesn't support indirect_branch attribute
Message-ID: <20180227194828.GA29918@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Don't use __attribute__((indirect_branch)) if we're compiling with
sparse.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index e2c7f4369eff..b6be4cc25e9d 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -93,7 +93,7 @@
 #define __weak		__attribute__((weak))
 #define __alias(symbol)	__attribute__((alias(#symbol)))
 
-#ifdef RETPOLINE
+#if defined(RETPOLINE) && !defined(__CHECKER__)
 #define __noretpoline __attribute__((indirect_branch("keep")))
 #endif
 
