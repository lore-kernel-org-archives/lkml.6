Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751532AbeCOKWr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 06:22:47 -0400
Received: from mail-it0-f68.google.com ([209.85.214.68]:55142 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751595AbeCOKWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 06:22:43 -0400
X-Google-Smtp-Source: AG47ELsITE7f3dYToYmv2svVVh5DopitqkmCmudhelYcSaEzsKYn+Ec4hSDctEAmZTaZQ6oahBu9cJd1H6A22gGBmu4=
MIME-Version: 1.0
In-Reply-To: <20180223064138.18401-2-jh80.chung@samsung.com>
References: <CGME20180223064140epcas2p41a734737c3fe7373329a94f485c21fd4@epcas2p4.samsung.com>
 <20180223064138.18401-1-jh80.chung@samsung.com> <20180223064138.18401-2-jh80.chung@samsung.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 15 Mar 2018 11:22:41 +0100
Message-ID: <CAPDyKFrkDPfff1KD53HVTevGwCvdJGBRo6_z4NRmLcGC7qHhfw@mail.gmail.com>
Subject: Re: [PATCH 2/6] mmc: dw_mmc: remove the deprecated "num-slots"
To: Jaehoon Chung <jh80.chung@samsung.com>
Cc: "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Joachim Eastwood <manabian@gmail.com>, dinguyen@kernel.org,
        Will Deacon <will.deacon@arm.com>, Wei Xu <xuwei5@hisilicon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 February 2018 at 07:41, Jaehoon Chung <jh80.chung@samsung.com> wrote:
> 'num-slots' property had already deprecated.
> Remove the 'nom-slots' property that is kept to maintain the compatibility.
>
> Signed-off-by: Jaehoon Chung <jh80.chung@samsung.com>

Thanks, applied for next!

Kind regards
Uffe

> ---
>  Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt | 5 -----
>  drivers/mmc/host/dw_mmc-pci.c                              | 1 -
>  drivers/mmc/host/dw_mmc.c                                  | 4 ----
>  drivers/mmc/host/dw_mmc.h                                  | 3 ---
>  4 files changed, 13 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> index 75c9fdca4aaf..7e5e427a22ce 100644
> --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> @@ -59,11 +59,6 @@ Optional properties:
>    is specified and the ciu clock is specified then we'll try to set the ciu
>    clock to this at probe time.
>
> -* num-slots (DEPRECATED): specifies the number of slots supported by the controller.
> -  The number of physical slots actually used could be equal or less than the
> -  value specified by num-slots. If this property is not specified, the value
> -  of num-slot property is assumed to be 1.
> -
>  * fifo-depth: The maximum size of the tx/rx fifo's. If this property is not
>    specified, the default value of the fifo size is determined from the
>    controller registers.
> diff --git a/drivers/mmc/host/dw_mmc-pci.c b/drivers/mmc/host/dw_mmc-pci.c
> index ab8713297edb..3ad07d7b2c97 100644
> --- a/drivers/mmc/host/dw_mmc-pci.c
> +++ b/drivers/mmc/host/dw_mmc-pci.c
> @@ -29,7 +29,6 @@
>                                 MMC_CAP_SDIO_IRQ)
>
>  static struct dw_mci_board pci_board_data = {
> -       .num_slots                      = 1,
>         .caps                           = DW_MCI_CAPABILITIES,
>         .bus_hz                         = 33 * 1000 * 1000,
>         .detect_delay_ms                = 200,
> diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> index 38e0e7c4ffd9..a63ca7bc1099 100644
> --- a/drivers/mmc/host/dw_mmc.c
> +++ b/drivers/mmc/host/dw_mmc.c
> @@ -3124,10 +3124,6 @@ static struct dw_mci_board *dw_mci_parse_dt(struct dw_mci *host)
>                         return ERR_PTR(-EPROBE_DEFER);
>         }
>
> -       /* find out number of slots supported */
> -       if (!device_property_read_u32(dev, "num-slots", &pdata->num_slots))
> -               dev_info(dev, "'num-slots' was deprecated.\n");
> -
>         if (device_property_read_u32(dev, "fifo-depth", &pdata->fifo_depth))
>                 dev_info(dev,
>                          "fifo-depth property not found, using value of FIFOTH register as default\n");
> diff --git a/drivers/mmc/host/dw_mmc.h b/drivers/mmc/host/dw_mmc.h
> index e3124f06a47e..80ff9a6c6fdd 100644
> --- a/drivers/mmc/host/dw_mmc.h
> +++ b/drivers/mmc/host/dw_mmc.h
> @@ -102,7 +102,6 @@ struct dw_mci_dma_slave {
>   * @bus_hz: The rate of @mck in Hz. This forms the basis for MMC bus
>   *     rate and timeout calculations.
>   * @current_speed: Configured rate of the controller.
> - * @num_slots: Number of slots available.
>   * @fifoth_val: The value of FIFOTH register.
>   * @verid: Denote Version ID.
>   * @dev: Device associated with the MMC controller.
> @@ -253,8 +252,6 @@ struct dma_pdata;
>
>  /* Board platform data */
>  struct dw_mci_board {
> -       u32 num_slots;
> -
>         unsigned int bus_hz; /* Clock speed at the cclk_in pad */
>
>         u32 caps;       /* Capabilities */
> --
> 2.15.1
>
