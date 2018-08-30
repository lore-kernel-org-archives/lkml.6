Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65C31C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 078AE2084D
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 11:41:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BVW0OkFl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 078AE2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbeH3PnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 11:43:20 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37768 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbeH3PnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 11:43:19 -0400
Received: by mail-wr1-f67.google.com with SMTP id u12-v6so7743315wrr.4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Aug 2018 04:41:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7j7XmdTnSVmbmp015wk6qie+oiQQcCjLk4bzMit5h2s=;
        b=BVW0OkFljrINNZdwpZG1fLFvC/nUNg+PNl5V7e4irtxMf/8ds5fOmDiRg0jiFxSrpC
         AoYJuALMe+AwwNcfL+XFZr5OzegbBxhqq4zyR3efYXh1fkP+iudAXgQaGXgjA0W+3l/D
         WukQPVBIbghbxssWNq1MCLUOyqolxuuPzS34fFrWgLDrwmu1SE0O2z3sdJMrXC1j3irA
         q1hnmunuGfmDepy467DjEY/c1lMVlc9uRJcbBb/wHYMZetaFrAnnEbaGp+N/IU4nvYzN
         ELf+B+wUUsGUHENjxGoO9fJ1uoV7CDg40dpQ2QR74jOyv51pz1LyZw4GDWYM8APpnIYu
         zuMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7j7XmdTnSVmbmp015wk6qie+oiQQcCjLk4bzMit5h2s=;
        b=O6J5AniwCkSpZ4/SsRKUQ7dMtOebacyusGVGrU5gS2Ver8AMCSALVtXNZ5UVpITDVO
         kYxvVCbGt23o6tD2Q01TpjsmvFVJSaKtRxrxcJ3sMGvT3QM9cvllKNMIhdC8/gBx30Q8
         hJKL84JxL21r1BgAG25b30byviOU0C43NIYTMLFr3C9mDyEv80DzoirjiZNtNDN0pXmU
         BPUH0iHYUiKwNDIaReV17DjN8isVuahoL5VjSsXvsIda5zL61tOL/KthMjBon76j+CCi
         cEYYTmvnsmDHGo7vqvOoj/ZOw6X4y1SltnwXxSG51yuyr1HTati36gvIRMLcbfae4sM7
         pG7A==
X-Gm-Message-State: APzg51DHwdj/wg/6/WlhrUFwRqSYOnxLrdV09tMdYV5wCsaJ9uI/1dqP
        5E1IZBxbg5yprku/1JFAcEMphw==
X-Google-Smtp-Source: ANB0VdaasFCpPPAdrf+W+nL5HWuIz30Gs7DZp4dQAqVCpoXf0LEuYlfMYwsCQB2tjDdTqw5MKflljw==
X-Received: by 2002:adf:ad8e:: with SMTP id w14-v6mr7818521wrc.178.1535629295169;
        Thu, 30 Aug 2018 04:41:35 -0700 (PDT)
Received: from andreyknvl0.muc.corp.google.com ([2a00:79e0:15:10:84be:a42a:826d:c530])
        by smtp.gmail.com with ESMTPSA id z184-v6sm2175218wmz.0.2018.08.30.04.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Aug 2018 04:41:34 -0700 (PDT)
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
Subject: [PATCH v6 10/11] selftests, arm64: add a selftest for passing tagged pointers to kernel
Date:   Thu, 30 Aug 2018 13:41:15 +0200
Message-Id: <087a7b141ae275a2ea2b53c9df96a1fbce9dc79a.1535629099.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.19.0.rc0.228.g281dcd1b4d0-goog
In-Reply-To: <cover.1535629099.git.andreyknvl@google.com>
References: <cover.1535629099.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
2.19.0.rc0.228.g281dcd1b4d0-goog

