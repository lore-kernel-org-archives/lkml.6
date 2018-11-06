Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2541EC32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:25:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23EC2081D
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 15:25:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23EC2081D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388238AbeKGAvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 19:51:18 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:33780 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730448AbeKGAvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 19:51:17 -0500
Received: by mail-ua1-f68.google.com with SMTP id s26so4666156uao.0;
        Tue, 06 Nov 2018 07:25:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5bzwxXLTuZIkYi1+oDy9WcbQ21yhzr5FkooL8IpTbKQ=;
        b=tV0lXebKSYlPISc1afSLv508fI9iqKJIL8Rd8x44lDgBRMlJjIxBIIe/zwd82a1WnA
         b4TlTxN+mNHBPIf0nSFhdjtSuqg4Q4wzkFqThkpDxNrlX8aRl0a3cyLYeZxsz6eYStq1
         MQ0lGxxGJfPNv1NpDEmj0/XQOcJF6OeVftw1dQ8meB44QI8I2ZrB5DEI3lQdX+PgXNfp
         nW/looEbRGFrOt3lta/coXbNx9yXWXeDQMyajSNG7tLAYf59bFfoz8RfjWtpBl+L7X0u
         73uxpt05axKPQDri1oq8NZF3TDwcEBcKbP7Q1FgXSUxdH86C9DvyoP2C7blzIyRUe3fL
         QZmg==
X-Gm-Message-State: AGRZ1gIaqBlMZGX44jXjRHTPtpQ9R8tmXn4g/oHw6VT4aMHOcja4yQdC
        mYsa66Epo3PI6LiXbyAfZuzQ/VryNlNQN6Oq3KGUhdeR
X-Google-Smtp-Source: AJdET5cKZBHkvYCvNrPkAsfD+RUizrsz+u52iWhXmeTx/85JtDrSRJojeBxlixA422MjSXFU48YWS2lhCDCnVMQivdM=
X-Received: by 2002:ab0:210e:: with SMTP id d14mr489643ual.20.1541517933483;
 Tue, 06 Nov 2018 07:25:33 -0800 (PST)
MIME-Version: 1.0
References: <20181105220559.27458-1-geert@linux-m68k.org> <CAMuHMdWGpjvwunNWgFujPO9_j+=QiNsi346s4-xBF1g4DT5xZw@mail.gmail.com>
 <80f2f98b-9ab1-2a1c-0962-63e3be1dd742@infradead.org> <CAMuHMdViTrKqQzci3=YJzk2+kQKqbWcr0oaaR1ZQM_VqT33RvA@mail.gmail.com>
 <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
In-Reply-To: <eccd20fa-5be3-957d-7905-9cc4021ba94e@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Nov 2018 16:25:21 +0100
Message-ID: <CAMuHMdWMO5yE7vjWsyz6dWQ6eswVRcWO8A43vTrJn26D1EsfVQ@mail.gmail.com>
Subject: Re: [alsa-devel] Build regressions/improvements in v4.20-rc1 (sound/pci/hda/patch_ca0132.c)
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

On Tue, Nov 6, 2018 at 3:56 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
> >>>>
> >>>> *** ERRORS ***
> >>>>
> >>>>    + /kisskb/src/sound/pci/hda/patch_ca0132.c: error: implicit declaration of function 'pci_iomap' [-Werror=implicit-function-declaration]:  => 8799:3
> >>> sh4-all{mod,yes}config
> >>>
> >>> Looks like d9b84a15892c0233 ("ALSA: hda: Fix implicit definition of
> >>> pci_iomap() on SH")
> >>> is not sufficient?
> >> Different problem.  This is about "select":
> >>
> >> config SND_SOC_ALL_CODECS
> >>          tristate "Build all ASoC CODEC drivers"
> >>
> >> That enables (sets):
> >>          select SND_SOC_HDAC_HDA
> >> which selects SND_HDA even though CONFIG_PCI is not enabled.
> >>
> >> After SND_HDA is selected (above), the Kconfig symbols in
> >> sound/pci/hda/Kconfig are available for enabling, so
> >> SND_HDA_CODEC_CA0132 is enabled but will not build.
> > Thanks for looking into this!
> >
> >> One simple solution (but possibly too naive) is:
> >>
> >> ---
> >>   sound/soc/codecs/Kconfig |    2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> --- lnx-420-rc1.orig/sound/soc/codecs/Kconfig
> >> +++ lnx-420-rc1/sound/soc/codecs/Kconfig
> >> @@ -82,7 +82,7 @@ config SND_SOC_ALL_CODECS
> >>          select SND_SOC_ES7241
> >>          select SND_SOC_GTM601
> >>          select SND_SOC_HDAC_HDMI
> >> -       select SND_SOC_HDAC_HDA
> >> +       select SND_SOC_HDAC_HDA if PCI
> >>          select SND_SOC_ICS43432
> >>          select SND_SOC_INNO_RK3036
> >>          select SND_SOC_ISABELLE if I2C
> > I guess that will work. There are already plenty of "select foo if bar" lines.
> > However, looking at what else can enable SND_HDA, I think it should be
> >
> >      select SND_SOC_HDAC_HDA if SND_PCI || ARCH_TEGRA
>
> This codec can only be used by the Skylake driver (and the upcoming SOF
> one). For Tegra this module will never be used unless they follow the
> same path of enabling ASoC to deal with the HDaudio codecs instead of
> the legacy.
>
> Likewise HDAC_HDMI will only work on Intel platforms for now.
>
> >
> > That still leaves the issue that pci_iomap() on SH should be an empty stub if
> > PCI is not available, like on other architectures.
>
> I thought Mark Brown provided a fix to SH maintainers?

Indeed, https://patchwork.kernel.org/patch/10597409/

As usual, no response from the J^HSH maintainers :-(

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
