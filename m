Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4A58C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:57:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6372320863
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:57:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GtjEJO2O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbfBKJ5O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:57:14 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:51132 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfBKJ5O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:57:14 -0500
Received: by mail-it1-f195.google.com with SMTP id z7so24875123iti.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 01:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yn3LX26QvHVsiLYSnhIRA+BhZv857IBuSZZW4F03zJU=;
        b=GtjEJO2O0FTnAHiFl9DDpfqSrUHd+2r0K/PGNbayWdUKxnK10FTK/8BJzYAxImT7W8
         StelEswMsuhfTxq+fET1UQ4/8xdUMkZn7LtCD8NjaSS9Ayr90wEJekWJL1G10h5PESBl
         kZqlL3bO6oK6lGXTkFktsGzzO2yWgQ+S33RFWXefppSi15Za3pXupuBy1yHa3fnxwqHQ
         e4ewaeSGZ1HKGmW1xce85MZHfkapZhciQF4Qbryov69OOcg5icJdOrvKzWHbKFCHckm6
         u1OixF/Y7UGYXOzwnZejZWFLgCLeRSXcj6omrg45oOf+5vrh+qzCxvtf51r3whvIYcUk
         e1rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn3LX26QvHVsiLYSnhIRA+BhZv857IBuSZZW4F03zJU=;
        b=K1UsPSNxb/RQzKa/yhqL67uPDqfAhZUjluax47nDzRx2rv3TKpfH1EDE/jurIIOcwU
         2j0vzYsRkUt7EgZcwuh0COjdfo3pR09DI9x/oMS4gHI12S5iX/5Wi2dSrQCnVJAf8G09
         m7Hfi+ef59tiMuIFAXAyiR6bvx9YmoD8w87uoNhXAr0/0C0uKoPlOxe2kjLg/V2EcN1l
         UfhcXKCRl2upUM2qELBQM1o/tMnOIw0SEC++VWrmvBU4COTbPrnxEgs+GfzKKGNkZEpZ
         2DcBb9n4dBkWe+kKeS635RpLl8xSwq1RMJWzaw/l++ZKKCgks8SKRvMO/XZSMAAGxDLl
         +9jg==
X-Gm-Message-State: AHQUAuZp8lX1hMVV8EMv+CQHS50u8hQ4QXi28dDF3ouuAvrvpmfjTcMn
        8i/6arghZeyoD0Jrskh9Mo4LBpLR883GbmUCCzTg2g==
X-Google-Smtp-Source: AHgI3IaKRM4tKpi2/dQ8NMKdFDJyT9xJFvaJHkE3gKOzigQ9/Hidge8HkiP/wrGMUqs0JspsMkMoDxrvKfIH28RgY/o=
X-Received: by 2002:a02:15da:: with SMTP id 87mr348340jaq.2.1549879033350;
 Mon, 11 Feb 2019 01:57:13 -0800 (PST)
MIME-Version: 1.0
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net> <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net> <20190208215322.GO674@zn.tnic>
 <20190211002220.GD14948@zn.tnic> <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain>
In-Reply-To: <20190211095547.GB1651@localhost.localdomain>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Feb 2019 09:57:02 +0000
Message-ID: <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
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

On Mon, 11 Feb 2019 at 10:56, Chao Fan <fanc.fnst@cn.fujitsu.com> wrote:
>
> On Mon, Feb 11, 2019 at 09:46:03AM +0000, Ard Biesheuvel wrote:
> >On Mon, 11 Feb 2019 at 01:22, Borislav Petkov <bp@alien8.de> wrote:
> >>
> >> On Fri, Feb 08, 2019 at 10:53:22PM +0100, Borislav Petkov wrote:
> >> > On Fri, Feb 08, 2019 at 12:44:51PM -0800, Guenter Roeck wrote:
> >> > > Yes, the kernel boots if I comment out that function and have it return 0.
> >> >
> >> > Thanks, this localizes the issue significantly.
> >>
> >> Some observations:
> >>
> >>                 } else {
> >>                         efi_config_table_32_t *tmp_table;
> >>
> >>                         tmp_table = config_tables;
> >>                         guid = tmp_table->guid;                 <--- *
> >>                         table = tmp_table->table;
> >>                 }
> >>
> >> It blows up at that tmp_table->guid deref above. Singlestepping through
> >> it with gdb shows:
> >>
> >> # arch/x86/boot/compressed/acpi.c:114:                  guid = tmp_table->guid;
> >>         movq    (%rdi), %rax    # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
> >>         movq    8(%rdi), %rsi   # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
> >> # arch/x86/boot/compressed/acpi.c:115:                  table = tmp_table->table;
> >>         movl    16(%rdi), %r10d # MEM[(struct efi_config_table_32_t *)config_tables_37].table, table
> >>         jmp     .L30    #
> >>
> >> and %rdi has:
> >>
> >>         rdi            0x630646870
> >>
> >> which is an address above 4G but we're using a 32-bit EFI BIOS.
> >>
> >> Which begs the question whether EFI system tables can even be mapped at
> >> something above 4G with a 32-bit EFI and whether that could work ok.
> >> Hmm.
> >>
> >> Lemme add Ard and mfleming for insight here.
> >>
> >
> >-ENOCONTEXT, but let me try in any case:
> >
> >linux/efi.h has
> >
> >typedef struct {
> >  efi_guid_t guid;
> >  u32 table;
> >} efi_config_table_32_t;
> >
> >so if we end up with more than 32 bits set in table, there is
> >something seriously wrong.
> >
> >The size of efi_config_table_32_t deviates from efi_config_table_64_t,
> >so you will have to ensure that you are using the correct stride when
> >iterating over config_tables.
>
> Here I use signature to judge it.
> If the signature is EFI64_LOADER_SIGNATURE, I will use efi_config_table_64_t,
> if the signature is EFI32_LOADER_SIGNATURE, I will use efi_config_table_32_t.
> But the efi32 whose signature is EFI32_LOADER_SIGNATURE points to a
> address above 4G, I am not sure whether this is normal and works well.
>

This is impossible. The 'table' member of efi_config_table_32_t is
only 32 bits wide, so how can it contain an address over 4 GB ?
