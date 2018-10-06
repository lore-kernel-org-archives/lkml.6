Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA08ECDE43
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A18E2087D
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 22:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="eiyKvAlc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A18E2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbeJGFWf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Oct 2018 01:22:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:54018 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbeJGFWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Oct 2018 01:22:35 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DEF6C214AB
        for <linux-kernel@vger.kernel.org>; Sat,  6 Oct 2018 22:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538864256;
        bh=EydBx8Y1sVEc7r+PLq9ZaGivxcTg3ytUZ55ZgquFN/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=eiyKvAlcEtqqwgtKpqyyjabGkzFDuYkx/RgX/t7bwmNI8RGxg6ypLkNNfSEmJY337
         X+tdPV0zJmmS5mIVbVK0vfWoJnKuHzPWA0QXlsfZbZOO7v+ERWmHMByXOHCKiygNqk
         S0vOL2E8adikCyzDbudKtaVLSWuHHX2ZUAHRPgMk=
Received: by mail-wr1-f44.google.com with SMTP id n1-v6so16908833wrt.10
        for <linux-kernel@vger.kernel.org>; Sat, 06 Oct 2018 15:17:35 -0700 (PDT)
X-Gm-Message-State: ABuFfojYEgDfRUB+45uuIRiv5jsZ5D3UY4pZWbuIIl3l27A5CUx56X0W
        iNFSKVPOE05jUkLg/HGzgj71wozCqSJI24fGt26Wsg==
X-Google-Smtp-Source: ACcGV60txTtgCUR1ibFmlcXGuADoxJlh+yxiOWCul3I3M4YCuj1lHfsff5ppsU4gDsoN2cTJM6YgDiR1QAOutcGlU88=
X-Received: by 2002:adf:9792:: with SMTP id s18-v6mr12609763wrb.283.1538864254215;
 Sat, 06 Oct 2018 15:17:34 -0700 (PDT)
MIME-Version: 1.0
References: <20181006084327.27467-1-bhe@redhat.com> <20181006122259.GB418@gmail.com>
 <20181006143821.GA72401@gmail.com> <20181006170317.GA21297@gmail.com>
