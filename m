Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12A22C67839
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:53:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4CD62086D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 03:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HiLtJPzO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4CD62086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbeLNDx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Dec 2018 22:53:29 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34540 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbeLNDx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Dec 2018 22:53:28 -0500
Received: by mail-ed1-f65.google.com with SMTP id b3so3864056ede.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Dec 2018 19:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=272NXYEg2U2K+2cRZHLa+5UEFeFuZ5KQvrY7ISauzxQ=;
        b=HiLtJPzO9/mXF1Jp+I23nkmefPTGpZqN19kZarltEsoff0fofBGuBfjYMcS4g3xI0K
         lGSRu9nk/55YKT895uqjObNFAmRMRn/rVB6V0zUoJgEU6KR5gu28ssORw/RvuzV/I6bc
         hr9DT11/5HTxp9UlIwdmXFzJ/KjjyoCmIwZNH44oqS7nHseDkxxzWrq4Sy5mv1Fb+lvu
         CFJu9OkH4yox96/kGEMH459gi8xx9LKVyy2Sy9fYSZFkHFFbFGWW6p36GBjh9xt86lnn
         iBGUZp08TtL/0dXYSF7jrFCsOdxlzWW8gb0hyQtWdWcPVJMlZUsjABowuOipMavmp9Xa
         3GLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=272NXYEg2U2K+2cRZHLa+5UEFeFuZ5KQvrY7ISauzxQ=;
        b=ehiYs1wX3+K2kYlo2Hd1iGMDHgTRhyy4uVHgY9jYNiweSrFjUdX39aUGLNQhYr4TG3
         0IP/iInIZmt9kHSl/CeYMcKyDnKtEuhQNe/29wtoPKGiIq0kfe7zh/3+EfrnAJStcCnl
         bCPOCbkB/rP5tW3yv7Kj8PL3n5nWNnMryzyFVcD2uhsmDLyS0eRGff5tZ+TlkhmHeXx1
         QeiMchFgvKGowAtfod0H9IlNaYAva6CQdJHZtjLowjRvTXeWALbiYbgoJyGFqt053X9y
         iiDvLYqrxVbOL9FQ2I0lW+afliOUXm76fDVI2N2Iosin7u78xsQDJ2itxjny47JgLlXc
         DU+Q==
X-Gm-Message-State: AA+aEWYQpgaIqZeVWgEl5h2OcjR3d47A3+qnYZUq1yCXnAfO5lwg0MX7
        WMvXpqbx1umIfcS2D3KiIof+UIvF8ljcbzGhfaE2Yjs=
X-Google-Smtp-Source: AFSGD/XNWnC1IywOimPme4suHO2o/RE+PBfI3gq9i7TFuK1CeZSrb9uwF06ykXHnkqWU2KPDLFo9Sf3sd4doCHwiTEc=
X-Received: by 2002:aa7:cf88:: with SMTP id z8mr1590673edx.208.1544759606299;
 Thu, 13 Dec 2018 19:53:26 -0800 (PST)
MIME-Version: 1.0
References: <1544602756-17449-1-git-send-email-kernelfans@gmail.com> <20181212090144.GQ17340@MiWiFi-R3L-srv>
In-Reply-To: <20181212090144.GQ17340@MiWiFi-R3L-srv>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Fri, 14 Dec 2018 11:53:14 +0800
Message-ID: <CAFgQCTuXnXmhSA7yfszGJ1z6f=K_Rg3_MW=4P+yupJ2BTsAtPw@mail.gmail.com>
Subject: Re: [PATCH] x86/kdump: directly find a candidate region when crashkernel=X
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Dave Young <dyoung@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>, yinghai@kernel.org,
        vgoyal@redhat.com, kexec@lists.infradead.org, jroedel@suse.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baoquan,

Thanks for your kindly review. I will update the commit log to explain
the scenario.

Best regards,
Pingfan
On Wed, Dec 12, 2018 at 5:01 PM Baoquan He <bhe@redhat.com> wrote:
>
> Hi Pingfan,
>
> Thanks for fixing this.
>
> On 12/12/18 at 04:19pm, Pingfan Liu wrote:
> > I encounter a case where crashkernel=384M, and kaslr is enabled. During the
> > test, sometimes, the system may fail to reserve region for crash kernel,
> > although there is much free space above 896MB. It is caused by the
>
> I remember this bug was reported by our customer. They specify
> crashkernel=384MB on a high end server with many pcie devices. Even
> though we still see much memory under 896 MB, the finding still failed
> intermittently. Because currently we can only find region under 896 MB,
> if w/0 ',high' specified. Then KASLR breaks 896 MB into several parts
> randomly, and crashkernel reservation need be aligned to 128 MB, that's
> why failure is found.
>
> If want to make it succeed, customer can change kernel option to
> "crashkernel=384M, high". Just this give "crashkernel=xx@yy" a very
> limited space to behave even though its grammer looks more generic.
> And we can't answer questions raised from customer that confidently:
> 1) why it doesn't succeed to reserve 896 MB;
> 2) what's wrong with memory region under 4G;
> 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
>
> > truncation of the candidate region by kaslr kernel. It raises confusion to
> > the end user that sometimes crashkernel=X works while sometimes fails.
> > Since on x86, kaslr is a default option, and this corner case is
> > unavoidable.
> > This patch simplifies the method suggested in the mail [1]. It just goes
> > bottom-up to find a candidate region for crashkernel.
> > There is one trivial thing about the compatibility with old kexec-tools:
> > if the reserved region is above 896M, then old tool will fail to load
> > bzImage. But without this patch, the old tool also fail since there is no
> > memory below 896M can be reserved for crashkernel.
>
> Meanwhile, we set bottom-up to try to reserve crashkernel because we
> still want to get memory region from 896 MB firstly, then [896 MB, 4G],
> finally above 4G. This gives us a chance to be compatible with the old
> reservation style, and this is what we have been doing in redhat
> distros. We may only search [128MB, 4G] only if people mind, just leave
> above 4G reservation to ',high' explicitly.
>
> Thanks
> Baoquan
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
> Here maybe change it like below. Just personal opinion, not a big deal,
> not strongly suggested.
>                 bool bottom_up;
>
>                 bottom_up = memblock_bottom_up();
>                 memblock_set_bottom_up(true);
>
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
>                 memblock_set_bottom_up(bottom_up);
> > +
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> > --
> > 2.7.4
> >
