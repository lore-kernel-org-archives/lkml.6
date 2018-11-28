Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98650C43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA0620989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 19:38:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCoLXEex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FA0620989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729432AbeK2Gky (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 01:40:54 -0500
Received: from mail-pg1-f202.google.com ([209.85.215.202]:44441 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729117AbeK2Gkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 01:40:53 -0500
Received: by mail-pg1-f202.google.com with SMTP id a2so12710101pgt.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Nov 2018 11:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=4IKZcfrlGwiEH28lOjBx5LUer+sMqwxtctpWBn7VdAA=;
        b=UCoLXEex5P9gF0WFmCQLfGm+EaXZnIgPgEFS3D1b4XYYWAOr+oa/EhGwwpLKUwMoHv
         tuJbY1Jo3rvL8QmWbs7VoXQHUKjYsLzaBbfgWlUF+9QyDx525KsLaNCtov3bGDxjIhMq
         aM9iwePUKMTX37lxS70ZAWsaefCmazhkVU1LrnhwSaPzk58SYuodbP5WiEVAf4ddjWGQ
         vg3Lc4t7W5ZhhY1HXZ3yidiCg+ml4Pij4s8TMqdveqJjh4UqSzIhEcso6TdsYOZbQN5H
         NW1ao59aOBDsIVqCi+2gphq5l6I2W8ahTtcVviP7cBirF0n/1VG8Pw3Xk2vaa5oYScKA
         /1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=4IKZcfrlGwiEH28lOjBx5LUer+sMqwxtctpWBn7VdAA=;
        b=iSte9bvBcBzWv6mNkFlR9TZhLoXni3FiV23TYaR3sOgYfzE2ArossX30Fuwu0k9d8x
         EFaaWvbFgbVp4T6zstN3xMrKagFEM8Aa0hz93kL6CSVe2mqkwOtNz7+JYazukEoCQXbq
         tvhgt8C4J+We5uC7BP5hgfbHxwrfk/F8YOSzNnAaAJ5reqPB9VIXv03e5/HO2QdzZl/B
         xhsYNzfHrUAGSmreizLucBUKtlyx4vzWzv35hibF3RreozblmbR72/pF+pu+3xI3SwLp
         p646t+LcH2tiS00oq8EEnQD7UkDlu0Hd1xct0gwWzlngtGK1NTXIWvM5hB1Hc0IyQZ93
         vg0w==
X-Gm-Message-State: AA+aEWaMGV42yU6RBEMOWQ6Cz1aofzUodyDw2AADk5N/2dU1zgmzOUPc
        FZo7IWPu1EniHUNUOhWHDrT4mWFyA4+eMfCYAlBbYw==
X-Google-Smtp-Source: AFSGD/WnggAFh0owRTchvcPojBQP+KX0t2TGac4DD2dNnzBrZvZn2nu84oJBGeXQPeslzFI8Ot+IGoVssdKwirNseddX6g==
X-Received: by 2002:aa7:81cc:: with SMTP id c12mr2953373pfn.69.1543433888545;
 Wed, 28 Nov 2018 11:38:08 -0800 (PST)
Date:   Wed, 28 Nov 2018 11:36:27 -0800
In-Reply-To: <20181128193636.254378-1-brendanhiggins@google.com>
Message-Id: <20181128193636.254378-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181128193636.254378-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.20.0.rc0.387.gc7a69e6b6c-goog
Subject: [RFC v3 10/19] kunit: test: add test managed resource tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     gregkh@linuxfoundation.org, keescook@google.com, mcgrof@kernel.org,
        shuah@kernel.org
Cc:     joel@jms.id.au, mpe@ellerman.id.au, joe@perches.com, brakmo@fb.com,
        rostedt@goodmis.org, Tim.Bird@sony.com, khilman@baylibre.com,
        julia.lawall@lip6.fr, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        jdike@addtoit.com, richard@nod.at, linux-um@lists.infradead.org,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org, robh@kernel.org,
        dan.j.williams@intel.com, linux-nvdimm@lists.01.org,
        kieran.bingham@ideasonboard.com, frowand.list@gmail.com,
        knut.omang@oracle.com, Brendan Higgins <brendanhiggins@google.com>,
        Avinash Kondareddy <avikr@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tests how tests interact with test managed resources in their lifetime.

Signed-off-by: Avinash Kondareddy <avikr@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 kunit/test-test.c | 121 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 110 insertions(+), 11 deletions(-)

diff --git a/kunit/test-test.c b/kunit/test-test.c
index 88b3bcf9c4e00..36fd95c90a26a 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -7,31 +7,130 @@
  */
 #include <kunit/test.h>
 
-static void test_test_catches_segfault(struct kunit *test)
+static void kunit_test_catches_segfault(struct kunit *test)
 {
 	void (*invalid_func)(void) = (void (*)(void)) SIZE_MAX;
 
 	KUNIT_ASSERT_SIGSEGV(test, invalid_func());
 }
 
-static int test_test_init(struct kunit *test)
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_context {
+	struct kunit test;
+	bool is_resource_initialized;
+};
+
+static int fake_resource_init(struct kunit_resource *res, void *context)
 {
+	struct kunit_test_context *ctx = context;
+
+	res->allocation = &ctx->is_resource_initialized;
+	ctx->is_resource_initialized = true;
 	return 0;
 }
 
-static void test_test_exit(struct kunit *test)
+static void fake_resource_free(struct kunit_resource *res)
+{
+	bool *is_resource_initialized = res->allocation;
+
+	*is_resource_initialized = false;
+}
+
+static void kunit_test_init_resources(struct kunit *test)
+{
+	struct kunit_test_context *ctx = test->priv;
+
+	kunit_init_test(&ctx->test, "testing_test_init_test");
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_test_alloc_resource(struct kunit *test)
+{
+	struct kunit_test_context *ctx = test->priv;
+	struct kunit_resource *res;
+	kunit_resource_free_t free = fake_resource_free;
+
+	res = kunit_alloc_resource(&ctx->test,
+				   fake_resource_init,
+				   fake_resource_free,
+				   ctx);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, res);
+	KUNIT_EXPECT_EQ(test, &ctx->is_resource_initialized, res->allocation);
+	KUNIT_EXPECT_TRUE(test, list_is_last(&res->node, &ctx->test.resources));
+	KUNIT_EXPECT_EQ(test, free, res->free);
+}
+
+static void kunit_test_free_resource(struct kunit *test)
 {
+	struct kunit_test_context *ctx = test->priv;
+	struct kunit_resource *res = kunit_alloc_resource(&ctx->test,
+							  fake_resource_init,
+							  fake_resource_free,
+							  ctx);
+
+	kunit_free_resource(&ctx->test, res);
+
+	KUNIT_EXPECT_EQ(test, false, ctx->is_resource_initialized);
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_test_cleanup_resources(struct kunit *test)
+{
+	int i;
+	const int num_res = 5;
+	struct kunit_test_context *ctx = test->priv;
+	struct kunit_resource *resources[num_res];
+
+	for (i = 0; i < num_res; i++) {
+		resources[i] = kunit_alloc_resource(&ctx->test,
+						    fake_resource_init,
+						    fake_resource_free,
+						    ctx);
+	}
+
+	kunit_cleanup(&ctx->test);
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static int kunit_test_init(struct kunit *test)
+{
+	struct kunit_test_context *ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	kunit_init_test(&ctx->test, "test_test_context");
+	return 0;
+}
+
+static void kunit_test_exit(struct kunit *test)
+{
+	struct kunit_test_context *ctx = test->priv;
+
+	kunit_cleanup(&ctx->test);
+	kfree(ctx);
 }
 
-static struct kunit_case test_test_cases[] = {
-	KUNIT_CASE(test_test_catches_segfault),
+static struct kunit_case kunit_test_cases[] = {
+	KUNIT_CASE(kunit_test_catches_segfault),
+	KUNIT_CASE(kunit_test_init_resources),
+	KUNIT_CASE(kunit_test_alloc_resource),
+	KUNIT_CASE(kunit_test_free_resource),
+	KUNIT_CASE(kunit_test_cleanup_resources),
 	{},
 };
 
-static struct kunit_module test_test_module = {
-	.name = "test-test",
-	.init = test_test_init,
-	.exit = test_test_exit,
-	.test_cases = test_test_cases,
+static struct kunit_module kunit_test_module = {
+	.name = "kunit-test",
+	.init = kunit_test_init,
+	.exit = kunit_test_exit,
+	.test_cases = kunit_test_cases,
 };
-module_test(test_test_module);
+module_test(kunit_test_module);
-- 
2.20.0.rc0.387.gc7a69e6b6c-goog

