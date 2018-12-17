Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C90BC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E171F206A2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:42:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="SM9BKOjz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732036AbeLQWmZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:42:25 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52805 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731905AbeLQWmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:42:25 -0500
Received: by mail-it1-f194.google.com with SMTP id g76so1334549itg.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Dec 2018 14:42:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2F18iHjbeXFnSe8D0RJ2bj2JTcXMvlUaleBCxIQU6+A=;
        b=SM9BKOjzf0cRAHjAhMZm4knsmUYCxEUy2dSkAT//Tz2AgbfmEyEu36GexklZilkdc6
         g+C+MKsWVhi22MCgbb+71MSD3gUDbUR+wnfN3dGBJaorcieGCPj06hxrQ8vc5LsamGQO
         BMbALatcyywmGTKQlonP7WhCFxbvnPgQbOHdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2F18iHjbeXFnSe8D0RJ2bj2JTcXMvlUaleBCxIQU6+A=;
        b=af2enTkepfDy08hv3qMWG1mBFn1f2+IVb8RP3kWKP62EjX6K2a+7Qzb0ho9xyBVkYd
         badQN0xKZOrF6j496ZkVxarGqMbvxLOIIxqA/z/+Fyi00bfbg0dH+aBtIjruKebhtJU8
         m9M4Rjkjg3ge/MaB2JZqfUkXW9Znr/UrsIBPN04Q6v05c4RrIv/Ymlnr1In9N0YqY89j
         cSbK/qKf/lr2jKpkj1tP+OzZYQ36wyPjydZpowl7UQq3T2sFhnGlDewSnvqkk98dNur/
         /SKdrdtq98pDuE1cHMF79ojHpIlnuFkbXBEbWjmg72xxs42LBd+alXMDLB1OJeuPpH76
         e+dQ==
X-Gm-Message-State: AA+aEWaIZbJBQh328Cy5kdkDyReRkvdsCDCvYPumBn+cfy8V2EiJkpyS
        olKz2FerbW7FeBY4gzb1yqNxwRhb0RQrIewSigWR3A==
X-Google-Smtp-Source: AFSGD/WM9Xq9XZm916WsSFQY+QO2v0sp4Dqpg7fHyBeZh2oWkwLqjOALGPAvfZWohYuZEudAh/NGIwYiXzk69TkNBmY=
X-Received: by 2002:a24:710:: with SMTP id f16mr779270itf.121.1545086543192;
 Mon, 17 Dec 2018 14:42:23 -0800 (PST)
MIME-Version: 1.0
References: <20181217180214.9436-3-ard.biesheuvel@linaro.org>
 <tip-793423cf07e51e3185b8680167115813589c057d@git.kernel.org> <8cfd64a9-1a66-0ca1-851b-c3fc9a47809d@gmx.de>
In-Reply-To: <8cfd64a9-1a66-0ca1-851b-c3fc9a47809d@gmx.de>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 17 Dec 2018 23:42:11 +0100
Message-ID: <CAKv+Gu8kZutLz-4Z4QP+C4g5UFavWjGVNfx4340hd15j=fEVtw@mail.gmail.com>
Subject: Re: [tip:efi/urgent] efi: Align 'efi_guid_t' to 64 bits
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc:     Qian Cai <cai@gmx.us>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rik van Riel <riel@surriel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Dec 2018 at 23:33, Heinrich Schuchardt <xypron.glpk@gmx.de> wrote:
>
> On 12/17/18 7:16 PM, tip-bot for Heinrich Schuchardt wrote:
> > Commit-ID:  793423cf07e51e3185b8680167115813589c057d
> > Gitweb:     https://git.kernel.org/tip/793423cf07e51e3185b8680167115813589c057d
> > Author:     Heinrich Schuchardt <xypron.glpk@gmx.de>
> > AuthorDate: Mon, 17 Dec 2018 19:02:14 +0100
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Mon, 17 Dec 2018 19:12:48 +0100
> >
> > efi: Align 'efi_guid_t' to 64 bits
> >
> > The UEFI Specification Version 2.7 Errata A defines:
> >
> >   "EFI_GUID
> >   128-bit buffer containing a unique identifier value.
> >   Unless otherwise specified, aligned on a 64-bit boundary."
> >
> > Before this patch efi_guid_t was only 8-bit aligned.
> >
> > Note that this could potentially trigger alignment faults during
> > EFI runtime services calls on 32-bit ARM, given that it does not
> > permit load/store double or load/store multiple instructions to
> > operate on memory addresses that are not 32-bit aligned.
> >
> > Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > Cc: <stable@vger.kernel.org> # v4.9+, or earlier if possible
> > Cc: Andy Lutomirski <luto@kernel.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: Linus Torvalds <torvalds@linux-foundation.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: Qian Cai <cai@gmx.us>
> > Cc: Rik van Riel <riel@surriel.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: linux-efi@vger.kernel.org
> > Link: http://lkml.kernel.org/r/20181217180214.9436-3-ard.biesheuvel@linaro.org
> > Signed-off-by: Ingo Molnar <mingo@kernel.org>
> > ---
> >  include/linux/efi.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/efi.h b/include/linux/efi.h
> > index 100ce4a4aff6..e6480c805932 100644
> > --- a/include/linux/efi.h
> > +++ b/include/linux/efi.h
> > @@ -48,7 +48,7 @@ typedef u16 efi_char16_t;           /* UNICODE character */
> >  typedef u64 efi_physical_addr_t;
> >  typedef void *efi_handle_t;
> >
> > -typedef guid_t efi_guid_t;
> > +
> >
> >  #define EFI_GUID(a,b,c,d0,d1,d2,d3,d4,d5,d6,d7) \
> >       GUID_INIT(a, b, c, d0, d1, d2, d3, d4, d5, d6, d7)
> >
>
> Before rushing this patch in, we should carefully review its side
> effects, e.g. on 32bit system this changes the size of
> efi_config_table_32_t from 20 to 24, which is part of the interface to
> the UEFI firmware.
>

grmbl.

Thanks for spotting that.

The UEFI spec defines a GUID struct as { UINT32; UINT16; UINT16;
UINT8[8]; } so its natural alignment is 32 bits not 64 bits. The
alignment issue on ARM would be solved by using __aligned(4) rather
than __aligned(8), while not affecting the size of the config table
struct (and potentially others) on 32-bit architectures.

Ingo, apologies for the breakage. Do you prefer a replacement patch or
a followup patch?
