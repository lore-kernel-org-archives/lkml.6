Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC366C4360F
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A89213A2
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 13:15:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="eUjvqVSK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730300AbfB0NPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 08:15:50 -0500
Received: from conssluserg-01.nifty.com ([210.131.2.80]:50480 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbfB0NPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 08:15:49 -0500
Received: from mail-ua1-f51.google.com (mail-ua1-f51.google.com [209.85.222.51]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id x1RDFX16006429
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 22:15:33 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com x1RDFX16006429
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1551273333;
        bh=djb8iQMob2bSJBlY0t4o9cctgMFFmLZf7v2g5U6b26s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eUjvqVSKZ3d5JbU3JXeags8NobiSixVcZCqMuZtPKkyhSCvUyYAx0F59Ff5pI8J6M
         FFMk7pD3ETfML4AFp8261P9UxBIzMwSnMcA4Kgt2IZNSLmCwHHRS5vY2j8GRcoeDiw
         6MpCjXPytglLbyMcF6WY+Q0cXlvgViOQrNJP+6R6FObGeavcY7lw+xmkxccq/r/Nj6
         RUqZSuaahgwmTEZe9JM6qQbdSp7W8bD3bY0PykkHUDtd1ZBA1M7sn8esaHRsDhvPAU
         Njq2CP/hJoJRWGOAGzg3MboYAolBis3w0cEpXlw5jyxBjytK2EQhaw6XZ4jKt+vjVj
         P+ZrEwnaPTEwg==
X-Nifty-SrcIP: [209.85.222.51]
Received: by mail-ua1-f51.google.com with SMTP id s15so15243735uap.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 05:15:33 -0800 (PST)
X-Gm-Message-State: AHQUAuatc4e27WuT4Jn7N/7GUFdaVTr44NfLQ2225DDpUO+1QXV0x5dT
        9qR2RedC3AUIakO+cBs6agYgn7HXlUwU0ynqHfU=
X-Google-Smtp-Source: AHgI3IbmCVrdtra+Bi4QtdWoCQLD1yduNToX8FTKrETk4LvXKqLd6TuSgOi3qeY6e/ASM/a632VLHiQjgAA9eoZ50xU=
X-Received: by 2002:ab0:748a:: with SMTP id n10mr2045117uap.89.1551273332520;
 Wed, 27 Feb 2019 05:15:32 -0800 (PST)
MIME-Version: 1.0
References: <20190221132853.32043-1-sakari.ailus@linux.intel.com>
 <CAK7LNAR99+J1LOiy66+QA_uYf328B6EfecrBk0iUvuQEDnf5pQ@mail.gmail.com> <20190222113512.abpmbptqsnroibsi@paasikivi.fi.intel.com>
In-Reply-To: <20190222113512.abpmbptqsnroibsi@paasikivi.fi.intel.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Wed, 27 Feb 2019 22:14:56 +0900
X-Gmail-Original-Message-ID: <CAK7LNASh+HM_yuSHpjDgRWQnqauMwjb7fqioMQ8dURjt2L_aNw@mail.gmail.com>
Message-ID: <CAK7LNASh+HM_yuSHpjDgRWQnqauMwjb7fqioMQ8dURjt2L_aNw@mail.gmail.com>
Subject: Re: [RESEND PATCH 1/1] headers_install.sh: Support __aligned(x) for
 uAPI headers
To:     Sakari Ailus <sakari.ailus@linux.intel.com>
Cc:     Michael Forney <forney@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 22, 2019 at 8:37 PM Sakari Ailus
<sakari.ailus@linux.intel.com> wrote:
>
> Hi Yamada-san,
>
> On Fri, Feb 22, 2019 at 01:36:03PM +0900, Masahiro Yamada wrote:
> > On Thu, Feb 21, 2019 at 10:29 PM Sakari Ailus
> > <sakari.ailus@linux.intel.com> wrote:
> > >
> > > The headers-install.sh already supports __packed conversion to
> > > __attribute__((packed)) for uAPI headers but it does not support similar
> > > __aligned(x) conversion.
> > >
> > > Add support for __aligned(x).
> >
> >
> > I am not a big fan of sed scripting in headers_install.sh
> >
> > Is it a problem to write __attribute__((aligned(x)) in UAPI headers?
>
> Not really as such. __packed is supported in uAPI headers so I thought
> __aligned should probably be as well. One factor here would seem to be that
> __packed is way more common than __aligned is.
>
> FWIW, a corresponding change has been done to scripts/kernel-doc; see
> commit 3d9bfb19bd705f503ac7afc2776d5d56dab88858 so kerneldoc does correctly
> handle that now.

I am fine with using __aligned(x) shorthand for kernel-space code.

For UAPI headers, we get it back to __attribute__(aligned(x)) anyway,
and I'd like to minimize the complex text processing.


Since __aligned(x) takes an argument,
this is not feasible to process it by sed.


For example, please see
include/uapi/linux/netfilter_bridge/ebtables.h



If

__attribute__ ((aligned (__alignof__(struct ebt_replace))));

is converted into

__aligned(__alignof__(struct ebt_replace))


it would be difficult to revert it by sed









> Cc Jonathan.
>
> >
> >
> >
> > > Signed-off-by: Sakari Ailus <sakari.ailus@linux.intel.com>
> > > ---
> > >  scripts/headers_install.sh | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/scripts/headers_install.sh b/scripts/headers_install.sh
> > > index 593f8879c641..9ed490f33a3a 100755
> > > --- a/scripts/headers_install.sh
> > > +++ b/scripts/headers_install.sh
> > > @@ -36,6 +36,7 @@ do
> > >                 -e 's/__attribute_const__([[:space:]]|$)/\1/g' \
> > >                 -e 's@^#include <linux/compiler(|_types).h>@@' \
> > >                 -e 's/(^|[^a-zA-Z0-9])__packed([^a-zA-Z0-9_]|$)/\1__attribute__((packed))\2/g' \
> > > +               -e 's/(^|[^a-zA-Z0-9])__aligned(\([0-9 ]*\))([^a-zA-Z0-9_]|$)/\1__attribute__((aligned\2))\3/g' \
> > >                 -e 's/(^|[[:space:](])(inline|asm|volatile)([[:space:](]|$)/\1__\2__\3/g' \
> > >                 -e 's@#(ifndef|define|endif[[:space:]]*/[*])[[:space:]]*_UAPI@#\1 @' \
> > >                 "$SRCDIR/$i" > "$OUTDIR/$FILE.sed" || exit 1
> > > --
> > > 2.11.0
> > >
> >
> >
> > --
> > Best Regards
> > Masahiro Yamada
>
> --
> Sakari Ailus
> sakari.ailus@linux.intel.com



--
Best Regards
Masahiro Yamada
