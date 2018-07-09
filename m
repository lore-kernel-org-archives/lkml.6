Return-Path: <SRS0=qUjc=JZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A46EC5CFEB
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:55:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 499D620842
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Jul 2018 15:55:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ekhIfEx2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499D620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933890AbeGIPzR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Jul 2018 11:55:17 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:44012 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932931AbeGIPzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jul 2018 11:55:12 -0400
Received: by mail-pf0-f194.google.com with SMTP id y8-v6so13961958pfm.10;
        Mon, 09 Jul 2018 08:55:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OqjSjC2wx4mK/kBIHQrr7UEz9uFWnP1TChHPa0ydYvM=;
        b=ekhIfEx2qnIHLr/0AImHx4rR+UfXdVWbDoDZPRcsW/zOXWzHkNh9UzKxP5Jej1UG2t
         yQKzr7lQ0qyE1IBiGX/BoiSOGND5NF72e+rz5QoOpqPeZxkr1T66UKyfvUQERF+q/4ZC
         qsJCNZeNJmIVIDSa7BFvWcexWq+CqDzBjEN7f50BPMTuxXPUUg5LzRlpcbFqdOUcRDIK
         Zjdj7fZTlW99F192IzOyry+gG60Qj7EeakQDKueVL3bbC6CC3/1Ta9Oj4Apk6HxDmfxQ
         xeFHow+EciG97IDQG5upfEyRSkm79nPq0MmVPd/xuOoh85PMq/ukwj3Wnxr8ah6HUtd6
         V9+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=OqjSjC2wx4mK/kBIHQrr7UEz9uFWnP1TChHPa0ydYvM=;
        b=UMFXoocHcSC5TfaSKTGyIIs8TaV1W/76dK6eUbhW/wk8VfucXuYAzXKDfd8X6xG2Hw
         DNrVZT66xurK//tqiaTTX3lwe7VVUnyAqb874gy7vjQDb2y6b9xsCASKgdL6j5NZVd4K
         BuIg1EZJHYDP4+fOyXVh0NT4vm4jJAuCW12LF09fss38drphB5ZwG8PDSew//L6i2jrZ
         TrVbNpcgUKgH/CjpgYx1hwBwciWZGRMf1fvBDnJ5gDfWxKTMvzxVvg7x204D0Ozm+jf7
         zXsEl95MeVqRtNdPjG2ocrDWSVdsICT8rlFjYI5ae/Fun2p31YSkuiQy5TKxiaKYbeKd
         6EOg==
X-Gm-Message-State: APt69E3oq9luW4f4nlxkiHr6vk4t9fvYLpRchPGtqkKtS0I50nvSFjpx
        71hUsBmwZ69bJkMXOyd9lvs=
X-Google-Smtp-Source: AAOMgpeL+8zSMr6vZ4A2jCNbSGVyMHtw/Go63UJt7817bqxXfbIZGy64lWKDAaf5lBXJtVVO2KQiBQ==
X-Received: by 2002:a65:6110:: with SMTP id z16-v6mr14990423pgu.412.1531151712058;
        Mon, 09 Jul 2018 08:55:12 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id d11-v6sm24400228pfo.135.2018.07.09.08.55.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Jul 2018 08:55:11 -0700 (PDT)
Date:   Mon, 9 Jul 2018 08:55:09 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jean Delvare <jdelvare@suse.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Eric Anholt <eric@anholt.net>,
        Vadim Pasternak <vadimp@mellanox.com>,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH] hwmon: rpi: fix link error against rpi_firmware module
Message-ID: <20180709155509.GA4191@roeck-us.net>
References: <20180709154301.1781663-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180709154301.1781663-1-arnd@arndb.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 09, 2018 at 05:42:44PM +0200, Arnd Bergmann wrote:
> Compile-testing without CONFIG_RASPBERRYPI_FIRMWARE is possible, but we
> cannot build the rpi hwmon driver into the kernel if the firmware code
> is a loadable module:
> 
> drivers/hwmon/raspberrypi-hwmon.o: In function `rpi_hwmon_probe':
> raspberrypi-hwmon.c:(.text+0x140): undefined reference to `rpi_firmware_property'
> drivers/hwmon/raspberrypi-hwmon.o: In function `get_values_poll':
> raspberrypi-hwmon.c:(.text+0x350): undefined reference to `rpi_firmware_property'
> 
> This adapts the dependency to disallow that combination.
> 
> Fixes: 3c493c885cf8 ("hwmon: Add support for RPi voltage sensor")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Guenter Roeck <linux@roeck-us.net>

This will have to go through Florian's tree.

Guenter

> ---
>  drivers/hwmon/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
> index a4e5d3c9fc71..81da17a42dc9 100644
> --- a/drivers/hwmon/Kconfig
> +++ b/drivers/hwmon/Kconfig
> @@ -1322,7 +1322,7 @@ config SENSORS_PWM_FAN
>  
>  config SENSORS_RASPBERRYPI_HWMON
>  	tristate "Raspberry Pi voltage monitor"
> -	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> +	depends on RASPBERRYPI_FIRMWARE || (COMPILE_TEST && !RASPBERRYPI_FIRMWARE)

Is that one of the situations where "imply RASPBERRYPI_FIRMWARE"
would be useful ?

>  	help
>  	  If you say yes here you get support for voltage sensor on the
>  	  Raspberry Pi.
> -- 
> 2.9.0
> 
