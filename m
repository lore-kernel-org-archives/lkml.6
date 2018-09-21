Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD946C433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F7F22150E
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 18:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S4Mf5O7V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F7F22150E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391231AbeIVAIO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 20:08:14 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41676 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391092AbeIVAIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 20:08:14 -0400
Received: by mail-pf1-f196.google.com with SMTP id h79-v6so6327857pfk.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Sep 2018 11:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PnL1sJkLcMPkiObGig82HmU2FMBBkb4mBsdnODpA+oI=;
        b=S4Mf5O7Vu/aKpV2GlqRjpvbWyqyRMh4o4zTsyoiylGpL9Kvuo1OYyEhF820J2wffJM
         7p7uO9BpJDUqLMoqBCdPJN4nYPhbBcrjz/geODh9Y4JM4jpYftr7OMbzt1cUB5ywv1rq
         lXAlaAMAYQ6L5UDTvsm7thUT+6l7oZdeCNzHPHkju7OBApg4yM3uVHHgEOkyF9CD/b29
         XvWJd35Wax3jIJlRuJik3tPpFPfv52gaj6OMLq0fa2/Y0IeY2c3U2v2EsfcTapOqFVkY
         b9vYn+8G+C8vLMBcoIJuyHg4VPObUT1+h3MIZCZpnWbqr/qrYytbTp66GedXe9+6q/+Z
         aOpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PnL1sJkLcMPkiObGig82HmU2FMBBkb4mBsdnODpA+oI=;
        b=FSjwrLDmvGb4pphm4VLA3ER+94TjRnaUIpihtn2LJ7HReLN77ZYPHbDAXoKbyjCdV8
         lte+nxe8rJgaVoCMdZJ+rbWBNEbme7d1fkMHR/T2HwT7lPkvsAWtKQeSi2i3ElgMSEEh
         FssBfpl8O7Z3ojibgUs2KZKH7H2XjMwidxCs2HQrB8MTRry2fGCeXYcDGSQP3KxzcRmm
         3qj1BdCXIHSjBBBSSAVebwiAph8yQlTDZWYBIuzGCVe5T+QGgNHT9FswfKAzAw0DW2oC
         azM4rULbZ38KuJhW6h+qWgk3kZOHayHieKq+kF6KdyiaC2AD6kxsjfH1PDxc6WzzZsZj
         u25g==
X-Gm-Message-State: APzg51BSAZ31iw3Yk4u/Z5isP+AZAQzztAz1elMjdz11sHryX2DMhL/Z
        YzSLxONC7lz+9BqKgPen4JCYMhVQvFsZ4APy8Mx8iA==
X-Google-Smtp-Source: ANB0VdbZNK2cxV5v+gRHGGRlO9A+DhaOjw4pDEKA65QEHLdOnsrddW5ekWoVmU6Nuw47FSKF69nRxsAkblkl5Os0X4U=
X-Received: by 2002:a62:8559:: with SMTP id u86-v6mr47899451pfd.32.1537553890077;
 Fri, 21 Sep 2018 11:18:10 -0700 (PDT)
MIME-Version: 1.0
References: <20180921001513.12504-1-Jason@zx2c4.com> <CALCETrULOFr=oQFMVT4qxPTWEQ++G82HCuxRoA=Sr4Z8kmMbYQ@mail.gmail.com>
 <5b94d2f4-eb4a-e00e-5fdf-7f770c26f0da@virtuozzo.com> <CACT4Y+bEf3GQ7zyfFd_PDOW3Cgh0Ot+KbUo4rHij5oSPYPJUNQ@mail.gmail.com>
 <CAKwvOd=g2cyFa6MF+Zr6Sg5wPticby8BBxWN7_Zb4aKihJ3_Yw@mail.gmail.com>
