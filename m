Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeFEVlr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 17:41:47 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36874 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752025AbeFEVlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 17:41:45 -0400
X-Google-Smtp-Source: ADUXVKIh0QbC7FydS9UOeMqQOcXlCZPPloZDODxX555af56ErQVvghSlz+PQfz9hB27utJZiU0EhSw==
Subject: Re: [PATCH 1/1] net: dsa: b53: Fix for brcm tag issue in Cygnus SoC
To: Arun Parameswaran <arun.parameswaran@broadcom.com>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>
References: <1528231092-31472-1-git-send-email-arun.parameswaran@broadcom.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <c51cf072-beeb-6630-e260-24c585d29aae@gmail.com>
Date: Tue, 5 Jun 2018 14:41:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <1528231092-31472-1-git-send-email-arun.parameswaran@broadcom.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/05/2018 01:38 PM, Arun Parameswaran wrote:
> In the Broadcom Cygnus SoC, the brcm tag needs to be inserted
> in between the mac address and the ether type (should use
> 'DSA_PROTO_TAG_BRCM') for the packets sent to the internal
> b53 switch.
> 
> Since the Cygnus was added with the BCM58XX device id and the
> BCM58XX uses 'DSA_PROTO_TAG_BRCM_PREPEND', the data path is
> broken, due to the incorrect brcm tag location.
> 
> Add a new b53 device id (BCM583XX) for Cygnus family to fix the
> issue. Add the new device id to the BCM58XX family as Cygnus
> is similar to the BCM58XX in most other functionalities.
> 
> Fixes: 11606039604c ("net: dsa: b53: Support prepended Broadcom tags")
> 
> Signed-off-by: Arun Parameswaran <arun.parameswaran@broadcom.com>

Clement originally reported this to me/us:

Reported-by: Clément Péron <peron.clem@gmail.com>

I completely overlooked that when adding support for prepended Broadcom
tags, thanks for the fix Arun!

Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>

David, can you also queue this up for -stable? Thank you

> ---
>  drivers/net/dsa/b53/b53_common.c | 15 ++++++++++++++-
>  drivers/net/dsa/b53/b53_priv.h   |  2 ++
>  drivers/net/dsa/b53/b53_srab.c   |  4 ++--
>  3 files changed, 18 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index 3da5fca..bbc6cc6 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -684,7 +684,8 @@ static int b53_switch_reset(struct b53_device *dev)
>  	 * still use this driver as a library and need to perform the reset
>  	 * earlier.
>  	 */
> -	if (dev->chip_id == BCM58XX_DEVICE_ID) {
> +	if (dev->chip_id == BCM58XX_DEVICE_ID ||
> +	    dev->chip_id == BCM583XX_DEVICE_ID) {
>  		b53_read8(dev, B53_CTRL_PAGE, B53_SOFTRESET, &reg);
>  		reg |= SW_RST | EN_SW_RST | EN_CH_RST;
>  		b53_write8(dev, B53_CTRL_PAGE, B53_SOFTRESET, reg);
> @@ -1880,6 +1881,18 @@ struct b53_chip_data {
>  		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
>  	},
>  	{
> +		.chip_id = BCM583XX_DEVICE_ID,
> +		.dev_name = "BCM583xx/11360",
> +		.vlans = 4096,
> +		.enabled_ports = 0x103,
> +		.arl_entries = 4,
> +		.cpu_port = B53_CPU_PORT,
> +		.vta_regs = B53_VTA_REGS,
> +		.duplex_reg = B53_DUPLEX_STAT_GE,
> +		.jumbo_pm_reg = B53_JUMBO_PORT_MASK,
> +		.jumbo_size_reg = B53_JUMBO_MAX_SIZE,
> +	},
> +	{
>  		.chip_id = BCM7445_DEVICE_ID,
>  		.dev_name = "BCM7445",
>  		.vlans	= 4096,
> diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
> index 3b57f47..b232aaa 100644
> --- a/drivers/net/dsa/b53/b53_priv.h
> +++ b/drivers/net/dsa/b53/b53_priv.h
> @@ -62,6 +62,7 @@ enum {
>  	BCM53018_DEVICE_ID = 0x53018,
>  	BCM53019_DEVICE_ID = 0x53019,
>  	BCM58XX_DEVICE_ID = 0x5800,
> +	BCM583XX_DEVICE_ID = 0x58300,
>  	BCM7445_DEVICE_ID = 0x7445,
>  	BCM7278_DEVICE_ID = 0x7278,
>  };
> @@ -181,6 +182,7 @@ static inline int is5301x(struct b53_device *dev)
>  static inline int is58xx(struct b53_device *dev)
>  {
>  	return dev->chip_id == BCM58XX_DEVICE_ID ||
> +		dev->chip_id == BCM583XX_DEVICE_ID ||
>  		dev->chip_id == BCM7445_DEVICE_ID ||
>  		dev->chip_id == BCM7278_DEVICE_ID;
>  }
> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
> index c37ffd1..8247481 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c
> @@ -364,7 +364,7 @@ static int b53_srab_write64(struct b53_device *dev, u8 page, u8 reg,
>  	{ .compatible = "brcm,bcm53018-srab" },
>  	{ .compatible = "brcm,bcm53019-srab" },
>  	{ .compatible = "brcm,bcm5301x-srab" },
> -	{ .compatible = "brcm,bcm11360-srab", .data = (void *)BCM58XX_DEVICE_ID },
> +	{ .compatible = "brcm,bcm11360-srab", .data = (void *)BCM583XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm58522-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm58525-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm58535-srab", .data = (void *)BCM58XX_DEVICE_ID },
> @@ -372,7 +372,7 @@ static int b53_srab_write64(struct b53_device *dev, u8 page, u8 reg,
>  	{ .compatible = "brcm,bcm58623-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm58625-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ .compatible = "brcm,bcm88312-srab", .data = (void *)BCM58XX_DEVICE_ID },
> -	{ .compatible = "brcm,cygnus-srab", .data = (void *)BCM58XX_DEVICE_ID },
> +	{ .compatible = "brcm,cygnus-srab", .data = (void *)BCM583XX_DEVICE_ID },
>  	{ .compatible = "brcm,nsp-srab", .data = (void *)BCM58XX_DEVICE_ID },
>  	{ /* sentinel */ },
>  };
> 


-- 
Florian
