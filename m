Return-Path: <linux-arch-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-4141437-1525850777-2-12349512260155246214
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-charsets: 
X-Resolved-to: linux@kroah.com
X-Delivered-to: linux@kroah.com
X-Mail-from: linux-arch-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525850777; b=CFuJMPztS+9RQdGaTPKH5cg7mikIEU6rEXoL0xZLfYV526oPEV
    fn5+qaEcTNOmnO2yJl+pUgKmsFKNe8UZfy3iReLXKMF9oEDoa+lSB9nF0/EcefDo
    WyEjqVXYbKTVd7iR1FbA0YfCXa/UHV7i3znHRwkBmC2rK+5SZeE+ZgvtahfLIY/A
    NmWPK33ds3TfA2a0TWwNlkVOv6OUwVaJjOOWbD7KVCILdycmXWKOF/4roJp25pmO
    Q6IPcdLmyznfsw/1tojYzjRE1q2wd7qzIcEXle159IT4/u5DHfAaAn0CcKKhLj2s
    Fe01dNeqqLIajUHdOkzAmZJvN3fY9b5pDhBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=from:to:cc:subject:date:message-id
    :in-reply-to:references:sender:list-id; s=fm2; t=1525850777; bh=
    xhS00ZSM7KT+0n3/rX5mEiwCZNlVlih+SV5plVyaxAA=; b=MPyh1movrzCuXx5r
    s/qE9WXG7AXywiiCM5i4TJUwQf6vd0/Sv7z2WV48Ybkd6twbl6h6WArLGSv4sg9B
    CLNAu2W5YPfYSM8nHtTNFOt0idVZP/C7QaqB/NhHLi52LbGFbgEarWgDSjPsdsTQ
    kwY9fyB4X4NGfiwjP3n4AM5hAyQwV5A1RdC0Ux9ajpFftMo68b/0L2de6w9CwtJY
    g5/okYAI9GfL6EOe9nVAN4gRobgXxErF1btQuKvwXy0dYOKYrAxYnZCwW1yIub1M
    /I+VoPsdlcZRGcWqbR/t6zD7RNjQ0A+7Gv+vUUE8Xn1XfZmflqor7drj1QumESzN
    gMBQPw==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
    header.i=@nifty.com header.b=LvgeEmg6 x-bits=2048 x-keytype=rsa
    x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=socionext.com header.result=pass
    header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=pass (2048-bit rsa key sha256) header.d=nifty.com
      header.i=@nifty.com header.b=LvgeEmg6 x-bits=2048 x-keytype=rsa
      x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-arch-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=socionext.com header.result=pass
      header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLRc1pWqnyr9OJmXfwVyjzUeHJ8wA/iNex6sGGS6f5uYnLNAXdiMB/aa3qfyriFaYqUjJ/SoJOCZHjOZohIdb+dNsYakVT4h3acNmGfAR9AOFOsI+++d
    1sz73VA70XAoXalWY62iJfYDs2GP7BleqTAng6XfaDcfLTz3n47tLunMFzUYykeUq6lEdy4aFqqunmadqKbGMTP/kd3UHdbNxsUb/WpJ9ClP8r/w//mS9ERH
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=c-n4J4-pAAAA:8
    a=B8cWg5tXInZCVQM7JpkA:9 a=L0NDqeB7ZLmQzAogN4cw:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755888AbeEIH0P (ORCPT <rfc822;linux@kroah.com>);
        Wed, 9 May 2018 03:26:15 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:50566 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753339AbeEIHYq (ORCPT
        <rfc822;linux-arch@vger.kernel.org>); Wed, 9 May 2018 03:24:46 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com w497O36H028852
X-Nifty-SrcIP: [153.142.97.92]
From: Masahiro Yamada <yamada.masahiro@socionext.com>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>, Joe Perches <joe@perches.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] export.h: remove code for prefixing symbols with underscore
Date: Wed,  9 May 2018 16:23:49 +0900
Message-Id: <1525850632-10921-6-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
References: <1525850632-10921-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-arch-owner@vger.kernel.org
X-Mailing-List: linux-arch@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX was selected by BLACKFIN, METAG.
They were removed by commit 4ba66a976072 ("arch: remove blackfin port"),
commit bb6fb6dfcc17 ("metag: Remove arch/metag/"), respectively.

