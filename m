Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752021AbeDDMp3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 08:45:29 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:36267 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751534AbeDDMpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 08:45:25 -0400
X-Google-Smtp-Source: AIpwx4/GUehitLpM0OWJsmKKA756gfgbXCBCoe8hvvM4r6JE/wluQCBm0vaJjg9FL/3tHGYVo+Rs+u36RF9kmGDE3T0=
MIME-Version: 1.0
In-Reply-To: <1520951200-24703-1-git-send-email-phil.edworthy@renesas.com>
References: <1520951200-24703-1-git-send-email-phil.edworthy@renesas.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 4 Apr 2018 14:45:23 +0200
Message-ID: <CAPDyKFqFnPosPTb2x5=aeXjGqAJBDgKBCV9pJRfkREecChyJ9w@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-of-arasan: Add quirk to avoid unexpected
 interrupt msgs
To: Phil Edworthy <phil.edworthy@renesas.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Michal Simek <michal.simek@xilinx.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michel Pollet <michel.pollet@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 March 2018 at 15:26, Phil Edworthy <phil.edworthy@renesas.com> wrote:
> On SD 2.00 cards we get lots of these messages:
> "mmc0: Got data interrupt 0x00000002 even though no data operation was in progress"
> By applying the SDHCI_QUIRK2_STOP_WITH_TC quirk, the messages no longer happen.
>
> A single card claiming to be SD 3.00 compliant also generates the interrupts,
> but since the card's manfacturing date is 2002 mar, it's unlikely to really be
> SD 3.00. This card is a 8GB SanDisk 'SU08G' 8.0 (SDHC class 4).
>
> This has been reported on Xilinx devices that also use the Arasan IP.
> See https://patchwork.kernel.org/patch/8062871/
>
> This has been tested on the Renesas RZ/ND-DB board with the RZ/N1 SoC. The
> Arasan IP in this device is version 1.39a and uses a max SD clock of 50MHz and
> does not support DDR modes.
>
> Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>

Queued for 3.18, thanks!

Kind regards
Uffe

> ---
> v2:
>  - Changed commit msg to detail the cards that fail.
>  - Provided the IP version and further background info.
> ---
>  drivers/mmc/host/sdhci-of-arasan.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/host/sdhci-of-arasan.c b/drivers/mmc/host/sdhci-of-arasan.c
> index c33a5f7..ab66e32 100644
> --- a/drivers/mmc/host/sdhci-of-arasan.c
> +++ b/drivers/mmc/host/sdhci-of-arasan.c
> @@ -290,7 +290,8 @@ static const struct sdhci_pltfm_data sdhci_arasan_pdata = {
>         .ops = &sdhci_arasan_ops,
>         .quirks = SDHCI_QUIRK_CAP_CLOCK_BASE_BROKEN,
>         .quirks2 = SDHCI_QUIRK2_PRESET_VALUE_BROKEN |
> -                       SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN,
> +                       SDHCI_QUIRK2_CLOCK_DIV_ZERO_BROKEN |
> +                       SDHCI_QUIRK2_STOP_WITH_TC,
>  };
>
>  static u32 sdhci_arasan_cqhci_irq(struct sdhci_host *host, u32 intmask)
> --
> 2.7.4
>
