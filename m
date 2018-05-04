Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751755AbeEDRL3 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:11:29 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35592 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751623AbeEDRL2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:11:28 -0400
X-Google-Smtp-Source: AB8JxZqsOKWCD8dLei8IW6PSqydiKqtAaHXj6H2So5GNdcNgImYuDEIBiAZCVtsXjSOaU7mpfZ/8ow==
Subject: Re: [PATCH] mtd: spi-nor: add support for Microchip 25LC256
To: Radu Pirea <radu.pirea@microchip.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Cc: Zhiqiang.Hou@nxp.com, pp@emlix.com, richard@nod.at,
        boris.brezillon@bootlin.com, computersforpeace@gmail.com,
        dwmw2@infradead.org
References: <20180504155404.5285-1-radu.pirea@microchip.com>
From: Marek Vasut <marek.vasut@gmail.com>
Message-ID: <d0d9d950-4566-40c6-a471-0ab6e3cc9524@gmail.com>
Date: Fri, 4 May 2018 19:11:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180504155404.5285-1-radu.pirea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04/2018 05:54 PM, Radu Pirea wrote:
> Added geometry description for Microchip 25LC256 memory.

Are you sure this is a SPI NOR ? I don't see any RDID instruction in the
datasheet, only some 6 instructions to read/write the array and lock it.
Isn't the AT25 driver a better fit for this EEPROM ?

> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/mtd/devices/m25p80.c  | 3 +++
>  drivers/mtd/spi-nor/spi-nor.c | 3 +++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/mtd/devices/m25p80.c b/drivers/mtd/devices/m25p80.c
> index a4e18f6aaa33..1e359d811261 100644
> --- a/drivers/mtd/devices/m25p80.c
> +++ b/drivers/mtd/devices/m25p80.c
> @@ -372,6 +372,9 @@ static const struct spi_device_id m25p_ids[] = {
>  	{ "mr25h10" },  /*   1 Mib, 40 MHz */
>  	{ "mr25h40" },  /*   4 Mib, 40 MHz */
>  
> +	/* Microchip */
> +	{ "25lc256" },
> +
>  	{ },
>  };
>  MODULE_DEVICE_TABLE(spi, m25p_ids);
> diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
> index d445a4d3b770..6341c86be647 100644
> --- a/drivers/mtd/spi-nor/spi-nor.c
> +++ b/drivers/mtd/spi-nor/spi-nor.c
> @@ -1076,6 +1076,9 @@ static const struct flash_info spi_nor_ids[] = {
>  	{ "mx66l1g45g",  INFO(0xc2201b, 0, 64 * 1024, 2048, SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
>  	{ "mx66l1g55g",  INFO(0xc2261b, 0, 64 * 1024, 2048, SPI_NOR_QUAD_READ) },
>  
> +	/* Microchip */
> +	{ "25lc256", CAT25_INFO(32 * 1024, 1, 64, 2, SPI_NOR_NO_ERASE | SPI_NOR_NO_FR) },
> +
>  	/* Micron */
>  	{ "n25q016a",	 INFO(0x20bb15, 0, 64 * 1024,   32, SECT_4K | SPI_NOR_QUAD_READ) },
>  	{ "n25q032",	 INFO(0x20ba16, 0, 64 * 1024,   64, SPI_NOR_QUAD_READ) },
> 


-- 
Best regards,
Marek Vasut
