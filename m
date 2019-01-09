Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40877C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:48:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 02B4D2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 21:48:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="huyvVBDM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfAIVsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 16:48:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:38257 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbfAIVsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 16:48:01 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so9203223wrw.5;
        Wed, 09 Jan 2019 13:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wbPtCnCMYFXNwMaTry6/291aYlawOCT2SxLb0zLOzsI=;
        b=huyvVBDM3pwU3ksnZy8h/Ic6cXlyob6PrXIz5bHNSdK11APCdBieVVnd73ytxEvwJO
         +lYwXs1ZTDWf4+opAkxkwCUnIQNmIDdIK/bnsb43r6C4a1ewVLQGzKNRTm0bgpMf08OI
         roHpZ5vL/3wIu+zNLio0Bu9+lkbBzkrVlQgI4hF/qMccVTHZKqjlRSNTpkiPh7AoZZg0
         JYal0su6f5IwbumvfbPoc/sYyzZgjDnVLg5jlA75vYi+3WfughVUGMiCHQlPKTaInk0X
         goE5gPHHRejqfcU+g0n2RbHXO6NUJyjnpFdk9cv2zUGJH1SHBhLgJ3rqSQSI4maqBk5u
         C6Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wbPtCnCMYFXNwMaTry6/291aYlawOCT2SxLb0zLOzsI=;
        b=SN54WdYZR1a+vxWIexICjWyplAxGJrvCOISeUb9dyVsg16L7f7CG+LukSCy5MEfaia
         oAeUhIP2SbqxqzH6A/rBf2xH8oX3XaDG3t0SCG6yPrh7Hm5XyQMKUGlf4TZQtmPq71ia
         yKjPMbo5qnr+yoOfzhoz/V7IiilRpnEjxVdaImBiHIZcDMVArk6BvqvZZOdNSS0/DmLc
         b1+IZ4V+y7Xv3ez8x1PFugou0+GeMsP7ZIWw6UoYEBqhM07xHmEYbdulx4RTubzS+xbm
         2J2M8uyOPQkxARcWcNP6G86SEZ2jVOYDzblKBTxezKL+xcLVLUNdaEHDmvMRTleZ60bf
         dLVw==
X-Gm-Message-State: AJcUukdhxYaaRMKEEV6PAuK1dKc81hO1edIEi6kk8dBTPQTbl71kMY5z
        0mTYu/e30IudnaV4snyX7uE=
X-Google-Smtp-Source: ALg8bN6i43bnOxPmycRp2a4CUUYymT+kYP3hK2gXmWjkVd63qmsPy5KE9SV6fFqbC7zSkQo/+OXTBw==
X-Received: by 2002:adf:9d08:: with SMTP id k8mr6945177wre.203.1547070479392;
        Wed, 09 Jan 2019 13:47:59 -0800 (PST)
Received: from localhost.localdomain ([46.216.128.22])
        by smtp.gmail.com with ESMTPSA id g129sm13917603wmf.39.2019.01.09.13.47.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Jan 2019 13:47:58 -0800 (PST)
Received: from [127.0.0.1] (helo=jeknote.loshitsa1.net)
        by localhost.localdomain with esmtp (Exim 4.91)
        (envelope-from <jekhor@gmail.com>)
        id 1ghLhc-0005FV-Ik; Thu, 10 Jan 2019 00:47:56 +0300
Date:   Thu, 10 Jan 2019 00:47:56 +0300
From:   Yauhen Kharuzhy <jekhor@gmail.com>
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     wsa@the-dreams.de, linux-i2c@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@opensource.cirrus.com
Subject: Re: [PATCH 2/2] i2c: Clear client->irq in i2c_device_remove
Message-ID: <20190109214756.GA18115@jeknote.loshitsa1.net>
References: <20181019085958.32694-1-ckeepax@opensource.cirrus.com>
 <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181019085958.32694-2-ckeepax@opensource.cirrus.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2018 at 09:59:58AM +0100, Charles Keepax wrote:
> The IRQ will be mapped in i2c_device_probe only if client->irq is zero and
> i2c_device_remove does not clear this. When rebinding an I2C device,
> whos IRQ provider has also been rebound this means that an IRQ mapping
> will never be created, causing the I2C device to fail to acquire its
> IRQ. Fix this issue by clearing client->irq in i2c_device_remove,
> forcing i2c_device_probe to lookup the mapping again.

Hi.

I found  driver i2c/busses/i2c-cht-wc.c which instantiates I2C device
(battery charger) and passes IRQ to driver not using standard I2C IRQ mapping code.
So if we reprobe I2C device (by reloading I2C device driver module or by
manipulations with sysfs), we get invalid IRQ number for client:

 adap->client_irq = irq_create_mapping(adap->irq_domain, 0);
 ...
 irq_set_chip_data(adap->client_irq, adap);
 irq_set_chip_and_handler(adap->client_irq, &adap->irqchip, handle_simple_irq);
 ...
 board_info.irq = adap->client_irq;
 adap->client = i2c_new_device(&adap->adapter, &board_info);


adap->client->irq will be reset after device removing here.


Any advice to fix this? Maybe move initial i2c_client->irq value to new field
like client->init_irq and copy it to client->irq at probing, for example?

> 
> Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
> ---
>  drivers/i2c/i2c-core-base.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
> index 656f0a6fe3adf..28460f6a60cc1 100644
> --- a/drivers/i2c/i2c-core-base.c
> +++ b/drivers/i2c/i2c-core-base.c
> @@ -430,6 +430,8 @@ static int i2c_device_remove(struct device *dev)
>  	dev_pm_clear_wake_irq(&client->dev);
>  	device_init_wakeup(&client->dev, false);
>  
> +	client->irq = 0;
> +
>  	return status;
>  }
>  

-- 
Yauhen Kharuzhy
