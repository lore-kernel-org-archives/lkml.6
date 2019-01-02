Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E921C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:09:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 204F92171F
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546466998;
	bh=wpJHg6NVHx2Ulmo6BT7faosovfnpmyvwbVht7qw2L6g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=EhKV4TrJYjfxgGsNy9KY8jUPKiDEZrdtTpTY420ZlAlK4DhrZB3UDxLyYLb7of3BH
	 TCb5lptS/SxW/bpJ7bTmUqpmvvFfZ75u2Ie8Z58eptec7RfddWudlJDFki/EECTzCf
	 NaA/D7wOY319cidrB0HKa0zM1maklBs54Dtbg39k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729468AbfABWJ5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:09:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:51216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727140AbfABWJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:09:57 -0500
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F18FE21871;
        Wed,  2 Jan 2019 22:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546466996;
        bh=wpJHg6NVHx2Ulmo6BT7faosovfnpmyvwbVht7qw2L6g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=KHFFUhKnSteV67mOn24rVKyqtUcZxTU4uBABqrTHi971EDFV/41abUTRl6fn7++3W
         HyZT+vZcdLQdppInIRBq8TDsVpVrmyDeXVa9cKY756mdkDiIl20kCl8la3ynTgCej3
         t4qpGNXbz8AAKIMlN5IPvVQci14/oP0j91bShxnM=
Received: by mail-ot1-f45.google.com with SMTP id a11so27903996otr.10;
        Wed, 02 Jan 2019 14:09:55 -0800 (PST)
X-Gm-Message-State: AJcUukdsAMmZpmTuuDSQ+iwO5tsgM6IfEMgQY58yhusG/TmDIRUcT97J
        pPQN3VzDE8prxHkfJXFZLNyMpnnmjnTfYn21Wlc=
X-Google-Smtp-Source: ALg8bN4cfFf4wKD82RXQa5mZ5+VUS02f1LUOLU0qTrJVg/+IvN94q5dOXVCiZO2dYV4ihqqZrHPrJYMNZfMFAwtHbkg=
X-Received: by 2002:a9d:784a:: with SMTP id c10mr32723903otm.175.1546466995225;
 Wed, 02 Jan 2019 14:09:55 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-9-okaya@kernel.org>
 <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
In-Reply-To: <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Wed, 2 Jan 2019 22:09:43 +0000
X-Gmail-Original-Message-ID: <CAK9iUCNMAuDOh_CM-bTE1xT5FePfYbq7W+0R4KF1KbqskuJ8FA@mail.gmail.com>
Message-ID: <CAK9iUCNMAuDOh_CM-bTE1xT5FePfYbq7W+0R4KF1KbqskuJ8FA@mail.gmail.com>
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

On Wed, Jan 2, 2019 at 8:33 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> I have three opens with this ACPI/PCI change
>
> 1. the baseline change fails on my cross-compilation checks, see below
> the result of the attached script (simplification of the one I use to
> avoid 0day reports).
>

This is pointing to a kconfig issue on ia64 arch.

arch/ia64/Kconfig:128:error: recursive dependency detected!
arch/ia64/Kconfig:128:    choice <choice> contains symbol IA64_HP_SIM
arch/ia64/Kconfig:202:    symbol IA64_HP_SIM is part of choice PM

IA64_HP_SIM is both a choice and is selected.

I did allyesconfig and disabled PCI afterwards to find all the issues
on this patchset.

> 2. there are different patterns to express the dependency on PCI e.g.
>
>   config MMC_SDHCI_ACPI
>       tristate "SDHCI support for ACPI enumerated SDHCI controllers"
>       depends on MMC_SDHCI && ACPI
> -    select IOSF_MBI if X86
> +    select IOSF_MBI if (X86 && PCI)
>
> but
>
> config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>       tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>       default ACPI
> -    depends on X86 && ACPI
> +    depends on X86 && ACPI && PCI
>       select SND_SST_IPC_ACPI
>       select SND_SST_ATOM_HIFI2_PLATFORM
>       select SND_SOC_ACPI_INTEL_MATCH
>

I matched depends line to

depends on X86 && ACPI && PCI

for MMC_SDHCI_ACPI per feedback from Rafael on V5. This should resolve
the inconsistency.


> IOSF is only needed for Baytrail-CR detection, and the code will compile
> fine without it, so maybe it'd be a better model if you used the
> following diff?
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 2fd1b61e8331..68af0ea5c96c 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -95,7 +95,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>          select SND_SST_IPC_ACPI
>          select SND_SST_ATOM_HIFI2_PLATFORM
>          select SND_SOC_ACPI_INTEL_MATCH
> -       select IOSF_MBI
> +       select IOSF_MBI if PCI
>
> 3. All the Intel machine drivers depend on X86_INTEL_LPSS which depends
> on PCI. But for Baytrail/Haswell/Broadwell we have only a dependency on
> ACPI, so we expose drivers that can be selected but fail on probe since
> there are no machine drivers. I am not sure if we want to be strict and
> only expose meaningful configurations, or allow for more compilations
> tests and corner cases?

Hopefully, v5 resolves this too with

depends on X86 && ACPI && PCI

Let me know otherwise.
