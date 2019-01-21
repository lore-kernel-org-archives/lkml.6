Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4E1DC282E9
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 871A7214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uNHGShBt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729559AbfAUIHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:07:20 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:40744 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729131AbfAUIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:07:17 -0500
Received: by mail-it1-f193.google.com with SMTP id h193so13983991ita.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:07:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=J5oAp0R2bVrI9BacaLl9zgBvm002A3RFXBO6d48SkQo=;
        b=uNHGShBt095mvjoNI48r4+RRwF0Ms3iDuOcXXyV97XpGj619eHThsjHX9BNFirN/VX
         3rXOcixOZigyudwvYD0uXO64cBEKT92s/ZtHfs8hRUCF94Y4WiyrXOTCJGMxSvKnhviO
         B5gCNyoAFRyiZM2/z6X+NsZAw4Az3ME8v2KWLXsRGSXQmZ2a6reKFvdTddqhiRD7uHiE
         bdK3Nv9uNJtylPNzN7TT6ahL/hCT8spTh8icVXwcJMkz/7ubjuYiCmZeuamMPsVdj4D2
         KXTu4IVL1JnBQqYxz8qmGitIsJDR/Wmmwc4LFQG3EpexExmSbOGvPqUt8o6WoonTk2mU
         /xSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=J5oAp0R2bVrI9BacaLl9zgBvm002A3RFXBO6d48SkQo=;
        b=iGpP2jPWtlnD/h19Gx3jqzLsK6m2TiT6QM8cszvRav9UYGt+b1M9G3ppt9W/FwMrPV
         J1BOoVInEnWdAEyIvGM6x95ZRAZTCdLTYF/9oLHS6Fhe3BxKCzQR+XOMNWG+42L42q+9
         6ti4p3N1aX4OXPJvd1GCMMSS7zlwpczatgTMD1v2IXAzArRX+4MhhD695mcpiGK+DARs
         RNtzaqsqyrDMv1/Mu2Inxs+piRZe/A49rW4HQp6eCT8dZsfalZ2FK0VkeS7gCLO4pv0D
         svJLASgI9VaLEaloqjhpSFv2w8ypPrFPbLuz55ycP3U7PsFhFO8D8q/Zs0leqe7xa4Ru
         gA6A==
X-Gm-Message-State: AJcUukfrZxrdwDSOC4jrgoFGuGCDfqZVGpqb9eGk4FkQwV4AwSg7ICej
        YS4WfSZ7rdQzilvQuqGEU7pQD/ZRy4W0MRVX7YSU+8t2sQ==
X-Google-Smtp-Source: ALg8bN6s+QnvBCm8qROcwyrABvz2M2KQ3lzrED6fpRTph9hrLVs79TKLs40ebbENycyB3GbIghwWUGTYe3m5F3cLX4E=
X-Received: by 2002:a24:f143:: with SMTP id q3mr16866718iti.42.1548047512312;
 Sun, 20 Jan 2019 21:11:52 -0800 (PST)
MIME-Version: 1.0
References: <1547539623-18201-1-git-send-email-kernelfans@gmail.com> <20190119012505.GA21653@anatevka>
In-Reply-To: <20190119012505.GA21653@anatevka>
From:   Pingfan Liu <kernelfans@gmail.com>
Date:   Mon, 21 Jan 2019 13:11:41 +0800
Message-ID: <CAFgQCTuwG6ByuRvBH844bd=KQC-uF-uea_Z--evhU2k_oE8tOw@mail.gmail.com>
Subject: Re: [PATCHv7] x86/kdump: bugfix, make the behavior of crashkernel=X
 consistent with kaslr
To:     Jerry.Hoemann@hpe.com
Cc:     kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Yinghai Lu <yinghai@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Young <dyoung@redhat.com>, vgoyal@redhat.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 19, 2019 at 9:25 AM Jerry Hoemann <jerry.hoemann@hpe.com> wrote:
>
> On Tue, Jan 15, 2019 at 04:07:03PM +0800, Pingfan Liu wrote:
> > People reported a bug on a high end server with many pcie devices, where
> > kernel bootup with crashkernel=384M, and kaslr is enabled. Even
> > though we still see much memory under 896 MB, the finding still failed
> > intermittently. Because currently we can only find region under 896 MB,
> > if without ',high' specified. Then KASLR breaks 896 MB into several parts
> > randomly, and crashkernel reservation need be aligned to 128 MB, that's
> > why failure is found. It raises confusion to the end user that sometimes
> > crashkernel=X works while sometimes fails.
> > If want to make it succeed, customer can change kernel option to
> > "crashkernel=384M,high". Just this give "crashkernel=xx@yy" a very
> > limited space to behave even though its grammar looks more generic.
> > And we can't answer questions raised from customer that confidently:
> > 1) why it doesn't succeed to reserve 896 MB;
> > 2) what's wrong with memory region under 4G;
> > 3) why I have to add ',high', I only require 384 MB, not 3840 MB.
> > This patch tries to get memory region from 896 MB firstly, then [896MB,4G],
> > finally above 4G.
>
> While allocating crashkernel from below 4G seems fine, won't we have
> problems if the crash kernel gets allocated above 4G because of the SWIOTLB?
>
It will reserve extra memory below 4G for the swiotlb purpose. You can
find the logic in reserve_crashkernel_low()
And testing with crashkernel=512M@4G, we will get:
cat /proc/iomem  | grep Crash
  aa000000-b9ffffff : Crash kernel
  100000000-11fffffff : Crash kernel

Thanks,
Pingfan

> thanks
>
>
> > Dave Young sent the original post, and I just re-post it with commit log
> > improvement as his requirement.
> > http://lists.infradead.org/pipermail/kexec/2017-October/019571.html
> > There was an old discussion below (previously posted by Chao Wang):
> > https://lkml.org/lkml/2013/10/15/601
> >
> > Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
> > Cc: Dave Young <dyoung@redhat.com>
> > Cc: Baoquan He <bhe@redhat.com>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
> > Cc: yinghai@kernel.org,
> > Cc: vgoyal@redhat.com
> > Cc: Randy Dunlap <rdunlap@infradead.org>
> > ---
> > v6 -> v7: fix spelling mistake pointed out by Randy
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
> >               if (!crash_base) {
> >                       pr_info("crashkernel reservation failed - No suitable area found.\n");
> >                       return;
> > --
> > 2.7.4
> >
> >
> > _______________________________________________
> > kexec mailing list
> > kexec@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/kexec
>
> --
>
> -----------------------------------------------------------------------------
> Jerry Hoemann                  Software Engineer   Hewlett Packard Enterprise
> -----------------------------------------------------------------------------
