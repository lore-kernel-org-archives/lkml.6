Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90603C4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 438782086E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MB1XMDGX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 438782086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbeIICM4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43365 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728022AbeIICMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:34 -0400
Received: by mail-wr1-f67.google.com with SMTP id k5-v6so18100325wre.10;
        Sat, 08 Sep 2018 14:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QLWoO95oaoANsEnjgjtYxDXeyWdMYaJIHZZCQ0x3jE0=;
        b=MB1XMDGXrqKIsnKgQTPItNcmqjfxTQISOECRnZ0WrJLEtf9vamMqX2Fkc19pbkA2z+
         Vewpt4amP03+vi0O2KGvBOk/DgLAypnhRfF/aG5cNz04Zy77qJ+FMtThmZ6lbbphLcVj
         iVhyErOp17QSw5rx6+9/5yhODms5Nu/k7Q8rSEKYXF+hfXBt2YhkBuIHb5La480WTBk+
         gopICpGQ0IaElZ1S/LI8/0QJCpFNrUbxL/ixAixLhTRIRuErO4L6AMGFSG6Ie+63QDYs
         F8y0Fedb0HBzNulKLfBKgK7DwGBGwXuBnpx5bPYeQCRH2sR2po7YZPUxNTzn9/4D7MSj
         fafw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QLWoO95oaoANsEnjgjtYxDXeyWdMYaJIHZZCQ0x3jE0=;
        b=nnCVaCJaVJ115Lw2xSNh7SbI1iv7QdG4uqtI8kN/IGJQhQVtvMYQRvg4oLzLCN4yhj
         aZbufB3tX705jVnxYGRzuAKDF30LjEBuiohvSIwoozjdb52WuP1YzvhOSu2GpR5YQHkp
         bdA5joST+gr/ct3597NhiSgEZDiNpmXdGkLQPu8bQZYHKQt9FPGohIUM1cH2n90gryua
         t66ev7E6KqBNWe7yT/LAxfdtWPx6xtmN287eaQcmHJupCwAzCpdEArEdV6YIIdK93lMh
         ytpK/PPsgZe81rCHtiEi6i+pzFGVCsCGOe+jbza1y7nG69gDZ3VhhxswtXCs9ZCNwQA7
         i7ag==
X-Gm-Message-State: APzg51BIKHHQrhuhSoL3vB6k8ovtuNh1n8YQFVBNUc3OO6Llyj3+DxAX
        QjqTYITPlEjszg/h60gIH8c=
X-Google-Smtp-Source: ANB0VdbxbraxnxpSdlR1/4cLyIDBD7HvLtakISG05khzfsVS33HW+PPZbdsrtXJQq5EuT5r6BFr5aw==
X-Received: by 2002:a5d:6103:: with SMTP id v3-v6mr10806145wrt.265.1536441925252;
        Sat, 08 Sep 2018 14:25:25 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:24 -0700 (PDT)
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
Subject: [PATCH v4 10/13] Compiler Attributes: KENTRY used twice the "used" attribute
Date:   Sat,  8 Sep 2018 23:24:56 +0200
Message-Id: <20180908212459.19736-11-miguel.ojeda.sandonis@gmail.com>
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
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 4030a2940d6b..17ee9165ca51 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -146,7 +146,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	extern typeof(sym) sym;					\
 	static const unsigned long __kentry_##sym		\
 	__used							\
-	__attribute__((__section__("___kentry" "+" #sym ), used))	\
+	__attribute__((__section__("___kentry" "+" #sym )))	\
 	= (unsigned long)&sym;
 #endif
 
-- 
2.17.1

