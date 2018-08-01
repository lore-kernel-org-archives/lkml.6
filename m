Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E180EC28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:53:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9815320844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:53:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EpT9O6J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9815320844
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732256AbeHAUkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:40:47 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:33801 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731836AbeHAUkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 16:40:46 -0400
Received: by mail-vk0-f73.google.com with SMTP id o62-v6so8346153vko.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Aug 2018 11:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cWpRCNbR9wZRRO3Bu9vAA1N3rpTKgZMYLbuWcYGQ3hs=;
        b=EpT9O6J5umPO0tilCs1G43hmNepE5j2ixy8hXIC/1U7YFCq/Tw18osYKdrv75G004Z
         /9RrzYK8dEEcXDVxAAoPp5BD6tQhHXlDsEyv/Mo8sqx5JRfnNj4GqAO55bSYvVeQWd5P
         fmPLi3zMIauWJNThKDcL+c0KWxhGS9Zh/9o4xV9wy7F1uBAW6p/eOuA85siFDExbAwG6
         CLnBJQqDRkfZsH62Tj1LPgKTn0x8QsP2XhO2h/2uHvtq60vXz7GdBmu1dJHHpcdSfN2A
         vjXqa5QaT4aBfVd93BjpYRSR6C3M0lzoIMyGXHFLiz37++6AgV8tGHAZJLaUh6Lwo7Sr
         GDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cWpRCNbR9wZRRO3Bu9vAA1N3rpTKgZMYLbuWcYGQ3hs=;
        b=LzFo3KwjO7PfuZFahioDLCPoQK8bE6NXD4mj2oa09P1aR2HnPilSm0JuMX5H0UfuAT
         atir3q0nolm+B9k89KeWUVL4P84cMpBaFCz+VYlb1C5IWoRxGB2srvK5Q1ORfOQAIEfN
         ZL7g2Tn9fSP4VHsaznZtnPXmrbvTzZgWfuvdkyNu3mavPZa/ACwEFfwn79VAIK5oDu6L
         snaHJdq3X8MzrBdJiVpCa5TC6PJ9zMyDcgRNUeQHFSHP2kg77DMr7PA2ct8EWxF75f3O
         ZcgVrOeUNZyWwUEY1wanbUPaMNqQ+X9qXd8rE7UcYluxkCignbFO/69J8fJbGMN6lhzH
         AWsA==
X-Gm-Message-State: AOUpUlHJT9oOqszmYzKihPCYPwkUf13lLQ1iqvqxazT7dz8l9NeY1XRB
        NmKNM7J50K4MS0kUq9PNSjhOMALOnYlX72ItsOY=
X-Google-Smtp-Source: AAOMgpcAi0WCR5OeoHOvbSyZ/xInif3hjRzYYjODaLEJS9maNrcyFHx1EDgkwxFfZMLwEiw4w4guyD8KS9hPZPB+aAA=
X-Received: by 2002:ab0:a8f:: with SMTP id d15-v6mr12630777uak.54.1533149617208;
 Wed, 01 Aug 2018 11:53:37 -0700 (PDT)
Date:   Wed,  1 Aug 2018 11:53:31 -0700
In-Reply-To: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
Message-Id: <20180801185331.39535-1-ndesaulniers@google.com>
Mime-Version: 1.0
References: <CAKwvOd=DnrfVcuO8Pg=FBrub1M4A8LzarZbtv6m=JO_r6Ea6aQ@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH v2] sh: prefer _THIS_IP_ to current_text_addr
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     ysato@users.sourceforge.jp, dalias@libc.org
Cc:     akpm@linux-foundation.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the effort to reduce the code duplication between _THIS_IP_
and current_text_addr(), let's consolidate callers of
current_text_addr() to use _THIS_IP_.

Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
---
 arch/sh/include/asm/kexec.h | 3 ++-
 arch/sh/kernel/dwarf.c      | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/sh/include/asm/kexec.h b/arch/sh/include/asm/kexec.h
index fd5f331a3912..927d80ba2332 100644
--- a/arch/sh/include/asm/kexec.h
+++ b/arch/sh/include/asm/kexec.h
@@ -4,6 +4,7 @@
 
 #include <asm/ptrace.h>
 #include <asm/string.h>
+#include <linux/kernel.h>
 
 /*
  * KEXEC_SOURCE_MEMORY_LIMIT maximum page get_free_page can return.
@@ -61,7 +62,7 @@ static inline void crash_setup_regs(struct pt_regs *newregs,
 		__asm__ __volatile__ ("stc gbr, %0" : "=r" (newregs->gbr));
 		__asm__ __volatile__ ("stc sr, %0" : "=r" (newregs->sr));
 
-		newregs->pc = (unsigned long)current_text_addr();
+		newregs->pc = _THIS_IP_;
 	}
 }
 #else
diff --git a/arch/sh/kernel/dwarf.c b/arch/sh/kernel/dwarf.c
index 1a2526676a87..bb511e2d9d68 100644
--- a/arch/sh/kernel/dwarf.c
+++ b/arch/sh/kernel/dwarf.c
@@ -599,7 +599,7 @@ struct dwarf_frame *dwarf_unwind_stack(unsigned long pc,
 	 * time this function makes its first function call.
 	 */
 	if (!pc || !prev)
-		pc = (unsigned long)current_text_addr();
+		pc = _THIS_IP_;
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	/*
-- 
2.18.0.597.ga71716f1ad-goog

