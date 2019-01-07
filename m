Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9109C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8CA42087F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 11:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546859880;
	bh=t3tofjRcbBOTW5fk6R0QXTDCz548rb8bzq3C7SiG6iM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=QjiFlBGnOA6xPGRYzRdY7UwFn/VO4x+2Vbj6bna6gVv39e91y4qXITWu9RA1XdcAc
	 pXGAiQOKnHf+cOukiktbLeSRfDgWlmoBiQXGymSTO7dRGnfNwZoxJ5tgyYCmDE8Kog
	 2myme5AcSDiGCcWv2ce0ve0C1+8d7+tUvYlsxkIQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbfAGLSA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 06:18:00 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:41198 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726798AbfAGLR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 06:17:57 -0500
Received: by mail-oi1-f194.google.com with SMTP id j21so35567406oii.8;
        Mon, 07 Jan 2019 03:17:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qeDrp1wPW2lFUGmC/J13G0Ydsrdk7NKKrmC0vWnc9sI=;
        b=nZoWztU2RSLEJN+ftoO01e8a5QOGX7kMeTSsg7bwyT1y7q7MPq4i8qLpvfcm6xjJaF
         nydMv0n7IvMocKhWkxcpyznlS0BYzJI3NWwHPUxQEyWBfzo1ZaRye9hwbL3nM7y9fzep
         USuPIYAWpDBu8JgQ5OERK1E+540q4M55JRzrC7duDpoOGuOAQF/F4wYcIcNKCWIddenb
         UuU48Cn7BZnOIY3kXDOTXpaVJETG1zFII7JDLUcLuK/oSkpsBwub1JeovqNgiBvXqbEM
         PNhxU5UXzgxOwpZBEYNMlR5yDNLy61ru7D9SMirtIQieldQm5vpCzTZd/w1fjTLipKNB
         CD0g==
X-Gm-Message-State: AJcUukf13jnRM1Bw3nxKv86quZTaKr+8p9qgmBfViw/Za8BtgKHijZaz
        Wev3n3a5Q1+0lBcttMjYudlpNaXYjhNjo7kqHGDHIg==
X-Google-Smtp-Source: ALg8bN7z9MaB4624BY3QN5ugYDqOLoiqGAgQPYQxtNDGu5zZz+LmpDruzJdYKS/dyPNLjZd+3xfgeTqhtbV9vGbDoQ0=
X-Received: by 2002:aca:e715:: with SMTP id e21mr24696751oih.76.1546859876104;
 Mon, 07 Jan 2019 03:17:56 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-10-okaya@kernel.org>
In-Reply-To: <20190105100606.6673-10-okaya@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jan 2019 12:17:45 +0100
Message-ID: <CAJZ5v0gXM3d0uuaQPyeafVS3S1tNbo0gY5TMskpQptNGvmVKzA@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     Linux-Next Mailing List <linux-next@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Faiz Abbas <faiz_abbas@ti.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Ludovic Barre <ludovic.barre@st.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alex Smith <alex.smith@imgtec.com>,
        Chris Brandt <chris.brandt@renesas.com>,
        "open list:MULTIMEDIA CARD (MMC), SECURE DIGITAL (SD) AND..." 
        <linux-mmc@vger.kernel.org>,
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
> specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
> on PCI. For this reason, add a direct dependency to CONFIG_PCI here.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>
> ---
>  drivers/mmc/host/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
> index e26b8145efb3..1b9401fe94c0 100644
> --- a/drivers/mmc/host/Kconfig
> +++ b/drivers/mmc/host/Kconfig
> @@ -116,7 +116,7 @@ config MMC_RICOH_MMC
>
>  config MMC_SDHCI_ACPI
>         tristate "SDHCI support for ACPI enumerated SDHCI controllers"
> -       depends on MMC_SDHCI && ACPI
> +       depends on MMC_SDHCI && ACPI && PCI
>         select IOSF_MBI if X86
>         help
>           This selects support for ACPI enumerated SDHCI controllers,
> --

Any objections against this one from anyone?
