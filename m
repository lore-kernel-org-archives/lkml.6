Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21FBDC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:55:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2D65218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 11:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbJ2Il1c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbfBKLzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 06:55:40 -0500
Received: from mail-it1-f182.google.com ([209.85.166.182]:35841 "EHLO
        mail-it1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfBKLzj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 06:55:39 -0500
Received: by mail-it1-f182.google.com with SMTP id c9so25527410itj.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 03:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5fXpCtQVEEGgRNSx87qyG6YwuXEUUVzlABYacTuwnHo=;
        b=zbJ2Il1cu9JLL7LS63SdGhwbGh4dg9o8FqhLUE2seCIYXAgctLl0redFXFyb4aduOQ
         W6ZpYJjNXmJ+W3q7Fg892OINcf6nqAyPSbpZq1s5gL3OEgjCqjj5DYRaGuUKFz5OlpND
         3r8ShgihvHLadDXnBqNO5neM+AqWc7g6dxr9oz7Gx1FsycowyLEAPK5MR39ihIPkiPSy
         0BIGKn2RMu9tALjETezXjqO2Ci6G7LIBc0w28gNKqZjHZ5qW1VgmvX2C9ZXrL+zuqeGP
         f0azSFnr9C3XJz06D/r6xwgUh5tQcXzVVAuH3Odx/MOB/24aMZF4/a9h4kV6XR8yI4M3
         m3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5fXpCtQVEEGgRNSx87qyG6YwuXEUUVzlABYacTuwnHo=;
        b=X1IQKesJH/A6kkWxlPX/Ql1PwAsdczckHxmUvgfubI/TyWNa8X0wWLhmBXERGZxfLv
         dvtsZidtzRcJZr16jZ11ndhK5J6l3lYECnjbCQAkJzG+pPwSVKttxzQK40+vCuHoZMNQ
         4IG0xdc292Oxqn+JA/wLvdckcWxDVGso4uOm4fZLfjaTWHkx2zn6aszXLvBQobiCdMTa
         /BxvDVIFxOlc8CzrrMufzG72/fDPKNP1KuDtkMSxQ3RDFI1K3wLOQfOeWb4Cps/NV2eQ
         nItcoCj9sI2BkPdbGbPi76s/vSPP8BoIXo1P3lRDMDZWd8k8NhD1unTzqeTj7yOyQIXP
         VyFA==
X-Gm-Message-State: AHQUAuaI2EAuOktrOqILIDHJ6G5e8Ak5f7+AGsgENztlWzkTs5Xbwf/D
        bmJDuIwFGexhgJZDVLf/rD2VEs3IwIVnLB7X54D42g==
X-Google-Smtp-Source: AHgI3IZqGyv7F2Pnft4sFafWeWABibxMSKkRmX07iyEQji4i4rxHrw0h88HB/llxRK5lt8BTWrUkU3/edw1nJ9E9Ruk=
X-Received: by 2002:a05:660c:4b:: with SMTP id p11mr4059211itk.71.1549886138400;
 Mon, 11 Feb 2019 03:55:38 -0800 (PST)
MIME-Version: 1.0
References: <20190208215322.GO674@zn.tnic> <20190211002220.GD14948@zn.tnic>
 <CAKv+Gu-6bxRrn7Ft4cRYzB1Jgca=L_d1u5OU1nUzLe7SBEd=xQ@mail.gmail.com>
 <20190211095547.GB1651@localhost.localdomain> <CAKv+Gu_r4Vz2BRpRyJ=UsM1r-+CbyP6heggL+qsKKhJ_iTWhFg@mail.gmail.com>
 <20190211101011.GA5333@localhost.localdomain> <CAKv+Gu-Tv=Wxhp9k_f4q+AZ+Wqc+joXrnpbz7aKD=75ZKp2Xcw@mail.gmail.com>
 <20190211102426.GA19618@zn.tnic> <20190211104254.GB19618@zn.tnic>
 <CAKv+Gu9mm-w66ZZrd7WhuD3_iELS5vUJ0-1DtRq1GDjSsDNEVg@mail.gmail.com> <20190211110451.GD19618@zn.tnic>
In-Reply-To: <20190211110451.GD19618@zn.tnic>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Mon, 11 Feb 2019 11:55:27 +0000
Message-ID: <CAKv+Gu-xbw2Rn41brkeFuv2kLxwXknHpB+vG5SVXE8GZdyyj7A@mail.gmail.com>
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

On Mon, 11 Feb 2019 at 12:04, Borislav Petkov <bp@alien8.de> wrote:
>
> On Mon, Feb 11, 2019 at 10:46:18AM +0000, Ard Biesheuvel wrote:
> > As I pointed out in my previous reply, systab will be the wrong type
> > on 32-bit firmware, it needs to be efi_system_table_32_t
>
> Yeah, that seems to work. It boots now and it says:
>
> [    0.000000] efi: No EFI runtime due to 32/64-bit mismatch with kernel
>
> Do you think we should mirror that behavoir early too, so that people
> don't get any ideas?
>

It you have CONFIG_EFI_MIXED enabled, you can in fact use 32-bit UEFI
runtime services from 64-bit Linux, so just using the tables should be
fine as well, and I don't think we should hide that behind a Kconfig
option. (Note that ACPI defines its table layouts without regard for
architecture bitness, so this is just about the minimal EFI table
parsing that is required to get at the RDSP)


> Or should we limit that only to the RDSP address computation and
> anything else where kernel and EFI bitness mismatch should be disabled?
>
> Thanks Ard!
>
> --
> Regards/Gruss,
>     Boris.
>
> Good mailing practices for 400: avoid top-posting and trim the reply.