No more architecture enables CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX.
Clean up the export.h headers.  I am keeping VMLINUX_SYMBOL() and
VMLINUX_SYMBOL_STR() because they are widely used.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 include/asm-generic/export.h | 34 ++++++++++++----------------------
 include/linux/export.h       | 16 +++++-----------
 2 files changed, 17 insertions(+), 33 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 719db19..68efb95 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -19,42 +19,32 @@
 #define KCRC_ALIGN 4
 #endif
 
-#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
-#define KSYM(name) _##name
-#else
-#define KSYM(name) name
-#endif
-
 /*
  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
  * since we immediately emit into those sections anyway.
  */
 .macro ___EXPORT_SYMBOL name,val,sec
 #ifdef CONFIG_MODULES
-	.globl KSYM(__ksymtab_\name)
+	.globl __ksymtab_\name
 	.section ___ksymtab\sec+\name,"a"
 	.balign KSYM_ALIGN
-KSYM(__ksymtab_\name):
-	__put \val, KSYM(__kstrtab_\name)
+__ksymtab_\name:
+	__put \val, __kstrtab_\name
 	.previous
 	.section __ksymtab_strings,"a"
-KSYM(__kstrtab_\name):
-#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
-	.asciz "_\name"
-#else
+__kstrtab_\name:
 	.asciz "\name"
-#endif
 	.previous
 #ifdef CONFIG_MODVERSIONS
 	.section ___kcrctab\sec+\name,"a"
 	.balign KCRC_ALIGN
-KSYM(__kcrctab_\name):
+__kcrctab_\name:
 #if defined(CONFIG_MODULE_REL_CRCS)
-	.long KSYM(__crc_\name) - .
+	.long __crc_\name - .
 #else
-	.long KSYM(__crc_\name)
+	.long __crc_\name
 #endif
-	.weak KSYM(__crc_\name)
+	.weak __crc_\name
 	.previous
 #endif
 #endif
@@ -84,12 +74,12 @@ KSYM(__kcrctab_\name):
 #endif
 
 #define EXPORT_SYMBOL(name)					\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)),)
+	__EXPORT_SYMBOL(name, KSYM_FUNC(name),)
 #define EXPORT_SYMBOL_GPL(name) 				\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)), _gpl)
+	__EXPORT_SYMBOL(name, KSYM_FUNC(name), _gpl)
 #define EXPORT_DATA_SYMBOL(name)				\
-	__EXPORT_SYMBOL(name, KSYM(name),)
+	__EXPORT_SYMBOL(name, name,)
 #define EXPORT_DATA_SYMBOL_GPL(name)				\
-	__EXPORT_SYMBOL(name, KSYM(name),_gpl)
+	__EXPORT_SYMBOL(name, name,_gpl)
 
 #endif
diff --git a/include/linux/export.h b/include/linux/export.h
index 1a1dfdb..b768d6d 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -10,14 +10,8 @@
  * hackers place grumpy comments in header files.
  */
 
-/* Some toolchains use a `_' prefix for all user symbols. */
-#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
-#define __VMLINUX_SYMBOL(x) _##x
-#define __VMLINUX_SYMBOL_STR(x) "_" #x
-#else
 #define __VMLINUX_SYMBOL(x) x
 #define __VMLINUX_SYMBOL_STR(x) #x
-#endif
 
 /* Indirect, so macros are expanded before pasting. */
 #define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
@@ -46,14 +40,14 @@ extern struct module __this_module;
 #if defined(CONFIG_MODULE_REL_CRCS)
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
-	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) " - .	\n"	\
+	    "	.weak	__crc_" #sym "				\n"	\
+	    "	.long	__crc_" #sym " - .			\n"	\
 	    "	.previous					\n");
 #else
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
-	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.weak	__crc_" #sym "				\n"	\
+	    "	.long	__crc_" #sym "				\n"	\
 	    "	.previous					\n");
 #endif
 #else
@@ -66,7 +60,7 @@ extern struct module __this_module;
 	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), aligned(1)))	\
-	= VMLINUX_SYMBOL_STR(sym);					\
+	= #sym;								\
 	static const struct kernel_symbol __ksymtab_##sym		\
 	__used								\
 	__attribute__((section("___ksymtab" sec "+" #sym), used))	\
-- 
2.7.4
