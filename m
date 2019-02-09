Return-Path: <SRS0=1U6d=QQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06134C282CC
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C797721841
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Feb 2019 00:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MirIZ+3P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbfBIAJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 19:09:08 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52552 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfBIAJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 19:09:08 -0500
Received: by mail-wm1-f65.google.com with SMTP id m1so6280200wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 16:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5ORFvEqPg40FyrMt/fLXHHlLvflq3laGk3IRwh/eP24=;
        b=MirIZ+3PsN5et4GxGn+L8yDCYRFmolz3ch2quRams1L4kezKyKP8T1h/lMWw4HLw3j
         qflJWUF7dxCkRm9BZo5oB9P1g8LduJUF6eDllCAeVgX9Ucjiv9YL/CzuxxnMIcZCxhQ3
         Cvaitucrcr2zoCbinGZJ3UTMc87z41zG++3beXvnGOW8yVGbD9SSsh+rnqC0zPT8/le6
         ahFOr3X3hhXMequKxkYzpCl2B6rvjNHHKZAgHiWpfIFYdPXiNzw/ynmgjlE7d30YyEfJ
         lCUE9f2pQkLwezxuilWYIRJzGpL6oFcbp7tncmhyw08pUI8DI/2BLVSq39ygOuxSXs+N
         Yz5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5ORFvEqPg40FyrMt/fLXHHlLvflq3laGk3IRwh/eP24=;
        b=VJIGQ/B70+kuZ0LEtdZ+dy4ex6I17bzPvCety3qDUtq1XpARIvFjmxjYdoXNPjbPpz
         ma7ZZvXNVeDUTgAd2flnsyjzk9RMNokT2w7YWltBGZgiNxoPzrobHKhLyfdjUWgjo5FH
         bHuUDJKAf6EMFUiMcWbgvXA7PTLvF2kZ0b9Sm5n+pViOQcdu6lHSbWb8nJgCcyoHNf0v
         2Yv+wtop89bM3YkbE/pCq5XIepi6Po4gnmlmlRxrhGQ6/GWGcaxX2UeEb6nEXaQAXMjB
         AwlzqzcATrbX6OFKYyfYv15g4ZRqHneZxyQPz76ntnlTqoDmZyFaD2sbLHb4ca50WqEX
         ZXJw==
X-Gm-Message-State: AHQUAuamoKJjvGO/OyguJDIQG1W8Frj/lI1c6vr8G/4NidoSHwrlsusG
        k2VpBk2l8HS/ovAHysacldfMzUN77xdVvg==
X-Google-Smtp-Source: AHgI3IYsXZWonq/T/Yz16YT3iZm6Rkmn7EyPr0s0FcW+a9bKEfN4EiUiDsqJUDrfOy02pYl4uzpiQA==
X-Received: by 2002:adf:ca13:: with SMTP id o19mr18202139wrh.148.1549670946088;
        Fri, 08 Feb 2019 16:09:06 -0800 (PST)
Received: from localhost.localdomain (79.108.96.12.dyn.user.ono.com. [79.108.96.12])
        by smtp.gmail.com with ESMTPSA id 65sm10483171wrb.62.2019.02.08.16.09.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 16:09:05 -0800 (PST)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Martin Sebor <msebor@gcc.gnu.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Laura Abbott <labbott@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Kees Cook <keescook@chromium.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH 2/3] Compiler Attributes: add support for __copy (gcc >= 9)
Date:   Sat,  9 Feb 2019 01:08:39 +0100
Message-Id: <20190209000840.11018-3-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
References: <20190209000840.11018-1-miguel.ojeda.sandonis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From the GCC manual:

  copy
  copy(function)

    The copy attribute applies the set of attributes with which function
    has been declared to the declaration of the function to which
    the attribute is applied. The attribute is designed for libraries
    that define aliases or function resolvers that are expected
    to specify the same set of attributes as their targets. The copy
    attribute can be used with functions, variables, or types. However,
    the kind of symbol to which the attribute is applied (either
    function or variable) must match the kind of symbol to which
    the argument refers. The copy attribute copies only syntactic and
    semantic attributes but not attributes that affect a symbol’s
    linkage or visibility such as alias, visibility, or weak.
    The deprecated attribute is also not copied.

  https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html

The upcoming GCC 9 release extends the -Wmissing-attributes warnings
(enabled by -Wall) to C and aliases: it warns when particular function
attributes are missing in the aliases but not in their target, e.g.:

    void __cold f(void) {}
    void __alias("f") g(void);

diagnoses:

    warning: 'g' specifies less restrictive attribute than
    its target 'f': 'cold' [-Wmissing-attributes]

Using __copy(f) we can copy the __cold attribute from f to g:

    void __cold f(void) {}
    void __copy(f) __alias("f") g(void);

This attribute is most useful to deal with situations where an alias
is declared but we don't know the exact attributes the target has.

For instance, in the kernel, the widely used module_init/exit macros
define the init/cleanup_module aliases, but those cannot be marked
always as __init/__exit since they some modules do not have their
functions marked as such.

Suggested-by: Martin Sebor <msebor@gcc.gnu.org>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler_attributes.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/linux/compiler_attributes.h b/include/linux/compiler_attributes.h
index 19f32b0c29af..6b318efd8a74 100644
--- a/include/linux/compiler_attributes.h
+++ b/include/linux/compiler_attributes.h
@@ -34,6 +34,7 @@
 #ifndef __has_attribute
 # define __has_attribute(x) __GCC4_has_attribute_##x
 # define __GCC4_has_attribute___assume_aligned__      (__GNUC_MINOR__ >= 9)
+# define __GCC4_has_attribute___copy__                0
 # define __GCC4_has_attribute___designated_init__     0
 # define __GCC4_has_attribute___externally_visible__  1
 # define __GCC4_has_attribute___noclone__             1
@@ -100,6 +101,19 @@
  */
 #define __attribute_const__             __attribute__((__const__))
 
+/*
+ * Optional: only supported since gcc >= 9
+ * Optional: not supported by clang
+ * Optional: not supported by icc
+ *
+ *   gcc: https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html#index-copy-function-attribute
+ */
+#if __has_attribute(__copy__)
+# define __copy(symbol)                 __attribute__((__copy__(symbol)))
+#else
+# define __copy(symbol)
+#endif
+
 /*
  * Don't. Just don't. See commit 771c035372a0 ("deprecate the '__deprecated'
  * attribute warnings entirely and for good") for more information.
-- 
2.17.1

