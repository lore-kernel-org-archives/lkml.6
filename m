Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F95FC43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D589721547
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 19:29:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rF1J1Jn0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D589721547
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbeI0BoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 21:44:01 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37299 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726544AbeI0BoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 21:44:00 -0400
Received: by mail-pf1-f193.google.com with SMTP id x26-v6so78362pfn.4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Sep 2018 12:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fy9a0xmtIONzRUF59arYr7m9+Szk2YA+k3QOO2pqiJI=;
        b=rF1J1Jn0GfxtHjC+roQ170Svlo7PKSoQhgX9jt2fWakyAh82T6YBpl/kN3rfixVSZa
         MLYtvrli+LPV0ypgBbZHwQenne8bpiy+7eqqUMeX9AjrobcIQTBuaCg7N/AxkQdCB2Ol
         Pi/MrlrXGhHaePViu5Lo5sV/ktb/Cz5DDNJeW2jcGlYJLqZZBrHieDVqHIx6MrzCXUd4
         nhvWkKnR3qYkxXk+/Eo6PqtQsx9DqXgtj8XvIkiDkOpkDKCRXivMoIiKNWlx5bUSLJ7x
         H408YNcIxxVCu/4YCda90aICGlvMT33Bu2+MuRhQAZ6E8wH2U4+3WqIbmNWCQj2EIR5g
         4laQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fy9a0xmtIONzRUF59arYr7m9+Szk2YA+k3QOO2pqiJI=;
        b=stVrgaHcvUjIkpJfBXy7WpK3xr8wkgEms+py/+WZ+qyjRDcFeYMCTVgkfTBsMVSMst
         3vImk4ybEjV5sAb6I4mZKuQaDEf6LB9f83rtqxMxXomIOUx7/BZjFv+9Qotl/SvsdWB5
         vPeb3LS8t6fDWGj9K5y63VcNRUWfHCtmAPA0AfmGzRAd/ip8KglpttS/ZQiNJe+yc3lG
         JnbXRJwYCtC2mOyFpL7pGwP8p1iMui5t/X2RZr0AggUaJH01b17lwQ0j9OMrq5moIKhd
         DaJ5j2N9Sc5yCbYffatKTjTWhFXbvpV2oCpEEAomNX9y9HQhaTcsjU4u5MXuK9g01bVF
         xELQ==
X-Gm-Message-State: ABuFfojH14Xe3tKIKmZ7/ZoZP7Ggyy8GgY9A3Edv+o2boYSlS9Gpnd3M
        /VzI3THxzIZgCfAcY7z9mt30TjA/cBUEW73kcPiMtw==
X-Google-Smtp-Source: ACcGV63FkogNVKddmbNvd3FRZq00MrTG6sDghAjSg1hHHAhf2li436mm2cU21EVkDQ8A8tlBBiVZAMiAPX8+bIlhImU=
X-Received: by 2002:a63:f347:: with SMTP id t7-v6mr2445529pgj.255.1537990171349;
 Wed, 26 Sep 2018 12:29:31 -0700 (PDT)
MIME-Version: 1.0
References: <84cf6ae0-97c8-6b73-ca86-b3d3b3daba5b@pobox.com>
 <CAKwvOdm7RrGpwk4LMFhsKx=5QMDoFAF8JX=RMZ9YXwOptDfhCg@mail.gmail.com>
 <8d5cf8c6-556a-96a1-610d-c92355783a9f@pobox.com> <CAKwvOdkD0cmF5373LRS92U--ptRvikSrG_oKyE-AiaybCQYMBg@mail.gmail.com>
 <CAKwvOdnyA=Y_+KnJrDc5mu7twTAEOMXvb8cAZhwzsXTi7a9sEA@mail.gmail.com>
 <20180926180019.GD22824@google.com> <CAKwvOd=xYG+r4KU+QurUTyaxkPB2AMane4YfWxuvKtONvVtLxQ@mail.gmail.com>
 <CAGXu5jLBz1YanL5X4HFZjhb8NZe5QK=Q1ySfBkBDNWqEg4hs5g@mail.gmail.com>
 <20180926184259.GB14797@kroah.com> <CAGXu5jJaJ+1Sg3uwaZ8hzw3wFbiLrftpZDO8vdjY9_tB+P-HPQ@mail.gmail.com>
 <20180926190303.GA18293@kroah.com>
In-Reply-To: <20180926190303.GA18293@kroah.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 26 Sep 2018 12:29:19 -0700
Message-ID: <CAKwvOdnx6D+_LeSZ-1v_s8dLErXq4B5Nx1UQozdr1+ZaGYWnrA@mail.gmail.com>
Subject: Re: [PATCH v2] compiler.h: give up __compiletime_assert_fallback()
To:     Kees Cook <keescook@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        sparse@chrisli.org, linux-sparse@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>, daniel.santos@pobox.com,
        chris@chris-wilson.co.uk, jani.nikula@intel.com,
        Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 26, 2018 at 12:03 PM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Wed, Sep 26, 2018 at 11:45:19AM -0700, Kees Cook wrote:
> > On Wed, Sep 26, 2018 at 11:42 AM, Greg KH <gregkh@linuxfoundation.org> wrote:
> > > I'm not digging up a compiler.h patch from a web site and adding it to
> > > the tree this late in the release cycle.  Especially given that it
> > > hasn't had any testing anywhere...
> >
> > Good point about it not living in -next.
> >
> > Who should be carrying these sorts of patches? In the past it's been
> > Andrew or Masahiro, yes? For linux-next, maybe it can go via -mm?
>
> Either is fine with me, as long as it isn't one of my trees :)
>
> thanks,
>
> greg k-h

Besides, I think we want the v2: https://lkml.org/lkml/2018/8/25/103
-- 
Thanks,
~Nick Desaulniers
