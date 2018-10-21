Return-Path: <SRS0=f4JY=NB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36086ECDE43
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2241204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Oct 2018 17:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qzElEMZP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2241204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbeJVB3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Oct 2018 21:29:34 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:36852 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727835AbeJVB3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Oct 2018 21:29:34 -0400
Received: by mail-wm1-f67.google.com with SMTP id a8-v6so8004423wmf.1;
        Sun, 21 Oct 2018 10:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=q5w/nTQUtgeSapqPfzXNGuFUr8eXJwPXsiCxfn1bH64=;
        b=qzElEMZPacAbz/PqxTnWNZTPeyJykLJR8zfQbpSmIjLxwYDELMQQZRBvxFBdEixbI/
         4tnueCOFoSnkuMqdg2BMNhM/mj5oVRnd28nKS/HYQQsjE2dUbcOy0209EHdmgCZCthWg
         cAbg7JwhE1+yNyQxe0EG+YXAtLNJyPuLYAmSGXGy8oE4fyDFF8qz8M55efb1uSUAbOk4
         TdowzH0KFq1m97OJhqozFY56bDR9hE+LITZkUHVgGQxMNrBkQZh1aaDCpCh8vecA0Q60
         Q45H2RZ7Ub+Ast8PSZI5m5XOBHlLlav5+hSKAOlpbqIIWSuodYpc6Lle0kggiPjKvYsv
         qgxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=q5w/nTQUtgeSapqPfzXNGuFUr8eXJwPXsiCxfn1bH64=;
        b=WS1g4Hhio1MIUq7dMHfojYbmcMpsXcN+5C49YxzAzf6xX7kdPvRglUKAWtty4+yATy
         dX0/nK2DktRhIxO+hjuYGzS7LFNlzJ9Jy70x8bdeEGVqwsTf7QI+z1P6H/Gchw45YDp1
         L+BlNYLqCpG7zyQs6vOkvXiXuD32eawBCW/wddk1uKVhngEFmPxjWa4vv93ejtJ2qyDn
         sTtX9SK/bK7hlAoeVlAjiomP4pneiUmU/SLCMZYUl3CUQSUBXH+b9oJFXMDNSWG4/1o1
         VjJR4lbHMCVhpGXVv7EZ5Z3pfaSqZ9ykwWZcYTtBDdDJXA+Jx2fXcIJTbv2wIeoYz4tC
         0TWA==
X-Gm-Message-State: ABuFfogzY/IWW0RHYafxu6wUJjimsYng3uWtCb1/qnAWEzcFPX/WFSKD
        6sSMzRt24HU2nYJCsoZeOt0=
X-Google-Smtp-Source: ACcGV611pibJsDHGqOR1EI4l/CMwB1KwwrS5/uyf0F2U3WdTt8TEDo6mwfmmvSrpeUizyqt2uRc3tQ==
X-Received: by 2002:a1c:c683:: with SMTP id w125-v6mr12546147wmf.117.1540142073090;
        Sun, 21 Oct 2018 10:14:33 -0700 (PDT)
Received: from localhost.localdomain (62.83.35.8.dyn.user.ono.com. [62.83.35.8])
        by smtp.gmail.com with ESMTPSA id y16-v6sm20860113wru.18.2018.10.21.10.14.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Oct 2018 10:14:31 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
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
Subject: [PATCH 0/2] Compiler Attributes: __fallthrough
Date:   Sun, 21 Oct 2018 19:14:12 +0200
Message-Id: <20181021171414.22674-1-miguel.ojeda.sandonis@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These are two patches are meant to go on top of the rest of the compiler
attributes series on:

  https://github.com/ojeda/linux/tree/compiler-attributes

which will be sent to Greg for the next merge window.

Please review them and let me know! (specially if someone is against
__fallthrough for some reason :-).

The first patch introduces the attribute and gives the rationale.
The second patch is an example of usage.

This was started in the following thread:

  https://lore.kernel.org/lkml/20181017062255.oiu44y4zuuwilan3@mwanda/

Cheers,
Miguel

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
Cc: Olof Johansson <olof@lxom.net>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Paul Lawrence <paullawrence@google.com>
Cc: Sandipan Das <sandipan@linux.vnet.ibm.com>
Cc: Andrey Konovalov <andreyknvl@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: David Rientjes <rientjes@google.com>
Cc: Willy Tarreau <w@1wt.eu>
Cc: Martin Sebor <msebor@gmail.com>
Cc: Christopher Li <sparse@chrisli.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Joe Perches <joe@perches.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Dominique Martinet <asmadeus@codewreck.org>
Cc: Stefan Agner <stefan@agner.ch>
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-sparse@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org

Miguel Ojeda (2):
  Compiler Attributes: add support for __fallthrough (gcc >= 7.1)
  Compiler Attributes: auxdisplay: panel: use __fallthrough

 drivers/auxdisplay/panel.c          |  6 +++---
 include/linux/compiler_attributes.h | 18 ++++++++++++++++++
 2 files changed, 21 insertions(+), 3 deletions(-)

-- 
2.17.1

