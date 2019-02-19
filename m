Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA4DC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A2552083E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 23:47:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="gTtTSGhG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729813AbfBSXrs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 18:47:48 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:64632 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbfBSXrs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 18:47:48 -0500
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1JNlbuU005047;
        Wed, 20 Feb 2019 08:47:38 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1JNlbuU005047
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1550620058;
        bh=kJUoHuqr32i8RnX7QL8ismQ7zHoW0S4RUk5y5Ujmhk8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gTtTSGhGinMk7Aha6hfZCKqE4mwMOePa2+r5vu0LthQusxWTRottQU97GgWY7sBev
         1d87r3UxwRjSLwMVO+zc01+SKg/fXd7yuwHicW4PbDhdj8WA3VwIQh3zoW/nHnWdg5
         x7peQpF+04Sygv3Vb9/Td7u/0ORLjz0WAVfr+aVgfCJUkgdP5oiX477oi9Uk1BX/Z3
         PvR4yHvyUKd5VQWPuaerkEWyMqqoPxoNeketscBVD3ly2uzzjcGDQBb5mk4wz2V+Rq
         tNAiFg5NuQMzro34rYUZFACPz/PRY3EfZtHjWxjTGzAa9uL7lXZ1SJ8/EigtFlGWeb
         QBDpycblillMg==
X-Nifty-SrcIP: [209.85.217.49]
Received: by mail-vs1-f49.google.com with SMTP id u64so12829057vsc.12;
        Tue, 19 Feb 2019 15:47:38 -0800 (PST)
X-Gm-Message-State: AHQUAua9atZDXKCn2uhjPF+YmNUzdgwN18AYcWagU4WnuvvOnMjEfhx3
        GeBWj4UmYo8/+gMK1bjH7qJV79yymdKNt2wwYlE=
X-Google-Smtp-Source: AHgI3IbNZeMOU1beoJbkAN9R7T8RCNq/CCSy9aglbTTPci3uHJo8QDLlAai5U8N9Xx9Tz9m3Qcscc24WGNF012k2O9o=
X-Received: by 2002:a67:7f43:: with SMTP id a64mr16644338vsd.155.1550620056964;
 Tue, 19 Feb 2019 15:47:36 -0800 (PST)
MIME-Version: 1.0
References: <20190207123022.7961-1-2pi@mok.nu> <CAK7LNAQZ7PDZ4+uZu-FT4V8yw9oUGz6e++9xSshWJvALj3gN0Q@mail.gmail.com>
 <20190219200837.d34cxg2d7gqxlvhs@mok.nu>
In-Reply-To: <20190219200837.d34cxg2d7gqxlvhs@mok.nu>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 20 Feb 2019 08:47:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNASU=Jf7aYnnn_7DWgxLz4sf4=x1HZaoGQW2rSXVbFO9Bg@mail.gmail.com>
Message-ID: <CAK7LNASU=Jf7aYnnn_7DWgxLz4sf4=x1HZaoGQW2rSXVbFO9Bg@mail.gmail.com>
Subject: Re: [PATCH] modpost: file2alias: define size of alias
To:     Mattias Jacobsson <2pi@mok.nu>
Cc:     Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 5:09 AM Mattias Jacobsson <2pi@mok.nu> wrote:
>
> Hi Masahiro,
>
> On 2019-02-18, Masahiro Yamada wrote:
> > Hi Mattias,
> >
> > On Thu, Feb 7, 2019 at 9:31 PM Mattias Jacobsson <2pi@mok.nu> wrote:
> > >
> > > The size of the variable alias provided to do_entry functions are
> > > currently not readily available. Thus hindering do_entry functions to
> > > perform bounds checking.
> > >
> > > Define the macro ALIAS_SIZE containing the size of the variable alias.
> > >
> > > Signed-off-by: Mattias Jacobsson <2pi@mok.nu>
> >
> >
> > Sorry for late reply.
> >
> > I can apply this to my kbuild tree shortly, but
> > it looks like a prerequisite for your
> > "platform/x86: wmi: use MODULE_DEVICE_TABLE() instead of MODULE_ALIAS()"
> >
> >
> > If you want all the patches to go through x86 platform-driver tree,
> > I am fine with that too.
>
> I don't mind either way, however I've asked the x86 platform-driver
> maintainers if they have a preference in this matter. You should have
> received that mail otherwise see [1].
>
> [1]: https://lkml.kernel.org/r/082d3d38b7dde6050b6b3e518ada439eade65b2c.1550603967.git.2pi@mok.nu


I saw it.  The 2/8 uses ALIAS_SIZE.

So, I think it will be better to include this one in your series.
If necessary, please feel free to add

Acked-by: Masahiro Yamada <yamada.masahiro@socionext.com>


> >
> > Please let me know what you want.
> >
> > Thanks.
> >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
> Thanks,
> Mattias



-- 
Best Regards
Masahiro Yamada
