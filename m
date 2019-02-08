Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A5BC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:30:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4140F20844
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 20:30:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=rasmusvillemoes.dk header.i=@rasmusvillemoes.dk header.b="BcabSrWZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfBHUaZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 15:30:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:39965 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726847AbfBHUaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 15:30:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id g22so3891984edr.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 12:30:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ehRHzTaTBAtmKBBVMIGuIbgV5NMuVN11Q5N0TGWbuOY=;
        b=BcabSrWZ2yWPXvUUb9unJDNQRQqXyxjSBIpHdGiuAR8J9jCThI4iNErxiQjTIC+/C1
         YE3G4IsC4XAg2XkmoI9gRO/L6dWVqcHRoN1gF1FeSj23il7cSz6KcIATvcZ/aSjlEA5Q
         QZyduWwC+tMZZWmPzPcEV8j6p8RiyqZr7gOUA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ehRHzTaTBAtmKBBVMIGuIbgV5NMuVN11Q5N0TGWbuOY=;
        b=jhXESJ/N4/Ewrj+ZVEQ+NpFlnX+4hM85GMfvHTxvBv/b2d69eZv9M/G6Oh2A2JI/oi
         RxyrkNOB8td0tbT4x4AyNaBlLulG6Ig0J7KRBDu+h1RNUOEMs7Dlss+hry9qez9hkt9P
         gfPGSQd+owJkDPghOPQebCtGBRi8mzBBx/oXoxJlQs2DBccmlVh4oUhF907MZcKBIw71
         avtnvSiMI7yn0cyBLe7dzyGEw5lgVRsJQXa3LS/Qr2/Efzf694Ad9ytxUNnFTxwGFy/c
         CR95XNvCEWmmfojxnVtG0A03Ug4TC0Gpx2wQHSE2uXxZSduaI/ufpRwO+9kKnIzp/Kg3
         NDfQ==
X-Gm-Message-State: AHQUAubRiwVHkzmBNVlCgutIUfHbwVzWWvo0E5SZoMCpBOK2O0z7c4B7
        MuGNEaPK91zgUTjY0OVg2OW87A==
X-Google-Smtp-Source: AHgI3IbRc2D6Hrrr4yS5Wjds/QS8Qs1MzlnuOp2zmVzbKsOwGV4sesPw6j7CgFydCT959iQLPTAH4A==
X-Received: by 2002:a17:906:c286:: with SMTP id r6mr859906ejz.7.1549657822458;
        Fri, 08 Feb 2019 12:30:22 -0800 (PST)
Received: from prevas-ravi.waoo.dk (ip-5-186-119-174.cgn.fibianet.dk. [5.186.119.174])
        by smtp.gmail.com with ESMTPSA id p7sm680095ejb.15.2019.02.08.12.30.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 12:30:22 -0800 (PST)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 2/3] lib/vsprintf.c: move sizeof(struct printf_spec) next to its definition
Date:   Fri,  8 Feb 2019 21:30:14 +0100
Message-Id: <20190208203015.29702-2-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190208203015.29702-1-linux@rasmusvillemoes.dk>
References: <20190203192401.29170-1-linux@rasmusvillemoes.dk>
 <20190208203015.29702-1-linux@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At the time of d0484193 (lib/vsprintf.c: expand field_width to 24
bits), there was no compiletime_assert/BUILD_BUG/.... variant that
could be used outside function scope. Now we have static_assert(), so
move the assertion next to the definition instead of hiding it in some
arbitrary function.

Also add the appropriate #include to avoid relying on build_bug.h
being pulled in via some arbitrary chain of includes.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
v2: added, mostly as an example of use of static_assert(), to check
that the compiler actually groks it.

 lib/vsprintf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/lib/vsprintf.c b/lib/vsprintf.c
index 3add92329bae..30b00de4f321 100644
--- a/lib/vsprintf.c
+++ b/lib/vsprintf.c
@@ -17,6 +17,7 @@
  */
 
 #include <stdarg.h>
+#include <linux/build_bug.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/module.h>	/* for KSYM_SYMBOL_LEN */
@@ -405,6 +406,8 @@ struct printf_spec {
 	unsigned int	base:8;		/* number base, 8, 10 or 16 only */
 	signed int	precision:16;	/* # of digits/chars */
 } __packed;
+static_assert(sizeof(struct printf_spec) == 8);
+
 #define FIELD_WIDTH_MAX ((1 << 23) - 1)
 #define PRECISION_MAX ((1 << 15) - 1)
 
@@ -422,8 +425,6 @@ char *number(char *buf, char *end, unsigned long long num,
 	int field_width = spec.field_width;
 	int precision = spec.precision;
 
-	BUILD_BUG_ON(sizeof(struct printf_spec) != 8);
-
 	/* locase = 0 or 0x20. ORing digits or letters with 'locase'
 	 * produces same digits or (maybe lowercased) letters */
 	locase = (spec.flags & SMALL);
-- 
2.20.1

