Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747C1C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:46:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B5512082F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 09:46:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A0S1zxDe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfBKJqP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 04:46:15 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:52421 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725931AbfBKJqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 04:46:15 -0500
Received: by mail-it1-f193.google.com with SMTP id r11so19358182itc.2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 01:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=36OPkUpmsbWAqjJhzyZx3TwxO5WFHVfVvNhFTz8SN60=;
        b=A0S1zxDe8eZ97pTzyNCJ34LnRURzuUFIF2R0qTMgyXsmJhPz+9OX8SnBJrZFV+WoSx
         bRToLSK3Wn3HwWNsptnFzoDklVUZFlhKcadCYk4A15SgXbOPG91IwMQhbdxLqwZp5vGN
         zZHhA+GiYD7/zTt9w+ivAAew7F9sNMQVocQ9FOlrmL/ob9xefdmaRBhCxC0+btc7vGP6
         M8oPbIBKzPoGX0WGqh/llfeyYOjeVa5+8TRrie8ufX5en1Hja2XvSYpKkDNVGypW89dS
         d186NjIrqsWDPDwHGXBz8fV+uK8Qi/fkgRepjKOiy/YXfXFhubttUjmC6q3UskAXEskH
         jA5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=36OPkUpmsbWAqjJhzyZx3TwxO5WFHVfVvNhFTz8SN60=;
        b=WfyV9GIW92WJTS1FGoW1IIuq2Pkf+KTX8+jOj3QlGg3T5IsT9eVNNRQklgDW+POmpR
         +9On2VZzcDhsvgnBTPcW9E5B97qtDKG6sONjE/3a/EfG27hoEBKmVUV+8Senwf11KcOK
         PGwm44K5g1Hv5nuMz4pdtvcWWvUkx/XxMUccNl4tequSmLCkZOM67o6hHQ25PTSnNINZ
         heN1BQY/HZg75adeD+6iP82PF2brI7LyjPUVdNHFgYzhhGX5qrcW287dQrRt586iUhH7
         ekR1vel65ag1YP/40tx8iOd3fcwE2spuE1dVB7gD4+b/ZL0xUQ95neGEI7h5/6gXUJhF
         jM6A==
X-Gm-Message-State: AHQUAub+RNDKJ/zPoz0TzOdBkBVihFWzw2Yk2vjbQ1SARwY3V/GACXUU
        H+R3Ej7/M0fRvWk+Db4uDf218W2BDS+kQvxMPyNGZA==
X-Google-Smtp-Source: AHgI3IZ34JMecsb52s5kAV8n4baV0Q1hqRbuYAsxvGJYXnmOD1bGNBLJAwmkg0zeSlK3MIYfl4xzYf+uGI9adaUby7k=
X-Received: by 2002:a5d:8410:: with SMTP id i16mr18605125ion.173.1549878374134;
 Mon, 11 Feb 2019 01:46:14 -0800 (PST)
MIME-Version: 1.0
References: <20190123110850.12433-6-fanc.fnst@cn.fujitsu.com>
 <tip-3a63f70bf4c3a17f5d9c9bf3bc3288a23bdfefce@git.kernel.org>
 <20190208190248.GA10854@roeck-us.net> <20190208191024.GL674@zn.tnic>
 <20190208204451.GA14024@roeck-us.net> <20190208215322.GO674@zn.tnic> <20190211002220.GD14948@zn.tnic>
In-Reply-To: <20190211002220.GD14948@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Feb 2019 09:46:03 +0000
Message-ID: <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
Subject: Re: [tip:x86/boot] x86/boot: Early parse RSDP and save it in boot_params
To:     Borislav Petkov <bp@alien8.de>
Cc:     Guenter Roeck <linux@roeck-us.net>, fanc.fnst@cn.fujitsu.com,
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

On Mon, 11 Feb 2019 at 01:22, Borislav Petkov <bp@alien8.de> wrote:
>
> On Fri, Feb 08, 2019 at 10:53:22PM +0100, Borislav Petkov wrote:
> > On Fri, Feb 08, 2019 at 12:44:51PM -0800, Guenter Roeck wrote:
> > > Yes, the kernel boots if I comment out that function and have it return 0.
> >
> > Thanks, this localizes the issue significantly.
>
> Some observations:
>
>                 } else {
>                         efi_config_table_32_t *tmp_table;
>
>                         tmp_table = config_tables;
>                         guid = tmp_table->guid;                 <--- *
>                         table = tmp_table->table;
>                 }
>
> It blows up at that tmp_table->guid deref above. Singlestepping through
> it with gdb shows:
>
> # arch/x86/boot/compressed/acpi.c:114:                  guid = tmp_table->guid;
>         movq    (%rdi), %rax    # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
>         movq    8(%rdi), %rsi   # MEM[(struct efi_config_table_32_t *)config_tables_37].guid, guid
> # arch/x86/boot/compressed/acpi.c:115:                  table = tmp_table->table;
>         movl    16(%rdi), %r10d # MEM[(struct efi_config_table_32_t *)config_tables_37].table, table
>         jmp     .L30    #
>
> and %rdi has:
>
>         rdi            0x630646870
>
> which is an address above 4G but we're using a 32-bit EFI BIOS.
>
> Which begs the question whether EFI system tables can even be mapped at
> something above 4G with a 32-bit EFI and whether that could work ok.
> Hmm.
>
> Lemme add Ard and mfleming for insight here.
>

-ENOCONTEXT, but let me try in any case:

linux/efi.h has

typedef struct {
  efi_guid_t guid;
  u32 table;
} efi_config_table_32_t;

so if we end up with more than 32 bits set in table, there is
something seriously wrong.

The size of efi_config_table_32_t deviates from efi_config_table_64_t,
so you will have to ensure that you are using the correct stride when
iterating over config_tables.
