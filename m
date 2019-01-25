Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB5FC282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5273E218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 11:47:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=norrbonn-se.20150623.gappssmtp.com header.i=@norrbonn-se.20150623.gappssmtp.com header.b="yKYWZX9o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfAYLrU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 06:47:20 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33514 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726252AbfAYLrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 06:47:19 -0500
Received: by mail-lj1-f196.google.com with SMTP id v1-v6so8156753ljd.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jan 2019 03:47:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=norrbonn-se.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=C31nlWpUsUu8j1iiazgCD439xBD7EbLuX36kiR/KNSI=;
        b=yKYWZX9oCKoMT2Fi/l3X1JV0wUphRDT2IxMzR7Wai8+fciGvOYKSaHLAVLUOkf9i8k
         +IOenP2MM0HMxoDWO1eyDwfybr44T5xVoWm9gczZDqyEoIIP1CnhylynJ4XKtnCrUpiB
         qdl7gQMAJCjBaSpDeZPn6gzZIonSYqworKlmxx7KZmKsCeByGwFFs/mVfWgMuiVjxnb/
         UbbfZEX9yPx+2g5paDNDpQE1MtSWi26oMYcZd70vXS6MNBXzNXAB9W+C+DEeXgXdywg7
         AEwH2VrWjT++EIY1hVl84fHsJmnAcyPP4+ecljFz0dQ3XMfSWVObLt5Q/4lUV6bnDj0X
         aMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=C31nlWpUsUu8j1iiazgCD439xBD7EbLuX36kiR/KNSI=;
        b=OVB5NDDvW7Dw9gLzFidzokqSFIouwBwx/0BYmtjByvt8gJ9HqmIpM8FW29hASL40Ny
         8nQ9dIEv26T3tmQuWcaShheTawxqlQjMpN905bt/9uPIR4NuTnkhbObFls9xxjMKg6xk
         RPK0ITcLAzJnqp11+KMG/pWCBkbEJOpiGIC1BQBSPmLM/gVjJw6EVK/lJlTl9RHJv8ha
         QKhdqMPTmkE5rhAfVoLTdtmBRCfAXwK4nUbWV2xDJjohGbr6AyyeSQ/2cYoYeaIpDvVQ
         cYKCMr98mufFg6qzd7APhSTmSaCNyO02HxzHtDpo1KLNuBYUt4nC+XJPYMaOiayn8Jvy
         MWnw==
X-Gm-Message-State: AJcUukcyJURJwqSZ+YChLmzOHKmqS4N1T+R+Un/Sx9dD59ilMM/ehkqK
        gRxaVqJ4gVGkdGstCTu9VwEBwg==
X-Google-Smtp-Source: ALg8bN57MEamk9wYy/GwFOX0tGuq2r4wbYBsROXpUqSD+7w1rimZDMdBR2dqSjH9QFH/sO/BXcq4xw==
X-Received: by 2002:a2e:58b:: with SMTP id 133-v6mr8263289ljf.127.1548416837534;
        Fri, 25 Jan 2019 03:47:17 -0800 (PST)
Received: from [192.168.1.169] (h-29-16.A159.priv.bahnhof.se. [79.136.29.16])
        by smtp.gmail.com with ESMTPSA id 15-v6sm1611419lje.18.2019.01.25.03.47.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 03:47:17 -0800 (PST)
Subject: Re: [PATCH 2/2] spi-atmel: support inter-word delay
To:     linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
Cc:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        linux-arm-kernel@lists.infradead.org
References: <20190125114429.20066-1-jonas@norrbonn.se>
 <20190125114429.20066-3-jonas@norrbonn.se>
From:   Jonas Bonn <jonas@norrbonn.se>
Message-ID: <296f8326-a33d-8db1-ca71-c6aba21b1302@norrbonn.se>
Date:   Fri, 25 Jan 2019 12:47:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190125114429.20066-3-jonas@norrbonn.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25/01/2019 12:44, Jonas Bonn wrote:
> If the SPI slave requires an inter-word delay, configure the DLYBCT
> register accordingly.
> 
> Tested on a SAMA5D2 board (derived from SAMA5D2-Xplained reference
> board).
> 
> Signed-off-by: Jonas Bonn <jonas@norrbonn.se>
> CC: Nicolas Ferre <nicolas.ferre@microchip.com>
> CC: Mark Brown <broonie@kernel.org>
> CC: Alexandre Belloni <alexandre.belloni@bootlin.com>
> CC: Ludovic Desroches <ludovic.desroches@microchip.com>
> CC: linux-spi@vger.kernel.org
> CC: linux-arm-kernel@lists.infradead.org
> ---
>   drivers/spi/spi-atmel.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/spi/spi-atmel.c b/drivers/spi/spi-atmel.c
> index 74fddcd3282b..88ff3fef56e9 100644
> --- a/drivers/spi/spi-atmel.c
> +++ b/drivers/spi/spi-atmel.c
> @@ -1209,13 +1209,14 @@ static int atmel_spi_setup(struct spi_device *spi)
>   		csr |= SPI_BIT(CSAAT);
>   
>   	/* DLYBS is mostly irrelevant since we manage chipselect using GPIOs.
> -	 *
> -	 * DLYBCT would add delays between words, slowing down transfers.
> -	 * It could potentially be useful to cope with DMA bottlenecks, but
> -	 * in those cases it's probably best to just use a lower bitrate.
>   	 */
>   	csr |= SPI_BF(DLYBS, 0);
> -	csr |= SPI_BF(DLYBCT, 0);
> +
> +	/* DLYBCT adds delays between words.  This is useful for slow devices
> +	 * that need a bit of time to setup the next transfer.
> +	 */
> +	csr |= SPI_BF(DLYBCT,
> +		clamp_t(u8, (as->spi_clk/1000000*spi->word_delay)>>5, 1, 255));

Ah... this is stupid.  The clamping here _always_ introduces a delay, 
which is not what we want...  will resubmit this.

/Jonas

>   
>   	/* chipselect must have been muxed as GPIO (e.g. in board setup) */
>   	npcs_pin = (unsigned long)spi->controller_data;
> 
