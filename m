Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D504C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:37:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 085BA20B1F
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 17:37:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VqtxMOSV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730162AbfBFRhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 12:37:11 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46931 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbfBFRhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 12:37:08 -0500
Received: by mail-pf1-f195.google.com with SMTP id c73so3380332pfe.13
        for <linux-kernel@vger.kernel.org>; Wed, 06 Feb 2019 09:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gqWiayW2le+Xx8pthLXfFQCE21oXa8z+EtXjfEzXj0Y=;
        b=VqtxMOSVQyVcKHoPULoH933xS9sV7zT5p0AkH7jPWIr0qFHL6DRLIJu0tOJzEfvizs
         1xJaGvxIHNEAyMMKADuqM73FPkRec4vausZWkwp0dSJokwaQ0b64f0hjJTsQFCOOIW+K
         omBgesh2mPW7CpRqCI7i3H9Skvte1xV5/zmAla0xIW0bwtMcFGYmzMB2GYas9Ri9KdXC
         85drCSc8Rl0L5xbvI2zCQgJxikSadhloePHMURwJHKM6PMTErdxOP1siucGaM47H4prO
         dT5nDVtxDMxExPjjoIbvWITcJpw0+KGVXDiU2UhY5oRqLaGOXotkfu2Zv0NSA1sXM3Ax
         2AWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gqWiayW2le+Xx8pthLXfFQCE21oXa8z+EtXjfEzXj0Y=;
        b=GR3FARIzBK7wXjHh8upD4sbL8+RTp/SEpib21MfqYzc0dz10jew2IpHmO+niJGFaLk
         HtRwah354Enst3v3ulBXgkZ9G4WvT03RcLU+aWDGnwHizUcA6o7pioI1Xx+TiLptgcG7
         cN2QKxnzGOaUvSpaNRrm3mH9Sa4Lav9T5A4pd02JZ98P+4tG/WNXjDf19Fnnua3Y2bow
         kM4v3hQRotZRXWt0EJHLGmmUxf+dMPwuaP7lPB7UFjmLBB0H9m7PGrp1DiL3r7EmEA/5
         TVPctLx12bb4TqTT5j6yzUWFP8vk8iOKXdEvCABGUPlZeXml0xc7r14jsK3JDSqIxwV0
         46jg==
X-Gm-Message-State: AHQUAuYYvaVOP3Ebv0R6NBmb7TC7mlQwgj6bWnI9L8xg4YKsHZIoQunF
        djsGDGc/akoChRvbsvxaQ+xy2/SiBlNwDddXOvsX0g==
X-Google-Smtp-Source: AHgI3IakhPXZ4qqjNiTmSrAeePXoGqN4zFkiz2ABLkqNwg1QCGku7OFEw6m0mbU+KV/qo6CxwBg1usicLb4ybakeRuY=
X-Received: by 2002:a63:bf0b:: with SMTP id v11mr10849848pgf.302.1549474627011;
 Wed, 06 Feb 2019 09:37:07 -0800 (PST)
MIME-Version: 1.0
References: <20190201210853.244043-1-jflat@chromium.org> <CAK7LNAS5j6+o+wb8WL=8WP4r4fgqY1MDSGe0_u9Nri81_Eb3xw@mail.gmail.com>
 <20190206164528.GA8925@archlinux-ryzen> <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
In-Reply-To: <CACJJ=pyLqhrxka2jXtby9CUqsAr=-_oQUraH5ua3PZpgXHgdOQ@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 6 Feb 2019 09:36:55 -0800
Message-ID: <CAKwvOdm=dqScCDVTgQ71i0wtBSqezEzLr69Pxp3bZJFs+_mXsQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild, LLVMLinux: Don't suppress format warnings
To:     Jon Flatley <jflat@chromium.org>
Cc:     Nathan Chancellor <natechancellor@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michal Marek <michal.lkml@markovi.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 6, 2019 at 9:32 AM Jon Flatley <jflat@chromium.org> wrote:
>
> On Wed, Feb 6, 2019 at 8:45 AM Nathan Chancellor
> <natechancellor@gmail.com> wrote:
> >
> > On Tue, Feb 05, 2019 at 05:26:05PM +0900, Masahiro Yamada wrote:
> > > On Sat, Feb 2, 2019 at 6:10 AM <jflat@chromium.org> wrote:
> > > >
> > > > From: Jon Flatley <jflat@chromium.org>
> > > >
> > > > gcc produces format warnings that clang suppresses. To keep behavior
> > > > consistent between gcc and clang, don't suppress format warnings in
> > > > clang.
> > > >
> > > > Signed-off-by: Jon Flatley <jflat@chromium.org>
> > > > ---
> > >
> > > Applied to linux-kbuild.
> > > Thanks.
> > >
> > >
> >
> > Hi Jon and Masahiro,
> >
> > Just as a heads up, this introduces a ton of warnings (duh). Isn't the
> > typical plan behind turning on warnings that were disabled to build with
> > 'W=', fix them all, then turn them on so as not to pollute the build?
> >
> > Log file: https://gist.github.com/443db156e56cd3c0f6b21d9d77728d80

Oh boy, that's a lot.  Too many to fix quickly IMO.

> >
> > Note a big chunk of them come from one scnprintf call in
> > include/linux/usb/wusb.h but still, there are many other warnings that
> > make quite a bit of noise. Some seem relatively easy to fix, which I
> > suppose I will try to tackle soon.
> >
> > Thanks,
> > Nathan
> >
>
> Hi Nathan,
>
> This was definitely not my intention.
> I noticed the added warnings this morning and was considering calling
> for a revert on this patch.
>
> The intent was to match the behavior of gcc, as it has -Wformat enabled.
> It was rather naive of me to assume the behavior of -Wformat would be
> the same in both gcc and clang.
> Indeed, it seems gcc is more permissive about what format
> substitutions it allows.
>
> For example passing int to the "%hu" format specifier is fine in gcc
> under -Wformat but produces a warning in clang.
> Maybe this was the motivation for adding -Wno-format to clang in the
> first place.

Sorry, I'm late to this thread.  What is it reverting; who authored
the original patch? Was it mka@chromium.org?

> This difference is puzzling to me, and I wonder if it's by design.

Probably; internally let's sync up with the Clang devs to understand
this difference more.

>
> Considering the whole point of this patch was to sync up this behavior
> between gcc and clang I am OK with reverting this.

Is this patch in -next, or has it already hit mainline?  I think it's
better to revert, then start upstreaming fixes, then re-land it once
we're warning free.

-- 
Thanks,
~Nick Desaulniers
