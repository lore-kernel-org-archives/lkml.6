Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7189C0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7761D20657
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 18:29:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxQjDJhu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7761D20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730120AbeKAD2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 23:28:44 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:41292 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729964AbeKAD2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 23:28:44 -0400
Received: by mail-qk1-f201.google.com with SMTP id n68so8812236qkn.8
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 11:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=i9QXbiyYnA/VgYjBPDYvW4PFISbSCy6/dfYVSObFaYc=;
        b=oxQjDJhuaUEwT9qm2JRaDw7lEonR+UTqS3l9CkEniZatBCWkWSEnxlBkwSTKm66t8x
         HDRgEbVZEJoDG3ls9CDw8cfGxIQ6KkujMJzML3JjEhSCjIdPyBLtBpha7apvnlt1zGvR
         aQw2cG9o533bAeF9ME8tFXu5QRRspnWjcZ51OPdIOg4XFUf7Z1NwzSj4V3/MVqym7kYR
         Bhdr2ATSOXh4DBBbfn2vJnxC0A4c9aK00sSS9bLvn+OLN9K5GbChTM5/TGhU3DtPEECJ
         L9xIjz7fTQYTCn41ZAlGFQac3RJC4+hAV6y/JoyVTs/AwiYEOhMivzNAbhnLo3TuBrl7
         tELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=i9QXbiyYnA/VgYjBPDYvW4PFISbSCy6/dfYVSObFaYc=;
        b=Poy+3NwWHBHr7XSfQmplkIoPCrcQxjoFmdZCpfNcFTU8amtLa11cu+2nduNxMFnkBw
         RynfVvHBJWc02uUSN1scz+30kjSPKjo3B0vaqRU4TGj4CpahFbKaWR6y9LnKH3OysKIZ
         Qjhok4Lai/V2xF/nki+jbuJCB3pa+SzgmRjyGigZ8QZsQfMzjAPn/gECVC0/F4DBZPxx
         Hblb4fuIxe+e0UkwnfHDJW3Bo5NNgiAqvyfftDL9TwZ6EB3KZPP08TpBxPAse70jlE+W
         XvhAXG6VjdZTeGoZGDUBnuIEjlcMcPF6FQT2B3IRYt2KAUvVxy/teVL8WHt22g3Ah/5w
         gC5Q==
X-Gm-Message-State: AGRZ1gJvQY/qtX2M19+Sagr+QZbTXEphEw/1udhHvo+vE2MtxfXn4tva
        RoblVnKxyoW0kE8G5rwnjj/TPkOUypfQSssb24Q=
X-Google-Smtp-Source: AJdET5eRcaP61zN2pBbh1szgtwZHOx9bMl+cnH+PSwlQQiWDOGM8C4mACqMUkFB9adOZ7LDUO7D7a0TjwEPep0EF91o=
X-Received: by 2002:a0c:e702:: with SMTP id d2mr3032930qvn.34.1541010572185;
 Wed, 31 Oct 2018 11:29:32 -0700 (PDT)
Date:   Wed, 31 Oct 2018 11:29:07 -0700
Message-Id: <20181031182909.169342-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
Subject: [PATCH v2] include/linux/compiler*.h: add version detection to asm_volatile_goto
From:   ndesaulniers@google.com
To:     torvalds@linux-foundation.org
Cc:     akpm@linux-foundation.org, miguel.ojeda.sandonis@gmail.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Burton <paul.burton@mips.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

asm_volatile_goto should also be defined for other compilers that support
asm goto.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
V1 -> V2: drop changes to include/linux/compiler-gcc.h.

 include/linux/compiler_types.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 97cfe29b3f0a..6f1cb84a687b 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -151,6 +151,10 @@ struct ftrace_likely_data {
 #define __assume_aligned(a, ...)
 #endif
 
+#ifndef asm_volatile_goto
+#define asm_volatile_goto(x...) asm goto(x)
+#endif
+
 /* Are two types/vars the same type (ignoring qualifiers)? */
 #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
 
-- 
2.19.1.568.g152ad8e336-goog

