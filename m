Return-Path: <SRS0=qqIy=KO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21577C43142
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:34:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF06C20857
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Jul 2018 21:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bZHNaaL8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF06C20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731899AbeG3XLV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Jul 2018 19:11:21 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:42383 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726867AbeG3XLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jul 2018 19:11:21 -0400
Received: by mail-oi0-f74.google.com with SMTP id w204-v6so12024025oib.9
        for <linux-kernel@vger.kernel.org>; Mon, 30 Jul 2018 14:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=7N31CAawBRwzBaHoYyiAt3wbZXaVwRjGL2r5AmRu8BQ=;
        b=bZHNaaL8DUsQNosIfFDkWtVJKEndMHIfIyISZKTyX2Og2gBpeYnb+HkUM66yYDjEwW
         MYVxiDYKpp4KCoyV1TmYVirsJvH2jCp6jSHg+SUjWDyw9izDxPMkdNFa6M97nyoVSNNG
         MEufgbgEfpkDc7EOjSgkkVZghUxXIiVGjHoPFfGzfeQ4fMQGeNUo5wxI+MqYShdYofP2
         Mx8njdROpwl0wr/LPfp2Xw877WOjYdN/FoFnReUkTaPga5v9nTVZHt4fonSZYUVstZ5+
         k4msCac/42d9NT1xo1Jq587mrwL/fzUpX1uwhF941wWjIfW5/BmSLPMS32N9nhL3Dvaq
         Zoiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=7N31CAawBRwzBaHoYyiAt3wbZXaVwRjGL2r5AmRu8BQ=;
        b=pqWkdYJvzystlytcLZ85txJ1SBOWDv58bb0cIWC866rA/eE+XD+iVXdekCFFR59g3s
         PAblqYWDC1I/VaKGn6p858jJtPsp66MPcySr2arV1/0BulKvlHT920vLA6K+DeUjQggR
         7F0tO3bgUQoqXaMMibnDq2lydn+TrLxW6kB6ILW9R0kApontCdOiSOAzxD/Au+ibbxPD
         IHau2YOEscv5MvKTEoBPdzmTNj7KVg/GAb8oWXMeTk3Yxoeu1nljaEkpKQKE9dSbB3Ce
         2z6xITcCo4+2sC/OJMcABwufg2ax9eAbQA4Kwx84oV0Et2UaxEUXwS3bJn9Z7SBwUY8y
         eDEg==
X-Gm-Message-State: AOUpUlGLk1NQDej2lhxebqdX9RoyDkazMve6SlYAcb2WVN3+9hUi4u6k
        OlaISQMTmBiRCEOV/0/29iWOr3XX7Akc0SrYrV8=
X-Google-Smtp-Source: AAOMgpcSqf6bJZSmVE8MsODJtlcBqc68tJxSmh86ttHqh0sFZMXeFwEwGJAYWfGlPxDfLT9tTLKPd9jgGdam95Y7SFw=
X-Received: by 2002:aca:4503:: with SMTP id s3-v6mr11296815oia.116.1532986465900;
 Mon, 30 Jul 2018 14:34:25 -0700 (PDT)
Date:   Mon, 30 Jul 2018 14:34:11 -0700
In-Reply-To: <20180730213412.242849-1-ndesaulniers@google.com>
Message-Id: <20180730213412.242849-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20180730213412.242849-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH v2 1/2] compiler-clang.h: Add CLANG_VERSION and __diag macros
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org, natechancellor@gmail.com
Cc:     arnd@arndb.de, paul.burton@mips.com, christophe.leroy@c-s.fr,
        shorne@gmail.com, yamada.masahiro@socionext.com,
        keescook@chromium.org, mingo@kernel.org,
        gregkh@linuxfoundation.org, tglx@linutronix.de,
        rdunlap@infradead.org, bp@suse.de, neilb@suse.com,
        linux-kernel@vger.kernel.org, aryabinin@virtuozzo.com,
        dwmw@amazon.co.uk, sandipan@linux.vnet.ibm.com,
        linux@rasmusvillemoes.dk, paullawrence@google.com,
        andreyknvl@google.com, will.deacon@arm.com, ghackmann@android.com,
        stable@vger.kernel.org, ghackmann@google.com, mka@chromium.org,
        jpoimboe@redhat.com, wvw@google.com, avagin@openvz.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are needed for doing proper version checks, though feature
detection via __has_attribute,  __has_builtin, and __has_feature should
be preferred, see:
https://clang.llvm.org/docs/LanguageExtensions.html#feature-checking-macros

Also adds __diag support, for generating compiler version specific
_Pragma()'s.

__diag support based on commit 8793bb7f4a9d ("kbuild: add macro for
controlling warnings to linux/compiler.h")

Cc: stable@vger.kernel.org # 4.17, 4.14, 4.9, 4.4
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 include/linux/compiler-clang.h | 19 +++++++++++++++++++
 include/linux/compiler_types.h |  4 ++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/compiler-clang.h b/include/linux/compiler-clang.h
index 7087446c24c8..9442e07a361e 100644
--- a/include/linux/compiler-clang.h
+++ b/include/linux/compiler-clang.h
@@ -7,6 +7,10 @@
  * for Clang compiler
  */
 
+#define CLANG_VERSION (__clang_major__ * 10000	\
+		       + __clang_minor__ * 100	\
+		       + __clang_patchlevel__)
+
 #ifdef uninitialized_var
 #undef uninitialized_var
 #define uninitialized_var(x) x = *(&(x))
@@ -46,3 +50,18 @@
     __has_builtin(__builtin_sub_overflow)
 #define COMPILER_HAS_GENERIC_BUILTIN_OVERFLOW 1
 #endif
+
+#define __diag_str1(s) #s
+#define __diag_str(s) __diag_str1(s)
+#define __diag(s) _Pragma(__diag_str(clang diagnostic s))
+#define __diag_CLANG_ignore ignored
+#define __diag_CLANG_warn warning
+#define __diag_CLANG_error error
+#define __diag_CLANG(version, severity, s) \
+	__diag_CLANG_ ## version(__diag_CLANG_ ## severity s)
+
+#if CLANG_VERSION >= 70000
+#define __diag_CLANG_7(s) __diag(s)
+#else
+#define __diag_CLANG_7(s)
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a8ba6b04152c..a04e6bd63476 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -279,6 +279,10 @@ struct ftrace_likely_data {
 #define __diag_GCC(version, severity, string)
 #endif
 
+#ifndef __diag_CLANG
+#define __diag_CLANG(version, severity, string)
+#endif
+
 #define __diag_push()	__diag(push)
 #define __diag_pop()	__diag(pop)
 
-- 
2.18.0.345.g5c9ce644c3-goog

