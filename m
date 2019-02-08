Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58298C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C002086C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GfVHqIfH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbfBHPuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 10:50:55 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:52132 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbfBHPuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 10:50:54 -0500
Received: by mail-it1-f196.google.com with SMTP id y184so3496013itc.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Feb 2019 07:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sqia3qO4YXTJONmSi1fmyP7uLd4m8bPTYBZv8tKu34U=;
        b=GfVHqIfHhZVmoa7zDOabJ8gQ3b3ul671NjSdJZXuhveSa1ZlNPq9EPW/S/efx6XoDn
         Y7vdRPQPusp1fboE/38fBQgNtOrGWL4rKCkn1VlJRfPhKGPEMugps0XvPJbBny6QSF5F
         nSQsW+bC0p/svcIH6LNw9qsQDl18CD9je/vAelKA1Cc9xek2Cocmi4fObxYYPoWPTC6y
         AALH+fT992slBXn68V8PRHYzh1ghEfQt6NjUOn7ofagJgVnh5m7zZl6HsjVt8FhgIh56
         siCBcJyMdefzMqyc4eIX2s0U0d55DlgSVdPqJjsNM1SyMfzw+d3+hDeRN/tGDqP0tey0
         ti2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sqia3qO4YXTJONmSi1fmyP7uLd4m8bPTYBZv8tKu34U=;
        b=NLXYJLgoBLf7x0QMkJS3UU2fvi9njFSFWzvD9jPij/CzzONZmi6DmcSUcerHbeq1ZC
         P/+KctVCqwGQAGsAR71MzffOlZe8hcK6/kacXLUvpSnmbkwya9W64KXrQjQ46JvC25pm
         0HlDokiOkIaDnNFzOasV6oUbU9hlRSBzgZPhGKUhFZCnag79vGl8O7+b0rFz90+4IC1H
         lK05oBX1YH/lcyhNwfij1ay2BVK9GAfegfs7kZWNiggSS3XqqTdAv3kwbrFXLvrqLflt
         upu7cvEmdAeNEGBloDY97Nvu+r+pao9FchvQ1yFmIQ2VnlSB50rHhY384ghcmf/LIdJ0
         6HEg==
X-Gm-Message-State: AHQUAuZMvJ74d+O6UipF1DQ0y8ipuH7bubF+Gh8DCL9QEVZlRBlj5sJ5
        OfTf1kcRoDT3hP7hKWJX2YB8va+PNvxY2j/mjAwOQw==
X-Google-Smtp-Source: AHgI3IZOCX08BjO9ZSBMHIP+7cM9CVaEyMc/qxWesRNRltgI13/MtLA9ZsAT0grGfXXV8HlAmftrKk6KxdskHSzBeQc=
X-Received: by 2002:a5e:d609:: with SMTP id w9mr9748612iom.170.1549641052447;
 Fri, 08 Feb 2019 07:50:52 -0800 (PST)
MIME-Version: 1.0
References: <20190202094119.13230-1-ard.biesheuvel@linaro.org>
 <20190202094119.13230-3-ard.biesheuvel@linaro.org> <20190204071809.GA115714@gmail.com>
 <CAKv+Gu-vxV_U03jdMY0N1UMDWcB1jZLKj-ONV2rsw3UTeimhBg@mail.gmail.com> <FFF73D592F13FD46B8700F0A279B802F486FF4C3@ORSMSX114.amr.corp.intel.com>
In-Reply-To: <FFF73D592F13FD46B8700F0A279B802F486FF4C3@ORSMSX114.amr.corp.intel.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Fri, 8 Feb 2019 16:50:37 +0100
Message-ID: <CAKv+Gu83HJo29=d4VEMCi3D2PH-Crqrt_oUz14Ogz2r0W9ih+g@mail.gmail.com>
Subject: Re: [PATCH 02/10] x86/efi: Return error status if mapping EFI regions fail
To:     "Prakhya, Sai Praneeth" <sai.praneeth.prakhya@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Alexander Graf <agraf@suse.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Borislav Petkov <bp@alien8.de>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Jeffrey Hugo <jhugo@codeaurora.org>,
        Lee Jones <lee.jones@linaro.org>,
        Leif Lindholm <leif.lindholm@linaro.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Jones <pjones@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Feb 2019 at 23:29, Prakhya, Sai Praneeth
