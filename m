Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 875C3C46460
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:38:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 31F3221727
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 19:38:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OREjY5gZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31F3221727
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbeHNW1G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 18:27:06 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37594 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728034AbeHNW1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 18:27:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so18178197wrr.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 12:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=Ya7+lcwxTld/Yshw/rZOR6JUPPVhqf8alklCuUtrEKU=;
        b=OREjY5gZMsk5tjX0uFfzppDXYXSL9y4D05b4VZMJZy8MPd0cISuBiqNal1b6rBtt0q
         LaLSwW/YtGuBCz9C0s8lqXaaQQGrfQuI2uOlAJEIFE1kDNbDix5+U8gXQ4xGVlM/0oev
         ApXdbiZXaV81pYST+h9GA0AMnYxTZh5LfBymkQPXPh26O4zuANKGUZsiVMsUQwUBC7ua
         TTT38KrFEs1WPRyihNTEZS0AsWLvBMnUIsN0dPPqNBbo2Ojme8v6gJPYD/bWvL/M1W5Y
         NXgdXkDTjF8AfeF0DD1a9+5zABkobUn5O5Gr6aLdd13PdJ0P5wRIma0NPC//qr1mStQ+
         vHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=Ya7+lcwxTld/Yshw/rZOR6JUPPVhqf8alklCuUtrEKU=;
        b=RFspwNIdvtR1hrmxhqGEFcFoTmyOb4flRBQGTpA4ldK4LT8llyIlX5cOR4Oj401fZ1
         uKh/Kidt02iYEEq18vk6dfsT1aUXchk7Vindm1b/blZeFaWTR6yTh7bL4BBYyZGfP7Dj
         k7uobq0jNaKiwmFPxjvV6pF4sfD0YAfXXkY3ms/JsEEeJTgziGdmftrYP66BxFEkcqlB
         EvJCOd5OSwoU+9SaE73UttNJBwF/Qvi7Z40sBBR4010zGhqAq8YDhIgOfIHT9hIuUDcM
         7RnJBPXaQzpV4VbfLprL8sNkFLBDYa/+cg71aVfEReYQzMpevgQp3tEHkri6l3Tz1Fbn
         xCzA==
X-Gm-Message-State: AOUpUlFBxEGZ82njecPLyC4F+edCWIgak1WDEIKtkHUzgdfGMHUn/6E8
        bKhkjyLqWmPbX5fKubCJc7o=
X-Google-Smtp-Source: AA+uWPyQN1f2D8/SdLBEkL4zJKY4KMHkbPKKFp2EuH+0fHDD1oOg7cRc/DHvP7XMntN8TVJvLsSxNQ==
X-Received: by 2002:adf:be03:: with SMTP id n3-v6mr14280280wrh.267.1534275502236;
        Tue, 14 Aug 2018 12:38:22 -0700 (PDT)
Received: from gmail.com (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id i23-v6sm19234710wmf.24.2018.08.14.12.38.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 14 Aug 2018 12:38:21 -0700 (PDT)
Date:   Tue, 14 Aug 2018 21:38:13 +0200
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Willy Tarreau <w@1wt.eu>, Ingo Molnar <mingo@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Will Deacon <will.deacon@arm.com>,
        David Rientjes <rientjes@google.com>,
        Martin Sebor <msebor@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] Support the nonstring variable attribute (gcc >= 8)
Message-ID: <20180814193813.GA5473@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: elm/2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the GCC manual:

  The nonstring variable attribute specifies that an object or member
  declaration with type array of char, signed char, or unsigned char,
  or pointer to such a type is intended to store character arrays that
  do not necessarily contain a terminating NUL. This is useful in detecting
  uses of such arrays or pointers with functions that expect NUL-terminated
  strings, and to avoid warnings when such an array or pointer is used as
  an argument to a bounded string manipulation function such as strncpy.

  https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html

Some reports are already coming to the LKML regarding these
warnings. When they are false positives, like this one

  https://lkml.org/lkml/2018/1/16/135

we can use __nonstring to let gcc know a NUL character is not required.

Cc: Willy Tarreau <w@1wt.eu>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Martin Sebor <msebor@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Joe Perches <joe@perches.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
v3:
  Moved #ifdef block to the bottom of the file as suggested
  by Joe. Updated description of the nonstring attribute
  in the patch and in the commit message from the GCC docs.
  Put all Cc people in both patches since the second is
  really an example of the first. Added Linus and Greg.

v2:
  Re-sending this since a few months have passed, Martin has improved
  GCC's feature and warnings are appearing in Geert's build bot.
  Added an example in the second patch as requested by David.

 include/linux/compiler-gcc.h   | 15 +++++++++++++++
 include/linux/compiler_types.h |  4 ++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/compiler-gcc.h b/include/linux/compiler-gcc.h
index 573f5a7d42d4..6b7fd8cd2851 100644
--- a/include/linux/compiler-gcc.h
+++ b/include/linux/compiler-gcc.h
@@ -387,3 +387,18 @@
 #else
 #define __diag_GCC_8(s)
 #endif
+
+#if GCC_VERSION >= 80000
+/*
+ * The nonstring variable attribute specifies that an object or member
+ * declaration with type array of char, signed char, or unsigned char,
+ * or pointer to such a type is intended to store character arrays that
+ * do not necessarily contain a terminating NUL. This is useful in detecting
+ * uses of such arrays or pointers with functions that expect NUL-terminated
+ * strings, and to avoid warnings when such an array or pointer is used as
+ * an argument to a bounded string manipulation function such as strncpy.
+ *
+ * https://gcc.gnu.org/onlinedocs/gcc/Common-Variable-Attributes.html
+ */
+#define __nonstring __attribute__((nonstring))
+#endif
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a8ba6b04152c..9c07be36e86a 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -289,4 +289,8 @@ struct ftrace_likely_data {
 #define __diag_error(compiler, version, option, comment) \
 	__diag_ ## compiler(version, error, option)
 
+#ifndef __nonstring
+# define __nonstring
+#endif
+
 #endif /* __LINUX_COMPILER_TYPES_H */
-- 
2.17.1

