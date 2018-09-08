Return-Path: <SRS0=P5JM=LW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4BEC4321E
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7731820868
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Sep 2018 21:25:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvHgldHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7731820868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728038AbeIICMe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Sep 2018 22:12:34 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42166 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727675AbeIICMc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Sep 2018 22:12:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id v17-v6so18096703wrr.9;
        Sat, 08 Sep 2018 14:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6YrBEO0ygu8L4Ye+S5Cs5/KXj10wa1TGIrvc4xjTIE8=;
        b=EvHgldHWJ9yTjlt9WKbvrsxI2XNYJsmXJqatrgWL3/T9J8Db4ja7kvy8hT2YJwVIeV
         +vIyfRWrpMqNSjYZC8JKTf4ijPKm6WhmUVGUUGo0fQqT4iAUozV9WNH1fOqNbHsCsKJh
         uw0v8iLCO5jBu00MK0VliyJrR+9sJGqyIpDl+B8LtPZ8y9T3q2MY1G5HpvMCbZvVFGpn
         LI65owTdkUy546pxeFNE4311moxcKBOij9r8LsUqAghnD+gdMq8LkTwjr/HSLcHNcqfd
         XUXKRQ82wxE1zlu8RaIIyKaOZxIKiefitmZDenlP4pW6AYUR2PCyw9cB2UW9n0RoS1nK
         3h6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6YrBEO0ygu8L4Ye+S5Cs5/KXj10wa1TGIrvc4xjTIE8=;
        b=AJtoMX2sDqdLHd3U1tSwpof+SXC1HE5buFml2u3gVCdBwqpV5hyYX7qbbCV9qgLoTl
         p2UA3XoKgT8PVh8O9IXQh/lZxAw7zK/92Ss6LzZo4tJq49X+iK8b5EMZ6CHWb3ZXbLF5
         QRmmH2qNyBZUmn7jYeRPqniupajEOdcv9uNtBEx0PQITepCJSUP5wBQm7pA1Q6IXeVpG
         ls0tOiRYHeJ1+PfilPxQrcX1ZjDa4BEBiRmlPUo62bD2QVc8MLwTDW78Ykw3Jrww7rzj
         6RcES//AXdvF9TRod8UBvGX9jZnu/ATeyPIGbMXlCB2FxIDvBb3H+m2NEN8UNjP33Zzq
         Y5eg==
X-Gm-Message-State: APzg51A5xU9nxYB+5TRgRDHuOT/6MxsViY1DO084t5p7DLTHaSyMCCyv
        LAytOh0eJZSvvp/KP+5vdzg=
X-Google-Smtp-Source: ANB0VdbJw4sXyQW6AFzux/pccqaJdJQ5f0+n7vG8hEvsPuqGxAOzWWeTUvcwhRf4NP9IgrpYiZIdGg==
X-Received: by 2002:adf:a292:: with SMTP id s18-v6mr10815063wra.100.1536441922499;
        Sat, 08 Sep 2018 14:25:22 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id u40-v6sm17340786wrc.43.2018.09.08.14.25.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 08 Sep 2018 14:25:22 -0700 (PDT)
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
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-sparse@vger.kernel.org
Subject: [PATCH v4 08/13] Compiler Attributes: add missing SPDX ID in compiler_types.h
Date:   Sat,  8 Sep 2018 23:24:54 +0200
Message-Id: <20180908212459.19736-9-miguel.ojeda.sandonis@gmail.com>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-sparse@vger.kernel.org
Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
---
 include/linux/compiler_types.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index a3eceb3ad1b3..ed7c0e4a180e 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_COMPILER_TYPES_H
 #define __LINUX_COMPILER_TYPES_H
 
-- 
2.17.1

