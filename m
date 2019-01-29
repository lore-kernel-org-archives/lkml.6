Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEA9C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:52:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F3620989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 05:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSHQ+wLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfA2Fv6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 00:51:58 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:34671 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfA2Fv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 00:51:58 -0500
Received: by mail-it1-f196.google.com with SMTP id x124so12812156itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 21:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cnq+adqEpXUXmlrZoNzU7jVlJ5OW87Vyf9hH+vtspCE=;
        b=iSHQ+wLWyW2zaveyCPzIzoHIoqkaD4yumm6K0/KkgLQikm1RTyVoCq1VILSy9cmw60
         TgvJZmxiVwbjwRavfSpWCu6lMEFSZdhiuWt7FxWTHBHamv6mr2Pa9T5eXd8fEmoSl2Qw
         HH23jd9ZO87JvBunUdGeRbvC4X7+DQW9jCO9t8/+dQ8TzUt13rLOnfZrarHARSxI24L/
         6BimV6FrcTgZNNphRB68AgLXzzKIWz6t/55i+X/tYS1+p/V9AxyyUPbfjlrMKUnAJUQf
         lDry0ZrG+Lds9q/HxYTJ8c3nNwli0fs1HO8i9qJmat9+DSXhWHqcZ0b7bhlMOZ++QMYM
         d4dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cnq+adqEpXUXmlrZoNzU7jVlJ5OW87Vyf9hH+vtspCE=;
        b=mYdUpmWOM5oXCZXetmDnUyC0oeY/xlNJ6dwyFYN26cckgarEQMH7uz5PnORyIOPfgy
         YiEgHL0cztSnKcT0887XGA/qHGY6ulhYI/iQENnNsNR2l5wULmF+aDAt/gc3SY0+picJ
         FqOUado00QIeWkBofAqI3JwPPt3qCqUYPE2vldttwZ3z7lS6SlT2BPltIIgMpcNN02+b
         WxYNav0sql5nx8fMzLiDbLRamnfy/VAbL0sjKmYQa+YnusBuqjMqhmdnBS45couxda5Y
         fQOFrejfZvcwhhnVaUX3isUb562RbOsbvYxiIKav199B74H80cJDD5RTtlR8BUYT2IfK
         9j0A==
X-Gm-Message-State: AJcUukfTnAb6W5+23RJTkXf2XdP1Mk725fjNb4jam1EVHgIb4nP60jBd
        1bQcy7nXPrrEazGyrrDE8HyZ0ZHLa+srKZsNmQ==
X-Google-Smtp-Source: ALg8bN6zwID7pFNrAHjz/Su/SAHvRS5mYwHiYLS1kZW3oM+38Ep1BxKk2hat1JBjwSh1aGL4s4OkQZRmTL+F6PA2ssc=
X-Received: by 2002:a24:5608:: with SMTP id o8mr11603782itb.35.1548741117125;
 Mon, 28 Jan 2019 21:51:57 -0800 (PST)
MIME-Version: 1.0
References: <1548047768-7656-1-git-send-email-kernelfans@gmail.com> <20190125103924.GB27998@zn.tnic>
In-Reply-To: <20190125103924.GB27998@zn.tnic>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Tue, 29 Jan 2019 13:51:45 +0800
Message-ID: <CAFgQCTtrBrt9CEY=3YiVm7ADD+8oh8bYmatu=3vU92K2_C45ww@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Borislav Petkov <bp@alien8.de>
Cc:     kexec@lists.infradead.org, Dave Young <dyoung@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Yinghai Lu <yinghai@kernel.org>, vgoyal@redhat.com,
        Randy Dunlap <rdunlap@infradead.org>, x86@kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 6:39 PM Borislav Petkov <bp@alien8.de> wrote:
>
>
> >  Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
>
> s/bugfix, //
>
OK.

