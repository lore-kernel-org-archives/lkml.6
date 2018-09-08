Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0059EC433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC95A20868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbIkJbIU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC95A20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728099AbeIICMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:39 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:54815 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728049AbeIICMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id c14-v6so17808825wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Sep 2018 14:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RN1v3Ql+wLphvjoCI5G+xeFMdHNiCY79fT1B1O/IW0E=;
        b=lbIkJbIUdTtqjnxvt0gYDvT9zzRv/3nD20Of3qc//yvx3NQvK3uRLSUWYIFMtehJbX
         dai4HDWEWTsmpIoDtaVeRFwWYzqBAEtlxxAaGWm651obowcZrdF2KpJIL8Grm2zLnkVR
         yCS54HkS6kfHaY28aB3a8XkRWY3d9Una4bqtB+IFkMOWJ7AXUPJeIhcrL8HfL7zFs0BF
         5tOgyNGw3D60X2IWRMzfzYsFffIKzNKAkJbU+NWE7Bv9fWVMStBuI05YZ+rZklkWxGN+
         VPmynHD8X8DU41w1mcssaNZKRFKSVUmH0KSmpbInqEvKvFUjgRjWUMjbxCfSSf3btkZO
         V4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RN1v3Ql+wLphvjoCI5G+xeFMdHNiCY79fT1B1O/IW0E=;
        b=O16DbrpDVPWK3SmtGA6ZaMRhrtfqjpp86u2dTHa5sXosr9NCPrUlifZtBOAsfE+Kp2
         4VbgC0+EcED3Tav5ZHOzimnFh7e+8A3K9n0/c22UDX8cVu6vB/EPa5aSL2CPLR/CNwAL
         tbtGIea3kj+6yGhOodtuIFXDdnVlzpp5v0Qc3soajKKEuwz63AnEUBV/Sle1YAXFQ5Bt
         R87ciHYRH9sF4Bys2JJ9SbsLiqdhJSyg62FvV8bJ9sI9HlkEjTZYka1fBWnRuSB9WSQB
         qM7Sqaoo3kTPfUuW8TEwg2KHH2Ts5B8pjhCJq8mL982osF1Y1wDt0toNwxSoFcyeWWvI
         c35Q==
X-Gm-Message-State: APzg51AY4FvcBKmAQb06ndvb5Xe9ZR4QAuBSNqOKoDuHrmEwvHQw999l
        nH26e9u6XLBpNKkAWQbZ38I=
X-Google-Smtp-Source: ANB0Vdbx6SuKK6WExQHqZ16kkBcERZf6LW7PG0nXa8Qp5191+weTy+rAgbkuvmdVOf84E9IBsofhfA==
X-Received: by 2002:a1c:385:: with SMTP id 127-v6mr9105177wmd.92.1536441929236;
        Sat, 08 Sep 2018 14:25:29 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:28 -0700 (PDT)
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
Subject: [PATCH v4 13/13] Compiler Attributes: Add MAINTAINERS entry
Date:   Sat,  8 Sep 2018 23:24:59 +0200
Message-Id: <20180908212459.19736-14-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
References: <20180908212459.19736-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
 MAINTAINERS | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9ad052aeac39..a7ef76d694d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3721,6 +3721,11 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 F:	drivers/platform/x86/compal-laptop.c
 
+COMPILER ATTRIBUTES
+M:	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
+S:	Maintained
+F:	include/linux/compiler_attributes.h
+
 CONEXANT ACCESSRUNNER USB DRIVER
 L:	accessrunner-general@lists.sourceforge.net
 W:	http://accessrunner.sourceforge.net/
-- 
2.17.1

