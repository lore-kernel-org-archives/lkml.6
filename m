Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46D3C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:05:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BB02088E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 17:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="crE0+sbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BB02088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbeH1U6R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 16:58:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:47046 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbeH1U6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 16:58:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id u24-v6so972836pfn.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Aug 2018 10:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JoL4N8OCkOj8w0qAasgdXp7m3UaUC5/Cfk5FPAXwvfQ=;
        b=crE0+sbhNh+oo8ZP4a2k9aDPQ14L0kni5L5Ylt+99HKIEBD4mUsvxjmX7jBefHrMeg
         wekT4DGXmgjQjoxaMcKHT+HE8q6Gb+WJ8fxfKim5gbB4scAwwKP2ThCjKug/pICZnBwh
         Y9T3sM54h8jrgpVHaH1udMvTIEZi9FT3nIq21vpPld8mq9S3vN3ykIbzKZNQ86PKOH9d
         Z/gKqcZ98IEZWsNmDcfjC+FQkYTdgGCm7osGDbqlzEP3UlVn9PhYii23OA9awu5RMEo8
         dssp00qU3VXzvSv0enz/aVG9OmQU/TPkJ0UbtWsrrMD1D89oDtqCFfw9GfbwBVsp0RDI
         MrIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JoL4N8OCkOj8w0qAasgdXp7m3UaUC5/Cfk5FPAXwvfQ=;
        b=JFxHwvEIaKm/yLbWN8M5PlnhYfPTrJLOnVrvhrH2w+O3BrtvE9HVlm6J+li/osa1+a
         SlH52OgQIQe+fGEM9bc9UVesdlOO9BtNbKIrzC73c+mPDftGaCEVB9mRsl1ko7gbqP59
         n4BZAVWmVb1sjX3/XwnOQYkq/zujm/XaPGj4aUdqekOYj10zpNdJ+UT9KYkNGvJzymEw
         cvQMz4yABpqv7yH+IfR7poQx6gC92IbeGVmIi8kzXM/YzLIbhEwwGHgaXnv43lQOIC6B
         1IncFiqI4b1gV/hIL03tf3dnhdX1irQN1eh8bYphnazEhSj6tY7Q9jXbpo5E9gaD5u0T
         dSRg==
X-Gm-Message-State: APzg51CDJ64EkF0C6l80UJnp8kiKM5J2xQBmOzhJI69+GY777GiRgztF
        8TlHe6IV7bxT/Xcx5uUAE5Lj69g9h8kd65L0J6MThg==
X-Google-Smtp-Source: ANB0VdZwgl0I5lZXe8/T/GtL/j5XCbin3iXPkftPXU8haL1SbNmqD/WEzQUARNInA/3LbyztIsUGQltpFSwyjEpj8m8=
X-Received: by 2002:a63:190e:: with SMTP id z14-v6mr2420065pgl.302.1535475942192;
 Tue, 28 Aug 2018 10:05:42 -0700 (PDT)
MIME-Version: 1.0
References: <20180826175748.GA29525@gmail.com> <CAKwvOdnyHctAYRBOdrkX15MBPX68pOSiKc2P2S_JnDdffdY+OA@mail.gmail.com>
 <CAKwvOdk3PjNtjMcsXxRVvKLNcT+O_=5D1B7DXNWcwxwcMqdV2w@mail.gmail.com> <CANiq72nV_sVGgQuZra2gqOXHnbtCYWZDBMRW=EeeLK3qTL99ew@mail.gmail.com>
In-Reply-To: <CANiq72nV_sVGgQuZra2gqOXHnbtCYWZDBMRW=EeeLK3qTL99ew@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 28 Aug 2018 10:05:30 -0700
Message-ID: <CAKwvOdmSOGRDaCUgsEnEd=uyf83FzrRhJt-E3VnzX4FzDwPFWw@mail.gmail.com>
Subject: Re: [PATCH] include/linux/compiler*.h: Use feature checking instead
 of version checks for attributes
To:     miguel.ojeda.sandonis@gmail.com
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        efriedma@codeaurora.org, sparse@chrisli.org,
        Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        joe@perches.com, asmadeus@codewreck.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2018 at 8:10 AM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Hi Nick,
>
> On Mon, Aug 27, 2018 at 7:48 PM, Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> > On Mon, Aug 27, 2018 at 10:43 AM Nick Desaulniers
> >> > +
> >> > +/*
> >> > + * Optional attributes: your compiler may or may not support them.
> >> > + *
> >> > + * To check for them, we use __has_attribute, which is supported on gcc >= 5,
> >> > + * clang >= 2.9 and icc >= 17. In the meantime, to support 4.6 <= gcc < 5,
> >> > + * we implement it by hand.
> >> > + */
> >> > +#ifndef __has_attribute
> >> > +#define __has_attribute(x) __GCC46_has_attribute_##x
> >> > +#define __GCC46_has_attribute_assume_aligned 0
> >> > +#define __GCC46_has_attribute_designated_init 0
> >> > +#define __GCC46_has_attribute_externally_visible 1
> >> > +#define __GCC46_has_attribute_noclone 1
> >> > +#define __GCC46_has_attribute_optimize 1
> >> > +#define __GCC46_has_attribute_no_sanitize_address 0
> >> > +#endif
> >
> > And a follow up; I'm trying to understand what will happen in the case
> > of say gcc 4.9 here.  Were any of these supported between gcc 4.6 and
> > 5.0?  If so, then this code will not use them.  It's simpler than
> > explicit version checks, but it won't use features that are supported.
> >
>
> I addressed that in the email I sent afterwards:
>
> """
> Note that:
>   - assume_aligned came with gcc 4.9
>   - no_sanitize_address came with gcc 4.8
>
> So if we feel it is important to have them there (before gcc 5), we
> would need here a quick version check here.
> """
>
> The idea is that, in the future, whenever gcc 5 or later is the
> minimum version, we just get rid of the #ifdef block without touching
> the rest of the code :-)

So if __has_attribute came with gcc 5, then that means that this patch
will break assume_aligned for gcc-4.9 users and no_sanitize_address
for gcc-4.8 and gcc-4.9 users?  The slab allocator uses
assume_aligned, and no_sanitize_address for CONFIG_KASAN.  Should this
patch ever come back through stable, Android and ChromeOS
gcc-4.9/KASAN builds will break.

I don't think we should leave that for a follow up; I would like to
see it as part of this patch.  It's ok to have explicit version checks
for those 2 attributes since it's not possible to feature detect them
for the versions of gcc that we support in this code base.  I think
you should add them in a v2 of this patch.  Then we can point to this
commit as the *shining example* of how to do proper feature detection,
falling back to version checks only as a last resort.

-- 
Thanks,
~Nick Desaulniers
