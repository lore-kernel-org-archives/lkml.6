Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C282C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:44:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04865208E7
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 08:44:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04865208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730488AbeKGSOA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 13:14:00 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:36557 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeKGSN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 13:13:59 -0500
Received: by mail-vk1-f194.google.com with SMTP id u62so3531749vkb.3;
        Wed, 07 Nov 2018 00:44:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wMoTerJKeg8lFio2Ljy91Dvj/RDjGUDC3iBhw/TWeqo=;
        b=LcvaoQF0LywhJSu11JTcAlPnAGhgydyBpGVXeteFhxeC3QQsXg7RyQbuyieBZYvlPE
         i80c0zMsNj6HEd5FPpEf1QrC/2C3/3yKQruP5a+d51THLVWw9/sjuhIf+Dhe9egorrqU
         dZ8idRG06jlwVL7fKxQPzdMiF6/2hqIvbq8hJDlDJIUo0tW9woKGRxFU1Bx3ekbM4iKl
         0VWOZlmF2Xt9XhAQ+yl10DHGPQwwWyJcw43SNV7bGwQa70/5lCz4wfL+yMy8ip61xaMc
         eMesyYIfgohKcLshwx+ij7s7wBZvSPcLjHT+qrm7BQ7z8bydcduM+BDHXjDXhPtFdYCI
         iTQQ==
X-Gm-Message-State: AGRZ1gJfY5TqGj+CNsG/UXYZEKoxqxiyKc78ZQEOBXS+cuJZt1GNVUW8
        LmBB2M5iI66/PR+HKlbiBV35eAksb2Oxky/1Jpm95g==
X-Google-Smtp-Source: AJdET5fsRCw7GQN+q0ICx1TvLdKbBYtMxJi9u0kREOAyyThJaPcJdUDP6+JrJr4y8W7ZJvYAsWAM945h/lBtLndcVkU=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr366907vkh.65.1541580277266;
 Wed, 07 Nov 2018 00:44:37 -0800 (PST)
MIME-Version: 1.0
References: <20181105220559.27458-1-geert@linux-m68k.org> <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org> <s5h36seyyae.wl-tiwai@suse.de>
In-Reply-To: <s5h36seyyae.wl-tiwai@suse.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Nov 2018 09:44:25 +0100
Message-ID: <CAMuHMdUc6hcPp+Ca9tnWyHGWw-heKRJ82FTabDed5oqtbm7mjQ@mail.gmail.com>
Subject: Re: [alsa-devel] Build regressions/improvements in v4.20-rc1 (sound/pci/hda/patch_ca0132.c)
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Iwai-san,

On Tue, Nov 6, 2018 at 5:18 PM Takashi Iwai <tiwai@suse.de> wrote:
> On Tue, 06 Nov 2018 02:04:47 +0100,
> Randy Dunlap wrote:
> >
> > On 11/5/18 2:12 PM, Geert Uytterhoeven wrote:
> > > On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > >> Below is the list of build error/warning regressions/improvements in
> > >> v4.20-rc1[1] compared to v4.19[2].
> > >>
> > >> Summarized:
> > >>   - build errors: +3/-0
> > >>   - build warnings: +449/-2712
> > >>
> > >> Happy fixing! ;-)
> > >>
> > >> Thanks to the linux-next team for providing the build service.
> > >>
> > >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
> > >> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
> > >>
> > >>
> > >> *** ERRORS ***
> > >>
> > >>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
> > >
> > > sh4-all{mod,yes}config
> > >
> > > Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
> > > pci_iomap() on SH")
> > > is not sufficient?
> >
> > Different problem.  This is about "select":
> >
> > config SND_SOC_ALL_CODECS
> >       tristate "Build all ASoC CODEC drivers"
> >
> > That enables (sets):
> >       select SND_SOC_HDAC_HDA
> > which selects SND_HDA even though CONFIG_PCI is not enabled.
>
> Actually it is OK to enable CONFIG_SND_HDA_CODEC_CA0132 without
> CONFIG_PCI.  IIRC, there was a system like that, too.
> The commit above should have covered the build failure on SH, but
> apparently isn't enough for some arch setups, as it seems.
>
> The cause is clear now: pci_iomap() is defined in
> asm-generic/pci_iomap.h only when CONFIG_GENERIC_PCI_IOMAP is
> defined.  Including asm/io.h doesn't help unless CONFIG_PCI is set.
>
> Below is a quick fix for this.
>
>
> thanks,
>
> Takashi
>
> -- 8< --
>
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH] ALSA: hda/ca0132 - Yet more fix on build breakage without PCI
>  support
>
> The recent change in CA0132 codec driver for supporting more
> Creative boards includes the pci_iomap() call to get the extra
> register accesses.  This is supposed to work on all archs and setups,
> by the implicit assumption that every arch would provide a dummy
> function returning NULL when no PCI is available.  But the reality
> bites, of course; as Geert's regular build test shows, some configs
> (at least SH4 without CONFIG_PCI) leads to a build error due to the
> implicit function declaration.
>
> So this is another attempt to fix the issue: now we add an ifdef
> CONFIG_PCI line, so that pci_iomap() won't be called unless PCI is
> really usable.  This should fall back to the standard quirk again with
> a warning.
>
> Fixes: d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of pci_iomap() on SH")
> Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Thanks for your patch!

> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -8796,7 +8796,13 @@ static int patch_ca0132(struct hda_codec *codec)
>         }
>
>         if (spec->use_pci_mmio) {
> +               /*
> +                * ifdef below needed due to lack of pci_iomap() decleration
> +                * for some archs when no PCI is defined
> +                */
> +#ifdef CONFIG_PCI
>                 spec->mem_base = pci_iomap(codec->bus->pci, 2, 0xC20);
> +#endif

I'm sorry, but that is not a proper fix.
This should be fixed in the SH-specific code, to behave like other
architectures.

>                 if (spec->mem_base == NULL) {
>                         codec_warn(codec, "pci_iomap failed! Setting quirk to QUIRK_NONE.");
>                         spec->quirk = QUIRK_NONE;

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
