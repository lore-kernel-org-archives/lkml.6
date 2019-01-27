Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0A8C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561222148D
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 09:44:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cCxh0pjZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfA0Jmz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 04:42:55 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38381 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726419AbfA0Jmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 04:42:55 -0500
Received: by mail-pl1-f193.google.com with SMTP id e5so6453436plb.5
        for <linux-kernel@vger.kernel.org>; Sun, 27 Jan 2019 01:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=se7BxVIyNFcNpVxegQ8rA3stfJpqK+Q8feAKjvC+8o8=;
        b=cCxh0pjZt9JNQXMBF5JTAvFYt3iSLnEzcEUVGy4QWwYqbJV5FZYk/3PGZXUxoW0I9S
         zfE2jg2eOo5IhLlq/G8ifY17KIxU9WIAizu5OANSyrZIyBQLvy7pP9+nONOr/ItliSvZ
         ekjYh+soAYoCLJP44Uy6ogtlaM6/YiTCnw4vo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=se7BxVIyNFcNpVxegQ8rA3stfJpqK+Q8feAKjvC+8o8=;
        b=nfQDqmajqG5heeD4StIhQ24naIsXmo1qf1CkUsFD6XsAr7qjvmY1nWPhLlZs7+lsOy
         zIhKC4PuvQmfUYh6GA/i+uhb4ME3L0yctU+rS5mqeltKpAf66Eqs/kMXUK6Op2NhTLGi
         M+jFlLTQefSjaiTgkoXF2+0DPxsmcsFYKJl0yNrQ5qnGGd4pAd+x6q80pbbJd5V3w9je
         /Q7Qg1I8JuSv9U97pIb7TiUJRFv/IAZK/c3MaDGtPGTatSXR220DCbquwFLpjRq+diE7
         3JxIb8253Lj8r5dRvZ3Q9i08JIUok/sPFHCYJqK34g+9r2xiYlM7hV5vl75NkoKk/jhN
         b90Q==
X-Gm-Message-State: AJcUukeMp46GaJ497qU8p3Q1ea7WFcJissM3X9d/sZyB67L0jst0SXiq
        YcqqaHxWWg14mkpNdfAT5I3BFA==
X-Google-Smtp-Source: ALg8bN7HSMa9Ovaoy2hKbA10DPN30A6ot4mxWcIjJCfKmDnvp+DlwW6Y3gCGtsNCeR2EhqUPQ7S8ag==
X-Received: by 2002:a17:902:74cc:: with SMTP id f12mr17808403plt.134.1548582174394;
        Sun, 27 Jan 2019 01:42:54 -0800 (PST)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id y5sm51388777pge.49.2019.01.27.01.42.52
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 27 Jan 2019 01:42:53 -0800 (PST)
Date:   Sun, 27 Jan 2019 01:42:51 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Shuah Khan <shuah@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        ndesaulniers@google.com
Subject: [PATCH] selftests/harness: Update named initializer syntax
Message-ID: <20190127094251.GA9391@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The harness was still using old-style GNU named initializer syntax.
Fix this so Clang will stop warning:

seccomp_bpf.c:2924:1: warning: use of GNU old-style field designator extension
      [-Wgnu-designator]
./../kselftest_harness.h:147:25: note: expanded from macro 'TEST'
                        ^
./../kselftest_harness.h:172:5: note: expanded from macro '__TEST_IMPL'
                  fn: &test_name, termsig: _signal }; \
                  ^

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 tools/testing/selftests/kselftest_harness.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/kselftest_harness.h b/tools/testing/selftests/kselftest_harness.h
index 76d654ef3234..2d90c98eeb67 100644
--- a/tools/testing/selftests/kselftest_harness.h
+++ b/tools/testing/selftests/kselftest_harness.h
@@ -168,8 +168,8 @@
 #define __TEST_IMPL(test_name, _signal) \
 	static void test_name(struct __test_metadata *_metadata); \
 	static struct __test_metadata _##test_name##_object = \
-		{ name: "global." #test_name, \
-		  fn: &test_name, termsig: _signal }; \
+		{ .name = "global." #test_name, \
+		  .fn = &test_name, .termsig = _signal }; \
 	static void __attribute__((constructor)) _register_##test_name(void) \
 	{ \
 		__register_test(&_##test_name##_object); \
@@ -304,9 +304,9 @@
 	} \
 	static struct __test_metadata \
 		      _##fixture_name##_##test_name##_object = { \
-		name: #fixture_name "." #test_name, \
-		fn: &wrapper_##fixture_name##_##test_name, \
-		termsig: signal, \
+		.name = #fixture_name "." #test_name, \
+		.fn = &wrapper_##fixture_name##_##test_name, \
+		.termsig = signal, \
 	 }; \
 	static void __attribute__((constructor)) \
 			_register_##fixture_name##_##test_name(void) \
-- 
2.17.1


-- 
Kees Cook
