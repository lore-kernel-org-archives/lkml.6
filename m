Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C99FDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8903520838
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ygruOEaP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfBKKRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:17:48 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:35235 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725996AbfBKKRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:17:48 -0500
Received: by mail-it1-f194.google.com with SMTP id r6so24903407itk.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v+zAzsEmqJj3+VDTJAot4xCXp4oD767RK6vsBj1pB18=;
        b=ygruOEaPUU98ICmGbb41SxnzpVCTjYBHUOInreLWU3titSvtO4GO5M8Bcds+MDBnSc
         jb2u8IB8ERrR6JHxKSA4SXyDvCyWHIR3FtRMaSOo+awaaMjXC1wvgRW9C7Wtynk4c8Vv
         Dbd50CsELKuMvYQzKYuGFrFCWHj70Ffy7GE1+kgGe+A3k2ICkwi25PLBVhG1uGitp8Fl
         KKr1epKiDVRRZrqNxSNBoTuFBEtv2HVWuXRCbuBGiLiRcbFWHwwyyHFLins16ch2fPHP
         KyMoKRR6dN8ZZmmXF/ZniT0isfrGV0ZUq9jmPMT9MXXCEEHSEVQjJsB2S9oNw7DtpZtS
         vs6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v+zAzsEmqJj3+VDTJAot4xCXp4oD767RK6vsBj1pB18=;
        b=YvCq/tTKJ8JLjEXKdWxLTto6b9o5JGnAeWBGB+Q/qRE4InLttuowxGEbI+uelm+BMT
         NS6kmWNQnb+4NFeGNHX8uKeaUaVWVLxksCLcHCPv2a79VB5W4R+wJ/7bDhZ0B+Mxvzto
         0PGVlaUgNU3oXUx2NImlzTjB2TpB2M/N74MsVae2n4i67VLMKbgyzgwEZf87FcsNUEb0
         WU6VHqmi4s1Ut1ZcYZZi7ZMaf6EMENTT7Hd2vc9gYdt+6VyyL4TicbGrRZlITLk3RvFk
         ScZM7xm+LJm4AmKPqfhgX4Uq9Dzb/xzDrr1YP8GA+jkY3OcivC7ypVH+KlWNuNnoRJre
         RpwQ==
X-Gm-Message-State: AHQUAubX0PS1cy0wZwQ0tCTqj0eRV8AGJ5NDJ7YJxtJ+IMP58e07k3NN
        cG2TBVo9wiwkdQsp3WcFQ4LKOmXOfEbqCVnsOJM4+om4
X-Google-Smtp-Source: AHgI3Ia5jUnaZA0tnmmgW+gJstv2LSW0QyjpP/EVKC/kjq5PeOVMLqmpHAHLLEY/Oj4Ufy20zLcx5lN+Ru8XnLATDZA=
X-Received: by 2002:a24:710:: with SMTP id f16mr4689471itf.121.1549880267003;
 Mon, 11 Feb 2019 02:17:47 -0800 (PST)
MIME-Version: 1.0
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net> <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net> <20190208215322.GO674@zn.tnic>
 <20190211002220.GD14948@zn.tnic> <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain> <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain>
In-Reply-To: <20190211101011.GA5333@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Feb 2019 10:17:36 +0000
Message-ID: <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in boot_params
To:     Chao Fan <fanc.fnst@cn.fujitsu.com>
Cc:     Borislav Petkov <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Lendacky, Thomas" <thomas.lendacky@amd.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        caoj.fnst@cn.fujitsu.com, Juergen Gross <jgross@suse.com>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-tip-commits@vger.kernel.org,
        Matt Fleming <matt@codeblueprint.co.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Feb 2019 at 11:10, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Mon, Feb 11, 2019 at 09:57:02AM +0000, Ard Biesheuvel wrote:
