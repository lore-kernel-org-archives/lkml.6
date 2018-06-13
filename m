Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 464A5C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDD3B208D7
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 21:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KO2U2C7k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDD3B208D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935891AbeFMVFn (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 17:05:43 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:41093 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935861AbeFMVFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 17:05:38 -0400
Received: by mail-pl0-f67.google.com with SMTP id w8-v6so707052ply.8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jun 2018 14:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=TYSMRmk9ZLyT2hFFQ7TsTtjMbwZ/vaewiEECYeIXRoU=;
        b=KO2U2C7kHoXiqhneZzsEcwESWRTfF3inZJo7fPB8pij8zN+C7q9NO9enxc4I/Kj7dv
         O4ofGoYPRTtIQEaY5jkv2C7B1E3DY9yxM2qhUir6lu5WLpXKe+wK03N/iX0V4VmlvL1H
         f1EJmVRjliiIfj+pct547Sm4hfai87j/WiK8kXoYyv/EgW9ju4zlGscJM5IO0NpJrYZw
         /iEnCH4klRxH8lUAwDnoO0JMUHlKio5juDJrmZN44XzrlJK5TAP2halWgeg8GGes+nJ2
         qlWy3LfcxyGg1nw4oQMcumQfg4RmXUFzYZzc3tjpcCliwCxivXBAKUxvyiHTasI3IhWp
         WQ4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=TYSMRmk9ZLyT2hFFQ7TsTtjMbwZ/vaewiEECYeIXRoU=;
        b=aKehZUTysh7u8z95gKi03ULCmypgUtNqVpG/QGqmrG2rdXYDabMVWhCwB7YtMaB9U8
         EAw77phyOuqHZhvtW2h9qfEo+3/IjcWMOnhszumwW56Bu6iHqKsjbHE6HAPlw7o/+a+n
         Du2afftbnZ075bcw1OmTmGlelrsLf/csbNSGdm2yLlpRVeVsU1fW3oesC/C34GF7m/2q
         z/yt5lS2VEbtcWumG/keMSWkAV/Gu87a7JErQpu1qfvd+Ak88y3ccpH5SVjY4x2yiUX/
         i1AKAq/A8PqRrLqc7xL7NVbulvbMB31WcMrNsKWkzGSYu4JGZ9YM0mPrqJsTazQTiTSi
         DBLQ==
X-Gm-Message-State: APt69E0ZEyKPKeueoHyYqrlDiq2GSGScwDMtpTc695c7Tsru7vBn1N1U
        x9XuiA0UyTtlGV1TIiqfCEWSHw==
X-Google-Smtp-Source: ADUXVKIZ7+jpltllCx6QC3R3jNxSWAW+CNnE/OQKQ3lFsrc0j1ozNTHkepAITDkvsNRsdkV+I0cQ+g==
X-Received: by 2002:a17:902:3124:: with SMTP id w33-v6mr6744472plb.235.1528923937264;
        Wed, 13 Jun 2018 14:05:37 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id n76-v6sm8692976pfg.98.2018.06.13.14.05.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Jun 2018 14:05:36 -0700 (PDT)
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Subject: [PATCH v5 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
Date:   Wed, 13 Jun 2018 14:05:16 -0700
Message-Id: <20180613210518.113983-2-ndesaulniers@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
In-Reply-To: <20180613210518.113983-1-ndesaulniers@google.com>
References: <20180613210518.113983-1-ndesaulniers@google.com>
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
2.18.0.rc1.244.gcf134e6275-goog

