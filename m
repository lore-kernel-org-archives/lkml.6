Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B305C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E8620868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q2vi4N7N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E8620868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728082AbeIICMh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:37 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43366 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbeIICMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:36 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so18100346wre.10;
        Sat, 08 Sep 2018 14:25:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mdM1ZM+LvQmT66Azdcl1HKYOqFIc4f0Rj8Ky6vdAJJc=;
        b=Q2vi4N7NGsE2iyJhpdphfCwyRBH+1RA36w7192GOiIZGHwrLVn5KAqOsui/iBJSnUM
         ze9q7CZ7mKVjE7YZvw0M+q7hIrhcF+Dt6MF8NDYbQNBkPqeqGr2H+6HR9pN9yoLsIpKQ
         O4Cnmdp2aZ0bnHKoqRWUAgYC6oOoi7+xy2Sku64KqWAWSHkpLDuoOtnjQyIONDw+nRle
         qrECTxEMZTDGmq1u8oStpgX/9gxB3o59fy3g0zizG5EhSON7MG+QwtTRLi/xwxlrltzk
         HchqimG5Ff92iFvAl3jFYGFocnJr81lu0WzagvxnAshCe125Xo69OHPb4MqgLFhopwQ6
         L7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mdM1ZM+LvQmT66Azdcl1HKYOqFIc4f0Rj8Ky6vdAJJc=;
        b=Zzi2683e0h1OKzdNJRlS5qAPZgBDp+GfUFvHENtfDX21OgMctrNUXvr0bzB5Zn66E1
         u4pfBvSpJtPT3VM1FgZFbkgMfWEum4viUxUK4HGoDiyCA6NFHW7jcNIYD2WDVO8Slju3
         455Dwv8N4Ckoy5xkAFrPaLdjxdE9ca8cA2apM86GIpzXVHxUORVl2k0349Aka82rCMjj
         K8HADNdHzY1jOIDKXZbkHC3VWFrMd0ICq2l6qnnSUENmQHc+7A19o4nbDvd2gc8gmjFf
         Cc7za5KKOBpwZjCh7Wlhe62Sv8Net7CYtRpuDXCEpjT0T4CbjUBZc5drEfm0xFx0a5l6
         BP4g==
X-Gm-Message-State: APzg51BKgeNkoPPPKzSQd9G+4UTPxKDzGs7LH/nTBG+lgg+m8mVriffd
        SRUuG4fOZrt8vd97fYlgyAw=
X-Google-Smtp-Source: ANB0Vdb9I2hzwYx88f+1NHBWt7gkfGhDrWfHENMkmWjPjVZrlv0uZXd4XYdse4UVK01QqMlVmPafow==
X-Received: by 2002:adf:c78e:: with SMTP id l14-v6mr10027944wrg.230.1536441926553;
        Sat, 08 Sep 2018 14:25:26 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:26 -0700 (PDT)
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
Subject: [PATCH v4 11/13] Compiler Attributes: remove uses of __attribute__ from compiler.h
Date:   Sat,  8 Sep 2018 23:24:57 +0200
Message-Id: <20180908212459.19736-12-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
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

