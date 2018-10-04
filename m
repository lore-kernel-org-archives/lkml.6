Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F66C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:21:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7C0120652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 14:21:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7C0120652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727540AbeJDVP1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 17:15:27 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:35953 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbeJDVP1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 17:15:27 -0400
Received: by mail-ua1-f68.google.com with SMTP id b3so3471091uak.3;
        Thu, 04 Oct 2018 07:21:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=80mK9cXUh/w1d9a8Orsv+1HXHc67l7VaNHmDHFUb36w=;
        b=Uvgp2KVtsGJ4sLJ73Cn4gQQSaWySxWdBxII2SWqviMUhs5V9X64tSvNemM7IWGpD7w
         GlcoFYfPlibZjjFLlsHNgoO15QzZCuH4XsHMl/jCpIhEg9J0rsMeHbTU9ZZe2a98Iw3t
         H83YcuV/SrqCk3cM4tZoTs4swO9iC1XoREj/TtlXwjeByXjg955srqO95Vz4ej5ub+dm
         SQDc78cG8V3GnxGDIHKGA89unuJbgofFaUDwMhw1lugCGrrIzQml0ab0iYQiRlTk9TID
         FKcsOMuRc/eiqAqchWcbbvRm062HyMu2WNhAk3xhjCXYCharbtpIIjAVdkNsb7CSjc6F
         6T8Q==
X-Gm-Message-State: ABuFfojNWSjq9EBsApW6AoazZNlst0qDWOG4B7d6Ql+3//YcvOHdEiih
        XaR7SbxWpnGInymPd+VOk+tHp78HxXuke9Mq6thtqqao
X-Google-Smtp-Source: ACcGV60jcT6D9eTLT1loWz3NDKJWvyGSoqjGFWASPULdOMXuLvt1h7VwaOONfalQCxtpU+c/ju1qdryEckdH4Ont9fk=
X-Received: by 2002:ab0:1624:: with SMTP id k33-v6mr2824202uae.0.1538662915127;
 Thu, 04 Oct 2018 07:21:55 -0700 (PDT)
MIME-Version: 1.0
References: <20181004183449.36bcc93b@canb.auug.org.au> <20181004134644.GA9130@roeck-us.net>
In-Reply-To: <20181004134644.GA9130@roeck-us.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Oct 2018 16:21:42 +0200
Message-ID: <CAMuHMdXfhbFi8HYtqd6BeACyG64_eQvoiSQ7DMpyOmdXEXPymg@mail.gmail.com>
Subject: Re: linux-next: Tree for Oct 4
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 4, 2018 at 3:47 PM Guenter Roeck <linux@roeck-us.net> wrote:
> Time for a status report.
>
> Build results:
>         total: 135 pass: 121 fail: 14
> Failed builds:
>         arm:allmodconfig
>         i386:allyesconfig
>         i386:allmodconfig
>         m68k:defconfig
>         m68k:allmodconfig
>         m68k:sun3_defconfig
>         mips:allmodconfig
>         parisc:allmodconfig
>         powerpc:ppc6xx_defconfig
>         s390:defconfig
>         s390:allmodconfig
>         s390:allnoconfig
>         sparc32:allmodconfig
>         xtensa:allmodconfig

Most (all?) 32-bit builds are broken due to commit 571ed1fd2390f74e
("SUNRPC: Replace krb5_seq_lock with a lockless scheme"), presumably fixed
by Arnd's "SUNRPC: use cmpxchg64() in gss_seq_send64_fetch_and_inc"
(https://lore.kernel.org/patchwork/patch/994909/).

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
