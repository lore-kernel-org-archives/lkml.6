Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9876BC1B0F6
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:24:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4923C208C2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 15:24:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J3yTQZ1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4923C208C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932495AbeFTPYu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 11:24:50 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39199 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932425AbeFTPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 11:24:42 -0400
Received: by mail-wm0-f67.google.com with SMTP id p11-v6so204066wmc.4
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lPw14ir5b4WYyY1IhNATkeAXJBB+IrqZlAw0DjD5TTM=;
        b=J3yTQZ1f7n+TJHf/9o+PbNCwiTIqOpqcpuAZAjAp4VpJr8b+6IVZWEChhyNuHzW5CN
         x4oTUXoG5gTru7+EZlpV0+yD73A92yWwf5YfPQlHQ9zLiJBc7LkRrzmsPwt3uYEf2/oM
         LVz3auXNJFbsfhnHnD2X82eqtqNWbBwp7AnDAnaCaJ6UmhDUhGQOMMkyHutfpiMe9lW/
         SgUJY7JoHljiZD4AiI0oiW2yOirlZlqQ+BAXvs2qMnbx9TOq5w9vrg/smy9Hjul2PGzM
         VJByaKeRy33kp2BTwa/XsKcjG8HODhxRMyjGREC+8atPHrPzl1ne28mb7DDD8HLxdk4Q
         MXSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lPw14ir5b4WYyY1IhNATkeAXJBB+IrqZlAw0DjD5TTM=;
        b=HJVGayG/xfEb4zYNHjoNTfiNwI7CMCOIFQNF0JUifJ5RepPsT3/6gvyMyyMfzTJHE5
         2ggzPeG/fb22xyc4N0EBfd8DEbsVVTtuuDUUGa8519QOT9W1sKJ+28Ct2K2JEKFSNYLb
         23ulpQgtpa5AgTEUEsgBV3hdxnuzZ3wB8aJh0330tJ9gIrSWgYRPHWgDrRFwP4hcqy/T
         5bkjJu+h2nuoAKYsNsMzySZVppXbR9IFzKyw6etvhofh3Qe1F+2wQA6NV6VRQzxxGYjq
         2YKyYY3O5sU481HJRSANroCu3MhjiFJlbO7noWzOT2KuaKfzuAtiihvup7pEDO5jgzHg
         XXLw==
X-Gm-Message-State: APt69E1K/og86/BbLzHHRi4r44hb1n5Sn3Tr59d+QFyEcYdZAt1HsnWb
        wqhg2Qi/TP/+IjgXkHn6QJcCUA==
X-Google-Smtp-Source: ADUXVKIbUbPExVtCKiqKrwked5t/GTLnIMMkKufQ8UBcZs1ajm7oykpuIbSr9xNNO4Yptr8aXZsq9w==
X-Received: by 2002:a1c:7212:: with SMTP id n18-v6mr2173331wmc.5.1529508280581;
        Wed, 20 Jun 2018 08:24:40 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id c11-v6sm3959244wrm.65.2018.06.20.08.24.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 08:24:39 -0700 (PDT)
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Shuah Khan <shuah@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Kostya Serebryany <kcc@google.com>,
        Evgeniy Stepanov <eugenis@google.com>,
        Lee Smith <Lee.Smith@arm.com>,
        Ramana Radhakrishnan <Ramana.Radhakrishnan@arm.com>,
        Jacob Bramley <Jacob.Bramley@arm.com>,
        Ruben Ayrapetyan <Ruben.Ayrapetyan@arm.com>,
        Chintan Pandya <cpandya@codeaurora.org>
Subject: [PATCH v4 7/7] selftests, arm64: add a selftest for passing tagged pointers to kernel
Date:   Wed, 20 Jun 2018 17:24:26 +0200
Message-Id: <22a2fd7189189d0b67ea82e44f28a69627a6199e.1529507994.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <cover.1529507994.git.andreyknvl@google.com>
References: <cover.1529507994.git.andreyknvl@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a simple test, that calls the uname syscall with a
tagged user pointer as an argument. Without the kernel accepting tagged
user pointers the test fails with EFAULT.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 tools/testing/selftests/arm64/.gitignore      |  1 +
 tools/testing/selftests/arm64/Makefile        | 11 +++++++++++
 .../testing/selftests/arm64/run_tags_test.sh  | 12 ++++++++++++
 tools/testing/selftests/arm64/tags_test.c     | 19 +++++++++++++++++++
 4 files changed, 43 insertions(+)
 create mode 100644 tools/testing/selftests/arm64/.gitignore
 create mode 100644 tools/testing/selftests/arm64/Makefile
 create mode 100755 tools/testing/selftests/arm64/run_tags_test.sh
 create mode 100644 tools/testing/selftests/arm64/tags_test.c

diff --git a/tools/testing/selftests/arm64/.gitignore b/tools/testing/selftests/arm64/.gitignore
new file mode 100644
index 000000000000..e8fae8d61ed6
--- /dev/null
+++ b/tools/testing/selftests/arm64/.gitignore
@@ -0,0 +1 @@
+tags_test
diff --git a/tools/testing/selftests/arm64/Makefile b/tools/testing/selftests/arm64/Makefile
new file mode 100644
index 000000000000..a61b2e743e99
--- /dev/null
+++ b/tools/testing/selftests/arm64/Makefile
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# ARCH can be overridden by the user for cross compiling
+ARCH ?= $(shell uname -m 2>/dev/null || echo not)
+
+ifneq (,$(filter $(ARCH),aarch64 arm64))
+TEST_GEN_PROGS := tags_test
+TEST_PROGS := run_tags_test.sh
+endif
+
+include ../lib.mk
diff --git a/tools/testing/selftests/arm64/run_tags_test.sh b/tools/testing/selftests/arm64/run_tags_test.sh
new file mode 100755
index 000000000000..745f11379930
--- /dev/null
+++ b/tools/testing/selftests/arm64/run_tags_test.sh
@@ -0,0 +1,12 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+
+echo "--------------------"
+echo "running tags test"
+echo "--------------------"
+./tags_test
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+else
+	echo "[PASS]"
+fi
diff --git a/tools/testing/selftests/arm64/tags_test.c b/tools/testing/selftests/arm64/tags_test.c
new file mode 100644
index 000000000000..1452ed7d33f9
--- /dev/null
+++ b/tools/testing/selftests/arm64/tags_test.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <stdio.h>
+#include <unistd.h>
+#include <stdint.h>
+#include <sys/utsname.h>
+
+#define SHIFT_TAG(tag)		((uint64_t)(tag) << 56)
+#define SET_TAG(ptr, tag)	(((uint64_t)(ptr) & ~SHIFT_TAG(0xff)) | \
+					SHIFT_TAG(tag))
+
+int main(void)
+{
+	struct utsname utsname;
+	void *ptr = &utsname;
+	void *tagged_ptr = (void *)SET_TAG(ptr, 0x42);
+	int err = uname(tagged_ptr);
+	return err;
+}
-- 
2.18.0.rc1.244.gcf134e6275-goog

