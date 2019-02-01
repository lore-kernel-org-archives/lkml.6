Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0539BC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:21:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AD920863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 20:21:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s3ZBIVAA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731261AbfBAUVb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 15:21:31 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52455 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbfBAUVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 15:21:31 -0500
Received: by mail-it1-f195.google.com with SMTP id d11so11238491itf.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Feb 2019 12:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NtpgDq2Gw8aN0PaOjgpjgTZu/UHnpQMFSYsy8Ia28Bw=;
        b=s3ZBIVAAHyq3QJqxqSHc97aPvm1Owqm3SASatBZ7G7gR3r/93luNbWfRG80lfHLzii
         T+Ybs7Ua5lQTD/O91xLUaDbpaqH4bqHX57cT1aTDdvV1RzTsuIv9WGGLNORTCD7uLIWe
         0i9E2xJXmvSL7aFtmbfid5RhEOcTH/s+WVwuMqSHn2Dk4XmYHnwrSN/7YBLyF1RY4K2m
         OUgQTDWcFS9JrqMiwDu6Bnypn0m0JdilMvJCziBHLLzyB3VjIChyKtGU1dWg9bsce8Fd
         68uaYsDrSp6m8EezD93J8r7EJAdrWy3jhR/Qp+NEYKbnwV+YhfAQK2hEyrdxvdEkw4BJ
         BVFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NtpgDq2Gw8aN0PaOjgpjgTZu/UHnpQMFSYsy8Ia28Bw=;
        b=dg/V1xX4RHgMn8COCWdzFH1x2LujDX3SRTqdzaSMEpto7q8HeYs9BrfIVbTb8hHgFY
         MEUUJUHIeFiiZ3ZWh3v5Km2rIo/pK+5qHwEUARhKX+4r09oHJsADMK6LqUoy/Ofwv8gr
         hPbYu6Ux5BPBaQhLH1BJ/pU7Sgmr6NzOHQwy4BbzWK4yROBXWpqU0B26vYehxEhp559s
         DTXv6Myhmmphuqvor+16PUKjaq66sJJ//ujjRwsuWNY1tixlhMA7iezMuZmtiUTndhRC
         f7ht480EMvsBjk/0p58z2HRKjVZa7PsmOPpkoE/nwpsQJx59L91+FiOUDrBU2c0Ez1y0
         pwcg==
X-Gm-Message-State: AHQUAua625JzmJcWu2/UgCM2Fs/SXsSaAzI03wetnVtQWhZK78gvVpRK
        NtfGoLWn8PBZlgFaIWN2mMtsmbaoTtkizaX5XvSplg==
X-Google-Smtp-Source: AHgI3Iar7blftkyCyXfBmYEj6wVKJagv3ucak/q/skTUptCAqfx+QDLJkiwNMZHkfpVVTRIzrda8VZHQQIKm4DYjVlY=
X-Received: by 2002:a24:4a95:: with SMTP id k143mr2490160itb.77.1549052490154;
 Fri, 01 Feb 2019 12:21:30 -0800 (PST)
MIME-Version: 1.0
References: <20171205010616.5958-1-brijesh.singh@amd.com> <20171205010616.5958-9-brijesh.singh@amd.com>
In-Reply-To: <20171205010616.5958-9-brijesh.singh@amd.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 1 Feb 2019 12:21:18 -0800
Message-ID: <CALMp9eTpMm4qpNCUj00qk8CA7BmW-uq4YRwHzKa_GAwON2kgyQ@mail.gmail.com>
Subject: Re: [Part2 PATCH v9 38/38] KVM: X86: Restart the guest when insn_len
 is zero and SEV is enabled
To:     Brijesh Singh <brijesh.singh@amd.com>
Cc:     kvm list <kvm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 4, 2017 at 5:07 PM Brijesh Singh <brijesh.singh@amd.com> wrote:
>
> On AMD platforms, under certain conditions insn_len may be zero on #NPF.
> This can happen if a guest gets a page-fault on data access but the HW
> table walker is not able to read the instruction page (e.g instruction
> page is not present in memory).
>
> Typically, when insn_len is zero, x86_emulate_instruction() walks the
> guest page table and fetches the instruction bytes from guest memory.
> When SEV is enabled, the guest memory is encrypted with guest-specific
> key hence hypervisor will not able to fetch the instruction bytes.
> In those cases we simply restart the guest.
>
> I have encountered this issue when running kernbench inside the guest.
>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: "Radim Kr=C4=8Dm=C3=A1=C5=99" <rkrcmar@redhat.com>
> Cc: Joerg Roedel <joro@8bytes.org>
> Cc: Borislav Petkov <bp@suse.de>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
> ---
>  arch/x86/kvm/mmu.c | 10 ++++++++++
>  arch/x86/kvm/svm.c |  6 ++++--
>  2 files changed, 14 insertions(+), 2 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index e5e66e5c6640..d5e5dbd0e5ad 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -4950,6 +4950,16 @@ int kvm_mmu_page_fault(struct kvm_vcpu *vcpu, gva_=
t cr2, u64 error_code,
>         if (mmio_info_in_cache(vcpu, cr2, direct))
>                 emulation_type =3D 0;
>  emulate:
> +       /*
> +        * On AMD platforms, under certain conditions insn_len may be zer=
o on #NPF.
> +        * This can happen if a guest gets a page-fault on data access bu=
t the HW
> +        * table walker is not able to read the instruction page (e.g ins=
truction
> +        * page is not present in memory). In those cases we simply resta=
rt the
> +        * guest.
> +        */
> +       if (unlikely(insn && !insn_len))
> +               return 1;
> +

How does this work, for instance, with MMIO at CPL3 with SMAP enabled?
