Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7843C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61B132087D
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 06:10:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="jS7zuk4h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61B132087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbeJJNbK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 09:31:10 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:34064 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbeJJNbK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 09:31:10 -0400
Received: by mail-qk1-f195.google.com with SMTP id p6-v6so2494931qkg.1;
        Tue, 09 Oct 2018 23:10:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AoMGstWa/1dEP1miWFYB6E+CAwKqKuDlmU5Wm64NNa8=;
        b=jS7zuk4h8xiyPVjNKx9aw9+6C2S8d/ve1lpFddWULeUwPVWQoJGEPKxWCUgD7RvLGh
         09JN6yW1ImLYytgc6lkl+UAPGqCCgE5gBLBU2n/P6l9uUtCxpXMIY9DutglZAfFe5dkr
         9BGCBvbp+o7OeN6CpJAi8t+CCM8tWqDPTOYbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AoMGstWa/1dEP1miWFYB6E+CAwKqKuDlmU5Wm64NNa8=;
        b=UeT6SqB4GIOJuQwCMMPxaEKaSx0hwI52OgvkbgdiLpoWdv63xKdQmfFiu2uPU7xq3H
         cJbnIrc1N26d3Z06L6CpwO/2LMu3uvjEm0EPhEoa4hV00n88dXJBRcRM9qshMjwLRL4/
         E8UgCCyQxhsqZZCREQtNayOKpD07CSzS3OMNuGn7pV7dLq0DJYXSUjWJpL0CmatsnMmC
         2NTNCx8ojY6Vk5vQ6bMyTs/1KXWXxH9rfk5YUq2H6k2UeZTZnu5Gr+7nm6Zz+vToaio/
         BKHOa1z616MPsaugQykRP6XwrKoAjP+Jcib1ColB5dYrGQzgsqsd7rlqTED5IYEqwtvf
         Ry4Q==
X-Gm-Message-State: ABuFfog8FNmEcnVnrv31dUZfuL13oibPrJCdoA0Cfsz22slHvEAW0ysA
        vOte3H2UL9p37oZLPYsjF2X7PYH0l1sS4hXXD0c=
X-Google-Smtp-Source: ACcGV60aUlxkiSIshvL+63Ey6N8CeES+qQxZNAJPSbgkjBTsgMz5jxzCEQD2VA65+DNdbKNozfwAsCMVOAzX2Gmvq0o=
X-Received: by 2002:a37:9b82:: with SMTP id d124-v6mr24640487qke.231.1539151835397;
 Tue, 09 Oct 2018 23:10:35 -0700 (PDT)
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
In-Reply-To: <CAGXu5jKRn2EsPwNMtVTPyKyDnt+vqHZF=jdr+DajN_iN1DWjSw@mail.gmail.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 10 Oct 2018 16:40:24 +1030
Message-ID: <CACPK8XeAbiMk_yW-t+8HdW_WLqaFJFX-xnNnDSZJ5ZfhK63euA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Kees Cook <keescook@chromium.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, mka@chromium.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        sparse@chrisli.org, linux-sparse@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        daniel.santos@pobox.com, chris@chris-wilson.co.uk,
        jani.nikula@intel.com, Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Sep 2018 at 05:07, Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Sep 26, 2018 at 12:29 PM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > On Wed, Sep 26, 2018 at 12:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
> >>
> >> On Wed, Sep 26, 2018 at 11:45:19AM -0700, Kees Cook wrote:
> >> > On Wed, Sep 26, 2018 at 11:42 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> >> > > I'm not digging up a compiler.h patch from a web site and adding it to
> >> > > the tree this late in the release cycle.  Especially given that it
> >> > > hasn't had any testing anywhere...
> >> >
> >> > Good point about it not living in -next.
> >> >
> >> > Who should be carrying these sorts of patches? In the past it's been
> >> > Andrew or Masahiro, yes? For linux-next, maybe it can go via -mm?
> >>
> >> Either is fine with me, as long as it isn't one of my trees :)
> >>
> >> thanks,
> >>
> >> greg k-h
> >
> > Besides, I think we want the v2: https://lkml.org/lkml/2018/8/25/103
>
> Yeah, that's what I'd linked to in the patchwork URL. Andrew, can you take this?

clang built -next is blowing up now that Kees' -Wvla patch has been
included. This patch fixes it.

Kees, perhaps it should go in your tree along side of the -Wvla patch
if no one else wants to take it?

Cheers,

Joel
