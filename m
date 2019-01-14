Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F6D3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61CAA20659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 11:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="AyFjc9Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfANLpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 06:45:23 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43021 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbfANLpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 06:45:23 -0500
Received: by mail-vs1-f66.google.com with SMTP id x1so13390761vsc.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 03:45:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SfKdG5lSxJYjRQSxMaX6wj1ewmDr2/7r6OEuU4WHQKw=;
        b=AyFjc9LpXq3lkDCzVrJDGpGGb9gUtmx6Xn+Eh0JgNYWSR0JrhHfu/eiANxYBWD613c
         ouiremyvmZ0c2yNw4lqCxPTJkZA4q3sCb2eid7zTObDBx3lbhN+LI52RYM31T22GTuDz
         SaALdXHVnfDNDvbtMoWgykObAh9+72y0adEaI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SfKdG5lSxJYjRQSxMaX6wj1ewmDr2/7r6OEuU4WHQKw=;
        b=R+STY7b5B6mw4ONB5c6rPAQdKVSYMstq0J9Krdm+QGoYMATbf1WoM6q+s5ya6Jv9Gf
         xU4pWgKqtIMwjOI81UhGOJzV0uPELQcNMmpnJOminkrrhvsmtMcnDpRG41u+F9xV4Q2o
         Y01cKOL/S37rBEJMFoqQXv3ehlIxGxG/kM4LHQBlYXD+peG//vWvjpguxkmUQzGmFche
         4m6MJqC7C6+HQU1TSVtBsi7UzAPhd6L/MfltxaUulu6yYZMKVAc6hVvxVdXRHa1UFRYA
         M0fwD4D/GI0LQ1O0fE2QxbcruCTIQ119W7yytWFjPSmqNHf9cey5gBR5qvJa3+fc3xaR
         7Nmw==
X-Gm-Message-State: AJcUukcO399e7TIxbkbYqYcbgG9qwuyxcvM4qBMJW5BgzG0vSmGnq1MX
        mzt4XkCkL0gXEInt43tzGuTskglC7qy7+M7zEf/rKw==
X-Google-Smtp-Source: ALg8bN6GhrJhGuj48hZglZkpy7ousMgrvE7uy4/EJR24e/LTQvHItE9/I0z4XNs0xM8tPDFsIXAWhtDh6PMynGUuZ/E=
X-Received: by 2002:a67:d00f:: with SMTP id r15mr10274998vsi.191.1547466321776;
 Mon, 14 Jan 2019 03:45:21 -0800 (PST)
MIME-Version: 1.0
References: <20190105100606.6673-1-okaya@kernel.org> <20190105100606.6673-10-okaya@kernel.org>
In-Reply-To: <20190105100606.6673-10-okaya@kernel.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 14 Jan 2019 12:44:45 +0100
Message-ID: <CAPDyKFo7gQCZQbKhCaTukf8cRnRg5TzgDdOprHyeRbps=sjNWA@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] mmc: sdhci-acpi: Make PCI dependency explicit
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-next@vger.kernel.org,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
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

On Sat, 5 Jan 2019 at 11:06, Sinan Kaya <okaya@kernel.org> wrote:
>
> After 'commit 5d32a66541c4 ("PCI/ACPI: Allow ACPI to be built without
> CONFIG_PCI set")' dependencies on CONFIG_PCI that previously were
> satisfied implicitly through dependencies on CONFIG_ACPI have to be
> specified directly. This driver relies on IOSF_MBI and IOSF_MBI depends
> on PCI. For this reason, add a direct dependency to CONFIG_PCI here.
>
> Fixes: 5d32a66541c46 ("PCI/ACPI: Allow ACPI to be built without CONFIG_PCI set")
> Signed-off-by: Sinan Kaya <okaya@kernel.org>

Applied for fixes, thanks!

Kind regards
Uffe


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
> 2.19.0
>
