Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752512AbeEVTzp (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 15:55:45 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:38039 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751601AbeEVTzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 15:55:44 -0400
X-Google-Smtp-Source: AB8JxZrLLDQjhWkQLtEwpuiwHFWbhDD8bjW9JhoOt7TmV6KVaPqNWkhg02h7ALkYg3fLVr9XQrZRyA==
From: Mathieu Malaterre <malat@debian.org>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: Mathieu Malaterre <malat@debian.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Laura Abbott <lauraa@codeaurora.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Gargi Sharma <gs051095@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] Add missing header include <linux/mem_encrypt.h>
Date: Tue, 22 May 2018 21:55:31 +0200
Message-Id: <20180522195533.31415-1-malat@debian.org>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In commit c7753208a94c ("x86, swiotlb: Add memory encryption support") a
call to function ‘mem_encrypt_init’ was added. Include prototype
defined in header <linux/mem_encrypt.h> to prevent a warning reported
during compilation with W=1:

  init/main.c:494:20: warning: no previous prototype for ‘mem_encrypt_init’ [-Wmissing-prototypes]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 init/main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/init/main.c b/init/main.c
index 3d6b31f4e520..35ce2ddb1322 100644
--- a/init/main.c
+++ b/init/main.c
@@ -91,6 +91,7 @@
 #include <linux/cache.h>
 #include <linux/rodata_test.h>
 #include <linux/jump_label.h>
+#include <linux/mem_encrypt.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
-- 
2.11.0