> >On Mon, 11 Feb 2019 at 10:56, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
> >>
> >> On Mon, Feb 11, 2019 at 09:46:03AM +0000, Ard Biesheuvel wrote:
> >> >On Mon, 11 Feb 2019 at 01:22, Borislav Petkov <bp@alien8.de> wrote:
> >> >>
> >> >> On Fri, Feb 08, 2019 at 10:53:22PM +0100, Borislav Petkov wrote:
> >> >> > On Fri, Feb 08, 2019 at 12:44:51PM -0800, Guenter Roeck wrote:
> >> >> > > Yes, the kernel boots if I comment out that function and have it return 0.
> >> >> >
> >> >> > Thanks, this localizes the issue significantly.
> >> >>
> >> >> Some observations:
> >> >>
> >> >>                 } else {
> >> >>                         efi_config_table_32_t *tmp_table;
> >> >>
> >> >>                         tmp_table = config_tables;
> >> >>                         guid = tmp_table->guid;                 <--- *
> >> >>                         table = tmp_table->table;
> >> >>                 }
> >> >>
> >> >> It blows up at that tmp_table->guid deref above. Singlestepping through
> >> >> it with gdb shows:
> >> >>
> >> >> # arch/x86/boot/compressed/acpi.c:114:                  guid = tmp_table->guid;
> >> >>         movq    (%rdi), %rax    # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
> >> >>         movq    8(%rdi), %rsi   # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
> >> >> # arch/x86/boot/compressed/acpi.c:115:                  table = tmp_table->table;
> >> >>         movl    16(%rdi), %r10d # MEM[(struct efi_config_table_32_t *)config_tables_37].table, table
> >> >>         jmp     .L30    #
> >> >>
> >> >> and %rdi has:
> >> >>
> >> >>         rdi            0x630646870
> >> >>
> >> >> which is an address above 4G but we're using a 32-bit EFI BIOS.
> >> >>
> >> >> Which begs the question whether EFI system tables can even be mapped at
> >> >> something above 4G with a 32-bit EFI and whether that could work ok.
> >> >> Hmm.
> >> >>
> >> >> Lemme add Ard and mfleming for insight here.
> >> >>
> >> >
> >> >-ENOCONTEXT, but let me try in any case:
> >> >
> >> >linux/efi.h has
> >> >
> >> >typedef struct {
> >> >  efi_guid_t guid;
> >> >  u32 table;
> >> >} efi_config_table_32_t;
> >> >
> >> >so if we end up with more than 32 bits set in table, there is
> >> >something seriously wrong.
> >> >
> >> >The size of efi_config_table_32_t deviates from efi_config_table_64_t,
> >> >so you will have to ensure that you are using the correct stride when
> >> >iterating over config_tables.
> >>
> >> Here I use signature to judge it.
> >> If the signature is EFI64_LOADER_SIGNATURE, I will use efi_config_table_64_t,
> >> if the signature is EFI32_LOADER_SIGNATURE, I will use efi_config_table_32_t.
> >> But the efi32 whose signature is EFI32_LOADER_SIGNATURE points to a
> >> address above 4G, I am not sure whether this is normal and works well.
> >>
> >
> >This is impossible. The 'table' member of efi_config_table_32_t is
> >only 32 bits wide, so how can it contain an address over 4 GB ?
>
> Maybe I mislead you. In my code, I need to find the eficonfig_table_*.
> After that, I should type cast it to right
> efi_config_table_32_t or efi_config_table_64_t.
>
> Then my judgment is to compare its efi_info->efi_loader_signature.
> If it's EFI64_LOADER_SIGNATURE, I will type cast it to efi_config_table_64_t.
> If it's EFI32_LOADER_SIGNATURE, I will type cast it to efi_config_table_32_t.
>
> But here is a issue, its signature matches EFI32_LOADER_SIGNATURE, but
> it's table member is above 4G, but I use efi_config_table_32_t. That cause a problem.
>

That still does not explain how 'table' can assume a value > 4 GB
after assigning the contents of a u32 to it.
