Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01928C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FFE120869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KevZ8PIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FFE120869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbeIDAzl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:41 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50759 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbeIDAzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:41 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so2269535wmc.0;
        Mon, 03 Sep 2018 13:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZhryjHGsWzeSzxD0NW3OWSaZ8RANYxnQY/DMq4IP8+M=;
        b=KevZ8PILOJ52LFCPLGi6B7+4pQstK7gmLMNbSBzIkDwJzNW0MelnEvLkzfJsKtNTse
         2Wgo1/Plo0uWL9xQ7KjW0HhsOnPR0d5H8jRl/5cPxJrv72bYm2eC8wGhqclf0CKSugc5
         1SkrfX0rIt72u3eIKpArRrOR9OvT8Dhpc96U/U50ycGtvTS/xTOZK1CivenSl5MW5mUX
         lSAev42Wt1gVVCNWquD4FPhhzf8tH3MA4WLCx8EqPGlp2oQ4ArdmfbdLNMBy6O8jUKSC
         DMyPNQtgL4Txw6gif4G7XSITir8fBeqCnPFxEWTvI3ud7mr0VZAO6Hk4AnbDcCgOZyOi
         fuVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZhryjHGsWzeSzxD0NW3OWSaZ8RANYxnQY/DMq4IP8+M=;
        b=Oz1egg4gko+g67NIEyp0hV06b1h+sXqvXF3MDnT9ci4XRayXhtofVor7dMOWfGNZxh
         7nezSpeIzSye8A6fjO39LH20bjSL63F/E13QspXqSDyNF9YngF092wrDEDQRspYVoRJM
         6nn//dP4nVGVNCUsW7duXsYbnlZj0V8jtX65/WEgwD4L6/F+zziz8we8AX1SkzLXIMHS
         4Ee8vTCD4BX3sI9KQzLktGGow7AvUg6651WGOZvnJu4eL1r7621aALtq8JqWC7DTgKZ9
         /GkNG8EOwZqnokSmZQRcdsM09n9z+uoZcrn6/qPUp/ZdCtKjKjz5NyB0jKQ4eXiUiLjl
         06pQ==
X-Gm-Message-State: APzg51CID8tbFfarh2NNFdKX3RupGTWGpeVLad8rEKHMbO50ndPayf2O
        +f1xXssayuEhs75nBytj96E=
X-Google-Smtp-Source: ANB0VdYbX5Oa31laIZImtJpmZTii5ksCZCkd6tq0A71C7EaK6DpActd73FsXCpmzoGW/IY1HgP78vg==
X-Received: by 2002:a1c:d946:: with SMTP id q67-v6mr5934162wmg.156.1536006828434;
        Mon, 03 Sep 2018 13:33:48 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.33.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:33:47 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
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
        linux-sparse@vger.kernel.org
Subject: [PATCH 01/12] Compiler Attributes: remove unused attributes
Date:   Mon,  3 Sep 2018 22:33:05 +0200
Message-Id: <20180903203316.16183-2-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__optimize and __deprecate_for_modules are unused in
the whole kernel tree. Simply drop them.

Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h   | 2 --
 include/linux/compiler.h       | 4 ----
 include/linux/compiler_types.h | 1 -
 3 files changed, 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 763bbad1e258..0a2d06677d83 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -95,8 +95,6 @@
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-#define __optimize(level)	__attribute__((__optimize__(level)))
-
 #define __compiletime_object_size(obj) __builtin_object_size(obj, 0)
 
 #ifndef __CHECKER__
diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 681d866efb1e..7c0157d50964 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -301,10 +301,6 @@ static inline void *offset_to_ptr(const int *off)
 
 #endif /* __ASSEMBLY__ */
 
-#ifndef __optimize
-# define __optimize(level)
-#endif
-
 /* Compile time object size, -1 for unknown */
 #ifndef __compiletime_object_size
 # define __compiletime_object_size(obj) -1
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 3525c179698c..b6534292ea33 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -108,7 +108,6 @@ struct ftrace_likely_data {
 
 /* Don't. Just don't. */
 #define __deprecated
-#define __deprecated_for_modules
 
 #endif /* __KERNEL__ */
 
-- 
2.17.1

