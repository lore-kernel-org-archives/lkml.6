Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBBAC43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:33:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BE592087B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="icDclaID"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BE592087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeIDAzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:47 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34823 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727850AbeIDAzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:46 -0400
Received: by mail-wr1-f65.google.com with SMTP id j26-v6so1779883wre.2;
        Mon, 03 Sep 2018 13:33:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KSmd8Leci7Jq2YnVlQ1QxGK80ki+uToFeuQJJ1eS4UY=;
        b=icDclaID20kA2vZHgCRuEH4RbRbFT934AX/qUMq6Cy/ckNBZxCU2fbeKsc+HJlreL3
         4Kv+dXU1P9xGZfiSzASm13oxUWOIQKLTcZfleLfJ05j/1uXFhGFf3VySD8QwWg8uUjQv
         z+q1eHAZTpv6ZKxs9Jgjowx6JkJOy0YYVNVhbujWzX33+eB8rUQQZ/VSO/Vhog0cANxl
         srWpZ4zPNNV8TSXLNxQCDBxjWzhLDzgmKKJfARKvzX5h+6Cp4dY0m0K8nFlgiBmnHPK/
         12RkoufbGeVMJz9BsiIMK3r5xXriYbjgEzro79aKtandHseG2bCnhErsuhShks+5W8Do
         Szmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KSmd8Leci7Jq2YnVlQ1QxGK80ki+uToFeuQJJ1eS4UY=;
        b=NJBDXMieSQ657XgD45duw+zsdYr+ApQVx0ESqcmabg7hKAbwwuDJxo27FKGO5ZZiYh
         8z/eb2Hii+fTDzk5Q4rG9yISa4L6A2Niw705/U3LUHGZfTBabr8gLzIMoEuBpiPgJL1o
         z0zOtdxSSGDvbSiqRG5JGf1g5bcg/lRIc+es+13JAJNU6NcNRoB+e/PL5e+laNjEgMrC
         nHVX4iE6he/6497zw5hqlwScZT8zjuzzGu7eOw3cSOGBHAXutfCIOnrbDiLxcY80iqTc
         eZVCX8jDDYMUrc+HWSmSC1zT4NRUqx5gr72jUaC/gmKmGPKOrRemgxXR+1F+25e32gj4
         yplg==
X-Gm-Message-State: APzg51CaFZHDioqK38GUID8YAYgv285xmE9NjE3IcPPyqVVJ0GMmZvsX
        nRiZYcuHk1h3WyuNYV1Ydk8=
X-Google-Smtp-Source: ANB0Vdbs8rVQYZxMUubvVWWHkOb1n3a26S04W6xwv7J7JNE1Eh/UTzi/YfQLSjHkJWciUdri1qlCew==
X-Received: by 2002:a5d:550a:: with SMTP id b10-v6mr21413137wrv.228.1536006834015;
        Mon, 03 Sep 2018 13:33:54 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.33.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:33:53 -0700 (PDT)
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
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH 05/12] Compiler Attributes: naked was fixed in gcc 4.6
Date:   Mon,  3 Sep 2018 22:33:09 +0200
Message-Id: <20180903203316.16183-6-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 9c695203a7dd ("compiler-gcc.h: gcc-4.5 needs noclone
and noinline on __naked functions") added noinline and noclone
as a workaround for a gcc 4.5 bug, which was resolved in 4.6.0.

Since now the minimum gcc supported version is 4.6,
we can clean it up.

See https://gcc.gnu.org/bugzilla/show_bug.cgi?id=44290
and https://godbolt.org/z/h6NMIL

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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler-gcc.h | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 76f4907ef707..4cd5e9264bce 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -77,14 +77,8 @@
  * to trace naked functions because then mcount is called without
  * stack and frame pointer being set up and there is no chance to
  * restore the lr register to the value before mcount was called.
- *
- * The asm() bodies of naked functions often depend on standard calling
- * conventions, therefore they must be noinline and noclone.
- *
- * GCC 4.[56] currently fail to enforce this, so we must do so ourselves.
- * See GCC PR44290.
  */
-#define __naked		__attribute__((__naked__)) noinline __noclone notrace
+#define __naked		__attribute__((__naked__)) notrace
 
 #define __UNIQUE_ID(prefix) __PASTE(__PASTE(__UNIQUE_ID_, prefix), __COUNTER__)
 
-- 
2.17.1

