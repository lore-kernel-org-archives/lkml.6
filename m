Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754854AbeDCGDA (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 02:03:00 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:30868 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754331AbeDCGC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 02:02:59 -0400
Subject: Re: [PATCH v2 1/2] spi: spi-ti-qspi: Fix parameters order in
 regmap_update_bits calls
To: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>,
        <broonie@kernel.org>
CC: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <496c162d-5e3c-e008-a14b-6b990e253e64@ti.com>
 <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
From: Vignesh R <vigneshr@ti.com>
Message-ID: <87e92c69-60bb-37b0-87d3-c4c688e94d09@ti.com>
Date: Tue, 3 Apr 2018 11:33:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1522402884-26790-1-git-send-email-arkadiusz.kwiatkowski@aptiv.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Friday 30 March 2018 03:11 PM, Arkadiusz Kwiatkowski wrote:
> This commit fixes the order of parameters passed to regmap_update_bits
> function inside spi-ti-qspi driver. Accidentally the code worked
> correctly when cs=0, but it is not the case for other values.
> 

Add:
Fixes: 4dea6c9b0b64 ("spi: spi-ti-qspi: add mmap mode read support")
before Signed-off-by

> Signed-off-by: Arkadiusz Kwiatkowski <arkadiusz.kwiatkowski@aptiv.com>
> ---

Unfortunately, your mail client is still mangling the patch and "git am"
 still fails to apply this from my inbox. Could you try using "git
send-email" to send patches? See
https://www.kernel.org/doc/Documentation/process/email-clients.rst for
more info

>  drivers/spi/spi-ti-qspi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/spi/spi-ti-qspi.c b/drivers/spi/spi-ti-qspi.c
> index c24d9b4..d0ea62d 100644
> --- a/drivers/spi/spi-ti-qspi.c
> +++ b/drivers/spi/spi-ti-qspi.c
> @@ -490,8 +490,8 @@ static void ti_qspi_enable_memory_map(struct spi_device *spi)
>         ti_qspi_write(qspi, MM_SWITCH, QSPI_SPI_SWITCH_REG);
>         if (qspi->ctrl_base) {
>                 regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
> -                                  MEM_CS_EN(spi->chip_select),
> -                                  MEM_CS_MASK);
> +                                  MEM_CS_MASK,
> +                                  MEM_CS_EN(spi->chip_select));
>         }
>         qspi->mmap_enabled = true;
>  }
> @@ -503,7 +503,7 @@ static void ti_qspi_disable_memory_map(struct spi_device *spi)
>         ti_qspi_write(qspi, 0, QSPI_SPI_SWITCH_REG);
>         if (qspi->ctrl_base)
>                 regmap_update_bits(qspi->ctrl_base, qspi->ctrl_reg,
> -                                  0, MEM_CS_MASK);
> +                                  MEM_CS_MASK, 0);
>         qspi->mmap_enabled = false;
>  }
> 
> --
> 2.7.4
> 
> **************************************************************************************** Note: If the reader of this message is not the intended recipient, or an employee or agent responsible for delivering this message to the intended recipient, you are hereby notified that any dissemination, distribution or copying of this communication is strictly prohibited. If you have received this communication in error, please notify us immediately by replying to the message and deleting it from your computer. Thank you. ****************************************************************************************
> 

-- 
Regards
Vignesh
