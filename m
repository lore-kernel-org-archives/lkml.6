Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22430C43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7CAD20989
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 16:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t3zuQvQz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7CAD20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933477AbeFUQXk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 12:23:40 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:35382 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933417AbeFUQXf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 12:23:35 -0400
Received: by mail-qt0-f201.google.com with SMTP id a10-v6so2932783qtp.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jun 2018 09:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=/vQmHl8cd2NT8hl07OE94mYUyQt2yjyU18WcKiSTNXc=;
        b=t3zuQvQz0nhoKtkxb/zaSWjV1xb+x/+sou3GorvnWq06x7zhVhUqbt/zHauWLLqS9A
         up7wDGzzZ9tVW0cydrETItaN4dGoA+320bX3bm1qaJMG6CPGTzj4NIJpQPe5gtumSuBM
         8kDGCBDAn/SvRMKDh9T7Qz5zx0Tt10jQgqP41OHAREugwAciZwhXTzRzWUyRQxMR/NmR
         vuzICd6iuvf8eeT/Jjc8vx3u8I7pRaBxr6b/6GiZL1+LD0+Ii9LHeJWBtCgC/UW9lYTU
         hfcjn+OXuSX1D8MOqaEZ6HBMmo2rXVOxMBrkQH0zC3K5PK91+PCi/8jat1awbRHjnrdI
         46lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=/vQmHl8cd2NT8hl07OE94mYUyQt2yjyU18WcKiSTNXc=;
        b=jnpIw+JZn5yrgVHLxfMPjXXc5kJcaHQ7TEsxwpWyd6jRUQp++CFocbReMh3R+UgGvG
         w8kuiJ3tlhDl0sqgt0Qu4RxdOjw3FhWW6JuC6nS+Z6PoZNqPszbYayxkzOIzcOy2aSb0
         HIw/aThKVwgdLwvmYi+Q6SawXhVA8IYTY2X4XkwU7usk8dcO5AlyYArc+uEcoATzJLwx
         OY5AHIEkp7/yHPMTdSAWXJEMcEm7cy3Y2JMyzMeiRHCkbri55TflX3SBDLJ6JKFC5ih/
         wXB/Lk23viQYg5glD1tUSeGQQlAoMuShYfHytmiGJzs7czViIHXxKGhFpx+cmqFMZ5k0
         n04g==
X-Gm-Message-State: APt69E2SafciaaOoQAJK9qUDYHXn6yFEGPdhxi2LYw/LBacfM8u1I++O
        zShl0NEjoZ1LZWJPmDzjVxyQKEzUvOGPKqcUjOk=
X-Google-Smtp-Source: ADUXVKJSWC1eDCch2QV7phR6Iez+/IhWRJhSdLMrAZ0OsF6ErYJXMNegfe6cDog0v/FHE6YH5UeGnYq7GVnIprhHldk=
MIME-Version: 1.0
X-Received: by 2002:ac8:4508:: with SMTP id q8-v6mr14100098qtn.39.1529598214186;
 Thu, 21 Jun 2018 09:23:34 -0700 (PDT)
Date:   Thu, 21 Jun 2018 09:23:22 -0700
In-Reply-To: <20180621162324.36656-1-ndesaulniers@google.com>
Message-Id: <20180621162324.36656-2-ndesaulniers@google.com>
References: <20180621162324.36656-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v6 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     mingo@redhat.com, tglx@linutronix.de
Cc:     akpm@linux-foundation.org, hpa@zytor.com,
        linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, mka@chromium.org,
        ndesaulniers@google.com, thomas.lendacky@amd.com, tweek@google.com,
        mjg59@google.com, joe@perches.com,
        andrea.parri@amarulasolutions.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Functions marked extern inline do not emit an externally visible
function when the gnu89 C standard is used. Some KBUILD Makefiles
overwrite KBUILD_CFLAGS. This is an issue for GCC 5.1+ users as without
an explicit C standard specified, the default is gnu11. Since c99, the
semantics of extern inline have changed such that an externally visible
function is always emitted. This can lead to multiple definition errors
of extern inline functions at link time of compilation units whose build
files have removed an explicit C standard compiler flag for users of GCC
5.1+ or Clang.

Acked-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Joe Perches <joe@perches.com>
---
 include/linux/compiler-gcc.h | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index b4bf73f5e38f..c7cfca4ba02b 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -65,6 +65,18 @@
 #define __must_be_array(a)	BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
 #endif
 
+/*
+ * Feature detection for gnu_inline (gnu89 extern inline semantics). Either
+ * __GNUC_STDC_INLINE__ is defined (not using gnu89 extern inline semantics,
+ * and we opt in to the gnu89 semantics), or __GNUC_STDC_INLINE__ is not
+ * defined so the gnu89 semantics are the default.
+ */
+#ifdef __GNUC_STDC_INLINE__
+#define __gnu_inline	__attribute__((gnu_inline))
+#else
+#define __gnu_inline
+#endif
+
 /*
  * Force always-inline if the user requests it so via the .config,
  * or if gcc is too old.
@@ -72,19 +84,22 @@
  * -Wunused-function.  This turns out to avoid the need for complex #ifdef
  * directives.  Suppress the warning in clang as well by using "unused"
  * function attribute, which is redundant but not harmful for gcc.
+ * Prefer gnu_inline, so that extern inline functions do not emit an
+ * externally visible function. This makes extern inline behave as per gnu89
+ * semantics rather than c99. This prevents multiple symbol definition errors
+ * of extern inline functions at link time.
+ * A lot of inline functions can cause havoc with function tracing.
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
     !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
-#define inline inline		__attribute__((always_inline,unused)) notrace
-#define __inline__ __inline__	__attribute__((always_inline,unused)) notrace
-#define __inline __inline	__attribute__((always_inline,unused)) notrace
+#define inline \
+	inline __attribute__((always_inline, unused)) notrace __gnu_inline
 #else
-/* A lot of inline functions can cause havoc with function tracing */
-#define inline inline		__attribute__((unused)) notrace
-#define __inline__ __inline__	__attribute__((unused)) notrace
-#define __inline __inline	__attribute__((unused)) notrace
+#define inline inline		__attribute__((unused)) notrace __gnu_inline
 #endif
 
+#define __inline__ inline
+#define __inline inline
 #define __always_inline	inline __attribute__((always_inline))
 #define  noinline	__attribute__((noinline))
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

