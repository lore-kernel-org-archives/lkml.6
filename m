Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16CDEC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1E1D21547
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 18:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lnMU0+E2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E1D21547
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728645AbeI0ARW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 20:17:22 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34314 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727280AbeI0ARV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 20:17:21 -0400
Received: by mail-pf1-f195.google.com with SMTP id k19-v6so13841552pfi.1
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 11:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SgcFGJJUtq6eZLcL/KDBMl8P8D13pxfYuI39YY/ceGE=;
        b=lnMU0+E2jSo6zdp9xYfqLd7DvxnNoZsjlJM7g5cU+o9dlMgDxdXNpQbq8MFxIzHmY3
         z/tXjKdkDMkE7ZP1/CeRkqHickJipMTLDnzOsOKvGeaAwa/2/jEwEnfXXyrlDZpvp06/
         9buho0ag2hyp2rQPnO40Yo6TqsEdmlSfK11L7pYXL8cltvAdG9EyqaHiB2ts/ws5rUKw
         nscrQebOGdjCB83csS/NTGyj4xG3UCWU+CJuggnXA0bX39lH0dlziK+uWSZjFWJCzBnM
         bkHIgErFnT0PnKrfc1n8Ows2Oo5+WDcdBZ18TD5b3pKFWC3qDu5VnE4TcPfNm9GA6Y3m
         l0tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SgcFGJJUtq6eZLcL/KDBMl8P8D13pxfYuI39YY/ceGE=;
        b=D91IqNchT6X38/Svmtgc7/dMmxAJTCvAOr/QdEmdiHwthnSrkpvMM4Cu5ls3Ps6Fvl
         y3C4lmlOAzhb89xn13QucJOTvZpaWN4Na4IA6Kw3zf4sNo1Px5IDg+kSjnma7ZXuXEDt
         IFskTkcoKDdVxE29AZ6kqAk+vTOMZoxZ0fGWP69mT9kmhgFypU5tqqBWQ/9jDz+tZPdZ
         /kDhN9ubU+ezFSXAMRPMcbkB8SCaOFyp5mIC5/LVrPIuJ4BRDo5bNc6nVbrK9BdHvKx4
         ZZI1bRxmovIrXbl/o9a3prghrz1SaPzTbqxHDUtse33ZS0Zl/46AXhbpYpZXPP9Lh6uq
         7unw==
X-Gm-Message-State: ABuFfoh1dTcZxVvIdSQYr48lnjfKDjHZNxVIvhaa1Mk1BgZuO8kDRolh
        /Nq/JpViQXDoy2S0Us5PJ/7MLpd/aJZ5YiTdySPCbA==
X-Google-Smtp-Source: ACcGV62QYAIybWlUEPMlkg0gxJsdmpPnAlMZnRXGcYT1tKIQPneCphtckdSX2LsYz9ikUoksF6+8Cz0YG1oWEc8V32M=
X-Received: by 2002:a62:1b45:: with SMTP id b66-v6mr2903315pfb.94.1537984994569;
 Wed, 26 Sep 2018 11:03:14 -0700 (PDT)
MIME-Version: 1.0
References: <1535220989-27645-1-git-send-email-yamada.masahiro@socionext.com>
 <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com> <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com> <20180926180019.GD22824@google.com>
In-Reply-To: <20180926180019.GD22824@google.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Sep 2018 11:03:03 -0700
Message-ID: <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>, sparse@chrisli.org,
        linux-sparse@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        daniel.santos@pobox.com, chris@chris-wilson.co.uk,
        jani.nikula@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 11:00 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> On Fri, Aug 31, 2018 at 09:46:02AM -0700, Nick Desaulniers wrote:
> > On Tue, Aug 28, 2018 at 4:00 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > >
> > > On Mon, Aug 27, 2018 at 1:42 PM Daniel Santos <daniel.santos@pobox.com> wrote:
> > > >
> > > > Hello Nick,
> > > >
> > > > On 08/27/2018 03:09 PM, Nick Desaulniers wrote:
> > > > >>> Let's give up __compiletime_assert_fallback().  This commit does not
> > > > >>> change the current behavior since it just rips off the useless code.
> > > > >> Clang is not the only target audience of
> > > > >> __compiletime_assert_fallback().  Instead of ripping out something that
> > > > >> may benefit builds with gcc 4.2 and earlier, why not override its
> > > > > Note that with commit cafa0010cd51 ("Raise the minimum required gcc
> > > > > version to 4.6") that gcc < 4.6 is irrelevant.
> > > >
> > > > Ah, I guess I'm not keeping up, that's wonderful news!  Considering that
> > > > I guess I would be OK with its removal, but I still think it would be
> > > > better if a similar mechanism to break the Clang build could be found.
> > >
> > > I'm consulting with our best language lawyers to see what combinations
> > > of _Static_assert and __builtin_constant_p would do the trick.
> >
> > Linus,
> > Can this patch be merged in the meantime?
>
> friendly ping :)
>
> With c5c2b11894f4 ("drm/i915: Warn against variable length arrays")
> clang raises plenty of vla warnings about
> __compiletime_error_fallback() in the i915 driver. Would be great to
> get rid of those without having to revert that commit.

I've been meaning to follow up on this, thanks Matthias.  I too would
really like this patch.

-- 
Thanks,
~Nick Desaulniers
