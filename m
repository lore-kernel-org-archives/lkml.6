Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967223AbeBNKiQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 05:38:16 -0500
Received: from mail-it0-f68.google.com ([209.85.214.68]:55414 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967105AbeBNKiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 05:38:14 -0500
X-Google-Smtp-Source: AH8x227kXDLt9zTHRW9rzzXkxKd3Fytq+d9WwZZRKbLGEQXPUjYkV6sFxf365riNSdCV6Qdz/amN8SLjgmsAryqdrl4=
MIME-Version: 1.0
In-Reply-To: <20180205125029.21570-1-kishon@ti.com>
References: <20180205125029.21570-1-kishon@ti.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 14 Feb 2018 11:38:13 +0100
Message-ID: <CAPDyKFrh5-p4hDtG5eSbU4rX4+q4ZMsW1APOKSZh=wAASmoQKg@mail.gmail.com>
Subject: Re: [PATCH v2 00/16] mmc: sdhci-omap: Add UHS/HS200 mode support
To: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Tony Lindgren <tony@atomide.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-omap <linux-omap@vger.kernel.org>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 February 2018 at 13:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
> Add UHS/HS200 mode support in sdhci-omap. The programming sequence
> for voltage switching, tuning is followed from AM572x TRM
> http://www.ti.com/lit/ug/spruhz6i/spruhz6i.pdf
> (Similar to all AM57x/DRA7x SoCs). The patch series also implements
> workaround for errata published in
> http://www.ti.com/lit/er/sprz429k/sprz429k.pdf.
>
> It also includes a pdata-quirk patch since both pdata-quirks and
> sdhci-omap uses struct sdhci_omap_platform_data.
>
> The dt patches enabling UHS/HS200 will follow this series.
>
> Changes from v1:
> *) Only poll on DAT0 and DATI for card_busy status
> *) Cleanup iodelay patch as suggested by Tony.
> *) Added quirk to disable HW timeout
> *) Use the existing data timer but program a relatively accurate
>    SW timeout value (Impacts all platforms)
> *) Fix a bug in sdhci which was using data_timer for non data line
>    commands
>
> I've tested on dra72-evm, dra7xx-evm, dra71-evm, am572x-idk, am571x-idk
> dra76-evm, am57xx-evm and k2g-evm.
>
> I've also pushed the series (along with dt) to
> https://github.com/kishon/linux-wip.git sdhci_uhs_v2
>
> Kishon Vijay Abraham I (16):
>   mmc: sdhci-omap: Update 'power_mode' outside sdhci_omap_init_74_clocks
>   mmc: sdhci-omap: Add card_busy host ops
>   mmc: sdhci-omap: Add custom set_uhs_signaling sdhci_host ops
>   mmc: sdhci-omap: Add tuning support
>   mmc: sdhci-omap: Workaround for Errata i802
>   mmc: sdhci_omap: Add support to set IODELAY values
>   mmc: sdhci_omap: Fix sdhci-omap quirks
>   mmc: sdhci-omap: Add support to override f_max and iodelay from pdata
>   mmc: sdhci: Add quirk to disable HW timeout
>   mmc: sdhci: Fix to use data_timer only for data line commands
>   mmc: sdhci: Program a relatively accurate SW timeout value
>   mmc: sdhci-omap: Workaround for Errata i834
>   dt-bindings: sdhci-omap: Add K2G specific binding
>   mmc: sdhci-omap: Add support for MMC/SD controller in k2g SoC
>   mmc: sdhci-omap: Add SPDX identifier
>   ARM: OMAP2+: Use sdhci-omap specific pdata-quirks for MMC/SD on DRA74x
>     EVM
>
>  .../devicetree/bindings/mmc/sdhci-omap.txt         |   2 +
>  arch/arm/mach-omap2/pdata-quirks.c                 |  34 +-
>  drivers/mmc/host/sdhci-omap.c                      | 430 +++++++++++++++++++--
>  drivers/mmc/host/sdhci.c                           |  62 ++-
>  drivers/mmc/host/sdhci.h                           |  17 +
>  include/linux/platform_data/sdhci-omap.h           |  22 ++
>  6 files changed, 518 insertions(+), 49 deletions(-)
>  create mode 100644 include/linux/platform_data/sdhci-omap.h
>
> --
> 2.11.0
>

To move forward and while waiting for Adrian to come back, I have
applied patch 1 -> 7 for next.

Thanks and kind regards
Uffe
