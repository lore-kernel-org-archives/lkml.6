Return-Path: <SRS0=kQMq=PK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD22C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6004D20874
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Jan 2019 22:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546466517;
	bh=HPeI2insvCD0IbQ79NwpFrl9DqIq1O81yDiPu4mor7Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=eT0pUOYcLOQ/H/n4YKph00ikbkionnPu4K0IjteWBtP5tyvkUZ1496HWikpe6VNxD
	 pv38ULKjPQgIOUw7VNSewFZ11oDi4hOfGpOGpVmViWcHffXwIbEDndqclqh5OOmhoO
	 lW8tmcPQGo8UQW5EBKTHcLvuYDYYlyNMWhjrHeu0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729219AbfABWB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Jan 2019 17:01:56 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37855 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726143AbfABWBz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Jan 2019 17:01:55 -0500
Received: by mail-ot1-f67.google.com with SMTP id 40so27900506oth.4;
        Wed, 02 Jan 2019 14:01:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VZubh1I1Z+Vo5l11siYpNXPfmvkd1NhArjp7I1rBeyo=;
        b=G7Q42w4ama3KOY7hMrB4jMluAxxPy4I2/n79Su2kdEEBkqypxl7NpDCzn5vKMpREok
         mxvBPguPyoCxHna7hv9B39H6CQKeYmVeokWIOu60upqflQF50+Tc39tOJDPc9KbxtCfc
         q5mStJPUuurD7XMS8jG8NzJTptJJkMRM1giSZjZ6okGJv1m0asxtR5P8hvFxH2x89/ML
         t0tNQc4/dC+PCd219wmRKnCGp0snmuYlsxI1eUreaVyxxo5VKhgy/p6Wo4o5hP1n+6c2
         1b14uBaOkJTOFKw7lmkBDSyPgRJKdlt9RykyNtLBpToQmlQa08KNZx0kWYbPmaAAxXhi
         Zj2Q==
X-Gm-Message-State: AJcUukd15+6txpc0JEOXlIvwx83oQbHHUavnNbimR2rdrx+28HRWfT/u
        Q0rkcc7S+xX/bx9rqUmhOE6MQFVq4n3Iru0uMeu9IwM2
X-Google-Smtp-Source: ALg8bN4JWpV9Nq+RfAVwiUbiOB14rjTJKjW5gpYkibT9phUaM0fesISO0H7pU/Gx52DMhxM8aGVkTZttXiT33ZdN97A=
X-Received: by 2002:a9d:588c:: with SMTP id x12mr32490459otg.139.1546466514619;
 Wed, 02 Jan 2019 14:01:54 -0800 (PST)
MIME-Version: 1.0
References: <20190102181038.4418-1-okaya@kernel.org> <20190102181038.4418-9-okaya@kernel.org>
 <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
In-Reply-To: <57ed1d94-7f89-20e8-3289-7ef7efd18c20@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 2 Jan 2019 23:01:43 +0100
Message-ID: <CAJZ5v0jniuqiLVnB3ufkAKY2nT4H6OJG-wWrL7GsaK5dAJ6ybA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v5 08/11] ASoC: Intel: atom: Make PCI
 dependency explicit
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Sinan Kaya <okaya@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        Takashi Iwai <tiwai@suse.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 2, 2019 at 9:33 PM Pierre-Louis Bossart
<pierre-louis.bossart@linux.intel.com> wrote:
>
> I have three opens with this ACPI/PCI change
>
> 1. the baseline change fails on my cross-compilation checks, see below
> the result of the attached script (simplification of the one I use to
> avoid 0day reports).

What baseline change?

That failure is not related to PCI if I'm not missing anything.

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

Well, does it actually make sense to ever set
SND_SST_ATOM_HIFI2_PLATFORM_ACPI without PCI?

> 3. All the Intel machine drivers depend on X86_INTEL_LPSS which depends
> on PCI. But for Baytrail/Haswell/Broadwell we have only a dependency on
> ACPI, so we expose drivers that can be selected but fail on probe since
> there are no machine drivers. I am not sure if we want to be strict and
> only expose meaningful configurations, or allow for more compilations
> tests and corner cases?

I would only expose meaningful configurations to start with and then
*maybe* relax that going forward as long as the benefit is worth it.

Cheers,
Rafael
