Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id A5W8ND56GVt6OAAAmS7hNA
	; Thu, 07 Jun 2018 18:32:39 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id C217E6074D; Thu,  7 Jun 2018 18:32:39 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HvHAwbNP"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 29BE1606DD;
	Thu,  7 Jun 2018 18:32:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29BE1606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936316AbeFGSci (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 14:32:38 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:45728 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936302AbeFGSca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 14:32:30 -0400
Received: by mail-pl0-f66.google.com with SMTP id c23-v6so6653559plz.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 11:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MUMzXIPVobfzmQROoZfwZH3wW3WGc0fqs5NqVBmHC34=;
        b=HvHAwbNPFcEOvzEnRGtInMDr7M6n/7+GqO50EJJCbwpANlYXNd/kiVlxK0w7wOjJx3
         OenTnSXeIRSMTv4clXCFNiJARJra3TGUsIoYePHUD+lrfo8hm6tlsweAUJaXtEXUJ7HZ
         RnChLGfOv+/XK33clJwFmbfgNDybVLsz/v80tsRAPaqSr0N2weOPc0csOr0krVW2z1xy
         1NwxTNRjsjuT0ooA5GBQD6/Hm0+SygjfJSf9lpm/4dOJcLxnVgymDA3ogGNhORMRDst7
         yTVbJ/iZ9yK+gLgKw+8oizxQG4sVMVRGyCoeCDHYZHwldQqQpr0k/q8vGcepj4BDLhgK
         4AsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MUMzXIPVobfzmQROoZfwZH3wW3WGc0fqs5NqVBmHC34=;
        b=nNw7cjR2i6M22k/ZCOHnxaF1vwXrvWcl6zbj8rRfiMxR13xLHXLXq3VALfydlaLumd
         Z7P4wsI76SPKerMowyQ9yYnEERgOSzh/tl8lld0iMtR65HbcqV0rrK8z+/lQQ+H+l75R
         BiL7clTuv0wsZqNrfs9DN7qhK1QAVccIDBq+Hdqs2bZgCnkDodC+9OjcBj64R9WdurDz
         A/uVWhIDmswvD5BpKsbo2kHxE51lMcfQPv2ENq2veGW0JvUHQ90FyrD/3slv5bRY/+JH
         CZ99IsFxH3Oe8fOtCBkVPdXPXk6Y5IC+5x/IWKoSKeWQemIGVX7r+F8pbKrgs32g6qJb
         WhIA==
X-Gm-Message-State: APt69E3PJVPnGvNbiQiykXo0X6j6+1o7x/gTQVKVQ4fKW7lF9jdl/NNu
        osNbtBR4+ViVi3vAa0Ll9T8H1g==
X-Google-Smtp-Source: ADUXVKLPH1t/wzUALw4J3gthqHaSh9sRbB8SIbtO/2fZqZ4wOXfqWnJDgoxJUlFtINrst3yojFKCvA==
X-Received: by 2002:a17:902:2bc5:: with SMTP id l63-v6mr3053335plb.299.1528396349890;
        Thu, 07 Jun 2018 11:32:29 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id n76-v6sm6932739pfg.98.2018.06.07.11.32.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 11:32:29 -0700 (PDT)
From: Nick Desaulniers <ndesaulniers@google.com>
To: akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        mjg59@google.com, joe@perches.com
Subject: [PATCH v3 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
Date: Thu,  7 Jun 2018 11:32:17 -0700
Message-Id: <20180607183219.192973-2-ndesaulniers@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607183219.192973-1-ndesaulniers@google.com>
References: <20180607183219.192973-1-ndesaulniers@google.com>
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
Suggested-by: H. Peter Anvin <hpa@zytor.com>
Suggested-by: Joe Perches <joe@perches.com>
---
 include/linux/compiler-gcc.h | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index b4bf73f5e38f..3365f20dba5a 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -72,17 +72,22 @@
  * -Wunused-function.  This turns out to avoid the need for complex #ifdef
  * directives.  Suppress the warning in clang as well by using "unused"
  * function attribute, which is redundant but not harmful for gcc.
+ * Prefer gnu_inline, so that extern inline functions do not emit an
+ * externally visible function. This makes extern inline behave as per gnu89
+ * semantics rather than c99. This prevents multiple symbol definition errors
+ * of extern inline functions at link time.
  */
 #if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) ||		\
     !defined(CONFIG_OPTIMIZE_INLINING) || (__GNUC__ < 4)
-#define inline inline		__attribute__((always_inline,unused)) notrace
-#define __inline__ __inline__	__attribute__((always_inline,unused)) notrace
-#define __inline __inline	__attribute__((always_inline,unused)) notrace
+#define inline \
+	inline __attribute__((always_inline, unused, gnu_inline)) notrace
+#define __inline__ inline
+#define __inline inline
 #else
 /* A lot of inline functions can cause havoc with function tracing */
-#define inline inline		__attribute__((unused)) notrace
-#define __inline__ __inline__	__attribute__((unused)) notrace
-#define __inline __inline	__attribute__((unused)) notrace
+#define inline inline		__attribute__((unused, gnu_inline)) notrace
+#define __inline__ inline
+#define __inline inline
 #endif
 
 #define __always_inline	inline __attribute__((always_inline))
-- 
2.17.1.1185.g55be947832-goog
