Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE0EC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:40:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3239B205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:40:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I8zbllmP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3239B205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966810AbeFSPk2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:40:28 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:44188 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966078AbeFSPk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:40:27 -0400
Received: by mail-io0-f193.google.com with SMTP id g7-v6so604478ioh.11
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8FOV1EzZpyHNIzVcAW/Lu3kj+UiDvwLnv0mBBjUq7Vw=;
        b=I8zbllmPwKxeVwtNDeya13jUDULTWWI0qNNP5RRb34r6EzJ+f2iaYlrH/DFZOayUMs
         DXrJ1rY1iWMPRwEEmUisQMwIMHPwbHes0vFoweU4YutXAYjUvjgTTVv8YiGKRhK9fiNp
         Af5IbPv32pmaDQqvR3WTaTs5ZhyEnGkJpbxKo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8FOV1EzZpyHNIzVcAW/Lu3kj+UiDvwLnv0mBBjUq7Vw=;
        b=r8qNNPCews5i3NV9kOb75A7Z4NNTjOEnbfaF4AyqGrAGmdCCE6Cuo694JIkp0uyOyP
         DWLUblVCdn0Ednkb2zXPAy4m7tk2r/dv7nVXfU1JYtl9FLtosekyXgXa5N5jgJeUe6aQ
         BZGQtJm4rfsVGjP2YEilnKh2fNu5AOCgpXuxU1SfdjIAbHBUnl6fxYdWSE6Hd+IoNWgd
         qDmhtS/+vFgc1kkv4SW+T2Rjz/hypDAIp6BXO1tzc5pSd4pKS49Oz2mMcXwXsVb7SiEH
         zSUeHyRbbmvvBYvEoqZ61VZKY2qpph4hkFVxUTG0gRnlHx+JS+T0gQNW/mi52W9z8918
         rfIA==
X-Gm-Message-State: APt69E3pb21O5ApanxBc+WTGswpOP5Zlhmx61xugRPFP/L8bxWloGKM7
        avMkX+WLI0ZPm1igMKKCOEwWQiXjLo4j7YjS8hbfbQ==
X-Google-Smtp-Source: ADUXVKIGFtdG3jpgf9bEV8b4sZbRAyg77L2XyM47wV9oH/2WsChWa+Zm35JXg6nRS2lKBlLd0g1DMiMB1G9E5pHoODs=
X-Received: by 2002:a6b:520d:: with SMTP id g13-v6mr14763872iob.60.1529422826553;
 Tue, 19 Jun 2018 08:40:26 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 08:40:26
 -0700 (PDT)
In-Reply-To: <20180619153754.GO13984@arm.com>
References: <20180530044806.18449-1-yaojun8558363@gmail.com>
 <20180530091457.GB2452@arm.com> <CAKv+Gu8Zc7eQbG-Ww51GXUCEmhe2J03vbq5vVdyaKra-s13KrA@mail.gmail.com>
 <20180619152035.GM13984@arm.com> <CAKv+Gu-Mad64U63jjuKGjhg=h2wdoEKm2vywzATBYr-t_UY_bQ@mail.gmail.com>
 <20180619152805.GN13984@arm.com> <CAKv+Gu81zgvcLd-N_MMENykxcm6ENvvfCuWOoMGsrfUf9Usy5g@mail.gmail.com>
 <20180619153754.GO13984@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Jun 2018 17:40:26 +0200
Message-ID: <CAKv+Gu-x-e+M7_28m=zMeZ2=1p6DXWvu2L4K988jpfYjK+=JaA@mail.gmail.com>
Subject: Re: [PATCH] arm64: mm: mark tramp_pg_dir read-only
To:     Will Deacon <will.deacon@arm.com>
Cc:     YaoJun <yaojun8558363@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19 June 2018 at 17:37, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jun 19, 2018 at 05:29:03PM +0200, Ard Biesheuvel wrote:
>> On 19 June 2018 at 17:28, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Jun 19, 2018 at 05:23:41PM +0200, Ard Biesheuvel wrote:
>> >> On 19 June 2018 at 17:20, Will Deacon <will.deacon@arm.com> wrote:
>> >> > Hi Ard,
>> >> >
>> >> > Sorry, I forgot to reply to this.
>> >> >
>> >> > On Wed, May 30, 2018 at 11:53:20AM +0200, Ard Biesheuvel wrote:
>> >> >> On 30 May 2018 at 11:14, Will Deacon <will.deacon@arm.com> wrote:
>> >> >> > On Wed, May 30, 2018 at 12:48:06PM +0800, YaoJun wrote:
>> >> >> >> To protect against KSMA(Kernel Space Mirroring Attack), make
>> >> >> >> tramp_pg_dir read-only. The principle of KSMA is to insert a
>> >> >> >> carefully constructed PGD entry into the translation table.
>> >> >> >> The type of this entry is block, which maps the kernel text
>> >> >> >> and its access permissions bits are 01. The user process can
>> >> >> >> then modify kernel text directly through this mapping. In this
>> >> >> >> way, an arbitrary write can be converted to multiple arbitrary
>> >> >> >> writes.
>> >> >> >>
>> >> >> >> Signed-off-by: YaoJun <yaojun8558363@gmail.com>
>> >> >> >> ---
>> >> >> >>  arch/arm64/mm/mmu.c | 4 ++++
>> >> >> >>  1 file changed, 4 insertions(+)
>> >> >> >>
>> >> >> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> >> >> >> index 2dbb2c9f1ec1..ac4b22c7e435 100644
>> >> >> >> --- a/arch/arm64/mm/mmu.c
>> >> >> >> +++ b/arch/arm64/mm/mmu.c
>> >> >> >> @@ -551,6 +551,10 @@ static int __init map_entry_trampoline(void)
>> >> >> >>       __create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
>> >> >> >>                            prot, pgd_pgtable_alloc, 0);
>> >> >> >>
>> >> >> >> +     update_mapping_prot(__pa_symbol(tramp_pg_dir),
>> >> >> >> +                             (unsigned long)tramp_pg_dir,
>> >> >> >> +                             PGD_SIZE, PAGE_KERNEL_RO);
>> >> >> >
>> >> >> > Hmm, I like the idea but is there a risk that the page table has been mapped
>> >> >> > as part of a block entry, which we can't safely split at this point (i.e.
>> >> >> > we'll run into one of the BUG_ONs in the mapping code)?
>> >> >> >
>> >> >>
>> >> >> We'd need to create a separate segment for it initially so the mapping
>> >> >> is already at the right granularity.
>> >> >
>> >> > Why do you think that's the case? I can't see anything that guarantees this
>> >> > for the page table itself.
>> >> >
>> >>
>> >> We'd need to pass NO_BLOCK_MAPPINGS to map_kernel_segment(),
>> >> obviously, but that shouldn't hurt since that segment is relatively
>> >> tiny anyway.
>> >
>> > Ah right, with NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS, I agree that we're good.
>> > Ideally, we'd move {idmap,swapper,tramp}_pg_dir into .rodata...
>> >
>>
>> idmap and tramp yes, but swapper needs to be modifiable at runtime, no?
>
> Right, but couldn't we swizzle the permissions in e.g. set_pmd? We could
> even predicate that on a sanity check of the prot.
>

Swizzle the permissions of the entire .rodata segment? That sounds
doable, but there is a whole class of data that belongs in this
category, and I think PaX/grsecurity had an API for that (but I don't
think anyone is upstreaming that yet). So let's not reinvent that
wheel for swapper_pg_dir only.
