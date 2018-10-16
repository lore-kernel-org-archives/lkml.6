Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306B9C5ACCC
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E553B2087B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 23:54:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ubrWuUTt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E553B2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727655AbeJQHrE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 03:47:04 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:45793 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbeJQHrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 03:47:02 -0400
Received: by mail-qk1-f201.google.com with SMTP id s123-v6so25526135qkf.12
        for <linux-kernel@vger.kernel.org>; Tue, 16 Oct 2018 16:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=qCMB3fmL8RW2FIsxtQnM0B4a1KuW981wvpeU2rLEEcQ=;
        b=ubrWuUTt+zLu0Ttoi9FT1FxFTtzIg0tY/UoZu25xt9iDVBIuAa9bDH/YNOArK3efUq
         Ul+yBUWzSlLCAT1S2u8XiehSp1PdWTJJgxl/W2+BSa6BBURSNMpxJJ3+jcj73YySSq1I
         5+C3SrLZ8lWF+pfw0Dqkgw+aD8nn9wubggiCTnkiQhcavMEAkkq6mNZ6hs4m1WH8cIts
         x/tyRHU1drdYAW5nWdlBPtOTVvJfZ2Cy1A4Kd9pccZKJol8DTRo6BQx6W6jpWK0IQ27R
         7bZVu4RyDxk4k/UdGU2gLJW7gB7IbvC/bkRNJ8BSBe1YIgxt56QkuKZOhR9K7kCzfrFL
         eWfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=qCMB3fmL8RW2FIsxtQnM0B4a1KuW981wvpeU2rLEEcQ=;
        b=FP0lBa3phW2klkQrMGE+7RXm0tjslClsmk+uv8tlPFTWbSFhnQAbnZKlTVRHscb/Cv
         Cd9ZqM9HfjiJRjd4urpUPBCtfx09BBuH/P/J41j4iCTPSAW67hBGSAah0nayEIXniVig
         aCSkkhtGU44oL7bXvywUSNDya9kYTfFH4uVDqAE0a92wemOq+3Rkqaomk1cYHWiEePUw
         i7/TAFLk6afD2kWEa1/+wvpzc7yU6liSZthEY6jA/ZARcaWo2LHeCOeU4i0CWx+eJWOp
         zjo3oVHwgT6CURj/FvulyfOB2P5Kl35wJluyL2b84V2IS0+kxZADQdk5fQohNwxAPceb
         i3SQ==
X-Gm-Message-State: ABuFfoh2d3hhP3/r033Ekpuq5wIMVo7nTxgXPhnqkF0+2tHvAwna0v6O
        0dZywio3O+Pe2uyKWvngeAM9VYUa+mH1ulKlN470PQ==
X-Google-Smtp-Source: ACcGV638XMOy/Ffu7bY3flfOsNB7BxsnbCcBa1BVNU0gynFQlCvza9x/sIIIJIGOqlAphgLA6gtXViWigbl/A6krJCynaA==
X-Received: by 2002:a0c:8a17:: with SMTP id 23mr19940884qvt.49.1539734053222;
 Tue, 16 Oct 2018 16:54:13 -0700 (PDT)
Date:   Tue, 16 Oct 2018 16:51:00 -0700
In-Reply-To: <20181016235120.138227-1-brendanhiggins@google.com>
Message-Id: <20181016235120.138227-12-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20181016235120.138227-1-brendanhiggins@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC v1 11/31] kunit: test: added concept of post conditions
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

Adds a way to specify that certain conditions must be met at the end of
a test case.

Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 include/kunit/test.h |  6 ++++++
 kunit/test.c         | 13 ++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 58dbe2aee423f..be2b11117d1de 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -158,6 +158,11 @@ struct test_initcall {
 	void (*exit)(struct test_initcall *this);
 };
 
+struct test_post_condition {
+	struct list_head node;
+	void (*validate)(struct test_post_condition *condition);
+};
+
 /**
  * struct test - represents a running instance of a test.
  * @priv: for user to store arbitrary data. Commonly used to pass data created
@@ -177,6 +182,7 @@ struct test {
 	bool success; /* Protected by lock. */
 	bool death_test; /* Protected by lock. */
 	struct list_head resources; /* Protected by lock. */
+	struct list_head post_conditions;
 	void (*set_death_test)(struct test *test, bool death_test);
 	void (*vprintk)(const struct test *test,
 			const char *level,
diff --git a/kunit/test.c b/kunit/test.c
index 9737465fb0568..6ea60059b4918 100644
--- a/kunit/test.c
+++ b/kunit/test.c
@@ -125,8 +125,9 @@ static void __noreturn test_abort(struct test *test)
 
 int test_init_test(struct test *test, const char *name)
 {
-	spin_lock_init(&test->lock);
 	INIT_LIST_HEAD(&test->resources);
+	INIT_LIST_HEAD(&test->post_conditions);
+	spin_lock_init(&test->lock);
 	test->name = name;
 	test->set_death_test = test_set_death_test;
 	test->vprintk = test_vprintk;
@@ -186,6 +187,16 @@ static void test_run_case_cleanup(struct test *test,
 				  struct test_module *module,
 				  struct test_case *test_case)
 {
+	struct test_post_condition *condition, *condition_safe;
+
+	list_for_each_entry_safe(condition,
+				 condition_safe,
+				 &test->post_conditions,
+				 node) {
+		condition->validate(condition);
+		list_del(&condition->node);
+	}
+
 	if (module->exit)
 		module->exit(test);
 
-- 
2.19.1.331.ge82ca0e54c-goog