<sai.praneeth.prakhya@intel.com> wrote:
>
> > > > efi_map_region() creates VA mappings for an given EFI region using
> > > > any one of the two helper functions (namely __map_region() and
> > old_map_region()).
> > > > These helper functions *could* fail while creating mappings and
> > > > presently their return value is not checked. Not checking for the
> > > > return value of these functions might create issues because after
> > > > these functions return "md->virt_addr" is set to the requested
> > > > virtual address (so it's assumed that these functions always succeed
> > > > which is not quite true). This assumption leads to "md->virt_addr"
> > > > having invalid mapping should any of
> > > > __map_region() or old_map_region() fail.
> > > >
> > > > Hence, check for the return value of these functions and if indeed
> > > > they fail, turn off EFI Runtime Services forever because kernel
> > > > cannot prioritize among EFI regions.
> > > >
> [...................]
> > > > -void __init old_map_region(efi_memory_desc_t *md)
> > > > +int __init old_map_region(efi_memory_desc_t *md)
> > > >  {
> > > >       u64 start_pfn, end_pfn, end;
> > > >       unsigned long size;
> > > > @@ -601,10 +601,14 @@ void __init old_map_region(efi_memory_desc_t
> > *md)
> > > >               va = efi_ioremap(md->phys_addr, size,
> > > >                                md->type, md->attribute);
> > > >
> > > > -     md->virt_addr = (u64) (unsigned long) va;
> > > > -     if (!va)
> > > > +     if (!va) {
> > > >               pr_err("ioremap of 0x%llX failed!\n",
> > > >                      (unsigned long long)md->phys_addr);
> > > > +             return -ENOMEM;
> > > > +     }
> > > > +
> > > > +     md->virt_addr = (u64)(unsigned long)va;
> > > > +     return 0;
> > >
> > > Just wondering, shouldn't the failure path set ->virt_addr to
> > > something safe, just in case a caller doesn't check the error and relies on it?
> > >
> > > That's because in this commit we've now changed it from 0 to undefined.
> > >
> >
> > Indeed. We don't usually rely on the value of ->virt_addr when
> > EFI_RUNTIME_SERVICES is unset, but there is some sysfs code, and perhaps
> > some other places where we do reference ->virt_addr, and not assigning it at all
> > is obviously wrong, and potentially hazardous.
> >
>
> Ok.. makes sense.
> Do you think md->virt_addr = 0 for fail case is ok?
>

0 should be fine. You shouldn't be able to dereference that anywhere.


> > > > +int __init efi_map_region_fixed(efi_memory_desc_t *md) { return 0;
> > > > +}
> > >
> > > Inline functions should be marked inline ...
> > >
> > > >       if (efi_va < EFI_VA_END) {
> > > > -             pr_warn(FW_WARN "VA address range overflow!\n");
> > > > -             return;
> > > > +             pr_err(FW_WARN "VA address range overflow!\n");
> > > > +             return -ENOMEM;
> > > >       }
> > > >
> > > >       /* Do the VA map */
> > > > -     __map_region(md, efi_va);
> > > > +     if (__map_region(md, efi_va))
> > > > +             return -ENOMEM;
> > > > +
> > > >       md->virt_addr = efi_va;
> > > > +     return 0;
> > >
> > > Same error return problem of leaving ->virt_addr undefined.
> > >
>
> Sure! Will fix it in V2.
>
> > > Note that I also fixed up the grammar and readability of the changelog
> > > - see the updated version below.
>
> Thanks for fixing :)
>
> > >
> > > Thanks,
> > >
> > >         Ingo
> > >
> > > =============>
> > > Subject: x86/efi: Return error status if mapping of EFI regions fails
> > > From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> > > Date: Sat, 2 Feb 2019 10:41:11 +0100
> > >
> > > From: Sai Praneeth Prakhya <sai.praneeth.prakhya@intel.com>
> > >
> > > efi_map_region() creates VA mappings for a given EFI region using one
> > > of the two helper functions (namely __map_region() and old_map_region()).
> > >
> > > These helper functions could fail while creating mappings and
> > > presently their return value is not checked.
> > >
> > > Not checking for the return value of these functions might create
> > > bugs, because after these functions return "md->virt_addr" is set to
> > > the requested virtual address (so it's assumed that these functions
> > > always succeed which is not quite true). This assumption leads to
> > > "md->virt_addr" having invalid mapping, should any of __map_region()
> > > or old_map_region() fail.
> > >
> > > Hence, check for the return value of these functions and if indeed
> > > they fail, turn off EFI Runtime Services forever because kernel cannot
> > > prioritize among EFI regions.
> > >
> > > This also fixes the comment "FIXME: add error handling" in
> > > kexec_enter_virtual_mode().
> > >
> >
> > Thanks Ingo.
> >
> > Sai, could you please respin this and use Ingo's updated version of the commit
> > log?
>
> Sure! I will send a V2 with the mentioned changes.
>
> Regards,
> Sai
