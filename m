Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703E5C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:33:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41EA021479
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:33:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PciZTvJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbfBKKdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:33:21 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:33844 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbfBKKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:33:14 -0500
Received: by mail-it1-f195.google.com with SMTP id x124so15610876itd.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FqRZfhaoqcUBFvy069ZQpzyiOo+xQdAJ5Kymuh1jnjE=;
        b=PciZTvJ2JXRXESzE6R6q51B3/TX3OitJK0uIIFVFcQw24tgulDTnpsHpvnZpKvK/4j
         jwCKOfuwiUTdPBpAgusJw1ydnwHUlxaQE5LiPUX0fz80tOWTWtq1hLa81xPrXRNRXnyv
         89Feu7iY1ErE+EmZVXZ5MRAVXxyiPlkr6UuAQE2kr1j8xC8SDUm90pyehOBOZlZFkJbd
         ZE16afQzaOLXYtHJu2nYFZqt0BUEwUyIlxyIxYoaFNNRe5UQjzuo2sEN1mciCOoOUqD9
         CoZF80rYE7nWNqwivgrGwaqZgWXncfX41qG9MitxbTUqSs4v/UVrUr4/KqHhmzsMU1pM
         L5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FqRZfhaoqcUBFvy069ZQpzyiOo+xQdAJ5Kymuh1jnjE=;
        b=OfFFTGl1Qp6FxnHLe8t69lYXNigyO9FqLqYTDX8nz/cwa23zzXW7+rTf9TwhNhwupw
         NAlWmAh7XvhH3O58bc9I8ev/Tp3qnr2miBhaf0gCrhoRMrgtvm4GYHoFI5vlG6/Xpe+1
         8zinbTBqtFBiZWRWcyntyMWRZee1px6rj0DtoQxVAdlvPiKOWNXyzWSxVei2Cv+SkPQ9
         4u1pCuFuhZZCSM3x5BDp9W/akH9RwkNLwfD1furQj727J36aIAA0sKNiy0K/CMvK2CPA
         A04vOc/K83U07u71LUZ4dLp+ij5kMUwF+ZnjGw3u3bRWBITvqvsFzwoPWKildLBiLkgk
         FjMA==
X-Gm-Message-State: AHQUAuYGui7Y2juZG4oue6lXNjl2ZKHUQQanJYMpJCVYqUUrtm46vbCu
        5x8CqPZrl1/8ij99QMTkvjJ+MPY31e4TfPHzIokdKA==
X-Google-Smtp-Source: AHgI3IZC1oDGvm1LHfCecfnEPJWK2JhJfqqL7rZ8WdHaXszBeTSEFuKWZsO3N9lM8GRnln9PSrh+bYsZYWZilgJdx9k=
X-Received: by 2002:a5e:9704:: with SMTP id w4mr12806884ioj.60.1549881193865;
 Mon, 11 Feb 2019 02:33:13 -0800 (PST)
MIME-Version: 1.0
References: <20190208190248.GA10854@roeck-us.net> <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net> <20190208215322.GO674@zn.tnic>
 <20190211002220.GD14948@zn.tnic> <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain> <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain> <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic>
In-Reply-To: <20190211102426.GA19618@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Feb 2019 10:33:02 +0000
Message-ID: <CAKv+Gu-Fk+_uDvRz7nbceaHAWS_mevm0BuDQd1sSYAQpiPgmNw@mail.gmail.com>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in boot_params
To:     Borislav Petkov <bp@alien8.de>
Cc:     Chao Fan <fanc.fnst@cn.fujitsu.com>,
        Guenter Roeck <linux@roeck-us.net>,
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

On Mon, 11 Feb 2019 at 11:24, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 11, 2019 at 10:17:36AM +0000, Ard Biesheuvel wrote:
> > That still does not explain how 'table' can assume a value > 4 GB
> > after assigning the contents of a u32 to it.
>
> See efi_get_rsdp_addr() in tip/master and especially that systable address
> computation:
>
> #ifdef CONFIG_X86_64
>         systab = (efi_system_table_t *)(ei->efi_systab | ((__u64)ei->efi_systab_hi<<32));
> #else
>         if (ei->efi_systab_hi || ei->efi_memmap_hi) {
>                 debug_putstr("Error getting RSDP address: EFI system table located above 4GB.\n");
>                 return 0;
>         }
>         systab = (efi_system_table_t *)ei->efi_systab;
> #endif
>
>         ...
>
>         config_tables = (void *)(systab->tables + size * i);
>
> It is hard to debug that early but I managed to singlestep it last night
> to this deref:
>
>               } else {
>                         efi_config_table_32_t *tmp_table;
>
>                         tmp_table = config_tables;
>                         guid = tmp_table->guid;
>                                 ^^^^^^^^^^^^^^
>
>                         table = tmp_table->table;
>
> which in asm is:
>
> # arch/x86/boot/compressed/acpi.c:114:                  guid = tmp_table->guid;
> #NO_APP
>         movq    (%rdi), %rax    # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
>         movq    8(%rdi), %rsi   # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
> # arch/x86/boot/compressed/acpi.c:115:                  table = tmp_table->table;
>         movl    16(%rdi), %r10d # MEM[(struct efi_config_table_32_t *)config_tables_37].table, table
>
> and %rdi has 0x630646870 so either we got the wrong address or qemu
> mapped it above 4G...
>
> It is only an observation for now though...
>

I think the problem is that efi_system_table_t is native, so if you
want to access a 32-bit EFI system table from a 64-bit build, you will
need to use efi_system_table_32_t explicitly.
