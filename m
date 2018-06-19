Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD1AEC5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:29:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97318205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 15:29:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gUZcXoaa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97318205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966730AbeFSP3K (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 11:29:10 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:35688 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966641AbeFSP3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 11:29:05 -0400
Received: by mail-it0-f68.google.com with SMTP id a3-v6so980853itd.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jun 2018 08:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=+Bii4H98d5lZzWOxEYun/5G7g+u2fB5Ok8emyDtROeo=;
        b=gUZcXoaaCyl56dtbUo1ngZJqpvPThWVNk/FvVzszIg407Zdk3T3Fafggd3Mw+6HaBc
         sPL6mRe0vfgguAA/bSR/064e0J8y080W9vd/5ltg7qDCms7lFctaSMdxoJNUDEEEeVHQ
         8WKf4B0LaaxYh4qGmPS3beBSEYDc/o4lwBJvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=+Bii4H98d5lZzWOxEYun/5G7g+u2fB5Ok8emyDtROeo=;
        b=lT4ge+5hW20G8a0CagAM5tn39Tbjam+AvxZw2VHMZFvf3917KyUNUA23ix1xpIsDqB
         H0HfZtHbAMB7+S/DLzR2UKK+eT3qt2e6fcyfTrZ3EzK8YfDAeHH14In22KfPGw102CMG
         xyBLotPDLk/W0Yh9zwKArV0MiF6lQE9CTACurt0iklhXNbKdChSeFdEnEa5B0bjG4StA
         h++nK6YnXAJc08OF8iCm9UE45pjYFjTFtQ1hgbvN30p7WxhmpGo2TEe4uPg1NFM4s5N+
         UzSMsJ7UIL2f6UWCap5f/5mRY99lg8fdVvfYfoZWEfUIFT0QHGhi1apD70VUZboU8gl6
         psfQ==
X-Gm-Message-State: APt69E2DcBn9ts4bwAhZ/RqBnvgAgko9vx/ixo40fFnAkLJTPNQtmeKO
        Ka+uqFW24O5VCXt0m5/zCICHTURB+2YlM329U++lkA==
X-Google-Smtp-Source: ADUXVKJfWeKuJDehWqlKcBSOKT1cAifSIUXWQOJtDiOtmJ+lJrV58q2df1y8nczjTEARhIdVf62ne5+41ESf4FVVjPc=
X-Received: by 2002:a24:3105:: with SMTP id y5-v6mr13535919ity.138.1529422144395;
 Tue, 19 Jun 2018 08:29:04 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:bbc7:0:0:0:0:0 with HTTP; Tue, 19 Jun 2018 08:29:03
 -0700 (PDT)
In-Reply-To: <20180619152805.GN13984@arm.com>
References: <20180530044806.18449-1-yaojun8558363@gmail.com>
 <20180530091457.GB2452@arm.com> <CAKv+Gu8Zc7eQbG-Ww51GXUCEmhe2J03vbq5vVdyaKra-s13KrA@mail.gmail.com>
 <20180619152035.GM13984@arm.com> <CAKv+Gu-Mad64U63jjuKGjhg=h2wdoEKm2vywzATBYr-t_UY_bQ@mail.gmail.com>
 <20180619152805.GN13984@arm.com>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Tue, 19 Jun 2018 17:29:03 +0200
Message-ID: <CAKv+Gu81zgvcLd-N_MMENykxcm6ENvvfCuWOoMGsrfUf9Usy5g@mail.gmail.com>
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

On 19 June 2018 at 17:28, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jun 19, 2018 at 05:23:41PM +0200, Ard Biesheuvel wrote:
>> On 19 June 2018 at 17:20, Will Deacon <will.deacon@arm.com> wrote:
>> > Hi Ard,
>> >
>> > Sorry, I forgot to reply to this.
>> >
>> > On Wed, May 30, 2018 at 11:53:20AM +0200, Ard Biesheuvel wrote:
>> >> On 30 May 2018 at 11:14, Will Deacon <will.deacon@arm.com> wrote:
>> >> > On Wed, May 30, 2018 at 12:48:06PM +0800, YaoJun wrote:
>> >> >> To protect against KSMA(Kernel Space Mirroring Attack), make
>> >> >> tramp_pg_dir read-only. The principle of KSMA is to insert a
>> >> >> carefully constructed PGD entry into the translation table.
>> >> >> The type of this entry is block, which maps the kernel text
>> >> >> and its access permissions bits are 01. The user process can
>> >> >> then modify kernel text directly through this mapping. In this
>> >> >> way, an arbitrary write can be converted to multiple arbitrary
>> >> >> writes.
>> >> >>
>> >> >> Signed-off-by: YaoJun <yaojun8558363@gmail.com>
>> >> >> ---
>> >> >>  arch/arm64/mm/mmu.c | 4 ++++
>> >> >>  1 file changed, 4 insertions(+)
>> >> >>
>> >> >> diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
>> >> >> index 2dbb2c9f1ec1..ac4b22c7e435 100644
>> >> >> --- a/arch/arm64/mm/mmu.c
>> >> >> +++ b/arch/arm64/mm/mmu.c
>> >> >> @@ -551,6 +551,10 @@ static int __init map_entry_trampoline(void)
>> >> >>       __create_pgd_mapping(tramp_pg_dir, pa_start, TRAMP_VALIAS, PAGE_SIZE,
>> >> >>                            prot, pgd_pgtable_alloc, 0);
>> >> >>
>> >> >> +     update_mapping_prot(__pa_symbol(tramp_pg_dir),
>> >> >> +                             (unsigned long)tramp_pg_dir,
>> >> >> +                             PGD_SIZE, PAGE_KERNEL_RO);
>> >> >
>> >> > Hmm, I like the idea but is there a risk that the page table has been mapped
>> >> > as part of a block entry, which we can't safely split at this point (i.e.
>> >> > we'll run into one of the BUG_ONs in the mapping code)?
>> >> >
>> >>
>> >> We'd need to create a separate segment for it initially so the mapping
>> >> is already at the right granularity.
>> >
>> > Why do you think that's the case? I can't see anything that guarantees this
>> > for the page table itself.
>> >
>>
>> We'd need to pass NO_BLOCK_MAPPINGS to map_kernel_segment(),
>> obviously, but that shouldn't hurt since that segment is relatively
>> tiny anyway.
>
> Ah right, with NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS, I agree that we're good.
> Ideally, we'd move {idmap,swapper,tramp}_pg_dir into .rodata...
>

idmap and tramp yes, but swapper needs to be modifiable at runtime, no?
