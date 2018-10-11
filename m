Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F0FC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90EFE2082B
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 02:49:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="AA1vtLEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EFE2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=socionext.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbeJKKO4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 06:14:56 -0400
Received: from conssluserg-05.nifty.com ([210.131.2.90]:33722 "EHLO
        conssluserg-05.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbeJKKO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 06:14:56 -0400
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176]) (authenticated)
        by conssluserg-05.nifty.com with ESMTP id w9B2nZLd009253;
        Thu, 11 Oct 2018 11:49:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-05.nifty.com w9B2nZLd009253
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1539226176;
        bh=O6asAfJP/j+X0cjMsjSrt6LkPwVxdbC5KEByL14TL9I=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AA1vtLEO7t3c7T1yKg8UHYSlP/og3v9H3ol1z1bUgrTVYSI4exjjf8V3/z5ZEvTS+
         GoOIlvBY/Jw2iTW/uhy5Yka1oj0E3bN/IzXoJScTvduIw4ZMWBqVPmFTGla6UBC3UZ
         Mv+0HWL93biex02dnGWy7QnFAkJtZED2DWzz4Ep0Mjn26RICCrAHbXt4ig03WbMmm2
         Mj9c76eSDIXmnJ6Av5bwFbQtxLdmy9uThaOYFFFEf+au3jql6CN6P6Yf9UjK2S6jYE
         X7BxNVW261k3VlOltHXUetBfrigQgZD2yCs6HcC+1U+/YqOoCMlrYPLeVGN90//Hwm
         q8ajtL2NMAQQw==
X-Nifty-SrcIP: [209.85.221.176]
Received: by mail-vk1-f176.google.com with SMTP id l186so1182681vke.0;
        Wed, 10 Oct 2018 19:49:36 -0700 (PDT)
X-Gm-Message-State: ABuFfohQEGS8sdXcixOhR97cY5ccP7K0ZDchviwjcV9iaFixJpHodCSe
        XFYvpe5g69qO4OSmZS+du6ekEivGPnVvp0VrQfo=
X-Google-Smtp-Source: ACcGV63Z/9VlNHe66cnMm01zcgkjBLcYM4TwB+UbGhBW/sisxGRkEosx9o2OmmlUiH7jAmisnYjOOpJS/N9wVo67u/g=
X-Received: by 2002:a1f:cd3:: with SMTP id 202-v6mr14153302vkm.74.1539226175253;
 Wed, 10 Oct 2018 19:49:35 -0700 (PDT)
MIME-Version: 1.0
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com> <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
 <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
 <CACPK8XeAbiMk_yW-t+8HdW_WLqaFJFX-xnNnDSZJ5ZfhK63euA@mail.gmail.com>
 <CANiq72nGrNMEqnPrxGXCp_iKf1_FuJLMvoV1+bbfYYCKnfTPVw@mail.gmail.com> <CAGXu5jKShFRJcP3vroEcZUevcHBSi53Towgs-t0v1JyEqmHJCA@mail.gmail.com>
In-Reply-To: <CAGXu5jKShFRJcP3vroEcZUevcHBSi53Towgs-t0v1JyEqmHJCA@mail.gmail.com>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Thu, 11 Oct 2018 11:48:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNATXiJkXa4bfrCMb-kuWrn2gg-7jJg3qT3UR6HVSpC3Y3w@mail.gmail.com>
Message-ID: <CAK7LNATXiJkXa4bfrCMb-kuWrn2gg-7jJg3qT3UR6HVSpC3Y3w@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Kees Cook <keescook@chromium.org>
Cc:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Joel Stanley <joel@jms.id.au>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christopher Li <sparse@chrisli.org>,
        linux-sparse@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Santos <daniel.santos@pobox.com>,
        Chris Wilson <chris@chris-wilson.co.uk>, jani.nikula@intel.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 11:51 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Oct 10, 2018 at 12:03 AM, Miguel Ojeda
> <miguel.ojeda.sandonis@gmail.com> wrote:
> > On Wed, Oct 10, 2018 at 8:12 AM Joel Stanley <joel@jms.id.au> wrote:
> >>
> >> On Thu, 27 Sep 2018 at 05:07, Kees Cook <keescook@chromium.org> wrote:
> >> >
> >> > Yeah, that's what I'd linked to in the patchwork URL. Andrew, can you take this?
> >>
> >> clang built -next is blowing up now that Kees' -Wvla patch has been
> >> included. This patch fixes it.
> >>
> >> Kees, perhaps it should go in your tree along side of the -Wvla patch
> >> if no one else wants to take it?
> >>
> >
> > I can take it along in the compiler attributes tree, since that
> > touches the compiler*.h stuff. Although that would make it
> > not-only-attributes, i.e. slightly lying :-)
>
> Oh, I had assumed Masahiro was going to carry it.

No, I am not.

Putting all sort of things into kbuild basket
is painful for me.



> If that's not true,
> sure I'll pick it up as part of my VLA "series".


-- 
Best Regards
Masahiro Yamada
