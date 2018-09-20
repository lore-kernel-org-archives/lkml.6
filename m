Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C07C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 694CF21523
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:24:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y2ZhvrhH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 694CF21523
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387728AbeITXJF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:09:05 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:52814 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388127AbeITXIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:16 -0400
Received: by mail-wm1-f66.google.com with SMTP id y139-v6so329357wmc.2;
        Thu, 20 Sep 2018 10:23:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=K89/ZdMSWc7JgU6GCLZqVVq7BWypCFFZoB8/hY3YhVU=;
        b=Y2ZhvrhHPdJeaczsY7+ovNMcpSm/7lppnlE3QgGblcyx0x8YBESNfN1QbNTonJTLmB
         +PLcfIjBDUouB/AJbQy9iWD9zRFSbJzfqrS1tq6LlG3PcXNgdW69dUvdRg3ueK4Xo07P
         LyQh3ljbTh73hi4aZJAlIQMvnHQuJ5Wt418kGJgbxMDJGSwAc1tqbnKuxtHa83N71e0V
         llKoETG0Mgs7D8HXEYJI0IpiKw+2NMYarRE50CAUOB1ndgmVmmeIN2NeCT05k6ZBQ07s
         5oWuvxIMzhQPizHkIAyMbrEduW+Duiyn61sKyygTSBzpArkD56Z9eEAi99nR9HDMGqxB
         o5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=K89/ZdMSWc7JgU6GCLZqVVq7BWypCFFZoB8/hY3YhVU=;
        b=VulQkBZyVdLO8juFys5S9nDhJJiRQQxJuf4thubj8Qf1HPMExW6MHh7nHaNkHSlKTA
         KCTRqcXziqvB0w9rW2v8l4mkABAH8VWUHN6R/SyuDOGBEJCfmNqaI+CwsTj36SQJE/98
         4wflyWVzr4iwk/ROtYJI99YXXvPN/lNQWuZfax/WyX/UnBNjRRi6uzsuVghRB6XoSB/6
         kpu+cuMdooKgU/khZ8PzcqJrlLOrAi33hUrmrRzyce8z284isPdcjnfhkfdHsc+D6f2G
         qWOpMevEtWrzfvwS4+Kb1eG7R43NDojl4HGPkOH7WNg731CRdwClR5cCiGAVGqjKZgWd
         oU6w==
X-Gm-Message-State: APzg51BKqbpJHxzUF+AldfPrnTKZk5TjSi5VtEoAV1GsX9GFivRtuEFK
        HZOzjPNmIus1/oXUE2Pp+mQ=
X-Google-Smtp-Source: ANB0VdZu0WA2jxcUbGBJ7PSLO513Kyr2rNqJmnuP7LBS4AVrDFKZWWmuk2pUu4hfVra+L85gBEDPiw==
X-Received: by 2002:a1c:1fcd:: with SMTP id f196-v6mr3891601wmf.154.1537464224190;
        Thu, 20 Sep 2018 10:23:44 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:43 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Olof Johansson <olof@lxom.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        "David S . Miller" <davem@davemloft.net>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Paul Lawrence <paullawrence@google.com>,
        Sandipan Das <sandipan@linux.vnet.ibm.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Will Deacon <will.deacon@arm.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Paul Burton <paul.burton@mips.com>,
        David Rientjes <rientjes@google.com>, Willy Tarreau <w@1wt.eu>,
        Martin Sebor <msebor@gmail.com>,
        Christopher Li <sparse@chrisli.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Theodore Ts'o <tytso@mit.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Joe Perches <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Stefan Agner <stefan@agner.ch>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-sparse@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: [PATCH v5 09/15] Compiler Attributes: remove uses of __attribute__ from compiler.h
Date:   Thu, 20 Sep 2018 19:22:55 +0200
Message-Id: <20180920172301.21868-10-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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

