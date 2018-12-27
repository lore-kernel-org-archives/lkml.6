Return-Path: <SRS0=YyAj=PE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D9C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC97921741
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Dec 2018 02:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrcnsvaO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727234AbeL0Czh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 21:55:37 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:41390 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbeL0Czh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 21:55:37 -0500
Received: by mail-ed1-f68.google.com with SMTP id a20so7516242edc.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Dec 2018 18:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ADLELYSduE8Jo4WSgQe9/+4jTmUv08JSVGYSSnL6oqM=;
        b=VrcnsvaO6g3vr0rOK3JVCBOk2PQk0Ari9fi72BFPM2roITmJBgLTZBCtHcmXX5qIfH
         Z+2oiVzjYGbRggTJBde5FMYmkRHm425wLAmF921A2JVS6KeMI/J8EWyUL84rcSS6tdDY
         RXH3ARaqPWF4YLMIXMuxTCLojJkVBqeemszbjU6UV3611/1FZ+uGFfdlKItJUChdXvEG
         eQD8spRloGpzKegHRoPd4uKi5CB0dppvPCMWdqnQMXk8/pQie6vquHGOi4P3GdAKTZp4
         mLis2jvNDf4oPbbUFCU7EIQ5oyZjpSMd+vF35zu+moCjn6qdT7BNIdOhTxoiKEQn2DyW
         HM+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ADLELYSduE8Jo4WSgQe9/+4jTmUv08JSVGYSSnL6oqM=;
        b=gESRiHGnqgrdVJjVAmC/cw0HsFEP36NJ1/bBH9VcJkz/MrQkcZmwMV6cVbeKrpTDFw
         PvXfhjn8OwOkqR6TMsR2L/JJHFASC0rWjJIHVTPQ7hufXSImbhroAxqt0LgjqFPWpzZQ
         Hbhpyfg2kcSwa0NEhn99ST4O8z1EH8XSBWB/lz1SdZDLUn7KGLWY3UhG7LPk2RK67FoP
         c9+XvBJnn9MyO/Oz9Kmt1TCZDuMZGfmdxLbJ4hF9iswx/ZykWJIwxopgGlIoPsA+e1db
         KzWd+BPcoEvf1eQ6R1m9GLzEoRjwRNRj+1pr66X1/Gr/YQhIK/OGFkUlTFA0DisYuviw
         Yclg==
X-Gm-Message-State: AA+aEWZ2uZAgwpDCYSQdXjQerU8ZMlAW3rZGI3bO3zwmFOyvyNfbWiyP
        NimaaMxu1/tDCMLrq4CnaOsEXEpAX4WLKs9gEvgOSWM=
X-Google-Smtp-Source: AFSGD/XIMwUogzKEdtm6t7TMlgtxM7+uXqYGVcdn2Nc0IweNcJLi95epz5NmKGs8cFLCUVPX6vfSjvUEvLoYF3HK7bY=
X-Received: by 2002:a17:906:22ca:: with SMTP id q10-v6mr14474398eja.66.1545879334698;
 Wed, 26 Dec 2018 18:55:34 -0800 (PST)
MIME-Version: 1.0
References: <1544760446-506-1-git-send-email-kernelfans@gmail.com> <20181226015757.GA12717@dhcp-128-65.nay.redhat.com>
In-Reply-To: <20181226015757.GA12717@dhcp-128-65.nay.redhat.com>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Thu, 27 Dec 2018 10:55:23 +0800
Message-ID: <CAFgQCTv9COU776G+157KaLRj_0y30u1eRZ2SKcruu-6xvsJ_sg@mail.gmail.com>
Subject: Re: [PATCHv2] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Dave Young <dyoung@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Baoquan He <bhe@redhat.com>, yinghai@kernel.org,
        vgoyal@redhat.com, kexec@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 26, 2018 at 9:58 AM Dave Young <dyoung@redhat.com> wrote:
>
> On 12/14/18 at 12:07pm, Pingfan Liu wrote:
> > Customer reported a bug on a high end server with many pcie devices, where
> > kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> > though we still see much memory under 896 MB, the finding still failed
> > intermittently. Because currently we can only find region under 896 MB,
> > if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> > randomly, and crashkernel reservation need be aligned to 128 MB, that's
> > why failure is found. It raises confusion to the end user that sometimes
> > crashkernel=X works while sometimes fails.
> > If want to make it succeed, customer can change kernel option to
> > "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> > limited space to behave even though its grammer looks more generic.
> > And we can't answer questions raised from customer that confidently:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> >
> > This patch simplifies the method suggested in the mail [1]. It just goes
> > bottom-up to find a candidate region for crashkernel. The bottom-up may be
> > better compatible with the old reservation style, i.e. still want to get
> > memory region from 896 MB firstly, then [896 MB, 4G], finally above 4G.
> >
> > There is one trivial thing about the compatibility with old kexec-tools:
> > if the reserved region is above 896M, then old tool will fail to load
> > bzImage. But without this patch, the old tool also fail since there is no
> > memory below 896M can be reserved for crashkernel.
> >
> > [1]: http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: kexec@lists.infradead.org
> >
> > ---
> > v1->v2:
> >   improve commit log
> >  arch/x86/kernel/setup.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
> > index d494b9b..60f12c4 100644
> > --- a/arch/x86/kernel/setup.c
> > +++ b/arch/x86/kernel/setup.c
> > @@ -541,15 +541,18 @@ static void __init reserve_crashkernel(void)
> >
> >       /* 0 means: find the address automatically */
> >       if (crash_base <= 0) {
> > +             if (!memblock_bottom_up())
> > +                     memblock_set_bottom_up(true);
>
> Looking at the memblock_find_in_range_node code, it is allocating
> bottom up in case bottom_up is true, but it will try to allocate above
> kernel_end:
>
> bottom_up_start = max(start, kernel_end);
>
> If kernel lives very high eg. KASLR case, then this bottom up way does
> not help.  So probably previous old version to try 896M first then 4G
> then maxmem is better.
>
Yes, you are right. I will try to see whether it can be resolved or not.

Thanks,
Pingfan

> >               /*
> >                * Set CRASH_ADDR_LOW_MAX upper bound for crash memory,
> >                * as old kexec-tools loads bzImage below that, unless
> >                * "crashkernel=size[KMG],high" is specified.
> >                */
> >               crash_base = memblock_find_in_range(CRASH_ALIGN,
> > -                                                 high ? CRASH_ADDR_HIGH_MAX
> > -                                                      : CRASH_ADDR_LOW_MAX,
> > -                                                 crash_size, CRASH_ALIGN);
> > +                     (max_pfn * PAGE_SIZE), crash_size, CRASH_ALIGN);
> > +             if (!memblock_bottom_up())
> > +                     memblock_set_bottom_up(false);
> > +
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> > --
> > 2.7.4
> >
