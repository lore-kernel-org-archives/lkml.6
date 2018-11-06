Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC1CDC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:01:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8EAF32085B
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 08:01:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8EAF32085B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbeKFRZf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 12:25:35 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:33468 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729430AbeKFRZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 12:25:35 -0500
Received: by mail-vk1-f193.google.com with SMTP id d201so67275vka.0;
        Tue, 06 Nov 2018 00:01:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T0Ix/0bIGw6OsEI0LrY5rkA9hhTbYLHvl/qo4fPrRBk=;
        b=eUtqZPO2Yi5vU1tmshc6ygpEhADs3g/n6Kl3vhSjzp6ALq9djzax6ur4BbFKH/3gy3
         moJvbYba2ZSBBE9+yliICznZifeeivS84bRWDmhgrZol7mymJH8usf9XhOKWYydUIBqj
         6/mNMUXtnYC1n9SgTROlFrVe6CXdKvcySf1hCKRVpju0YGIQU9+YqM/wKIjE3UK63+Wv
         kkTelSorqmLzXtparRJl+tg8/8cAUP+zhSe6x9krYTL3YZ0LfwVs0bkBliCVri+upjqT
         Kh/lRzElszRqsaUQYsUcQSAuvnG9tIv2fvjT0/FsQ41XkU1Tn6otsea7WIhbz/N1v3sl
         DQNw==
X-Gm-Message-State: AGRZ1gI9vxNeurGUWMBixrAhDLTyXsIGhYDQSwESZRy/S9zrs/SUGYfi
        3abdsgk174NDiP/sAa1uxKupBwtxQ06Qn8BLMz+C8grP
X-Google-Smtp-Source: AJdET5ewbKFORQ9x1DhND2Q43p9VeYab7xI9mCbQynqP/hmCGmI7jzUqB8EogrA4sYLZZNGFkZOQwvQZjggBrXjsq4U=
X-Received: by 2002:a1f:2145:: with SMTP id h66mr11145554vkh.65.1541491295531;
 Tue, 06 Nov 2018 00:01:35 -0800 (PST)
MIME-Version: 1.0
References: <20181105220559.27458-1-geert@linux-m68k.org> <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
In-Reply-To: <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 09:01:23 +0100
Message-ID: <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v4.20-rc1 (sound/pci/hda/patch_ca0132.c)
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Randy,

On Tue, Nov 6, 2018 at 2:06 AM Randy Dunlap <rdunlap@infradead.org> wrote:
> On 11/5/18 2:12 PM, Geert Uytterhoeven wrote:
> > On Mon, Nov 5, 2018 at 11:07 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >> Below is the list of build error/warning regressions/improvements in
> >> v4.20-rc1[1] compared to v4.19[2].
> >>
> >> Summarized:
> >>   - build errors: +3/-0
> >>   - build warnings: +449/-2712
> >>
> >> Happy fixing! ;-)
> >>
> >> Thanks to the linux-next team for providing the build service.
> >>
> >> [1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/651022382c7f8da46cb4872a545ee1da6d097d2a/ (all 240 configs)
> >> [2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/84df9525b0c27f3ebc2ebb1864fa62a97fdedb7d/ (all 240 configs)
> >>
> >>
> >> *** ERRORS ***
> >>
> >>   + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
> >
> > sh4-all{mod,yes}config
> >
> > Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
> > pci_iomap() on SH")
> > is not sufficient?
>
> Different problem.  This is about "select":
>
> config SND_SOC_ALL_CODECS
>         tristate "Build all ASoC CODEC drivers"
>
> That enables (sets):
>         select SND_SOC_HDAC_HDA
> which selects SND_HDA even though CONFIG_PCI is not enabled.
>
> After SND_HDA is selected (above), the Kconfig symbols in
> sound/pci/hda/Kconfig are available for enabling, so
> SND_HDA_CODEC_CA0132 is enabled but will not build.

Thanks for looking into this!

> One simple solution (but possibly too naive) is:
>
> ---
>  sound/soc/codecs/Kconfig |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> --- lnx-420-rc1.orig/sound/soc/codecs/Kconfig
> +++ lnx-420-rc1/sound/soc/codecs/Kconfig
> @@ -82,7 +82,7 @@ config SND_SOC_ALL_CODECS
>         select SND_SOC_ES7241
>         select SND_SOC_GTM601
>         select SND_SOC_HDAC_HDMI
> -       select SND_SOC_HDAC_HDA
> +       select SND_SOC_HDAC_HDA if PCI
>         select SND_SOC_ICS43432
>         select SND_SOC_INNO_RK3036
>         select SND_SOC_ISABELLE if I2C

I guess that will work. There are already plenty of "select foo if bar" lines.
However, looking at what else can enable SND_HDA, I think it should be

    select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA

That still leaves the issue that pci_iomap() on SH should be an empty stub if
PCI is not available, like on other architectures.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
