Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 284CEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:01:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB4782075E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 16:01:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="N8+Bllhv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB4782075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966962AbeFSQBA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 12:01:00 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:40248 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965783AbeFSQA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 12:00:59 -0400
Received: by mail-io0-f194.google.com with SMTP id g22-v6so677290iob.7
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 09:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ByqldH7dTyPyFtITxEc5c0PEkUVLXx/A2Wd9MSkRRTA=;
        b=N8+Bllhv0YeC6zZUMmla555Mu8sXdMfg6B/1oIbn0kxA5dGomRCDiYQhLVSxrMcKOE
         KsOILfRm+eYblkGo9sCzpbqxibnX9kBx+wlvMLp/2A7o7LvSdCxqALYySnS6FnVU5M/9
         zkVoJF23jos4EHcF042cSn7MdyHH32dEju4S0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ByqldH7dTyPyFtITxEc5c0PEkUVLXx/A2Wd9MSkRRTA=;
        b=lMpr4ngrSgqVKGWVnzLfJ0qzAefS+I8pWhYQV50kSidB4TzTg6nTd9SPZbY0WjwsYm
         4zdSOt/0aXLQvPQPIrXIHuk6gmBfXp5HZXCFsTq8bWICVzKuKZqdCb11PaYPycSvGBZb
         Kvund/8SxLZpGwnAcez7gEKGPmCy/DwdgKvm7LUwfl9IIkF9mI3uihd+e9Gp0SQCEG1E
         CsxVfqyWBFP2j+H7WSHBGD14D0o8p/axTmF2K5V/t7nOVmgE9Xnt6i3vSNotKN/mbbCn
         L42upAjfmXPQpOVP7Wy6Ao/G2aijbaWMr2kKctFuhEH1QgDvMn7VYGLun8kYhRF3u6AH
         xZrg==
X-Gm-Message-State: APt69E3Pt97j2Ji7JsHzMQjQCFK5btTPGzmWGcmjJDt2TKBQenpqgtPE
        HVa04e5OmZ0NOMDkmnOTifhV85Ox2xumEgUPvWnTs089
X-Google-Smtp-Source: ADUXVKIwD26h8YDM0EVZe1ijCARmz7+VlZuo3ymelZYE3GR+kX6XuFmV38sLg0dSHeujP/R7qipVLF2H4OF/7SaU3ow=
X-Received: by 2002:a6b:dd0b:: with SMTP id f11-v6mr13863072ioc.173.1529424058382;
 Tue, 19 Jun 2018 09:00:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 09:00:57
 -0700 (PDT)
In-Reply-To: <20180619155512.GQ13984@arm.com>
References: <20180530091457.GB2452@arm.com> <CAKv+Gu8Zc7eQbG-Ww51GXUCEmhe2J03vbq5vVdyaKra-s13KrA@mail.gmail.com>
 <20180619152035.GM13984@arm.com> <CAKv+Gu-Mad64U63jjuKGjhg=h2wdoEKm2vywzATBYr-t_UY_bQ@mail.gmail.com>
 <20180619152805.GN13984@arm.com> <CAKv+Gu81zgvcLd-N_MMENykxcm6ENvvfCuWOoMGsrfUf9Usy5g@mail.gmail.com>
 <20180619153754.GO13984@arm.com> <CAKv+Gu-x-e+M7_28m=zMeZ2=1p6DXWvu2L4K988jpfYjK+=JaA@mail.gmail.com>
 <20180619155001.GP13984@arm.com> <CAKv+Gu-fA61TbOWOfMbwffyJEzMDKrOSOOw0nbNbeO-xm8YbaA@mail.gmail.com>
 <20180619155512.GQ13984@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Jun 2018 18:00:57 +0200
Message-ID: <CAKv+Gu-KA0Yog7mxfPkF7aNkJsTr=V6+R9+tbKLw0xMb4mSmWQ@mail.gmail.com>
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

