Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58AF2C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D0832148E
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Yx0djIaN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D0832148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727632AbeJQHrB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:01 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:46655 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeJQHrA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:00 -0400
Received: by mail-qk1-f201.google.com with SMTP id p128-v6so25870119qke.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d9RWd340hsvL8f+86Hq8ZYiuwlmFywi6LURyY+fbx2M=;
        b=Yx0djIaN7qGsKbKVWcYTEqjXtuCt5mJzBG+llgMyRaDxHH9Nk2+9u04slBVXvfc3wS
         WWJHLZ4Cy0qql1s9KGSUtvIF+PX0aE7H32+1XHTQwloMetji6MM1GrYxeoWsHDNEyHme
         26sRpezs791PHz4VTxdpWVRBV4zsZkpnI+T4tVqgNpfWT3JVKRx9VCbofy90SGD86rNZ
         CVw0KoKkl9sSfkCpgdn4xhVAM4qWEBIHZA6zZhx9yOE/i8xtzOj5GcVO+gq7diSY3OG3
         3aJXOMLC0d6eKbLtdgSbwRXBJ4WRK0n7XsIsJ8o1UnMToMe3XRTQjSJFXuGQOvz9UjCu
         IUHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d9RWd340hsvL8f+86Hq8ZYiuwlmFywi6LURyY+fbx2M=;
        b=Ue9NyxMK2O02s/Wg6BA9psRtOX7heql7x8BX+wg9jqegaJkpO6ViGJN7KnuKfQMzMV
         PD7EyNrw+NJe1LnHmguQWYXTrT7HvXodb25cF+4qnlOtWutpE7DJf0DmPoTrpXurAlkq
         dv/mGW8aqmUx+OkeD4WcTH8cyZVWsgzi1FD6lHscrAZUJYnb0/KbZE5mp8rZ3+YaNtH4
         zl2hvMzQBM2CMwte9AR7K2JXP4U+WebOQaZqUpgACjN/SRQmuoZRoVxxDrRQhqcVYuHt
         J9s3/q1r+cruyD2DuHQ0w+YhyXQ8PxLw5KRuvwE3NXoGjn4/5O3CRs5xb+jGO3CiAweu
         p+0Q==
X-Gm-Message-State: ABuFfog/Q+Ol+cVQJCJB5WqSlsbAYNwO95dAodXdNImrfG02Jy0QaGOI
        N6kSZdrivP3NHZP9ASsKiRQnPX+Qn8MmB5+NdypMyw==
X-Google-Smtp-Source: ACcGV60dfjopFdXI57rHANuj2fTuNIbfr0UGtI22ZYmJqsrCuYMIb093FrDiq5/oUqMydOfiaVQ+Y58DAxIqLJV1QYBy9g==
X-Received: by 2002:ac8:8d4:: with SMTP id y20-v6mr20143675qth.9.1539734050869;
 Tue, 16 Oct 2018 16:54:10 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:50:59 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 10/31] kunit: test: added concept of initcalls
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added a way to add plugins that require a test module to be loaded
during initialization.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h | 19 +++++++++++++++++++
 kunit/test.c         | 29 +++++++++++++++++++++++++++++
 2 files changed, 48 insertions(+)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 49a9d6e43992c..58dbe2aee423f 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -152,6 +152,12 @@ struct test_module {
 	struct test_case *test_cases;
 };
 
+struct test_initcall {
+	struct list_head node;
+	int (*init)(struct test_initcall *this, struct test *test);
+	void (*exit)(struct test_initcall *this);
+};
+
 /**
  * struct test - represents a running instance of a test.
  * @priv: for user to store arbitrary data. Commonly used to pass data created
@@ -183,6 +189,19 @@ int test_init_test(struct test *test, const char *name);
 
 int test_run_tests(struct test_module *module);
 
+void test_install_initcall(struct test_initcall *initcall);
+
+#define test_pure_initcall(fn) postcore_initcall(fn)
+
+#define test_register_initcall(initcall) \
+		static int register_test_initcall_##initcall(void) \
+		{ \
+			test_install_initcall(&initcall); \
+			\
+			return 0; \
+		} \
+		test_pure_initcall(register_test_initcall_##initcall)
+
 /**
  * module_test() - used to register a &struct test_module with KUnit.
  * @module: a statically allocated &struct test_module.
diff --git a/kunit/test.c b/kunit/test.c
index f89cfaaf5eb79..9737465fb0568 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -53,6 +53,19 @@ static void test_set_death_test(struct test *test, bool death_test)
 	spin_unlock_irqrestore(&test->lock, flags);
 }
 
+struct test_global_context {
+	struct list_head initcalls;
+};
+
+static struct test_global_context test_global_context = {
+	.initcalls = LIST_HEAD_INIT(test_global_context.initcalls),
+};
+
+void test_install_initcall(struct test_initcall *initcall)
+{
+	list_add_tail(&initcall->node, &test_global_context.initcalls);
+}
+
 static int test_vprintk_emit(const struct test *test,
 			     int level,
 			     const char *fmt,
@@ -130,8 +143,18 @@ static void test_run_case_internal(struct test *test,
 				   struct test_module *module,
 				   struct test_case *test_case)
 {
+	struct test_initcall *initcall;
 	int ret;
 
+	list_for_each_entry(initcall, &test_global_context.initcalls, node) {
+		ret = initcall->init(initcall, test);
+		if (ret) {
+			test_err(test, "failed to initialize: %d", ret);
+			test->success = false;
+			return;
+		}
+	}
+
 	if (module->init) {
 		ret = module->init(test);
 		if (ret) {
@@ -146,6 +169,12 @@ static void test_run_case_internal(struct test *test,
 
 static void test_case_internal_cleanup(struct test *test)
 {
+	struct test_initcall *initcall;
+
+	list_for_each_entry(initcall, &test_global_context.initcalls, node) {
+		initcall->exit(initcall);
+	}
+
 	test_cleanup(test);
 }
 
-- 
2.19.1.331.ge82ca0e54c-goog

