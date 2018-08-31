Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C940C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBF820839
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:05:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVZ+6NVk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBBF820839
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbeHaVNn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:13:43 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33762 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbeHaVNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:13:43 -0400
Received: by mail-wr1-f66.google.com with SMTP id v90-v6so11866533wrc.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KmZ/8ann44LN0ZT2rnjF3ZO4diEsci8eChLxZrSdQ1s=;
        b=UVZ+6NVkBvSZzQ4RyjsFyEQCX4orD5pLvzLYRs663ZYV7yXZhXrCSCO3vKv4x4AjZA
         oOaF/rxGxVP8B0OE4+1N9kaJ/Cd1m9UlOOs8hBUDpzqLbiDWF0Gnx9ebe3yVpDyD4n16
         OzMpxxz1r3LEZP1aWmJiN0wxkUp/3vnuFotoFg5xGIeaSrW3oCjxHUTV145RG2D1u10Z
         ubRxgRxQfW8WcgA7VyQmdRseDZ8ICJ27g5TwfjG6VYbjb2lPpAtyp1Z5wXGeTYzKYTnr
         Cq5yOgB95+eezoTWPeCXlyMhjiDY2+Ryp5I5fSpXPW5neXoqoKpf596sxxO0MV5x+09J
         G60g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KmZ/8ann44LN0ZT2rnjF3ZO4diEsci8eChLxZrSdQ1s=;
        b=aM1RDEdcLIeTcgN4/D5uLftF1L0nbuHngh5oS5MTCKwyqJkvjUEDSTlKWXxowM430j
         Yojm/UlWdwV5Seq13xKP+h1Ox7aFLPUuACiTlR4OEeVcHvzHnWeYUsXHqWalvMHHRAe9
         i5/gfVYZ+F8hm0Ul1vjFbGiGhIz5fJBg7Y298Zu9NFG7z+XD08762L+gHDfOitqzkise
         i6CuMdLb0wxaoQzmScP5gra2IqOjc4NckjC2LwrxNgVSLO7n5YxvRDPDQapuwoLE2RFD
         7WYMxXocMPwcO4Ua2/dFr2Oc0Azg7hwy28OulhmV5AuAzpDfiO5+qKphaKGxfaJwPSmu
         Qavw==
X-Gm-Message-State: APzg51DAVgmO9D6H3dOZ6Q27BowM3tZ/EpqhaJ9Npt3UlOF+DaIFCVOx
        vazhbDHkmzw2HJEY1fppmd8=
X-Google-Smtp-Source: ANB0VdbIG4R/YFbkuqLqlZgUABTtUuif2jQ+SNbhjGpeoat862qsmMGIMAQatVQYOEi7mWj50qNwZg==
X-Received: by 2002:adf:f608:: with SMTP id t8-v6mr551619wrp.186.1535735117958;
        Fri, 31 Aug 2018 10:05:17 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id c19-v6sm11280332wre.86.2018.08.31.10.05.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 Aug 2018 10:05:17 -0700 (PDT)
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
Subject: [PATCH 1/7] Compiler Attributes: remove unused attributes
Date:   Fri, 31 Aug 2018 19:05:08 +0200
Message-Id: <20180831170514.24665-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__optimize and __deprecate_for_modules are unused in
the whole kernel tree. Simply drop them.

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

