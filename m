Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22203C433F5
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDEC20869
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 20:34:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZYL5GRvg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CCDEC20869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729221AbeIDA4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 20:56:19 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:46401 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728627AbeIDAzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 20:55:50 -0400
Received: by mail-wr1-f66.google.com with SMTP id a108-v6so1708683wrc.13;
        Mon, 03 Sep 2018 13:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tyByUs7kt2t4Ku+/20W32lHPeOdyJrtaUHJ/yr5hQMo=;
        b=ZYL5GRvgiZuVpzeQoLjNVuo3SjZV4wiqwKjt72UxEy3/CI/NThuoHZebRsr69Yx51C
         geaZaii6XxeV7jF19TTSrSiFGRDMDF11eVFN9IvXgV5G0iwPATAADEuwtn8y+CVk3zSD
         KWvGL24iLJ82v4DpqvomBRlmO/ocChDBPssYFjC2c7YuKYuAijO4RWOgGk2NxZo5RnG5
         dK1K36pyNTon/4LAp4Yd+6vgUHf8U783ALsKkvpo679mXGk+QWgwzx5Nk+25wR4iDw21
         6oYRG1ASbKdvrxv9kbQcAvoQip9C4XcS4U0vjPCgFkoHaLO0wy+O2/dRJtibIt2gwyjs
         Y3iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tyByUs7kt2t4Ku+/20W32lHPeOdyJrtaUHJ/yr5hQMo=;
        b=A9754KgxfMw3QEhMoyhOhMoj6PJK0Q89fpl4dINHW4LIfa/6DYHPgKu5knKN2KoJLi
         eLy99Bp8OX/9LCGPTiTudpSEMl/xjALFEqZtnnHzLZXKXeZuK8NjMW2g7c3Am5uj52fy
         tXsOELJiAB7Ki+GhVagthKBmXSTXE8PM/s67fcwvejbLh/q41Osay1R+Lk0k4GyJglRm
         Hn9B2RpEbI3lSg4rQu+NXd/vb6l5Bk5voKlS8vhxaU6XlTZJ0HuzFj73H6Gt5Kq6ztvF
         bLkpukhITbsrCFCwsvyIKk/mF8EpCg1LciXsgr7pmSHFjUSrUjqOkV3JFQZcmSKOW5qh
         dwrw==
X-Gm-Message-State: APzg51DQYwh9vjbhDOCOnH42py49uhRgy0/wkxzPXOl0NBgHhFBMXRJj
        GLqQbfRO4j4uv64eqaV+Tik=
X-Google-Smtp-Source: ANB0VdZeBaJtJEPL6a3LpSD3Q2x8NhsIMTZ8asPCyF11kwWL8GCJ3APMy3Z7rwdjFb+JhtFrwG/Ang==
X-Received: by 2002:adf:f0c8:: with SMTP id x8-v6mr587292wro.49.1536006838204;
        Mon, 03 Sep 2018 13:33:58 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id 132-v6sm12354870wmd.13.2018.09.03.13.33.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 13:33:57 -0700 (PDT)
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
Subject: [PATCH 08/12] Compiler Attributes: add missing SPDX ID in compiler_types.h
Date:   Mon,  3 Sep 2018 22:33:12 +0200
Message-Id: <20180903203316.16183-9-miguel.ojeda.sandonis@gmail.com>
In-Reply-To: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
References: <20180903203316.16183-1-miguel.ojeda.sandonis@gmail.com>
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
index 65b10b1e2a59..0cb40df59418 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -1,3 +1,4 @@
+/* SPDX-License-Identifier: GPL-2.0 */
 #ifndef __LINUX_COMPILER_TYPES_H
 #define __LINUX_COMPILER_TYPES_H
 
-- 
2.17.1

