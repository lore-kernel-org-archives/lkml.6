Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F34CBC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C4C720837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 17:31:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="phy3mZKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C4C720837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727282AbeHaVj3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 17:39:29 -0400
Received: from mail-qt0-f170.google.com ([209.85.216.170]:37809 "EHLO
        mail-qt0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbeHaVj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 17:39:29 -0400
Received: by mail-qt0-f170.google.com with SMTP id n6-v6so15381294qtl.4
        for <linux-kernel@vger.kernel.org>; Fri, 31 Aug 2018 10:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=I7fscWPIjoIlIctB8QgH+aLQU48eHWdM1ILitmf/lRg=;
        b=phy3mZKfOrt2M5cmQsv5w85yDXcH5gEnJErcWlKE/j7MilUDWcIjaiB9y5MxCqKYTP
         RYn+QUAnbrVTLh/RYeAr3rgxCbIyVS3B9OXQd+aMZbYazWjNH3LfxVCtfWJUdEiTEKLq
         aVDa4h2z6FEMUDHZkRzTWOz/Cm7q14QeEWks/uHff6LNppvwse9QV7ndr7/55dKwmIus
         Bkr4gWrFGA+g+evnhO92nDTQxVbnMPls24yKPeOxf5kWfahBua0XjyOmdhw7/2/12Gd1
         j22trhATntU4BxSJ2nh0ZcTW1UoN26iv7FVZJMLI/t68DcALv+uXpvdo4KCK4O83s9Qi
         Xx6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=I7fscWPIjoIlIctB8QgH+aLQU48eHWdM1ILitmf/lRg=;
        b=NanRIIa196m/bxkW1FPXrp0IRRysJ0PD0gIXtkBC6sZ0vaaFGOhoP+5cqeQZtQXc6Z
         F01Ejk+wT+XYWvsCPbtuPGCkZrqN1NoM7O3c3Tc2tjrJ3ffZGkqNoybJIxqcDmiCemtH
         JdEkI+A0YAtP8pJ+2DrBozD/0GP1Ef/P+qoXF9Ivk3zusYwscfiRJC+NCWNazC8TutPy
         f8BIsQGI+xfTfco32NQU9ZUggQNUSQgqhwBBeoWKZ7svkfEy8zrz78wqkd1M9ORPHjfB
         jRo+DtjTjCIEnRdJf+O6lnDc24lQi70276XqjcyTZ5rww04tYtz0yQhyYnOKeLdChZYo
         KaUQ==
X-Gm-Message-State: APzg51Cm2tQRKExGHyAm603TfrXaO6rnyYlow5/yos+DBF4ZVc8MCgN+
        G/BkTHDIlK3Z7UI9fIwKDa2V56fqxAGlk0DyFgc=
X-Google-Smtp-Source: ANB0VdYMhFBRJaeOFVOVFvevDjOSEQPdCV7hqIVdTPjuTJUmQVj6aWqL+R0TfU3sVYxqTTDR1SWF+RLXkmK4zj59L1o=
X-Received: by 2002:a0c:a202:: with SMTP id f2-v6mr16114587qva.170.1535736658193;
 Fri, 31 Aug 2018 10:30:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac8:33b1:0:0:0:0:0 with HTTP; Fri, 31 Aug 2018 10:30:37
 -0700 (PDT)
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 31 Aug 2018 19:30:37 +0200
Message-ID: <CANiq72=exw5RUNiZ2svNobeiX4vOhcCB1xs4fQsma2LJDDM5zg@mail.gmail.com>
Subject: [PATCH v2 0/7] Compiler Attributes: cover letter
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This is a quick cover letter for the series, explaining the
differences between v1-v2.

Added "features" of the patch series:

  * Added direct URL links for all attributes to gcc & clang docs.

  * Added proper support for gcc 4.8 and 4.9 (i.e. for assume_aligned
and no_sanitize_address).

  * Added the reason for each optional attribute to be so, for future reference.

  * Removed some __CHECKER__ tests

  * Removed __deprecated_for_modules

  * Removed noinline and noclone inside notrace since we are now post gcc 4.6

Modified v1 -> v2:

  * Moved quite a few things out of the patch into 1-6, so that the
7th is easier to read.

  * Sorted them all (whether they are optional or not) by attribute name
    (this actually puts some similar ones in the same group, e.g.
format and unused
    and I think it may be the best of both worlds).

  * Moved __must_be_array out of compiler_types.h to compiler.h (since
it is not really used as a attribute).

I might be forgetting something. Also, note that I have not
compile-tested as much as last time, so please consider it untested
for the moment. Take a look!

Cheers,
Miguel
