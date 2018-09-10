Return-Path: <SRS0=FvrY=LY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82195C433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D83820870
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Sep 2018 16:51:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UyeYrVAg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D83820870
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbeIJVqf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Sep 2018 17:46:35 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36966 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbeIJVqf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Sep 2018 17:46:35 -0400
Received: by mail-pg1-f196.google.com with SMTP id 2-v6so10769503pgo.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Sep 2018 09:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fj8Vwgnm5vG9Ic+sWDoy9ZkH/s6g4C32w7cC6u21FHk=;
        b=UyeYrVAgbxe05YoTgD2U3AQ9jL+xQHgJeyWAv8PYbEjMiGGumYQlFYb7AjqBREWYG0
         69SgiBHluHZbsAAEDY55h67fygaPAPr8gepUP29i7HN7C/2hZPVtBrP7cWcSpuGZfDiU
         6UmS46NUN43GZXv6p4IwUTcARXN1OJ1JmWf/w2cgVvzfuRpR6RqUdplHhWpATHqecuMT
         pokizQ9+d3cJMhgXze8bV8AgNFhIfzPABczW9iDsb89Ll/jFZ31Tjesv4NI30CypaNW4
         uU8oUZCZ5OhE/BFw9mFQZNzmRoDbegkJHhqwgbOsRe1Ht2jZoIQ6tvJL1D/KQRJuqx1K
         rNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fj8Vwgnm5vG9Ic+sWDoy9ZkH/s6g4C32w7cC6u21FHk=;
        b=oFAz5j1GZdYEQo2jH/qf7ECuZAR9RMdmEDDJVGruzIRoAzkf/GIikvToEkirEAknY1
         Y116kHQ/Ub5s460sNb6lz7dcgcjsZqR17PoxZcB6wihZRNKwHs8mvIN9SwZLCl13pI4S
         3ghK2iL2NTFpN4k1QK8G4b2Z8RqrPk/8Chx3rbLP29J0j+isUvEt7foGqHKP50K6prYd
         IDoHu0VB1EIoud4IrNzrt5emMtbNcFsTAsBotcuiNnDQ0c5HixB8kKMkfO0SjmC5KYzN
         it1hmpw8qH63QzTzl8c6NLs5EZt3S3LRSktMWSSrfo187fmptQCkTQl4LnomRy4KsD8T
         lPEw==
X-Gm-Message-State: APzg51DuZYc5KlasoPg001pnpy8iPeCQIjZZbgBo7I5lfJdKNJwphjzr
        7OJuw4T4d4lvv+OiRruXSNgwqV1PKUTKcO9QH+O3Ww==
X-Google-Smtp-Source: ANB0VdZ4rclKUjkwKyig25pL38OC2WHKdpNGniTvnyF9lx39HcT9yuz54pRKteuRa1JGeDrDvGsZ8UDGPOTLGWysuKI=
X-Received: by 2002:a63:1363:: with SMTP id 35-v6mr23759654pgt.202.1536598296091;
 Mon, 10 Sep 2018 09:51:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180910060455.20409-1-stefan@agner.ch> <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
In-Reply-To: <CAK8P3a2cc741UqFSk+hXpC2s4S+A+0FuiM1yP=Z4rC18sJHq9g@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 10 Sep 2018 09:51:24 -0700
Message-ID: <CAKwvOd=E6+QSoRqcMJ0o1_q8VSMO8Zoi75e+zhj2SRSTdfacJw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler-clang.h: define __naked
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Stefan Agner <stefan@agner.ch>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Will Deacon <will.deacon@arm.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>, dwmw@amazon.co.uk,
        Paul Lawrence <paullawrence@google.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 10, 2018 at 5:14 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Mon, Sep 10, 2018 at 8:05 AM Stefan Agner <stefan@agner.ch> wrote:
> >
> > ARM32 arch code uses the __naked attribute. This has previously been
> > defined in include/linux/compiler-gcc.h, which is no longer included
> > for Clang. Define __naked for Clang. Conservatively add all attributes
> > previously used (and supported by Clang).
> >
> > This fixes compile errors when building ARM32 using Clang:
> >   arch/arm/mach-exynos/mcpm-exynos.c:193:13: error: variable has incomplete type 'void'
> >   static void __naked exynos_pm_power_up_setup(unsigned int affinity_level)
> >               ^
> >
> > Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> > Signed-off-by: Stefan Agner <stefan@agner.ch>

Cool, thanks for this patch! I'll admit I need to start testing more
architectures with Clang.

>
> > +/*
> > + * ARM32 is currently the only user of __naked supported by Clang. Follow
> > + * gcc: Do not trace naked functions and make sure they don't get inlined.
> > + */
> > +#define __naked __attribute__((naked)) noinline notrace
> > +
>
> Please see patches 5 and 6 of the series that Miguel posted:
>
> https://lore.kernel.org/lkml/20180908212459.19736-6-miguel.ojeda.sandonis@gmail.com/

Yes, I'd prefer those 2 patches.

>
> I suppose we want the patch to fix clang build as soon as possible though,
> and follow up with the cleanup for the next merge window, right?

Can we take Miguel's two patches from above in the ARM tree, since
this attribute is only used on ARM, IIUC?

-- 
Thanks,
~Nick Desaulniers
