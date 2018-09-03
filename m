Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A334C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3F622086B
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a5k8Sg3N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3F622086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729169AbeIDAz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:55:57 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54361 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727729AbeIDAzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:55 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so2243310wmb.4;
        Mon, 03 Sep 2018 13:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mdM1ZM+LvQmT66Azdcl1HKYOqFIc4f0Rj8Ky6vdAJJc=;
        b=a5k8Sg3NL9gVL6qR9DyR/MNPb5wKijroR6gXCu52IIlrcvufuK7A7j8+IlvJW6O4wC
         hkGUanZgx9mHR1a9yB00mM0eYxtlepY3JldlC5N4WRWR23VEPeGnO3+G5OCT7AnP+wDj
         D+8n7CxUMkRIKojhwyDtSChMhy2ZVQ4IgdmS2WLNihNIsY8HIpCD/aiElZY9VQGjA5FT
         Y1eTWQ0hYrSlw60n9qQ1VnpqJ8Af7mhvqm7ie8xoB8XEXxBXmaH5o/5C3G79E3qG9qLg
         ve0+SRIWZMqjwhNyfp6VYCEdWvc5qXKj6eFhwkP2T9hhXdgTnUs2tVn3sRe4+rhdgU5N
         1t4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mdM1ZM+LvQmT66Azdcl1HKYOqFIc4f0Rj8Ky6vdAJJc=;
        b=Lyvjn7vv9lNL7rQWdDlpRAUIB76CZ4PoMEb4cUeqsoEgELZv6pI/MwlMGv1b88fZq/
         NIXFj6hueWHN2LzYtJrWmJbd9gtjZbuyg5tQAlJ4b4/ysRal+MQOVF8f4Ri2P71ftAwR
         JerVSZiLJeOdCAs+4Y8rI4Ou2wTFotk+ShVqD3FR7iczWtgK3XpAngDapnwC6R3UfT2F
         3IWYLhD6Xmydkl6Crxl9UbqJXXbcEBgwyCfza51Po5g16I3DbHHxRAy7o4DkCTQRKgcl
         XhaGvbk8FkdZniWop1Bje82ZkAOWKCcdSiVs1Mf9YBPB/0N+nnl+T2dUQWeBfx3UqsVQ
         4mRQ==
X-Gm-Message-State: APzg51C/gM2E+E9OJjPMjzgjrWS3/BRuRGZa5Yf1ibkTeQ9iXG8KP2kD
        hrVYwCRkE23sgqu7r8Bajso=
X-Google-Smtp-Source: ANB0VdYQOusjGWqdO+RUCjkTOc3AjU3nRbCt9zeYkHAtXwre0E0u176DUy2T2S/o6sqhgkfSvH9x1Q==
X-Received: by 2002:a1c:4887:: with SMTP id v129-v6mr5839130wma.129.1536006842732;
        Mon, 03 Sep 2018 13:34:02 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.34.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:34:02 -0700 (PDT)
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
Subject: [PATCH 11/12] Compiler Attributes: remove uses of __attribute__ from compiler.h
Date:   Mon,  3 Sep 2018 22:33:15 +0200
Message-Id: <20180903203316.16183-12-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 17ee9165ca51..b5fb034fa6fa 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -23,8 +23,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 #define __branch_check__(x, expect, is_constant) ({			\
 			long ______r;					\
 			static struct ftrace_likely_data		\
-				__attribute__((__aligned__(4)))		\
-				__attribute__((__section__("_ftrace_annotated_branch"))) \
+				__aligned(4)				\
+				__section("_ftrace_annotated_branch")	\
 				______f = {				\
 				.data.func = __func__,			\
 				.data.file = __FILE__,			\
@@ -59,8 +59,8 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	({								\
 		int ______r;						\
 		static struct ftrace_branch_data			\
-			__attribute__((__aligned__(4)))			\
-			__attribute__((__section__("_ftrace_branch")))	\
+			__aligned(4)					\
+			__section("_ftrace_branch")			\
 			______f = {					\
 				.func = __func__,			\
 				.file = __FILE__,			\
@@ -146,7 +146,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	extern typeof(sym) sym;					\
 	static const unsigned long __kentry_##sym		\
 	__used							\
-	__attribute__((__section__("___kentry" "+" #sym )))	\
+	__section("___kentry" "+" #sym )			\
 	= (unsigned long)&sym;
 #endif
 
@@ -287,7 +287,7 @@ unsigned long read_word_at_a_time(const void *addr)
  * visible to the compiler.
  */
 #define __ADDRESSABLE(sym) \
-	static void * __attribute__((__section__(".discard.addressable"), used)) \
+	static void * __section(".discard.addressable") __used \
 		__PASTE(__addressable_##sym, __LINE__) = (void *)&sym;
 
 /**
-- 
2.17.1

