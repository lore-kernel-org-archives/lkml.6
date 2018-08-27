Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49EFEC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F5E1208B4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 09:55:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5E1208B4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbeH0NlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 09:41:22 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:33950 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbeH0NlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 09:41:22 -0400
Received: by mail-vk0-f66.google.com with SMTP id l143-v6so7260675vke.1;
        Mon, 27 Aug 2018 02:55:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z015p4ynXfmmBj2Yrxtc2mTKUGfswqN3OUCvxFrT+zE=;
        b=fLltbmH4leSVVMIeZvs7uVIoqfA2PfGSCgTswQ6NhZyue/4Sqv2qcJlL7RKzIj1zue
         l7GdHTDa2HCKrJXbAoXS8yE7gb3u6bp8hz1McxFs1xSVi+I+aZ9PJLK5JCWpGk9T0tw+
         34SpozhCbjnDoqPPzfQ24/wTpqzfoUnUsPkIwVjr2gsF7QneI8ijhrD+Q9+MnCNhYIja
         Q5SzcolTwvx4n1uL+juMXlaPT/XJGhhxJ41Vv2euvvOdvJx51Mt3SxN0mIT/TUtYMlWG
         cbe22xirXbB9LPmpC5/tkh2YgEguKW0VY8i8EQpLV+Po5AfRM+WnHC8DQbnzqYy6rvxt
         eR8A==
X-Gm-Message-State: APzg51BRI80GFaeqmHNgHoUamYDicBP7KHvZURuq89jN4mtI3blcZgEk
        uNc+VZfTgln/zqIeHKuGCuF/yLRYPzZu3Z38+yD5fISF
X-Google-Smtp-Source: ANB0VdapXRkmxOjqLItkVUaQLrFpIoNjHm/L4ApOtayADEZ84TnrfnnbgRLV60x/5qRmpa758R2P94wIGAmKGDT5+5g=
X-Received: by 2002:a1f:1246:: with SMTP id 67-v6mr7391950vks.82.1535363722370;
 Mon, 27 Aug 2018 02:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20180827094926.15512-1-geert@linux-m68k.org>
In-Reply-To: <20180827094926.15512-1-geert@linux-m68k.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 27 Aug 2018 11:55:10 +0200
Message-ID: <CAMuHMdVDmq+Kmi74jhL6CTS1cEt61xq-sX8cm208anYggUPWxg@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.19-rc1
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 27, 2018 at 11:50 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Below is the list of build error/warning regressions/improvements in
> v4.19-rc1[1] compared to v4.18[2].
>
> Summarized:
>   - build errors: +5/-3
>   - build warnings: +14732/-179
>
> Note that there may be false regressions, as some logs are incomplete.
> Still, they're build errors/warnings.
>
> Happy fixing! ;-)
>
> Thanks to the linux-next team for providing the build service.
>
> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/5b394b2ddf0347bef56e50c69a58773c94343ff3/ (all 240 configs)
> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/94710cac0ef4ee177a63b5227664b38c95bbf703/ (239 out of 240 configs)
>
>
> *** ERRORS ***
>
> 5 error regressions:
>   + /kisskb/src/arch/nds32/include/asm/elf.h: error: expected '}' before ';' token:  => 126:29

nds32-allmodconfig, nds32-allyesconfig

>   + error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.init.text':  => (.head.text+0x5100), (.head.text+0x5040)
>   + error: arch/sparc/kernel/.tmp_head_32.o: relocation truncated to fit: R_SPARC_WDISP22 against symbol `leon_smp_cpu_startup' defined in .text section in arch/sparc/kernel/trampoline_32.o:  => (.init.text+0xa4)
>   + error: arch/sparc/kernel/process_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x4), (.fixup+0xc)
>   + error: arch/sparc/kernel/signal_32.o: relocation truncated to fit: R_SPARC_WDISP22 against `.text':  => (.fixup+0x0), (.fixup+0x8), (.fixup+0x10), (.fixup+0x18), (.fixup+0x20)

sparc64/sparc-allmodconfig

> *** WARNINGS ***
>
> [Deleted 14564 lines about "warning: -ffunction-sections disabled; it makes profiling impossible [enabled by default]" on powerpc-all{mod,yes}config*]

Parisc finally managed to get rid of these, and now powerpc got them :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
