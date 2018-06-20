Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C6CCC1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0569020846
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:50:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0569020846
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=geanix.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933190AbeFTIud (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:50:33 -0400
Received: from mail.hundeboll.net ([88.198.92.70]:47866 "EHLO
        mail.hundeboll.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932850AbeFTIu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:50:29 -0400
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Jun 2018 04:50:27 EDT
Received: from [10.0.0.161] (unknown [85.184.147.232])
        by mail.hundeboll.net (Postfix) with ESMTPSA id 2D6A01C08CB;
        Wed, 20 Jun 2018 10:40:41 +0200 (CEST)
Subject: Re: [PATCH 01/12] spi: spi-fsl-dspi: Drop unreachable else if
 statement
To:     Esben Haabendal <esben.haabendal@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org
Cc:     Kurt Kanzenbach <kurt@linutronix.de>,
        Angelo Dureghello <angelo@sysam.it>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Yuan Yao <yao.yuan@nxp.com>, linux-kernel@vger.kernel.org,
        Esben Haabendal <eha@deif.com>
References: <20180620073442.20913-1-esben.haabendal@gmail.com>
 <20180620073442.20913-2-esben.haabendal@gmail.com>
From:   =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <martin@geanix.com>
Message-ID: <84f8dca3-d1af-5190-270b-5f5319ae4987@geanix.com>
Date:   Wed, 20 Jun 2018 10:40:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180620073442.20913-2-esben.haabendal@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018-06-20 09:34, Esben Haabendal wrote:
> From: Esben Haabendal <eha@deif.com>
> 
> The if statement just above this if/else statement triggers on the same
> condition, and then invalidates it.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>
> Cc: Martin Hundebøll <martin@geanix.com>

For the entire series:
Acked-by: Martin Hundebøll <martin@geanix.com>

> ---
>   drivers/spi/spi-fsl-dspi.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/spi/spi-fsl-dspi.c b/drivers/spi/spi-fsl-dspi.c
> index 0630962ce442..3ca9b9608801 100644
> --- a/drivers/spi/spi-fsl-dspi.c
> +++ b/drivers/spi/spi-fsl-dspi.c
> @@ -593,8 +593,7 @@ static int dspi_eoq_write(struct fsl_dspi *dspi)
>   			dspi_pushr |= SPI_PUSHR_EOQ;
>   			if ((dspi->cs_change) && (!dspi->len))
>   				dspi_pushr &= ~SPI_PUSHR_CONT;
> -		} else if (tx_word && (dspi->len == 1))
> -			dspi_pushr |= SPI_PUSHR_EOQ;
> +		}
>   
>   		regmap_write(dspi->regmap, SPI_PUSHR, dspi_pushr);
>   
> 

-- 
Kind regards,
Martin Hundebøll
Embedded Linux Consultant

+45 61 65 54 61
martin@geanix.com

Geanix IVS
DK39600706
