Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57CD5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C1E02087F
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 20:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545854842;
	bh=yW6ad6ny47KdrigTr7nNyf/sLYovA1FZVHtuqp6MCfI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RRVe7VZ6nMYdCo9hxDtXB/TLUd0RnwUM2PfUUW8zxDkmHYJR5Am9LX1FIc813jFFy
	 8NdEZFpOjLO3tknnQU2k/cCYY95MiDCBWOZnMR1c229u+GtEq/6zcgTVrmwR/cMERo
	 47Zx8ld7jPZuF2NCZ51Efee1oFFeN59zmW9YipmA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbeLZUHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 15:07:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:56698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbeLZUHR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 15:07:17 -0500
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30D4B2087F;
        Wed, 26 Dec 2018 20:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545854836;
        bh=yW6ad6ny47KdrigTr7nNyf/sLYovA1FZVHtuqp6MCfI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=N1XZBJOsQX4XBMZ43pcCTm8W/R7vO9exgSR/CczyddoOKq4lYdn3aM2t/iVXhJDJ+
         shC+tpzIQCm9dSNe9RoHk7NH4wCCSCyy/IODRs21zfMKQy2h/NZskHIZbWyDKj6UBj
         GBfQqV4m0AvcNmU0Ad44yIsso52T+upHh013RDZc=
Received: by mail-ot1-f49.google.com with SMTP id 40so14778977oth.4;
        Wed, 26 Dec 2018 12:07:16 -0800 (PST)
X-Gm-Message-State: AJcUuketYSKc6aiI76HzrRD+zLLLqZvHx/jZto/27pkxaGsTiv0WBhfL
        1OPtNIxQcJLwQfsCKgcgJkpMzNfEwDAqwIUeZHk=
X-Google-Smtp-Source: ALg8bN4Zc4dwQ6O8K5Z67ibNimgZ5lHrORFDDnawKNAvvL06xWscZuxny53EQR6lyS8j/5C4bH9gdyhImIWlDMz/ebs=
X-Received: by 2002:a9d:762:: with SMTP id 89mr13350242ote.89.1545854835486;
 Wed, 26 Dec 2018 12:07:15 -0800 (PST)
MIME-Version: 1.0
References: <20181223232521.11320-1-okaya@kernel.org> <20181223232521.11320-9-okaya@kernel.org>
 <39200a36-6592-f010-8309-a249a8d514f4@linux.intel.com>
In-Reply-To: <39200a36-6592-f010-8309-a249a8d514f4@linux.intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Wed, 26 Dec 2018 23:07:04 +0300
X-Gmail-Original-Message-ID: <CAK9iUCMG9YkiZC-yAe0vJ62cJ2tW--KqVtDr3SMLM3zJFpJHSw@mail.gmail.com>
Message-ID: <CAK9iUCMG9YkiZC-yAe0vJ62cJ2tW--KqVtDr3SMLM3zJFpJHSw@mail.gmail.com>
Subject: Re: [PATCH v3 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
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

On Wed, Dec 26, 2018 at 8:35 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> On 12/23/18 5:25 PM, Sinan Kaya wrote:
> > Code does unconditional select for IOSF_MBI. IOSF_MBI driver depends on
> > CONFIG_PCI set but this is not specified anywhere.
>
> Can you please share the .config that exposes this problem? This hasn't
> changed in a long time and I wonder why this pops up now. You have
> similar cases elsewhere, e.g. arch/x86/Kconfig
>
Here is the background :

I have a changeset that was added to 4.21-rc1 that decouples  ACPI from
PCI. PCI was automatically selected when ACPI was chosen before.

This is no longer true.

If a code needs PCI support, it now needs to explicitly state that.

This allows usecase for smaller kernels and component isolation.

> config X86_INTEL_LPSS
>      bool "Intel Low Power Subsystem Support"
>      depends on X86 && ACPI
>      select COMMON_CLK
>      select PINCTRL
>      select IOSF_MBI
>
> or for the MMC.
>
> config MMC_SDHCI_ACPI
>      tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>      depends on MMC_SDHCI && ACPI
>      select IOSF_MBI if X86
>
> The use of IOSF_MBI is only for the Baytrail-CR detection and there are
> already in-flight patches to change the code and move it to a helper.
>
> My understanding is that for compilation you only need CONFIG_x86 since
> there are fall-back routines available in iosf_mbi.h
>
> Thanks!
>
> >
> > Signed-off-by: Sinan Kaya <okaya@kernel.org>
> > ---
> >   sound/soc/intel/Kconfig | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> > index 2fd1b61e8331..b0764b2fe001 100644
> > --- a/sound/soc/intel/Kconfig
> > +++ b/sound/soc/intel/Kconfig
> > @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
> >   config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
> >       tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
> >       default ACPI
> > -     depends on X86 && ACPI
> > +     depends on X86 && ACPI && PCI
> >       select SND_SST_IPC_ACPI
> >       select SND_SST_ATOM_HIFI2_PLATFORM
> >       select SND_SOC_ACPI_INTEL_MATCH
