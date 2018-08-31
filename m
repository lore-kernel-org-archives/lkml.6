Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9DBC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3351120839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONd6gx8y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3351120839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbeHaVN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:13:57 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45981 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727864AbeHaVN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:13:57 -0400
Received: by mail-wr1-f66.google.com with SMTP id 20-v6so11832730wrb.12
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:05:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fVWnnBzr0I1OKw6LtVCSpWDTlwLCxb+fZtKMlf89mRY=;
        b=ONd6gx8yQSiI4I5TSERfj26rU2n+lJb7UhpBmIBqqCrgH8/uB9bX8N1JCLYRMAvyX8
         mH5trdDAAOFwhw/TWKfX/GC5Rf6+eZRuybRsNwId8fHCZgory6rdcVOkBN5s2uSAIwI8
         RPCVKDbBX/tpJucO5NqIixX+zXQaasLDtDL2xfBCD2ABNa70A/0/A5ovm50b9aWwoM+j
         2o+JKlTYc0vpEyF5OqqcxPLcoOUxq/o1IvQUMnjy4eHCe04w5mv+6ArtktLYH+xkmmi1
         gY63ekESCArzvFaqtAyyLgW3s/atlPlfBGi3Z7w2Ouzj3LGej2CQJtqUyLTU84bpuh5G
         Fzog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fVWnnBzr0I1OKw6LtVCSpWDTlwLCxb+fZtKMlf89mRY=;
        b=CEwUwiLDGCLuv7WdY3jjSY+AwKNzeu08CnPtQOA3eRnbNk0LeRoqHX7udbpp8BfBnZ
         swRy0neQ5/XXcJ+0raeMtD+g9/2OSM/zvG8shvzwHBq4VFisdLb5Wi4GP63pYboE2G10
         N4RchzaVkPmGcAYzTF0EstB3iGmt/VCAXV0ZmLEj7C1SKY4cbvM+2lvl+oZ2yP6jO3Lf
         sfTJ/kz9yj1z6yuMyFKpWnSbAssQeWFkwI5mrrg6JagkBX5DfDSTinchqLm8GcABdq/o
         fAUBUUugz0pmKufucXQIRxbySjBB0sQYj6DykhJthP/XSw4PwXKVgbYUA1y5gxvuNcvu
         bTjQ==
X-Gm-Message-State: APzg51Ay/NOeYWsm6BV/obM+Ms9Tfb7p4Z2R3u3FKWLsRN+MdCmNd8m4
        KvBkAfrZq3RvNe7frEo5XlQ=
X-Google-Smtp-Source: ANB0VdZxtFS9dbZ+XXNeGIPomDa81L5LHX1Dl4AA92Iok4X2yljJq2S5dADX3BWVA9fuKb3GH1DDaQ==
X-Received: by 2002:a5d:6908:: with SMTP id t8-v6mr12317879wru.170.1535735131307;
        Fri, 31 Aug 2018 10:05:31 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id c19-v6sm11280332wre.86.2018.08.31.10.05.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:05:30 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Eli Friedman <efriedma@codeaurora.org>,
        Christopher Li <sparse@chrisli.org>,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Joe Perches <joe@perches.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 6/7] Compiler Attributes: remove unneeded sparse (__CHECKER__) tests
Date:   Fri, 31 Aug 2018 19:05:13 +0200
Message-Id: <20180831170514.24665-6-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
References: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse knows about a few more attributes now, so we can remove
the __CHECKER__ conditions from them (which, in turn, allow us
to move some of them later on to compiler_attributes.h).

  * assume_aligned: since sparse's commit ffc860b ("sparse:
    ignore __assume_aligned__ attribute"), included in 0.5.1

  * error: since sparse's commit 0a04210 ("sparse: Add 'error'
    to ignored attributes"), included in 0.5.0

  * hotpatch: since sparse's commit 6043210 ("sparse/parse.c:
    ignore hotpatch attribute"), included in 0.5.1

  * warning: since sparse's commit 977365d ("Avoid "attribute
    'warning': unknown attribute" warning"), included in 0.4.2

Cc: Eli Friedman <efriedma@codeaurora.org>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Joe Perches <joe@perches.com>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 6 ++----
 include/linux/compiler_types.h | 2 +-
 2 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index fdf2fbe6d544..32e6ce06163f 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -84,14 +84,12 @@
 
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
-#ifndef __CHECKER__
 #define __compiletime_warning(message) __attribute__((warning(message)))
 #define __compiletime_error(message) __attribute__((error(message)))
 
-#ifdef LATENT_ENTROPY_PLUGIN
+#if defined(LATENT_ENTROPY_PLUGIN) && !defined(__CHECKER__)
 #define __latent_entropy __attribute__((latent_entropy))
 #endif
-#endif /* __CHECKER__ */
 
 /*
  * calling noreturn functions, __builtin_unreachable() and __builtin_trap()
@@ -139,7 +137,7 @@
 
 /* gcc version specific checks */
 
-#if GCC_VERSION >= 40900 && !defined(__CHECKER__)
+#if GCC_VERSION >= 40900
 /*
  * __assume_aligned(n, k): Tell the optimizer that the returned
  * pointer can be assumed to be k modulo n. The second argument is
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3662b19599fc..5dddc7e0c607 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -216,7 +216,7 @@ struct ftrace_likely_data {
 #define __must_check
 #endif
 
-#if defined(CC_USING_HOTPATCH) && !defined(__CHECKER__)
+#if defined(CC_USING_HOTPATCH)
 #define notrace			__attribute__((hotpatch(0, 0)))
 #else
 #define notrace			__attribute__((no_instrument_function))
-- 
2.17.1