In-Reply-To: <20181006170317.GA21297@gmail.com>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Sat, 6 Oct 2018 15:17:21 -0700
X-Gmail-Original-Message-ID: <CALCETrXcsf9fNAkZH29e=p8pTkqE=YR42cbnLWmqqbAbJQ6KbA@mail.gmail.com>
Message-ID: <CALCETrXcsf9fNAkZH29e=p8pTkqE=YR42cbnLWmqqbAbJQ6KbA@mail.gmail.com>
Subject: Re: [PATCH 4/3 v2] x86/mm/doc: Enhance the x86-64 virtual memory
 layout descriptions
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Baoquan He <bhe@redhat.com>, Andrew Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        linux-doc@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Thomas Garnier <thgarnie@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 6, 2018 at 10:03 AM Ingo Molnar <mingo@kernel.org> wrote:
>
>
> There's one PTI related layout asymmetry I noticed between 4-level and 5-level kernels:
>
>   47-bit:
> > +                                                            |
> > +                                                            | Kernel-space virtual memory, shared between all processes:
> > +____________________________________________________________|___________________________________________________________
> > +                  |            |                  |         |
> > + ffff800000000000 | -128    TB | ffff87ffffffffff |    8 TB | ... guard hole, also reserved for hypervisor
> > + ffff880000000000 | -120    TB | ffffc7ffffffffff |   64 TB | direct mapping of all physical memory (page_offset_base)
> > + ffffc80000000000 |  -56    TB | ffffc8ffffffffff |    1 TB | ... unused hole
> > + ffffc90000000000 |  -55    TB | ffffe8ffffffffff |   32 TB | vmalloc/ioremap space (vmalloc_base)
> > + ffffe90000000000 |  -23    TB | ffffe9ffffffffff |    1 TB | ... unused hole
> > + ffffea0000000000 |  -22    TB | ffffeaffffffffff |    1 TB | virtual memory map (vmemmap_base)
> > + ffffeb0000000000 |  -21    TB | ffffebffffffffff |    1 TB | ... unused hole
> > + ffffec0000000000 |  -20    TB | fffffbffffffffff |   16 TB | KASAN shadow memory
> > + fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
> > +                  |            |                  |         | vaddr_end for KASLR
> > + fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
> > + fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | LDT remap for PTI
> > + ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
> > +__________________|____________|__________________|_________|____________________________________________________________
> > +                                                            |
>
>   56-bit:
> > +                                                            |
> > +                                                            | Kernel-space virtual memory, shared between all processes:
> > +____________________________________________________________|___________________________________________________________
> > +                  |            |                  |         |
> > + ff00000000000000 |  -64    PB | ff0fffffffffffff |    4 PB | ... guard hole, also reserved for hypervisor
> > + ff10000000000000 |  -60    PB | ff8fffffffffffff |   32 PB | direct mapping of all physical memory (page_offset_base)
> > + ff90000000000000 |  -28    PB | ff9fffffffffffff |    4 PB | LDT remap for PTI
> > + ffa0000000000000 |  -24    PB | ffd1ffffffffffff | 12.5 PB | vmalloc/ioremap space (vmalloc_base)
> > + ffd2000000000000 |  -11.5  PB | ffd3ffffffffffff |  0.5 PB | ... unused hole
> > + ffd4000000000000 |  -11    PB | ffd5ffffffffffff |  0.5 PB | virtual memory map (vmemmap_base)
> > + ffd6000000000000 |  -10.5  PB | ffdeffffffffffff | 2.25 PB | ... unused hole
> > + ffdf000000000000 |   -8.25 PB | fffffdffffffffff |   ~8 PB | KASAN shadow memory
> > + fffffc0000000000 |   -4    TB | fffffdffffffffff |    2 TB | ... unused hole
> > +                  |            |                  |         | vaddr_end for KASLR
> > + fffffe0000000000 |   -2    TB | fffffe7fffffffff |  0.5 TB | cpu_entry_area mapping
> > + fffffe8000000000 |   -1.5  TB | fffffeffffffffff |  0.5 TB | ... unused hole
> > + ffffff0000000000 |   -1    TB | ffffff7fffffffff |  0.5 TB | %esp fixup stacks
>
> The two layouts are very similar beyond the shift in the offset and the region sizes, except
> one big asymmetry: is the placement of the LDT remap for PTI.
>
> Is there any fundamental reason why the LDT area is mapped into a 4 petabyte (!) area on 56-bit
> kernels, instead of being at the -1.5 TB offset like on 47-bit kernels?
>
> The only reason I can see is that this way is that it's currently coded at the PGD level only:
>
> static void map_ldt_struct_to_user(struct mm_struct *mm)
> {
>         pgd_t *pgd = pgd_offset(mm, LDT_BASE_ADDR);
>
>         if (static_cpu_has(X86_FEATURE_PTI) && !mm->context.ldt)
>                 set_pgd(kernel_to_user_pgdp(pgd), *pgd);
> }
>
> ( BTW., the 4 petabyte size of the area is misleading: a 5-level PGD entry covers 256 TB of
>   virtual memory, i.e 0.25 PB, not 4 PB. So in reality we have a 0.25 PB area there, used up
>   by the LDT mapping in a single PGD entry, plus a 3.75 PB hole after that. )
>
> ... but unless I'm missing something it's not really fundamental for it to be at the PGD level
> - it could be two levels lower as well, and it could move back to the same place where it's on
> the 47-bit kernel.
>

The subtlety is that, if it's lower than the PGD level, there end up
being some tables that are private to each LDT-using mm that map
things other than the LDT.  Those tables cover the same address range
as some corresponding tables in init_mm, and if those tables in
init_mm change after the LDT mapping is set up, the changes won't
propagate.

So it probably could be made to work, but it would take some extra care.
