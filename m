Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AC78C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 493C320863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 10:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LuPgxwqI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfBKKqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 05:46:30 -0500
Received: from mail-it1-f176.google.com ([209.85.166.176]:56245 "EHLO
        mail-it1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbfBKKqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 05:46:30 -0500
Received: by mail-it1-f176.google.com with SMTP id f18so14096302itb.5
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 02:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/0SCk7wts1poY0owXc+0Q+x4dSOuXa2jqfsnZFbObJ4=;
        b=LuPgxwqI2IPxvhjGWRNzCjvam+FLu3Gjkgo6kop8HPd9oyJ3dfqp4UefYJ2vYlR7CF
         K3Vu1r1e11eZCNcF7a5W4RWEBWnstHB1OogWcm8mfqGUkcSLqaKCyg7AGt/U+Md18JfQ
         gMdhYTMVcjPruH3Eq/PHmCtuHkD0y+fNa5TUOL9p4pF8GHdB0oykahLY9koWo0S08+Zk
         GbT81cZcf1dK0rhNs0WYywPftDPIMBEJw2sXWxtVLbvpLs/iJvBpoiS0mPOBXrNxau58
         p9wHLpYzyQk75P6wSUfAUBM3o1OZBRui1huuuRUcUwkkrY9FqjgXdSP6aVRrrCU62RQB
         LiZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/0SCk7wts1poY0owXc+0Q+x4dSOuXa2jqfsnZFbObJ4=;
        b=iQsyYJ60bT/qSHFaogvD4rOVQb5p4rR4oJMsd+eNypTzGtyEL6nJCE/JQRkvUYigzS
         1BCtEXkdvv4KO+viisvyx7cb1bxlk1Oc3Fn9zDfwzoInTwlTe4OGNla9I/ulc68BjSbd
         3drcE79jRyZMkSLJiq+kqcpS+vW5zDvrhd31KBK82yx+S0jbvDndU90meYpryRKRrFUk
         vjcGj/4mrKyX7vo3SKYNOVcSXQF40BqAj3HtJqvhopbezjg3+nm7smTC8GgeNhHsV1ex
         iCjKWHlyt3eIViDfSychJI+XEM9eXwWAjIq0e+oI3AWhyrIosjYce79DK092rPT9HVbY
         42rg==
X-Gm-Message-State: AHQUAuZ1pYr5TKjlZEGPKxBnqHlQF7XoQaM0W9chKwGqgJRnawWMAHKM
        PCCBUdaHSed7+2/lwBktqXOvSL3gLAOVQvAgkHBmaw==
X-Google-Smtp-Source: AHgI3IYVqfT0cMYyNysVp//9YVxL9IS6oRo6Bhp/QHrgZo25UDKAR3pwRmw2LR99g9Wkb/FyCyUicuT//deQLHOi7+c=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr3920149itk.71.1549881988975;
 Mon, 11 Feb 2019 02:46:28 -0800 (PST)
MIME-Version: 1.0
References: <20190208191024.GL674@zn.tnic> <20190208204451.GA14024@roeck-us.net>
 <20190208215322.GO674@zn.tnic> <20190211002220.GD14948@zn.tnic>
 <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain> <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain> <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic> <20190211104254.GB19618@zn.tnic>
In-Reply-To: <20190211104254.GB19618@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Feb 2019 10:46:18 +0000
Message-ID: <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com>
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

On Mon, 11 Feb 2019 at 11:43, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 11, 2019 at 11:24:26AM +0100, Borislav Petkov wrote:
> > It is only an observation for now though...
>
> Ok, now I did this:
>
>         for (i = 0; i < systab->nr_tables; i++) {
>                 acpi_physical_address table;
>                 void *config_tables;
>                 efi_guid_t guid;
>
>                 if ((unsigned long)systab->tables >> 32)                        <---
>                         asm volatile("1:\n jmp 1b");
>
>                 config_tables = (void *)(systab->tables + size * i);
>
> It did stop at the endless loop there which would mean that
> systab->tables is simply pointing somewhere into the weeds.
>


As I pointed out in my previous reply, systab will be the wrong type
on 32-bit firmware, it needs to be efi_system_table_32_t


> Asm is:
>
> ---
> # arch/x86/boot/compressed/acpi.c:96:                   asm volatile("1:\n jmp 1b");
> #APP
> # 96 "arch/x86/boot/compressed/acpi.c" 1
>         1:
>  jmp 1b
> # 0 "" 2
> #NO_APP
>         movq    112(%rcx), %rdi # systab_147->tables, _31
> .L29:
> # arch/x86/boot/compressed/acpi.c:98:           config_tables = (void *)(systab->tables + size * i);
>         addq    %r9, %rdi       # ivtmp.64, config_tables
> # arch/x86/boot/compressed/acpi.c:104:                  guid = tmp_table->guid;
> ---
>
> and RDI is
>
> rdi            0x630646870
>
> in gdb.
>
> systab itself gets computed to something low: 0x3fedb010.
>
> Hmmm. Could it be that that EDK BIOS image is buggy?
>
> [    0.000000] efi: EFI v2.70 by EDK II
> [    0.000000] efi:  SMBIOS=0x3feb9000  ACPI=0x3fee7000  ACPI 2.0=0x3fee7014  MEMATTR=0x3f524110
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
