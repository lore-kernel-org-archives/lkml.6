Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-21.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D996C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D4232186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZBVmQgwn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbfBKTal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:30:41 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:33427 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388240AbfBKTak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:30:40 -0500
Received: by mail-pl1-f201.google.com with SMTP id o23so69260pll.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=d5X1DHNjDUb5NLL3O4YMEIQYPjCFJAnKD/tNSL5RNTA=;
        b=ZBVmQgwn6wPvQ808Q2qhEWWaFjM6+9X1q8IZ4ZIKeyEJduZfSgRN2FFUZoJEnmFB61
         2izQC8j/FEojBJj296AnNPhLv0IHe8E/75uimTQC+TQnX9aMXrNSlUNjZNg56yooRaO3
         LiGHDs/lGY3lEEWv4ziLOkQSDdDXbM9uCuY/bJ1px4k5FfpKNqeLnjCcldjnuDEaeP1a
         +Z0PuNJIMAGlUG0CtpTgdrTQo/fErysoynGFb9yZi+Qk1oiC93I3p2jnrcTrBRflFBW9
         Q5bvbEwRTjz3Rb5FX/HMP5FfhF7CmjZrBR8lM5fozm4sNYfqsPTTIpmougO9/NdQOWik
         vYVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=d5X1DHNjDUb5NLL3O4YMEIQYPjCFJAnKD/tNSL5RNTA=;
        b=J2SaVCLX8+k0Wjt3Fbr2ay7w0ryA6/TapJZxxO3F2EAMAlYEwkXZX9CruPLcSthk9+
         rTzC9cpBCyeS/f0MWhD8hVhJpZ4l56nC1ftAhYyzrPp5ujdqVSNmvAlz5a7yLs3yH/24
         TUG5NB2iErWa/Z1LLTw6nkRR9VRYDnzxYlBtW8KGK6dskmwcBjoLSGRJW0yod43+om5v
         6wF6c4bHowKqOSgdVEr8vscQvCkvQAit2FGvvvr/zqP7qYoUccv4vw138ctncnLm7f9+
         nFD+7RCKapihZLXlko6upVmg3w6Evp1hD0uLBxXcCjDNFwDtweb2xEBiJeEoFTeC/Dtw
         OJXg==
X-Gm-Message-State: AHQUAub8FmaVWXdDEPqG7eNGjupoGIUKG+gHuqYk/6Q9/u5P9r0T5895
        F2FH6INgCEKpRZlFVeWwnxk6VVD0vzRiUpVqcuA=
X-Google-Smtp-Source: AHgI3Ib3P7TggZpwqevlzSKuItbQf2rXHsRRYH3FFQnxMn84Vtvz0Kpep/2mKvDgaWdyk6EZ2VrQF8XPawp0tYV1UB0=
X-Received: by 2002:aa7:8acb:: with SMTP id b11mr1064903pfd.72.1549913438630;
 Mon, 11 Feb 2019 11:30:38 -0800 (PST)
Date:   Mon, 11 Feb 2019 11:30:04 -0800
In-Reply-To: <20190211193008.24101-1-ndesaulniers@google.com>
Message-Id: <20190211193008.24101-2-ndesaulniers@google.com>
Mime-Version: 1.0
References: <20190211193008.24101-1-ndesaulniers@google.com>
X-Mailer: git-send-email 2.20.1.791.gb4d0f1c61a-goog
Subject: [PATCH v2 2/4] Makefile: clang: choose GCC_TOOLCHAIN_DIR not on LD
From:   ndesaulniers@google.com
To:     yamada.masahiro@socionext.com
Cc:     natechancellor@gmail.com, sedat.dilek@gmail.com,
        keescook@chromium.org, samitolvanen@google.com,
        michal.lkml@markovi.net, akpm@linux-foundation.org,
        hannes@cmpxchg.org, peterz@infradead.org,
        linux@dominikbrodowski.net, npiggin@gmail.com,
        mathieu.desnoyers@efficios.com, gor@linux.ibm.com, adrian@lisas.de,
        rgb@redhat.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This causes an issue when trying to build with `make LD=ld.lld` if
ld.lld and the rest of your cross tools aren't in the same directory
(ex. /usr/local/bin) (as is the case for Android's build system), as the
GCC_TOOLCHAIN_DIR then gets set based on `which $(LD)` which will point
where LLVM tools are, not GCC/binutils tools are located.

Instead, select the GCC_TOOLCHAIN_DIR based on another tool provided by
binutils for which LLVM does not provide a substitute for, such as
elfedit.

Fixes commit 785f11aa595b ("kbuild: Add better clang cross build support")

Link: https://github.com/ClangBuiltLinux/linux/issues/341
Suggested-by: Nathan Chancellor <natechancellor@gmail.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Tested-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
Changes V1->V2:
* add reviewed and tested tags.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 86cf35d1d79d..d3b65e96d183 100644
--- a/Makefile
+++ b/Makefile
@@ -492,7 +492,7 @@ endif
 ifneq ($(shell $(CC) --version 2>&1 | head -n 1 | grep clang),)
 ifneq ($(CROSS_COMPILE),)
 CLANG_FLAGS	:= --target=$(notdir $(CROSS_COMPILE:%-=%))
-GCC_TOOLCHAIN_DIR := $(dir $(shell which $(LD)))
+GCC_TOOLCHAIN_DIR := $(dir $(shell which $(CROSS_COMPILE)elfedit))
 CLANG_FLAGS	+= --prefix=$(GCC_TOOLCHAIN_DIR)
 GCC_TOOLCHAIN	:= $(realpath $(GCC_TOOLCHAIN_DIR)/..)
 endif
-- 
2.20.1.791.gb4d0f1c61a-goog

