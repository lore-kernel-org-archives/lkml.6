Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13745C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:27:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B906320855
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JDqc0SH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B906320855
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729964AbeLJW1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:27:35 -0500
Received: from mail-yw1-f74.google.com ([209.85.161.74]:39026 "EHLO
        mail-yw1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbeLJW1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:27:35 -0500
Received: by mail-yw1-f74.google.com with SMTP id v195so7684174ywc.6
        for <linux-kernel@vger.kernel.org>; Mon, 10 Dec 2018 14:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1tffQdfy/E3lw9a3UskYkup8sDqxDmaMwmEfYiwXrIg=;
        b=JDqc0SH7wMkxsGNCJtY7GKLUduom01YNGmyb8qhrkwwfWwzsoAvc73aqnxKCHltGJc
         J25YIxS+X63YO3DYKojuB/rQle7TFZsgHqCUtl/hy9qNemyblQGZ/ARa1e+XjdDjh9Ig
         2rOvcspTA25SsmZEp5nW6YckweIenrco7xPoH3TKch8SkzqjNWWsbDZzwueh2wsZQ68v
         5pTrvShniKeXeIQ6fDHHINrnKcFY5pPnrowEsvquizs6+jKiyYPlMWtBq86p8dLKfFCm
         aX4odgIGyN4meit3wH8Pi/Ex5fwW0cENTlozk8Y66FtHbAUlL8OdqmejcJv8RPLy9VSS
         aJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1tffQdfy/E3lw9a3UskYkup8sDqxDmaMwmEfYiwXrIg=;
        b=lJByRHSInf3eHAyJm1ajs6AQDXmEQXPl/JiqrgBbVDEnq0Ha1XcjbRs/LDv9CkpAW4
         dRKQg1L8eeGweZS7eI8pw0nLoNKMvHn6IYXzHq1vC5iVtquE04KGWyQLdUh5AM6obBgC
         xUlbaJ8vbnKhKhP7KMjMWLCo3NFI9nG8Q936ODsMVJtDhs6dfCqyD8+bj3JoFPo0eNnF
         SN3cLQi4m6jNq90xeJGlX7jvRFiAEkI1VGSwpLqPhg5jjGq+qDyVXAehHu+qox221o3i
         yyHLKDO15OgAKsg7fDoB0MJlxWUAl4m1BIuv9n/Sao2SY70pc6fr9ER+QO9TEn9R6v17
         IiBQ==
X-Gm-Message-State: AA+aEWa3xmGPiGLLrRmm6nEBAgY/YVKnqm5jX3bMR583CEt3/1J2ReE/
        XKg5aq6FBzBgQBHizrgmAguorKLbg3f1XUzq9Qo=
X-Google-Smtp-Source: AFSGD/VnXewhXkMR4bv1pxIimoCl6Xoi5rHbHcrUI20SW7OklAWs5WgQdp0spbu2LHCkmnFR6ZWcfQI0N0fzsjZhB8Y=
X-Received: by 2002:a25:c74a:: with SMTP id w71mr1436927ybe.11.1544480854288;
 Mon, 10 Dec 2018 14:27:34 -0800 (PST)
Date:   Mon, 10 Dec 2018 14:27:16 -0800
Message-Id: <20181210222718.19926-1-ndesaulniers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH] x86/um/vdso: Drop implicit common-page-size linker flag
From:   ndesaulniers@google.com
To:     jdike@addtoit.com, richard@nod.at
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-um@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GNU linker's -z common-page-size's default value is based on the target
architecture. arch/x86/entry/vdso/Makefile sets it to the architecture
default, which is implicit and redundant. Drop it.

Link: https://lkml.kernel.org/r/20181206191231.192355-1-ndesaulniers@google.com
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/x86/um/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index 822ccdba93ad..bf94060fc06f 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -26,7 +26,7 @@ targets += vdso.so vdso.so.dbg vdso.lds $(vobjs-y)
 CPPFLAGS_vdso.lds += -P -C
 
 VDSO_LDFLAGS_vdso.lds = -m64 -Wl,-soname=linux-vdso.so.1 \
-       -Wl,-z,max-page-size=4096 -Wl,-z,common-page-size=4096
+       -Wl,-z,max-page-size=4096
 
 $(obj)/vdso.o: $(src)/vdso.S $(obj)/vdso.so
 
-- 
2.20.0.rc2.403.gdbc3b29805-goog

