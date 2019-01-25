Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C088C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFBF8218CD
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 04:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noxPPGM9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbfAYEag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 23:30:36 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:36073 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbfAYEaf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 23:30:35 -0500
Received: by mail-yw1-f68.google.com with SMTP id i73so3416668ywg.3;
        Thu, 24 Jan 2019 20:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HyX/aw5NyT6H0MdYC4RYsIJg2sU71AJwhOqZBljavi0=;
        b=noxPPGM9kHmC9LX3ocPlzqTh4rwuZDgjRZKeaN9pjLrHZyWBeh5SImQZ3K5i0sLofJ
         Mzm9Q7MT1404e+KVsvHluAmgyrK+C0TaIzXR+s5GAZYLmVGxJxa8WVpiIx8h3llCU+O/
         /1hi7kp1rtkHQkVdIAOSOifcVEBKCg1cHt3n/65B1aaPYp5hZ9hByixy7/1HlbqZsnQb
         hrWicTahvp5EcFTU8poEVLa2m2rpJVTuS65Vu4PC+r84ioZRiup15ozqcVCRb1w6Jqo3
         wblmyA3PEoxUGbkxmSbVeubdwh3tO6jSWdka7j8cQNqJsSC4jbleLUcWhKya8/Vymmxl
         JK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HyX/aw5NyT6H0MdYC4RYsIJg2sU71AJwhOqZBljavi0=;
        b=EXXSDdHnt15nJh018jWkbjXyAypSv3fb+l/N1BFCYun7o/KbSNmnMxYS3NAKssvqAT
         /kLZ7NWCf/1mj+5Mph+FnWddIWfe4tHvxa5UzNZOCrOYyQ2yGPr6U4MDUcCZLjmKXZWu
         feeU6fMjAYP3ETaRmALjbCno/Pfv8CkXiC8Q3z4bUb2Ds8qmIMwJiZKA9E9xOkkC0+6A
         RFmClhz+7XMeRSKxwmYpHxhy4DjqRfspUYrHDPxon5CcY9u/tzpi3F2x52KSIVwrYExg
         BVwwHcj/enGmZOuT8EARlRePyr6xger/PPl0fMkm0BQSZteP4DxQsonhPCYhEqPmTW8x
         WNTA==
X-Gm-Message-State: AJcUukeekQbY6OY35aLJBBE+ejn4jlmb5/AWVfizeQI39bPKD0vLXYG/
        LkaskBQxZ28wYZ/xMbYePE+c7brW
X-Google-Smtp-Source: ALg8bN5k153XLhm35LZSNiNWUuUui1gGh3VhVeIBjejBA3Ya75K66TqVnAvcJ3S44WTUfj/ujzJCzQ==
X-Received: by 2002:a81:ad64:: with SMTP id l36mr9478284ywk.114.1548390633874;
        Thu, 24 Jan 2019 20:30:33 -0800 (PST)
Received: from [10.10.116.193] ([192.19.218.250])
        by smtp.gmail.com with ESMTPSA id j12sm11872726ywk.43.2019.01.24.20.30.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Jan 2019 20:30:33 -0800 (PST)
Subject: Re: [PATCH] iio: adc: ti-ads7950: inconsistency with spi msg
To:     justinpopo6@gmail.com, linux-iio@vger.kernel.org
Cc:     jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        linux-kernel@vger.kernel.org
References: <1548381414-20561-1-git-send-email-justinpopo6@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <ac0a8ff6-92f5-09ef-932b-aba6378f1f47@gmail.com>
Date:   Thu, 24 Jan 2019 20:30:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1548381414-20561-1-git-send-email-justinpopo6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Justin,

On 1/24/19 5:56 PM, justinpopo6@gmail.com wrote:
> From: Justin Chen <justinpopo6@gmail.com>
> 
> To read a channel we require 3 cycles to send, process, and receive
> the data. The transfer buffer for the third transaction is left blank.
> This leaves it up to the SPI driver to decide what to do.
> 
> In one particular case, if the tx buffer is not set the spi driver
> sets it to 0xff. This puts the ADC in a alarm programming state,
> therefore the following read to a channel becomes erroneous.
> 
> Instead of leaving us to the mercy of the SPI driver, we send the
> ADC cmd on the third transaction to prevent inconsistent behavior.

Do you think this warrants a Fixes: tag?

> 
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/iio/adc/ti-ads7950.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/ti-ads7950.c b/drivers/iio/adc/ti-ads7950.c
> index 0ad6359..5453e10 100644
> --- a/drivers/iio/adc/ti-ads7950.c
> +++ b/drivers/iio/adc/ti-ads7950.c
> @@ -422,6 +422,7 @@ static int ti_ads7950_probe(struct spi_device *spi)
>  	st->scan_single_xfer[1].tx_buf = &st->single_tx;
>  	st->scan_single_xfer[1].len = 2;
>  	st->scan_single_xfer[1].cs_change = 1;
> +	st->scan_single_xfer[2].rx_buf = &st->single_tx;

Should this be st->scan_single_xfer[2].tx_buf?

>  	st->scan_single_xfer[2].rx_buf = &st->single_rx;
>  	st->scan_single_xfer[2].len = 2;
>  
> 

-- 
Florian
