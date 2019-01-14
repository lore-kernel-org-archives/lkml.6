Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3420EC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06C3A20651
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:32:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mGxIxpZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfANSc2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:32:28 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43227 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfANSc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:32:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id w73so10724492pfk.10;
        Mon, 14 Jan 2019 10:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XR5gtJAobwIyA7lYr0SPKFiQbtw7N6vkRr4/TFdvAPI=;
        b=mGxIxpZkASyE6V1QhO8l3rS9FlMASaDNWcXNI2s8JEj3+7WZTWiFNsjEiQKlwmVz8T
         8GZI5WCaoAlLIGj0oXi4G34TrGKd2+Irzm1Ll1uijWM1/VV5yz996R9uUELuAPUnXuTH
         r1RC455JAGW/iG4PLfIBizyfaG+xcvCbK5k4J94A+7ZA9c/2bueg4z8Ga9iee71I8OWK
         dOZxf7xmIJwOa9I/crW7uDDm0An4bS4SPhP+77P4wptF/o90OuTi3rlK/Po1Ul9uNcUP
         jS4YflZ9ZFvGuxYgCBoLpzCkFLcI2dCti0D54/pHPuE4bJFAjAvuYvOUZ2eo9ue5WnjE
         JNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XR5gtJAobwIyA7lYr0SPKFiQbtw7N6vkRr4/TFdvAPI=;
        b=KW9kF2DFH0xN2UwC/wt5LEUSb/17vzXaTe0M/8YBXyyloW9ftEAphpHNT1TNVPnAYV
         THchT7/qK8KtzFLuw31Sl194asGgO/9nbGvngjYPJk/VKghOI1lKvdt846pxKDlhYAfd
         rz5Loqcrk/+JGCz39P6gHKrwHfumJgPjFo0sMxMO+G3uVbHYiEfHFlsPUw5FU4vzH7Wy
         hZLdJyUv1DkJ08b7scbOz5ZdL4lr3IbM69YBwBELXD4XcMx0RtrO+PPhnFZstwEV+gHC
         VSuqB/Lp4jSSkpo3M0dGfaEMLrpjsoY3HKMsqt3xmIQ06lsKLVh4Wtn7HsM1NC8hd0Jx
         Un/Q==
X-Gm-Message-State: AJcUukc67uGi6KQeFKb0eTsftOhymhk7IOdRfZPvzcuj1/COO0OI//7Q
        MNmqs4XRddznTJaHT4oFplnk32wo
X-Google-Smtp-Source: ALg8bN6IaGmb4ZGPPEXRkXsjM6YRqGzI1buiS+BdxCHMS9PJcwEFBykAMKRY+oCpLyctvF3e0Vb24g==
X-Received: by 2002:a65:49cd:: with SMTP id t13mr24355663pgs.376.1547490746948;
        Mon, 14 Jan 2019 10:32:26 -0800 (PST)
Received: from dtor-ws ([2620:15c:202:201:3adc:b08c:7acc:b325])
        by smtp.gmail.com with ESMTPSA id f64sm2670362pfh.0.2019.01.14.10.32.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 10:32:26 -0800 (PST)
Date:   Mon, 14 Jan 2019 10:32:24 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] input: touchscreen: fix link error
Message-ID: <20190114183224.GB117329@dtor-ws>
References: <20190114095754.23175-1-anders.roxell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114095754.23175-1-anders.roxell@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 10:57:54AM +0100, Anders Roxell wrote:
> Fix link error when TOUCHSCREEN_RASPBERRYPI_FW is enabled as a module
> and the dependent module is built-in.
> The 'depends on RASPBERRYPI_FIRMWARE' by itself prevents the touchscreen
> driver from being built-in when the firmware is configured as a module.
> However, the '|| COMPILE_TEST' still allows it unless we explicitly
> prevent that configuration with '|| (RASPBERRYPI_FIRMWARE=n &&
> COMPILE_TEST)'
> 
> ld: drivers/input/touchscreen/raspberrypi-ts.o: in function `rpi_ts_probe':
> raspberrypi-ts.c:(.text+0x3a8): undefined reference to `rpi_firmware_get'
> ld: raspberrypi-ts.c:(.text+0x3a8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_get'
> ld: raspberrypi-ts.c:(.text+0x4c8): undefined reference to `rpi_firmware_property'
> ld: raspberrypi-ts.c:(.text+0x4c8): relocation truncated to fit: R_AARCH64_CALL26 against undefined symbol `rpi_firmware_property'
> 
> Rework so that TOUCHSCREEN_RASPBERRYPI_FW depends on
> RASPBERRYPI_FIRMWARE=n if COMPILE_TEST is enabled.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thank you.

> ---
>  drivers/input/touchscreen/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/Kconfig b/drivers/input/touchscreen/Kconfig
> index af6027cc7bbf..068dbbc610fc 100644
> --- a/drivers/input/touchscreen/Kconfig
> +++ b/drivers/input/touchscreen/Kconfig
> @@ -698,7 +698,7 @@ config TOUCHSCREEN_EDT_FT5X06
>  
>  config TOUCHSCREEN_RASPBERRYPI_FW
>  	tristate "Raspberry Pi's firmware base touch screen support"
> -	depends on RASPBERRYPI_FIRMWARE || COMPILE_TEST
> +	depends on RASPBERRYPI_FIRMWARE || (RASPBERRYPI_FIRMWARE=n && COMPILE_TEST)
>  	help
>  	  Say Y here if you have the official Raspberry Pi 7 inch screen on
>  	  your system.
> -- 
> 2.19.2
> 

-- 
Dmitry
