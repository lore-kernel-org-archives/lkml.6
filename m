Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id xQY9FWyaGVujIwAAmS7hNA
	; Thu, 07 Jun 2018 20:50:04 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 4CAEE608CD; Thu,  7 Jun 2018 20:50:04 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V20V+yVH"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 1D620606DD;
	Thu,  7 Jun 2018 20:50:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1D620606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932632AbeFGUuB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:50:01 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34153 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932595AbeFGUt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:49:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id g20-v6so6886126plq.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 13:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ajVCbUL1zYj2BBf5z9RQTGIReuirO/b3dkFEYOD35rI=;
        b=V20V+yVHGYpEkfVaydTdIsMX7c7IGW4jOk2/8ABLMLP+8TlPzkZqSr2XqIXu+UBOlP
         9IchrQ11tzYidl3dQfVmCscwlymyIFQ7pmNNP2tJT8J5rbr4uJHZGqyhHjL8d8Kfrg0e
         zAPrzowv3+G0muqRC9azojfqxpkvgAq4QjzT4c83XYlD4VkGdW0LkD9GZO44YmPy9/uy
         SPzfxku9l/8R6omD4H239ZNGTFgj9BLakFDcQCitYxsIKEBroyoUKbcFSzbuQ1R48iZp
         ZFIUnucZaVFbV8BqtkN80nCLkFZs/1ndRpukSUhTkGqEqJkUejcENk/29PvKvEvfqiFY
         P4GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ajVCbUL1zYj2BBf5z9RQTGIReuirO/b3dkFEYOD35rI=;
        b=o1VeKJ8pCoOpHGEXJiTKiy6tkQ9IeHErZdtTbTyVTXGx5jCvTre+ixaXEGVpTSpSxS
         nkkXw4BaJKnVSwtrczS1xiwFiFvuuos+KYNMV8Vz5cXJrbVNzg1VIoFFHmj3w6tluxdc
         rB59DH14vTJqtps87WNDZOawo69gjCcmEFqvvxlPUfTvKGej48zPVmDX3K+iW/sTSOBn
         HueXP7ajWR8kR4aZDvKlBStZ8lrv5s3tqEjSEbzeNGpLqnUJN+ZN26XO8wXXGI3D8azI
         yrcUqTplsPttlZU9isEBtI87qiW5+UGKG+NSTdsYcXSjtChUldsbxN5iFNLfxGgibBm+
         vEqw==
X-Gm-Message-State: APt69E32Y2N//fK3xNp4LHrmJmxLk1i3GJqgbYEokIWHR0/GIZ68uzD2
        ZyI2pelXpCKI47SKm1N9qYQWUw==
X-Google-Smtp-Source: ADUXVKKCVX5k5PfIrdPgPZaONkYeybz79QviaRAg6O99cn2EmCpjOx5EKKynoeglrBIWrO2wnPd7Bw==
X-Received: by 2002:a17:902:1e2:: with SMTP id b89-v6mr3531386plb.279.1528404595523;
        Thu, 07 Jun 2018 13:49:55 -0700 (PDT)
Received: from ndesaulniers0.svl.corp.google.com ([2620:15c:2a3:1:d33:166f:5b79:14b3])
        by smtp.gmail.com with ESMTPSA id w18-v6sm3780460pgq.1.2018.06.07.13.49.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 13:49:54 -0700 (PDT)
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
Subject: [PATCH v4 1/3] compiler-gcc.h: add gnu_inline to all inline declarations
Date: Thu,  7 Jun 2018 13:49:25 -0700
Message-Id: <20180607204927.219329-2-ndesaulniers@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
In-Reply-To: <20180607204927.219329-1-ndesaulniers@google.com>
References: <20180607204927.219329-1-ndesaulniers@google.com>
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
 include/linux/compiler-gcc.h | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index b4bf73f5e38f..0c79c588e572 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -72,19 +72,22 @@
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
+	inline __attribute__((always_inline, unused, gnu_inline)) notrace
 #else
-/* A lot of inline functions can cause havoc with function tracing */
-#define inline inline		__attribute__((unused)) notrace
-#define __inline__ __inline__	__attribute__((unused)) notrace
-#define __inline __inline	__attribute__((unused)) notrace
+#define inline inline		__attribute__((unused, gnu_inline)) notrace
 #endif
 
+#define __inline__ inline
+#define __inline inline
 #define __always_inline	inline __attribute__((always_inline))
 #define  noinline	__attribute__((noinline))
 
-- 
2.17.1.1185.g55be947832-goog
