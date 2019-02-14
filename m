Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E188FC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:39:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65DD21B68
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 21:39:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wR5UZ8Mn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440360AbfBNVi7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:38:59 -0500
Received: from mail-vk1-f201.google.com ([209.85.221.201]:56808 "EHLO
        mail-vk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393180AbfBNVi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Feb 2019 16:38:57 -0500
Received: by mail-vk1-f201.google.com with SMTP id q125so834955vka.23
        for <linux-kernel@vger.kernel.org>; Thu, 14 Feb 2019 13:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lFB3ckD9wxM7bLXj4FIGXk/8wLU/9JJW8w6AYqQ9grk=;
        b=wR5UZ8MnBfmgt0mrk9OI2zfDUhZY2FSpJFlc0H37jwgc96pBztb7fGKWTkoOFM28Ga
         QdMIu5N3UkjMmm7021TzRYk/cV1BnPbW4MtjUKPwt51uaE+fMNPFoimjbpRGCDHRC4qG
         rF/9HGEJTgXVmjERaYbSkHQNurtVfrADHvm+4f2etjUc19ab4p6e7BsAxhXpCzh2DVbh
         1qIqHUMYZmAhWwLj0wStuzKrlp2f5ArmCo8Pw4WHmaV0ubR/6cHsjshHUAlvy2ad4Zc7
         fT6+TNOikOpDCk2iZY9GB/1MB0KgGDOgjPxVqJZHudZCO4TukRT9wX0iqh4to7EcadBk
         jKQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lFB3ckD9wxM7bLXj4FIGXk/8wLU/9JJW8w6AYqQ9grk=;
        b=Jm9f1DiA9eAbUa4uZrWT/AVB53Xqs0u4f1+VUe18pJ+P2cSiekvKNa6v5HiF0Pu/CS
         D0IpvnCIgUitYnJX2tNaGW3QHXBrY0V2bjWfKDT41yTt1924rUC2kTNloZ3/Y/2h5upl
         ilQn8e++41KRv+ZPqNUExMi997Rls++qBu9EKIxmedDagsWMAsJ5Eqa6d+TQvO07w5Z4
         yNjZviCJrsbMzQAp898j0t/NwXtpkk956XIGQmWGPsueZkRpZ67kS3HnQifqFJgZKR6w
         hiPwowB40okr9lVwXk4xEdOgQjX7KA0oHYXipctEYqIb/Auj4HZZ4lI8vXfJ5s8d3Pv9
         RUGQ==
X-Gm-Message-State: AHQUAuZpu0HCosVa/8jS0AnHoP9XlugOrNCUQu2zMkScwN/0m0/7qfvG
        m/xrgSpJqWhGdKnnYZcojRkGWFDa+UnLwgBvG2obrw==
X-Google-Smtp-Source: AHgI3IZSFaDNk0CEH4L9GvdAED7vCeS8gXXQOioZtPpSgMCEqNw/swX6iIzcGwBJejpW5Xow4Gqbz47ePA5Svka1+dm8fw==
X-Received: by 2002:ac5:c203:: with SMTP id m3mr3934061vkk.19.1550180335945;
 Thu, 14 Feb 2019 13:38:55 -0800 (PST)
Date:   Thu, 14 Feb 2019 13:37:22 -0800
In-Reply-To: <20190214213729.21702-1-brendanhiggins@google.com>
Message-Id: <20190214213729.21702-11-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20190214213729.21702-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.21.0.rc0.258.g878e2cd30e-goog
Subject: [RFC v4 10/17] kunit: test: add test managed resource tests
From:   Brendan Higgins <brendanhiggins@google.com>
To:     keescook@google.com, mcgrof@kernel.org, shuah@kernel.org,
        robh@kernel.org, kieran.bingham@ideasonboard.com,
        frowand.list@gmail.com
Cc:     gregkh@linuxfoundation.org, joel@jms.id.au, mpe@ellerman.id.au,
        joe@perches.com, brakmo@fb.com, rostedt@goodmis.org,
        Tim.Bird@sony.com, khilman@baylibre.com, julia.lawall@lip6.fr,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, jdike@addtoit.com, richard@nod.at,
        linux-um@lists.infradead.org, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, dan.j.williams@intel.com,
        linux-nvdimm@lists.01.org, knut.omang@oracle.com,
        devicetree@vger.kernel.org, pmladek@suse.com,
        Alexander.Levin@microsoft.com, amir73il@gmail.com,
        dan.carpenter@oracle.com, wfg@linux.intel.com,
        Brendan Higgins <brendanhiggins@google.com>,
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
 kunit/test-test.c | 121 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)

diff --git a/kunit/test-test.c b/kunit/test-test.c
index 0b4ad6690310d..bb34431398526 100644
--- a/kunit/test-test.c
+++ b/kunit/test-test.c
@@ -127,3 +127,124 @@ static struct kunit_module kunit_try_catch_test_module = {
 	.test_cases = kunit_try_catch_test_cases,
 };
 module_test(kunit_try_catch_test_module);
+
+/*
+ * Context for testing test managed resources
+ * is_resource_initialized is used to test arbitrary resources
+ */
+struct kunit_test_resource_context {
+	struct kunit test;
+	bool is_resource_initialized;
+};
+
+static int fake_resource_init(struct kunit_resource *res, void *context)
+{
+	struct kunit_test_resource_context *ctx = context;
+
+	res->allocation = &ctx->is_resource_initialized;
+	ctx->is_resource_initialized = true;
+	return 0;
+}
+
+static void fake_resource_free(struct kunit_resource *res)
+{
+	bool *is_resource_initialized = res->allocation;
+
+	*is_resource_initialized = false;
+}
+
+static void kunit_resource_test_init_resources(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_init_test(&ctx->test, "testing_test_init_test");
+
+	KUNIT_EXPECT_TRUE(test, list_empty(&ctx->test.resources));
+}
+
+static void kunit_resource_test_alloc_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
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
+static void kunit_resource_test_free_resource(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
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
+#define KUNIT_RESOURCE_NUM 5
+static void kunit_resource_test_cleanup_resources(struct kunit *test)
+{
+	int i;
+	struct kunit_test_resource_context *ctx = test->priv;
+	struct kunit_resource *resources[KUNIT_RESOURCE_NUM];
+
+	for (i = 0; i < KUNIT_RESOURCE_NUM; i++) {
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
+static int kunit_resource_test_init(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx =
+			kzalloc(sizeof(*ctx), GFP_KERNEL);
+
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	kunit_init_test(&ctx->test, "test_test_context");
+	return 0;
+}
+
+static void kunit_resource_test_exit(struct kunit *test)
+{
+	struct kunit_test_resource_context *ctx = test->priv;
+
+	kunit_cleanup(&ctx->test);
+	kfree(ctx);
+}
+
+static struct kunit_case kunit_resource_test_cases[] = {
+	KUNIT_CASE(kunit_resource_test_init_resources),
+	KUNIT_CASE(kunit_resource_test_alloc_resource),
+	KUNIT_CASE(kunit_resource_test_free_resource),
+	KUNIT_CASE(kunit_resource_test_cleanup_resources),
+	{},
+};
+
+static struct kunit_module kunit_resource_test_module = {
+	.name = "kunit-resource-test",
+	.init = kunit_resource_test_init,
+	.exit = kunit_resource_test_exit,
+	.test_cases = kunit_resource_test_cases,
+};
+module_test(kunit_resource_test_module);
-- 
2.21.0.rc0.258.g878e2cd30e-goog