In-Reply-To: <CAKwvOd=g2cyFa6MF+Zr6Sg5wPticby8BBxWN7_Zb4aKihJ3_Yw@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 21 Sep 2018 11:17:58 -0700
Message-ID: <CAKwvOd=j7nnpuhdZFuPuWfk76znFJ8sbkg2JGDi26mpfQY9Kog@mail.gmail.com>
Subject: Re: [PATCH] framewarn: expand KASAN_EXTRA exception to KASAN
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>, luto@kernel.org,
        Jason@zx2c4.com, Alexander Potapenko <glider@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 21, 2018 at 10:59 AM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Sep 21, 2018 at 2:45 AM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Fri, Sep 21, 2018 at 11:25 AM, Andrey Ryabinin
> > <aryabinin@virtuozzo.com> wrote:
> > > On 09/21/2018 04:50 AM, Andy Lutomirski wrote:
> > >> This patch seems reasonable, but you emailed the wrong people :)
> > >>
> > >> On Thu, Sep 20, 2018 at 5:15 PM Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> > >>>
> > >>> It turns out that KASAN in general will bloat stack frames in unexpected
> > >>> ways, not just KASAN_EXTRA. So, this patch trivially changes that
> > >>> default to be associated with KASAN instead of KASAN_EXTRA.
> > >>>
> > >
> > > KASAN_EXTRA bloats stack more than just KASAN, that's why the limit is higher than just for KASAN.
> > > If want more details, tead the changelog from commit e7c52b84fb18f08ce49b6067ae6285aca79084a8
> > >
> > > If anything causes "stack frame > 2048" warning for KASAN we should at least try to fix it,
> > > I mean reduce stack usage.
> >
> >
> > +Nick who is also hitting these warnings on clang/arm64 build. As far
> > as I understand the situation there is much worse.
> >
> > I would be good to understand/fix the worst offenders. But the stack
> > size increase with KASAN is a real, inherent thing. So if we live very
> > close the edge, we can get people using different compilers and/or
> > versions of compilers constantly breaking each other. And clang hits
> > this warnings in lots of places today just because the current code
> > was tailored to gcc over long period, i.e. allowing more locals where
> > gcc happened to handle that better and having fewer locals where gcc
> > happened to handle it worse. But for another compiler all these
> > assumptions are significantly perturbed.
> >
> > Nick, do you know what frame size limit eliminates the bulk of
> > warnings on clang? Is 3072 a reasonable limit allowing to fix the
> > remaining outliners?
>
> Here's a plot of the distribution from an arm64 clang build with
> allyesconfig minus LSE_ATOMICS, BIG_ENDIAN, and GCOV:
> https://github.com/ClangBuiltLinux/linux/issues/39#issuecomment-423621655
>
> A value of 3072 would ignore 79 out of the 128 instances (62%).

A value of 4614 would ignore 95% of the instances (2 standard
deviations of the distribution of current warnings).

>
> Some values are huge outliers.
>
> >
> >
> > >>> Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
> > >>> ---
> > >>>  lib/Kconfig.debug | 2 +-
> > >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>
> > >>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > >>> index 4966c4fbe7f7..39078a080e29 100644
> > >>> --- a/lib/Kconfig.debug
> > >>> +++ b/lib/Kconfig.debug
> > >>> @@ -222,7 +222,7 @@ config ENABLE_MUST_CHECK
> > >>>  config FRAME_WARN
> > >>>         int "Warn for stack frames larger than (needs gcc 4.4)"
> > >>>         range 0 8192
> > >>> -       default 3072 if KASAN_EXTRA
> > >>> +       default 3072 if KASAN
> > >>>         default 2048 if GCC_PLUGIN_LATENT_ENTROPY
> > >>>         default 1280 if (!64BIT && PARISC)
> > >>>         default 1024 if (!64BIT && !PARISC)
> > >>> --
> > >>> 2.19.0
>
>
>
> --
> Thanks,
> ~Nick Desaulniers



-- 
Thanks,
~Nick Desaulniers
