Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A8E9C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:15:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4538720859
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:15:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546859748;
	bh=kTPT3kn/zChx/q71SBbBpHN3d33CrAsyDX7qSQsyPPc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ZIqH+R5fhWdnB2cIbpY2s6GSFifrCXQfhT3FoHgjKJNQBoiZHfPc/By4UGgR6m8TF
	 SO/SpQiS/GcyQqRHmCEEytx/Gs6HiIY0WQzb53LuqDWEl571dcTkK4uvD0HPD3z8lv
	 LW+W8WzGeXLrE7fNncvm95fFjJ4EwU8irAsX0Lno=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbfAGLPr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:15:47 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:37945 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfAGLPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:15:47 -0500
Received: by mail-oi1-f195.google.com with SMTP id a77so35559482oii.5;
        Mon, 07 Jan 2019 03:15:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8vuU/QkgnzmMdOsMipKPEn0MeBUlYH0FAsCjmO/A+RU=;
        b=WoJ2ARdGGCIOrMX0dAdxnsSNRlMZw7SR/8FqWvAnhDdafzzfdC6iw27AVUEfIO1EgQ
         lgEy0oCZjAcm381Ceu5hHblRmyVX8BJ/ZTLRv08f3r7A6r1z/20QRiOvL4JJ5rJRzRMi
         SzN3y7roPDQnEiZovsxz9ryR0RJpESLXNm+WUPCXIqiaDqqB4eiYt8jWseKK0VsyGo4Z
         +HmnkcSt5/eK6IjAfHG2c3FLlHnJ2+zEsiBAk7sI+AoA1T/UWH0kX3pcbHQvxqE5Tcop
         8AlJHRh9UmV5YrkvuJBayYh/6iMA1o3jkjMnxIliVNJF7/hTl2ZiE/W1mUQRvoEx8Xgj
         puAg==
X-Gm-Message-State: AJcUukfHwzjOpGdM9UiC5gjH02An9Gd44z0tkyGAU5QRZbv9QT2JUb3C
        v5BpA+hx9NrWp7iuh/BXoinMYIOYlyrpNp7bFzA=
X-Google-Smtp-Source: ALg8bN6TXNtpBvAkSNNjB+5nYnfzyL3FJW/WifMadGdvJutosd/uTBoiWkJu5v0ewo3rglyRPOxug5rFes60mOQI4vw=
X-Received: by 2002:a54:4d01:: with SMTP id v1mr7412377oix.246.1546859746321;
 Mon, 07 Jan 2019 03:15:46 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-9-okaya@kernel.org>
In-Reply-To: <20190105100606.6673-9-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 12:15:35 +0100
Message-ID: <CAJZ5v0g2bjzjuiDPTbBN8QgvOG0KMC0Ew2QOQH4u2+y6KRo0wQ@mail.gmail.com>
Subject: Re: [PATCH v6 08/11] ASoC: Intel: atom: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>, Mark Brown <broonie@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "moderated list:INTEL ASoC DRIVERS" <alsa-devel@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 5, 2019 at 11:06 AM Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. This code relies on IOSF_MBI and IOSF_MBI depends
> on PCI. For this reason, add a direct dependency on CONFIG_PCI to the
> IOSF_MBI driver.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Sinan, I thought you received an ACK from Pierre-Louis on this one, didn't you?

> ---
>  sound/soc/intel/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/sound/soc/intel/Kconfig b/sound/soc/intel/Kconfig
> index 99a62ba409df..bd9fd2035c55 100644
> --- a/sound/soc/intel/Kconfig
> +++ b/sound/soc/intel/Kconfig
> @@ -91,7 +91,7 @@ config SND_SST_ATOM_HIFI2_PLATFORM_PCI
>  config SND_SST_ATOM_HIFI2_PLATFORM_ACPI
>         tristate "ACPI HiFi2 (Baytrail, Cherrytrail) Platforms"
>         default ACPI
> -       depends on X86 && ACPI
> +       depends on X86 && ACPI && PCI
>         select SND_SST_IPC_ACPI
>         select SND_SST_ATOM_HIFI2_PLATFORM
>         select SND_SOC_ACPI_INTEL_MATCH
> --

Mark, assuming that the ACK above was given here, do you want me to
take this patch or do you want to take care of it yourself?
