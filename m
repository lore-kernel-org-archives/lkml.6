Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CC7AC43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:58:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1576E2070D
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546469918;
	bh=x81zMFByEwwbiOt+nSfbY8l0nMemOCoixK0m9bjpXBY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Pg9XryK6Wms7zu3PcLl6XIL4YQNIwlV8Cct32y3+3WHsFfrs1kJuYIZZfcFEThc87
	 fftrlSo8COI2b1K1zAsOA6VwDX+uMXxMUYaONaVDoPRL0sIFBbNXGybgvSKyO+bSa4
	 yhXtnXz7MTgnVKwLTS+nonQyPmAOhjqOClGsv4FU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbfABW6h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:58:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:44652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbfABW6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:58:36 -0500
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A72892171F;
        Wed,  2 Jan 2019 22:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546469914;
        bh=x81zMFByEwwbiOt+nSfbY8l0nMemOCoixK0m9bjpXBY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=DRie+9UcdWhVqfQDfk8IC2tuar/YVFeforUrNyYz855Mg7pVHhnc71MqBsQ3PwFJZ
         PHp2DvFb29/DyBTt0Pf+F7lHK4TTufONSVz3FAvlsTb3r0dqLOtUphTeuwu6d3EgGO
         v5vB0MTb1y1Qt5FZTmWjCJGoQWDWzMH8k7BeauSY=
Received: by mail-oi1-f181.google.com with SMTP id v6so26352481oif.2;
        Wed, 02 Jan 2019 14:58:34 -0800 (PST)
X-Gm-Message-State: AJcUukfPJE4QtDNqcdA02hBY6sLRECNE7mmpn+aU4Yd+sXlodqJyeDoe
        dheKhdT0nthJ0vb1Yb/KY9Rg9l7ZpGH7r/KbKMo=
X-Google-Smtp-Source: ALg8bN7nOOo/xKnUrdpIRN0dZGkBQE7O0X62qaesVRD/xhi8ZVNMQWaWS7fyqmdl56K1PEDj62SZ3TZxKBpTCBN9JDg=
X-Received: by 2002:aca:5e09:: with SMTP id s9mr14016461oib.153.1546469913950;
 Wed, 02 Jan 2019 14:58:33 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-9-okaya@kernel.org>
 <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com> <CAK9iUCNMAuDOh_CM-bTE1xT5FePfYbq7W+0R4KF1KbqskuJ8FA@mail.gmail.com>
 <a9ccf7e1-4752-6bf5-2621-15b21a80c2ca@linux.intel.com>
In-Reply-To: <a9ccf7e1-4752-6bf5-2621-15b21a80c2ca@linux.intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Wed, 2 Jan 2019 22:58:22 +0000
X-Gmail-Original-Message-ID: <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com>
Message-ID: <CAK9iUCPWQ=9EgnUFo8BHraEgFwHs3FdbegPLwhT-KHD=r2WBkQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ACPI Devel Mailing List <linux-acpi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 10:50 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
>
> > This is pointing to a kconfig issue on ia64 arch.
> >
> > arch/ia64/Kconfig:128:error: recursive dependency detected!
> > arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
> > arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM
> >
> > IA64_HP_SIM is both a choice and is selected.
> >
> > I did allyesconfig and disabled PCI afterwards to find all the issues
> > on this patchset.
>
> Are you saying there's a newer series that fixes this issue for both
> allyesconfig and allmodconfig?
>
> if yes, then we're good.


No, I haven't fixed ia64 kconfig issue. That's somebody else's job. I
used allyesconfig to find out all compilation issues on x86 arch to
come up with this patchset.


>
> >
> >> 2. there are different patterns to express the dependency on PCI e.g.
> >>
> >>    config MMC_SDHCI_ACPI
> >>        tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> >>        depends on MMC_SDHCI && ACPI
> >> -    select IOSF_MBI if X86
> >> +    select IOSF_MBI if (X86 && PCI)
> >>
> >> but
> >>
> >> config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
> >>        tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
> >>        default ACPI
> >> -    depends on X86 && ACPI
> >> +    depends on X86 && ACPI && PCI
> >>        select SND_SST_IPC_ACPI
> >>        select SND_SST_ATOM_HIFI2_PLATFORM
> >>        select SND_SOC_ACPI_INTEL_MATCH
> >>
> > I matched depends line to
> >
> > depends on X86 && ACPI && PCI
> >
> > for MMC_SDHCI_ACPI per feedback from Rafael on V5. This should resolve
> > the inconsistency.
> ok, I didn't see the delta
> >
> >
> >> IOSF is only needed for Baytrail-CR detection, and the code will compile
> >> fine without it, so maybe it'd be a better model if you used the
> >> following diff?
> >>
> >> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> >> index 2fd1b61e8331..68af0ea5c96c 100644
> >> --- a/sound/soc/intel/Kconfig
> >> +++ b/sound/soc/intel/Kconfig
> >> @@ -95,7 +95,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
> >>           select SND_SST_IPC_ACPI
> >>           select SND_SST_ATOM_HIFI2_PLATFORM
> >>           select SND_SOC_ACPI_INTEL_MATCH
> >> -       select IOSF_MBI
> >> +       select IOSF_MBI if PCI
> >>
> >> 3. All the Intel machine drivers depend on X86_INTEL_LPSS which depends
> >> on PCI. But for Baytrail/Haswell/Broadwell we have only a dependency on
> >> ACPI, so we expose drivers that can be selected but fail on probe since
> >> there are no machine drivers. I am not sure if we want to be strict and
> >> only expose meaningful configurations, or allow for more compilations
> >> tests and corner cases?
> > Hopefully, v5 resolves this too with
> >
> > depends on X86 && ACPI && PCI
> >
> > Let me know otherwise.
>
> it doesn't but that's not a good enough reason to lay on the tracks.
> I'll follow-up with a cleanup for the Intel audio parts when this series
> is merged. The PCI dependency could be moved to the top-level since it's
> pretty much required for all platforms except for compilation tests, and
> there are multiple dependencies that repeated for no good reason, so FWIW
>
> Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
>
