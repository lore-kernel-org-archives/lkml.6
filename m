Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13455ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8E4221535
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 17:23:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uWF+VHcD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8E4221535
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388118AbeITXIK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 19:08:10 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36715 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727556AbeITXIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 19:08:09 -0400
Received: by mail-wm1-f54.google.com with SMTP id j192-v6so361207wmj.1;
        Thu, 20 Sep 2018 10:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OlvTLHPATLzvPvQ7mfFI3Yc5QOC2M/uMcBZ3tLM5/xU=;
        b=uWF+VHcDMKQTEDn0EX8oFzhiWfwrMuJq1/36VhW3GXLzTmFbRjmNp/3XGvJuabWpC6
         A6QpkVVejUnHIm0GkfP8w6YCyRUfT24CRdDi5Nv5w50RXZHfW5WTYCOIBzwYQi3Z9ohS
         zAfIUmhnIHzo/6L0pT1pNISEk/nZBpSMOwzxgkLh7TyG5bKxEpqBc1yRtKLLJZn8LGli
         iPnn88f/61dLgX7zJNCypU4h64hqboC43JcqJCUWzzXsqTtocxWXMIOtZTjTTZ9ajkQh
         NDIZrtBCTaOfW6QjLztzV2V9c5MhzFhE0aAJ+9L5A0Bp36L4qhBFwKdrBxZItM3e3Nof
         Y5WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OlvTLHPATLzvPvQ7mfFI3Yc5QOC2M/uMcBZ3tLM5/xU=;
        b=CyEgYjm7VKSzhRlGPN1qc5ESFYY38s3vruDcleofGR4x7Zga1yhJb8CG8Ntvf2ZC21
         uTx+7EH8aFwSRBvbKrEwZlqtDn1vxu/XpY7bAbvDyoSrkyKE5gStagpxW7AYBf7Q8pTI
         bbIdImM1+nOnUncFmUdy7Nb5p2/Bs/1HxAhsA+ta0ZhL0ZBBz69OiuNkrfBKA10kNXqp
         1YJUqwCWGjfUxG0pjlR3huGXmbcGfdmVfe4wNaC0uTSBrJO9cwMgyToMR0FCZ9K3LnkA
         g7Bj6Xb/tZjrbKoSszjH7vXSskS4/Mig9OkV/Sm8A5wpr3o19jwWM5d6s40bDzNDl9/D
         XB7g==
X-Gm-Message-State: APzg51DODMulXZqvefmVa9pppojJlvet8cB/+qlznQYYwx4Ed4FHIc4G
        MhVIbjb7CuY4SYA1FU10rIv9y2HGzr4=
X-Google-Smtp-Source: ANB0VdYJSl2WZ6jGPdpGpfc2OLlImmnWzmsdD94LlzGUb5v5V/Cy7v0DLTIfvI3QZmRYLpX0YB63LQ==
X-Received: by 2002:a1c:3d07:: with SMTP id k7-v6mr3938145wma.146.1537464217504;
        Thu, 20 Sep 2018 10:23:37 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id q200-v6sm3466562wmd.2.2018.09.20.10.23.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 10:23:37 -0700 (PDT)
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
Subject: [PATCH v5 06/15] Compiler Attributes: add missing SPDX ID in compiler_types.h
Date:   Thu, 20 Sep 2018 19:22:52 +0200
Message-Id: <20180920172301.21868-7-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
References: <20180920172301.21868-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
Reviewed-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
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