> On Mon, Jan 21, 2019 at 01:16:08PM +0800, Pingfan Liu wrote:
> > People reported crashkernel=384M reservation failed on a high end server
> > with KASLR enabled.  In that case there is enough free memory under 896M
> > but crashkernel reservation still fails intermittently.
> >
> > The situation is crashkernel reservation code only finds free region under
> > 896 MB with 128M aligned in case no ',high' being used.  And KASLR could
> > break the first 896M into several parts randomly thus the failure happens.
>
> This reads very strange.
>
What about   "  It turns out that crashkernel reservation code only
tries to find a region under 896 MB, aligned on 128M. But KASLR
randomly breaks big region inside [0,896M] into smaller pieces, not
big enough as demanded in the "crashkernel=X" parameter."

> > User has no way to predict and make sure crashkernel=xM working unless
> > he/she use 'crashkernel=xM,high'.  Since 'crashkernel=xM' is the most
> > common use case this issue is a serious bug.
> >
> > And we can't answer questions raised from customer:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
>
> Errr, this looks like communication issue. Sounds to me like the text
> around crashkernel= in
>
What about dropping this section in commit log and another patch to
fix the document?

> Documentation/admin-guide/kernel-parameters.txt
>
> needs improving?
>
> > This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
>
> Avoid having "This patch" or "This commit" in the commit message. It is
> tautologically useless.
>
OK

> Also, do
>
> $ git grep 'This patch' Documentation/process
>
> for more details.
>
> > finally above 4G.
> >
> > Dave Young sent the original post, and I just re-post it with commit log
>
> If he sent it, he should be the author I guess.
>
> > improvement as his requirement.
> > http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > There was an old discussion below (previously posted by Chao Wang):
> > https://lkml.org/lkml/2013/10/15/601
>
> All that changelog info doesn't belong in the commit message ...
>
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > Cc: Borislav Petkov <bp@alien8.de>
> > Cc: x86@kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > ---
>
> .... but here.
>
> > v6 -> v7: commit log improvement
> >  arch/x86/kernel/setup.c | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index 3d872a5..fa62c81 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -551,6 +551,22 @@ static void __init reserve_crashkernel(void)
> >                                                   high ? CRASH_ADDR_HIGH_MAX
> >                                                        : CRASH_ADDR_LOW_MAX,
> >                                                   crash_size, CRASH_ALIGN);
> > +#ifdef CONFIG_X86_64
> > +             /*
> > +              * crashkernel=X reserve below 896M fails? Try below 4G
> > +              */
> > +             if (!high && !crash_base)
> > +                     crash_base = memblock_find_in_range(CRASH_ALIGN,
> > +                                             (1ULL << 32),
> > +                                             crash_size, CRASH_ALIGN);
> > +             /*
> > +              * crashkernel=X reserve below 4G fails? Try MAXMEM
> > +              */
> > +             if (!high && !crash_base)
> > +                     crash_base = memblock_find_in_range(CRASH_ALIGN,
> > +                                             CRASH_ADDR_HIGH_MAX,
> > +                                             crash_size, CRASH_ALIGN);
> > +#endif
>
> Ok, so this is silly: we know at which physical address KASLR allocated
> the kernel so why aren't we querying that and seeing if there's enough
> room before it or after it to call memblock_find_in_range() on the
> bigger range?
>
Sorry, can not catch up with you. Do you suggestion
memblock_find_in_range(0, kernel_start) and
memblock_find_in_range(kernel_end, mem_end)? But the memory is
truncated into fraction by many component which call
memblock_reserve(), besides kernel.

For the left question, Dave has follow the discussion in another
email, will follow there.

Thanks and regards,
Pingfan

> Also, why is "high" dealt with separately and why isn't the code
> enforcing "high" if the normal reservation fails?
>
> The presence of high is requiring from our users to pay attention what
> to use when the kernel can do all that automatically. Looks like a UI
> fail to me.
>
> And look at all the flavors of crashkernel= :
>
>         crashkernel=size[KMG][@offset[KMG]]
>         crashkernel=range1:size1[,range2:size2,...][@offset]
>         crashkernel=size[KMG],high
>         crashkernel=size[KMG],low
>
> We couldn't do one so we made 4?!?!
>
> What for?
>
> Nowhere in that help text does it explain why a user would care about
> high or low or range or offset or the planets alignment...
>
> So what's up?
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
