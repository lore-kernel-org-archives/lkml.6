Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69D33ECDE47
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307CC20840
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 18:26:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDTJsiRl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 307CC20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeKIEDd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Nov 2018 23:03:33 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34049 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbeKIEDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Nov 2018 23:03:33 -0500
Received: by mail-lf1-f65.google.com with SMTP id p6so7889678lfc.1;
        Thu, 08 Nov 2018 10:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Zo+y8DSdvQLEMG/yAjI8dPMT3MY5hGIc0wN47/K+rWU=;
        b=VDTJsiRlOEiGHfwoJHWQtrzXWsZXtXVdL28Md9Vs+8yuIzcFjlYaoFxPZwS8iO2nu4
         B5cadpxu8U6HKBxMAACIX/O2sJxmwoiJy9UXhRUYbq9elMriBeCbR6tBUvGozynkBeG/
         1TVa4ZcJiWXsMBSxIHeZ7GwenKLxvUz7oyoXQ4Q9VB7BmfnxOcgrC3MmMCcde740bmj1
         C3i/+lGR2bOrpIyvD4Z6gxwDO7zzXo1/Ce040DYxdLtzhZAYdOpeF+MB7jK4xbukln7S
         WabTeEpO1ypkXmN8W4PcpvKdeA77tystMdk+TaGd99QDljjzvOoWzXE8MEHQJHECwoUH
         Yjgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Zo+y8DSdvQLEMG/yAjI8dPMT3MY5hGIc0wN47/K+rWU=;
        b=tECW6lCqSCwmrUM+ppvHWhW7ibvHSTlvBIJU/FfcQ7vsSjv/PoaTAFXMhel0RfgIRJ
         Lz1s6JWngC2ZGyQ8WvrZnxqynOSYIQnkwwpwMNveP9qenwAlvvj9OjGPcKgptYaleggj
         RlJvLGNFisHMC71A1/WwuH6/Hpozb/S+NIm2mV0WlP5AKVhRccRbrxb70qyNpsg5g8TK
         vIZ9XPsIDcxoTL/oOL40KPyIgK7DIze40kODFY2dVPk2Vq/y/AfnoohmkC0yNTaiumIJ
         W3ZwU7n8XDSpsrxr6kaUPMMDhIGHaI07zDqya8loIw3Amv4f/zKCK8ezjEekZdv5xuLQ
         R75Q==
X-Gm-Message-State: AGRZ1gJmb3pLYx8BhLjAvZeQwAciRm0tY9vk0F/oavvv6KldDJCgH/iR
        D+Chv+LHdmC8u9muz3fZ/Ko=
X-Google-Smtp-Source: AJdET5dIBGQdMW3luzjB7Qck0mD4E9CqCxySc2r7DgljHt8tRgEKhcR402CgUUq4bZ8s6tvvLfnYTg==
X-Received: by 2002:a19:c650:: with SMTP id w77mr3496468lff.56.1541701606237;
        Thu, 08 Nov 2018 10:26:46 -0800 (PST)
Received: from [11.0.0.2] (89-70-226-70.dynamic.chello.pl. [89.70.226.70])
        by smtp.gmail.com with ESMTPSA id u65sm873470lff.54.2018.11.08.10.26.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Nov 2018 10:26:45 -0800 (PST)
Subject: Re: [PATCH v2 1/2] staging: iio: ad7780: check if ad778x before gain
 update
To:     Giuliano Belinassi <giuliano.belinassi@gmail.com>, lars@metafoo.de,
        Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org, renatogeh@gmail.com
Cc:     linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, kernel-usp@googlegroups.com
References: <cover.1541681371.git.giuliano.belinassi@usp.br>
 <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
From:   Tomasz Duszynski <tduszyns@gmail.com>
Message-ID: <55b5de74-a607-94b9-8c85-40658e38fbb5@gmail.com>
Date:   Thu, 8 Nov 2018 19:26:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <762e851dd819f27e3955cb695cd8422d84a19438.1541681371.git.giuliano.belinassi@usp.br>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Giuliano,

Comment inline.

On 11/8/18 2:03 PM, Giuliano Belinassi wrote:
> Only the ad778x have the 'gain' status bit. Check it before updating
> through a new variable is_ad778x in chip_info.
>
> Signed-off-by: Giuliano Belinassi <giuliano.belinassi@usp.br>
> ---
> Changes in v2:
> 	- Squashed is_ad778x declaration commit with the ad778x checkage
> 	- Changed is_ad778x type to bool
>  
>  drivers/staging/iio/adc/ad7780.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/ad7780.c b/drivers/staging/iio/adc/ad7780.c
> index 91e016d534ed..9ec2b002539e 100644
> --- a/drivers/staging/iio/adc/ad7780.c
> +++ b/drivers/staging/iio/adc/ad7780.c
> @@ -35,6 +35,7 @@ struct ad7780_chip_info {
>  	struct iio_chan_spec	channel;
>  	unsigned int		pattern_mask;
>  	unsigned int		pattern;
> +	bool			is_ad778x;
>  };
>  
>  struct ad7780_state {
> @@ -113,10 +114,12 @@ static int ad7780_postprocess_sample(struct ad_sigma_delta *sigma_delta,
>  	    ((raw_sample & chip_info->pattern_mask) != chip_info->pattern))
>  		return -EIO;
>  
> -	if (raw_sample & AD7780_GAIN)
> -		st->gain = 1;
> -	else
> -		st->gain = 128;
> +	if (chip_info->is_ad778x) {
> +		if (raw_sample & AD7780_GAIN)
> +			st->gain = 1;
> +		else
> +			st->gain = 128;
> +	}

Just some random though. Instead of introducing extra level of indentation you
can simply check whether is_ad778x is asserted and simply return.

>  
>  	return 0;
>  }
> @@ -135,21 +138,25 @@ static const struct ad7780_chip_info ad7780_chip_info_tbl[] = {
>  		.channel = AD7780_CHANNEL(12, 24),
>  		.pattern = 0x5,
>  		.pattern_mask = 0x7,
> +		.is_ad778x = false,

Any reason for setting this explicitly? That's going to be false anyway.

>  	},
>  	[ID_AD7171] = {
>  		.channel = AD7780_CHANNEL(16, 24),
>  		.pattern = 0x5,
>  		.pattern_mask = 0x7,
> +		.is_ad778x = false,
>  	},
>  	[ID_AD7780] = {
>  		.channel = AD7780_CHANNEL(24, 32),
>  		.pattern = 0x1,
>  		.pattern_mask = 0x3,
> +		.is_ad778x = true,
>  	},
>  	[ID_AD7781] = {
>  		.channel = AD7780_CHANNEL(20, 32),
>  		.pattern = 0x1,
>  		.pattern_mask = 0x3,
> +		.is_ad778x = true,
>  	},
>  };
>  

