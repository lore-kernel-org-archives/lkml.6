Return-Path: <SRS0=SmvU=O7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4551C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E422054F
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Dec 2018 17:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545500891;
	bh=NcuZvBHiyFU5E1lURFPd6t8N4nVFLOG5FYFIvKQXcAc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Kedi/Lj47q7Pl5p4CBOAbObC0bGs8JddcWlan/RNhVF2mU7ciKpSH4H2KORYfeAEC
	 TnW/fgmAcqYwmE69jDy8U0FXqcTWstlk3FQKcqlRTLdTeZJx0QCKgVj11CFgahtpM+
	 XKR1U+JtXJ+2dAzMHuWpr8YruosJfryb38Ql0EeY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392609AbeLVRsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Dec 2018 12:48:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:34172 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390011AbeLVRrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Dec 2018 12:47:14 -0500
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA1D12196E;
        Sat, 22 Dec 2018 06:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545460002;
        bh=NcuZvBHiyFU5E1lURFPd6t8N4nVFLOG5FYFIvKQXcAc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Ds4DfsZEagdLfjRi+eQsdn/OkDPAoigJnQgL7QiHeWaPz77qFXebN7wmBciHTftyM
         +T7Jkh3IRE1LjfNwWZFuFjACEYFLqEesKzdQqj+ZY1UgR4FLeLJOd6xg+60aX0tcih
         5iYtD58/S7P/3tiu0dAghOhqHzjtrHxewsgsdQU0=
Received: by mail-oi1-f170.google.com with SMTP id x202so6550661oif.13;
        Fri, 21 Dec 2018 22:26:42 -0800 (PST)
X-Gm-Message-State: AJcUukc6uwtN2wy33qsd2mfi2aNVCyrViZ7ogpRMIrBOyjER1VTKgxb4
        4/rYcTgSxYi7E+yqNfxXw2ObPM897RufHSpqR5Y=
X-Google-Smtp-Source: AFSGD/WssgAliX6LpUxP2bWOYyfBfAU9nh6ZaaRQbGmgLn5nA3+6EwZqjBSVJ6+ZfrP0bzbR3EnpgkEHzFiBIPcRv2s=
X-Received: by 2002:aca:e755:: with SMTP id e82mr3003619oih.153.1545460002006;
 Fri, 21 Dec 2018 22:26:42 -0800 (PST)
MIME-Version: 1.0
References: <20181222001452.7474-1-okaya@kernel.org> <20181222001452.7474-9-okaya@kernel.org>
 <eb27ab03-4f42-2e2e-9873-16d9a6927e2b@infradead.org>
In-Reply-To: <eb27ab03-4f42-2e2e-9873-16d9a6927e2b@infradead.org>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Sat, 22 Dec 2018 07:26:30 +0100
X-Gmail-Original-Message-ID: <CAK9iUCN77U5tQn-WWaL27v244GkEAgRBxKK1H_+xUhOZ2aCERw@mail.gmail.com>
Message-ID: <CAK9iUCN77U5tQn-WWaL27v244GkEAgRBxKK1H_+xUhOZ2aCERw@mail.gmail.com>
Subject: Re: [PATCH v1 08/11] ASoC: Intel: Make PCI dependency explicit
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 22, 2018 at 4:19 AM Randy Dunlap <rdunlap@infradead.org> wrote:
>
> On 12/21/18 4:14 PM, Sinan Kaya wrote:
> > IOSF_MBI driver depends on CONFIG_PCI set but this is not specified
> > anywhere.
>
> wrong patch description...?

Not really...
Code does unconditional select for IOSF_MBI.

>
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >  sound/soc/intel/Kconfig | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> > index 2fd1b61e8331..b0764b2fe001 100644
> > --- a/sound/soc/intel/Kconfig
> > +++ b/sound/soc/intel/Kconfig
> > @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
> >  config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
> >       tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
> >       default ACPI
> > -     depends on X86 && ACPI
> > +     depends on X86 && ACPI && PCI
> >       select SND_SST_IPC_ACPI
> >       select SND_SST_ATOM_HIFI2_PLATFORM
> >       select SND_SOC_ACPI_INTEL_MATCH
> >
>
>
> --
> ~Randy
