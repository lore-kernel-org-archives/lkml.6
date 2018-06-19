Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48190C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:40:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0207D20836
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 18:40:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYcXXyH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0207D20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030373AbeFSSkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 14:40:08 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:33462 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967134AbeFSSkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 14:40:05 -0400
Received: by mail-pg0-f67.google.com with SMTP id e11-v6so271383pgq.0;
        Tue, 19 Jun 2018 11:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wu+4TvYOrGeIdbzrtZ5gqqFy2tHShtA/80ub6Th0DKk=;
        b=UYcXXyH7MxChHMXKLfywk3YiOTXzcJ0ffdBrtCx2vNs05DwRKlDl161NxlmHZK8379
         qDirSrKUTrShQCZpVkoveT5PIgDey36sDiiug+TVwMakAT8pmaQU4M+Fwb/oOS2Y4hEa
         bujXgajH072P0l1BuqOYC2pxydwvKOva4oZSLblAefxR9tm2jVyDl8W6u6T7bW6Z4y+O
         ftTSSFp8rYbsLQ2/IH0b824o53tL+5O73f2y6PSLHP38ojU0/eXfV0nJE/USErypQKP+
         rR4fjjf5wX9ZtPpM3U1K3VzUPGpcRNRseLtKDyKKGbLhCE++UsUF1I/mrj5u9BjChOPE
         ZT5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wu+4TvYOrGeIdbzrtZ5gqqFy2tHShtA/80ub6Th0DKk=;
        b=d+YEa/9DaYlUkCIVpMQfXUCnWMHTS1cQkOb0K0AshfuFDkBzjJdJpTdRwIQ7AuuTha
         t/B8DS2KO4zKuLjHMS5MfxD5oo1JemdJLcZgWogM+4ZyzEgBV06aFzdc4vsSreO/6doH
         yAA1OwfIoAJ/8Oux3SSkCrPH1VnzIcNhBuWHzpbqpzGqpj88dZH73EbgLVjxSAWibB96
         arcta6I99M0pCBZ2A+jCv/WVc9t+ljHN20HH3ARc02SgDfFlPpsfOzaKDoAMhOkPKv3s
         q0APiBFBEqZWPIJ5UeYX5OHvGSAD8NA/++0+wouW+IH7nHubSXZCfuZqatNTqXwfL/lm
         z+OQ==
X-Gm-Message-State: APt69E2ZjwKcd6TNby1MEEoSTbbQOD2d5LqxOEJ6B2NmFI/s788fUgrr
        34u7+q5pRHclCQ7CQoXOt1Q=
X-Google-Smtp-Source: ADUXVKIdKa0zju+sU3btAR4aykGfaY7CUVJ3ZjPionhzet9avrJbMkGk7axsyKp/Ogl7XEzMk0+rxg==
X-Received: by 2002:a62:d388:: with SMTP id z8-v6mr19532425pfk.8.1529433603963;
        Tue, 19 Jun 2018 11:40:03 -0700 (PDT)
Received: from dtor-ws ([2620:0:1000:1511:8de6:27a8:ed13:2ef5])
        by smtp.gmail.com with ESMTPSA id l71-v6sm358023pge.8.2018.06.19.11.40.01
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Jun 2018 11:40:02 -0700 (PDT)
Date:   Tue, 19 Jun 2018 11:40:00 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Peter Rosin <peda@axentia.se>
Cc:     linux-kernel@vger.kernel.org, Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Guenter Roeck <linux@roeck-us.net>, Crt Mori <cmo@melexis.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Antti Palosaari <crope@iki.fi>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-integrity@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 04/11] input: rohm_bu21023: switch to i2c_lock_segment
Message-ID: <20180619184000.GJ71788@dtor-ws>
References: <20180615101506.8012-1-peda@axentia.se>
 <20180615101506.8012-5-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615101506.8012-5-peda@axentia.se>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 15, 2018 at 12:14:59PM +0200, Peter Rosin wrote:
> Locking the root adapter for __i2c_transfer will deadlock if the
> device sits behind a mux-locked I2C mux. Switch to the finer-grained
> i2c_lock_segment. If the device does not sit behind a mux-locked mux,
> the two locking variants are equivalent.
> 
> Signed-off-by: Peter Rosin <peda@axentia.se>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

I'm OK with it going through Wolfram's tree; I do not think I'd need an
immutable branch for this even...

> ---
>  drivers/input/touchscreen/rohm_bu21023.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/rohm_bu21023.c b/drivers/input/touchscreen/rohm_bu21023.c
> index bda0500c9b57..22d79db07234 100644
> --- a/drivers/input/touchscreen/rohm_bu21023.c
> +++ b/drivers/input/touchscreen/rohm_bu21023.c
> @@ -304,7 +304,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
>  	msg[1].len = len;
>  	msg[1].buf = buf;
>  
> -	i2c_lock_adapter(adap);
> +	i2c_lock_segment(adap);
>  
>  	for (i = 0; i < 2; i++) {
>  		if (__i2c_transfer(adap, &msg[i], 1) < 0) {
> @@ -313,7 +313,7 @@ static int rohm_i2c_burst_read(struct i2c_client *client, u8 start, void *buf,
>  		}
>  	}
>  
> -	i2c_unlock_adapter(adap);
> +	i2c_unlock_segment(adap);
>  
>  	return ret;
>  }
> -- 
> 2.11.0
> 

Thanks.

-- 
Dmitry
