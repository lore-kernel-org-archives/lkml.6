Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF78BC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0D6621903
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 17:55:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qMF2eoYC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390901AbeLURzV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 12:55:21 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34506 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731626AbeLURzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 12:55:21 -0500
Received: by mail-pg1-f196.google.com with SMTP id j10so2834217pga.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 09:55:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wZtEj0971+V2tIVyM/LvVmpA3o38XeK4CDzb54p+S6g=;
        b=qMF2eoYCS2DefMCPPq/yjVvbBQqG6Uv6QB+EDPBpsbq3FGw/C0f3qkeogMfOI3Ive0
         QquC6lkxUXa9pHuUDP5BqQLtFXVM2byBLpGDFU5ScbaexMfwjz3i0BjR9xd8NLgg7ku9
         mnzojkK92uYQQRgnMbllg/BeUnStFOna/Su8BOtM2jFXibGolCYwLkB60jkLJDO7jm9e
         LJWVK58cStxQJHPu5lYqOjRmUQtn7qDfx1EKSnvFqtublv3/Ovn9hW5WwFvSfcR2AXfp
         p9INThhB1USaCdUD4LLlR6pJ4fmxema2VpEuCuCwffy7+pl72wHBy9hFUeHNShYYCBYO
         8kZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wZtEj0971+V2tIVyM/LvVmpA3o38XeK4CDzb54p+S6g=;
        b=tJ3NwvXyUSCqb00Xdl1RotoZWRScf2aUHJdGh4W0QoUx4nfCD1O8EQTxvdfyFbGgEB
         /v41B+uNHcb19Lq9z7lCJAkU+Ut7tPrnhGgDq9XJ9BQW8leTEtGl6B88GoRwTsj+GmY6
         D5oFZqanHNAVfaBZ4WDGgZtmrcpzl/VJ9jcnFl//dp0Hy/ArNmzVs8jTKTU6dV4rvmKY
         EpgrEpQidU1zs4iQ1EKcLFxg7A0uKwn1Ss2pAGHK8tkM3E7V5qZsDKKYabu3/y6gyVp/
         5n8Y2JaHwgJsdctp9fW9twjhKBut/7E46LF3ViYjdJ1bAhtSoup+cfdhN4WFHeLK7C2y
         wF0Q==
X-Gm-Message-State: AJcUukfNTrvmrZP+CZ55sq/rdyMGaeeNCZTkdcZhinR2IcfLKIz7VT7R
        8/tM+XwuqZMYdK8Luvz0BOlVk7/XzS+szX/j4ybGbQ==
X-Google-Smtp-Source: ALg8bN70ZOkiOMU/ta5Q4DM4NTTVUypBZ6BawXZKDxhWOrGZBVxNawDWWj/PK6JILlbFOIOynwEfCHQHpTYc16PwSUw=
X-Received: by 2002:a63:42c1:: with SMTP id p184mr3317692pga.202.1545414919590;
 Fri, 21 Dec 2018 09:55:19 -0800 (PST)
MIME-Version: 1.0
References: <20181220193856.7833-1-natechancellor@gmail.com> <20181220215727.GA29539@flashbox>
In-Reply-To: <20181220215727.GA29539@flashbox>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Dec 2018 09:55:08 -0800
Message-ID: <CAKwvOdngQgK4f+TLNKx-d=iKTCCciLCqKtHEsAUhACFyzsaN_Q@mail.gmail.com>
Subject: Re: [PATCH] ACPI / tables: Add an ifdef around amlcode and dsdt_amlcode
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 1:57 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> On Thu, Dec 20, 2018 at 12:38:56PM -0700, Nathan Chancellor wrote:
> > Clang warns:
> >
> > drivers/acpi/tables.c:715:14: warning: unused variable 'amlcode'
> > [-Wunused-variable]
> > static void *amlcode __attribute__ ((weakref("AmlCode")));
> >              ^
> > drivers/acpi/tables.c:716:14: warning: unused variable 'dsdt_amlcode'
> > [-Wunused-variable]
> > static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
> >              ^
> > 2 warnings generated.
> >
> > The only uses of these variables are hiddem behind CONFIG_ACPI_CUSTOM_DSDT
> > so do the same thing here.
> >
> > Fixes: 82e4eb4e9653 ("ACPI / tables: add DSDT AmlCode new declaration name support")
> > Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
> > ---
> >  drivers/acpi/tables.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> > index ccb90eff00e5..48eabb6c2d4f 100644
> > --- a/drivers/acpi/tables.c
> > +++ b/drivers/acpi/tables.c
> > @@ -712,8 +712,10 @@ acpi_os_physical_table_override(struct acpi_table_header *existing_table,
> >                                         table_length);
> >  }
> >
> > +#ifdef CONFIG_ACPI_CUSTOM_DSDT
> >  static void *amlcode __attribute__ ((weakref("AmlCode")));
> >  static void *dsdt_amlcode __attribute__ ((weakref("dsdt_aml_code")));
> > +#endif

Thanks for this patch Nathan.  I'm curious if rather than adding a
second set of preprocessor guards, we could simply move the
declaration of these 2 variables closer to their use, putting them in
the existing preprocessor guards from 82e4eb4e9653?

-- 
Thanks,
~Nick Desaulniers