On 19 June 2018 at 17:55, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jun 19, 2018 at 05:51:46PM +0200, Ard Biesheuvel wrote:
>> On 19 June 2018 at 17:50, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Jun 19, 2018 at 05:40:26PM +0200, Ard Biesheuvel wrote:
>> >> On 19 June 2018 at 17:37, Will Deacon <will.deacon@arm.com> wrote:
>> >> > On Tue, Jun 19, 2018 at 05:29:03PM +0200, Ard Biesheuvel wrote:
>> >> >> On 19 June 2018 at 17:28, Will Deacon <will.deacon@arm.com> wrote:
>> >> >> > On Tue, Jun 19, 2018 at 05:23:41PM +0200, Ard Biesheuvel wrote:
>> >> >> >> On 19 June 2018 at 17:20, Will Deacon <will.deacon@arm.com> wrote:
>> >> >> >> > On Wed, May 30, 2018 at 11:53:20AM +0200, Ard Biesheuvel wrote:
>> >> >> >> >> On 30 May 2018 at 11:14, Will Deacon <will.deacon@arm.com> wrote:
>> >> >> >> >> > On Wed, May 30, 2018 at 12:48:06PM +0800, YaoJun wrote:
>> >> >> >> >> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> >> >> >> >> >> index 2dbb2c9f1ec1..ac4b22c7e435 100644
>> >> >> >> >> >> --- a/arch/arm64/mm/mmu.c
>> >> >> >> >> >> +++ b/arch/arm64/mm/mmu.c
>> >> >> >> >> >> @@ -551,6 +551,10 @@ static int __init map_entry_trampoline(void)
>> >> >> >> >> >>       __create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
>> >> >> >> >> >>                            prot, pgd_pgtable_alloc, 0);
>> >> >> >> >> >>
>> >> >> >> >> >> +     update_mapping_prot(__pa_symbol(tramp_pg_dir),
>> >> >> >> >> >> +                             (unsigned long)tramp_pg_dir,
>> >> >> >> >> >> +                             PGD_SIZE, PAGE_KERNEL_RO);
>> >> >> >> >> >
>> >> >> >> >> > Hmm, I like the idea but is there a risk that the page table has been mapped
>> >> >> >> >> > as part of a block entry, which we can't safely split at this point (i.e.
>> >> >> >> >> > we'll run into one of the BUG_ONs in the mapping code)?
>> >> >> >> >> >
>> >> >> >> >>
>> >> >> >> >> We'd need to create a separate segment for it initially so the mapping
>> >> >> >> >> is already at the right granularity.
>> >> >> >> >
>> >> >> >> > Why do you think that's the case? I can't see anything that guarantees this
>> >> >> >> > for the page table itself.
>> >> >> >> >
>> >> >> >>
>> >> >> >> We'd need to pass NO_BLOCK_MAPPINGS to map_kernel_segment(),
>> >> >> >> obviously, but that shouldn't hurt since that segment is relatively
>> >> >> >> tiny anyway.
>> >> >> >
>> >> >> > Ah right, with NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS, I agree that we're good.
>> >> >> > Ideally, we'd move {idmap,swapper,tramp}_pg_dir into .rodata...
>> >> >> >
>> >> >>
>> >> >> idmap and tramp yes, but swapper needs to be modifiable at runtime, no?
>> >> >
>> >> > Right, but couldn't we swizzle the permissions in e.g. set_pmd? We could
>> >> > even predicate that on a sanity check of the prot.
>> >> >
>> >>
>> >> Swizzle the permissions of the entire .rodata segment? That sounds
>> >> doable, but there is a whole class of data that belongs in this
>> >> category, and I think PaX/grsecurity had an API for that (but I don't
>> >> think anyone is upstreaming that yet). So let's not reinvent that
>> >> wheel for swapper_pg_dir only.
>> >
>> > I wasn't thinking of the whole .rodata segment -- just the page containing
>> > the entry being modified, but ok.
>>
>> That means we will need to map .rodata down to pages as well, or at
>> least avoid contiguous mappings.
>
> Doesn't it already avoid those?
>

You are right, it does.
