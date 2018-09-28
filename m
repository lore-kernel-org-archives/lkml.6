Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88BDBC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:33:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46AF62172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:33:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hm9uRb81"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46AF62172C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeI1Ozo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:55:44 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:37012 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728972AbeI1Ozo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:55:44 -0400
Received: by mail-it1-f195.google.com with SMTP id m9-v6so1690580ita.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Sep 2018 01:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=F12Ux4nSgmprBmPIu8auOTbDDa3Ai8e/lVLdV13qhXM=;
        b=hm9uRb81HgnrMbMkjiZfNwqfwQiURguPC0oeEOpncLNk39/J6haYPCerxqMmXVDv+i
         pSr3B3B6zwXpCWnh6RnCk4KzOxlqRWJiA8+xL+nAKqZ29Q6z14DddhKKBw5Yz/6HHsUf
         dVaA89C7BHQKnnVYeUhx3ha8koZyyZTBh33ldDDGyCPvhuAzvl1hAekAvh6dIwSXmphQ
         KEJy1wCVqJ0KnYfv/q0VLBWQurpIkBFTITpvmFD6LcECGSQzx00SPczS/+pX6KqXsTNZ
         uTz7s/NhNh96SCuuNAwSEmOvvE6FgP/tAvH2KLw9DX/c7oHLdh1oSMXQhSCbDLz1V5ck
         hYAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=F12Ux4nSgmprBmPIu8auOTbDDa3Ai8e/lVLdV13qhXM=;
        b=IGB5geKjnQgXQ10ridmqWmmJYLM+xExFAPonR1thWb7YPcrg7hN8OSQdA5wCAzKq0T
         qTPA3HFAc1NrL9pmcc+3CoeN5NyjNK7Ow3YVTGW86PuKd1X3q0ymNiauWUQ9W9YwkJlA
         jwsu2fQ6kD1eKGcCEhauWR7ehIxauyG3gKOZl9VSrEO3o/mWL8ZtbzJMT3/9a30ZVvMG
         Ilqt48imE7P6545+INnWhPm50Wfuh3zPTNyN5dAhhnnbXmyWsUKfjRCbT76Yp4uNu+WM
         FFfX5DIcIGr46otGPdKFeyCt7g2ZaijedzJPXtcG1a+SfZ/UWYX3ILfl6Zm05xURYbUy
         /hUA==
X-Gm-Message-State: ABuFfogpu1+Lgw/rKM8Jfo/RIfLE7buXsx/9oAXUMPmF4+7X9hgHE7KI
        Vc+vlf2+fzGhp1D/VItDzqNgwK5/0/uizX1bF0knBhHw
X-Google-Smtp-Source: ACcGV63imqvnqeEMqDmC2XfVZXwPV7cqY0TjiP5n1CMGe5Se96olWXaTr51OeN92K8cUit+KPn00xZgNjZyRznk7SYU=
X-Received: by 2002:a24:9343:: with SMTP id y64-v6mr852537itd.33.1538123585897;
 Fri, 28 Sep 2018 01:33:05 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a02:978e:0:0:0:0:0 with HTTP; Fri, 28 Sep 2018 01:33:05
 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Fri, 28 Sep 2018 10:33:05 +0200
Message-ID: <CAFULd4YdvwwhXWHqqPsGk5+TLG71ozgSscTZNsqmrm+Jzg941w@mail.gmail.com>
Subject: [PATCH resend] x86, asm: Use CC_SET()/CC_OUT() for __cmpxchg_double
To:     linux-kernel@vger.kernel.org
Cc:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove open-coded uses of set instructions to use CC_SET()/CC_OUT()
for __cmpxchg_double.

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 arch/x86/include/asm/cmpxchg.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/cmpxchg.h b/arch/x86/include/asm/cmpxchg.h
index a55d79b233d3..bfb85e5844ab 100644
--- a/arch/x86/include/asm/cmpxchg.h
+++ b/arch/x86/include/asm/cmpxchg.h
@@ -242,10 +242,12 @@ extern void __add_wrong_size(void)
        BUILD_BUG_ON(sizeof(*(p2)) != sizeof(long));                    \
        VM_BUG_ON((unsigned long)(p1) % (2 * sizeof(long)));            \
        VM_BUG_ON((unsigned long)((p1) + 1) != (unsigned long)(p2));    \
-       asm volatile(pfx "cmpxchg%c4b %2; sete %0"                      \
-                    : "=a" (__ret), "+d" (__old2),                     \
-                      "+m" (*(p1)), "+m" (*(p2))                       \
-                    : "i" (2 * sizeof(long)), "a" (__old1),            \
+       asm volatile(pfx "cmpxchg%c5b %1"                               \
+                    CC_SET(e)                                          \
+                    : CC_OUT(e) (__ret),                               \
+                      "+m" (*(p1)), "+m" (*(p2)),                      \
+                      "+a" (__old1), "+d" (__old2)                     \
+                    : "i" (2 * sizeof(long)),                          \
                       "b" (__new1), "c" (__new2));                     \
        __ret;                                                          \
 })
--
2.17.1
