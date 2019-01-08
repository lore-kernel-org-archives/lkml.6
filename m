Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4680C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1D32087F
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 09:01:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728004AbfAHJBg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 04:01:36 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:45220 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbfAHJBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 04:01:36 -0500
Received: by mail-ua1-f68.google.com with SMTP id e16so1019079uam.12
        for <linux-kernel@vger.kernel.org>; Tue, 08 Jan 2019 01:01:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0KYvlQz43o7q+5VwFGaqQDak4wIv2QCxeRi5jX8GAZE=;
        b=hS4pQBOU735gj0hKsBYsTmoSwbPF0Lfkp8G9WvZm2iIttjQ/kAtGA6gn1K0WKGCWMU
         yHaAdDzLFk5CqDr7+HsGf3T0VcqRi0RyVcNfLlnwRoYzPQvgXldwv9qZOzo233gw+ZBr
         MHBOnGmuhHutquKag+dMF66bylKGTilG0HGpYJXN9Gf0jGSDH2RgfJBz0BStRs2t46T5
         +lnLJvUaLdGkgfL5Yz3aVlLYbX90nqu8QxM5fY+q2if4A5i3uNz7iA/FeNE8e1EIj4jo
         MLFBh1lSpJzyDA3FQQTjfye/MnbkmFI8Bmf/pJt8RpCXC0TOhirGjukf6CdzICy3TVO6
         90/A==
X-Gm-Message-State: AJcUukffIgjaJ7EPhD0k/Kxgctkzb/RUcZYoWr1g8fHlyuMGQQ5F4SZw
        g8FgsSwDSXB2vP/5mTRvXbUhQ/GgihCYhgVov7kjoKewj60=
X-Google-Smtp-Source: ALg8bN5i9MgIYKguZUuidXv1cwrcrXQZ4b4k7gpCsAvs7urJB982cf4kOmnIIFj056LsK3NpKpeEVdajMV6tNK9pUDM=
X-Received: by 2002:a9f:364a:: with SMTP id s10mr285998uad.78.1546938094136;
 Tue, 08 Jan 2019 01:01:34 -0800 (PST)
MIME-Version: 1.0
References: <20190108084857.26756-1-geert@linux-m68k.org>
In-Reply-To: <20190108084857.26756-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Jan 2019 10:01:22 +0100
Message-ID: <CAMuHMdUw9LMVb-8RSNVBEcDMVB9SFOdfF+kb20=gxJiWF1x8sQ@mail.gmail.com>
Subject: Re: Build regressions/improvements in v5.0-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 8, 2019 at 9:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v5.0-rc1[1] compared to v4.20[2].
>
> Summarized:
>   - build errors: +12/-4
>   - build warnings: +405/-350
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/bfeffd155283772bbe78c6a05dec7c0128ee500c/ (all 240 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/8fe28cb58bcb235034b64cbbb7550a8a43fd88be/ (all 240 configs)
>
>
> *** ERRORS ***
>
> 12 error regressions:
>   + /kisskb/src/arch/mips/generic/init.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + /kisskb/src/arch/mips/generic/irq.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + /kisskb/src/arch/mips/kernel/branch.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + /kisskb/src/arch/mips/kernel/cmpxchg.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + /kisskb/src/arch/mips/kernel/cpu-probe.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + /kisskb/src/arch/mips/mm/cache.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + /kisskb/src/arch/mips/mm/extable.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + /kisskb/src/arch/mips/mm/fault.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + /kisskb/src/arch/mips/net/bpf_jit.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0
>   + arch/mips/vdso/vdso-image.c: error: -ffunction-sections disabled; it makes profiling impossible [-Werror]:  => 1:0

mips-allmodconfig

These are even more annoying than on powerpc, as mips enables -Werror for
arch/mips/ :-(
Can this be avoided, e.g. by making LD_DEAD_CODE_DATA_ELIMINATION and
profiling mutually exclusive?

>   + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>   + error: arch/sparc/kernel/head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)

Same as before, just a different signature.

> 4 error improvements:
>   - /kisskb/src/arch/s390/kernel/nospec-branch.c: error: macro "memcpy" passed 6 arguments, but takes just 3: 130:61 =>
>   - /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]: 8800:3 =>
>   - error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text': (.head.text+0x5040), (.head.text+0x5100) =>
>   - error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o: (.init.text+0xa4) =>
>
>
> *** WARNINGS ***
>
> [Deleted 490 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on {mips,powerpc}-all{mod,yes}config*]

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
