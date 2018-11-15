Return-Path: <SRS0=7coz=N2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2BE1C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:11:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 614DB2087E
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Nov 2018 01:11:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ET+mM1+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 614DB2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbeKOLRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 06:17:07 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42951 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725895AbeKOLRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 06:17:07 -0500
Received: by mail-pg1-f196.google.com with SMTP id d72so4742442pga.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 17:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=si/6TqmD6OuQBI1/+j+r0Ubf1Cm8CT7s9oXxAQdoHto=;
        b=ET+mM1+Te1Awu8TWjjWHy1XGrv8kTmkl82fZIzC0ZGarhOwix8Zj12Z+8OZq2eZMBf
         oSTRSDlc9CSVT7yU8wf9j8T9/DmbS8tWJHQHWqeYZPMfog7yGfBsM4+5VZS7hXC6+AXf
         x1C9uVm7gjNtUhYuanCC8HT6fb4Ohu+pdPBNiZ76bMZjZJsbItVDJrufyidyq9Wz9LEG
         KtMTNdzo6m+aCXtuUYkxUG3U3+jScl908NcuIRmJbIjmuE95gKq9/kz5JRrTuJDl4KWo
         5ttCGIQBmFHdzehMxyKGoVPtB18XbZCydiBUVyuV35p81vtWnUofiEfFePkaR5iCUD36
         lreA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=si/6TqmD6OuQBI1/+j+r0Ubf1Cm8CT7s9oXxAQdoHto=;
        b=P2ari6A08jl+MdKF37QiTmuqwuFwgFNNy5b1cqK9q9ddcpPVS3xhk8LFucNXxQJIHM
         U1e6TJXh/XVLu2nZnCionoLaafSnQ9Dvt7UpoRotK2BkHlzLmKA1zxoZSoDg2RJtLimL
         V/XfB/ZA1huUNu2R9BeGstSzoBOxLUlwBYOpjnVN+XAEdslZxVKwSBJ58HH5o6DsnEfg
         SR1ZI2lkwn5W7aBv3NM+gEokSJ1cmT+DWmUMDFDSut0fecByjwnRy1rZvpkBB12WF3Kk
         a5l4lN2c/4JoR6HJO06xycH9Bh+/or/CZxIAEZl70UgP2xIY4tud/4juUqp/7h31sLbB
         c8yg==
X-Gm-Message-State: AGRZ1gJKrq6420KFRSmew0bMuQ8z4X9QH1wDeiURrJ/RoLTmQJz5SbqP
        2bA8WcfPEDcOKavUX/KiP6/rs5TwaIc=
X-Google-Smtp-Source: AJdET5fvm4bC/o7T1j7hFq78U+HQYmmmt5tw4ljlnRiYRyN2WVR83lDw7oSctCWew3GxtjWgWku+jw==
X-Received: by 2002:a62:2fc7:: with SMTP id v190-v6mr4355177pfv.216.1542244287843;
        Wed, 14 Nov 2018 17:11:27 -0800 (PST)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t4-v6sm26074127pfh.21.2018.11.14.17.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 17:11:26 -0800 (PST)
Date:   Wed, 14 Nov 2018 17:11:25 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250: Default SERIAL_OF_PLATFORM to SERIAL_8250
Message-ID: <20181115011125.GA32556@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 01, 2018 at 11:26:06AM -0700, Florian Fainelli wrote:
> It is way too easy to miss enabling SERIAL_OF_PLATFORM which would
> result in the inability for the kernel to have a valid console device,
> which can be seen with:
> 
> Warning: unable to open an initial console.
> 
> and then:
> 
> Run /init as init process
> Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000100
> 
> Since SERIAL_OF_PLATFORM already depends on SERIAL_8250 && OF there
> really is no drawback to defaulting this config to the value of
> SERIAL_8250.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

This patch results in situations where CONFIG_SERIAL_OF_PLATFORM is now
defined where it was not previously. Example mpc85xx_defconfig. This in
turn results in boot failures for those configurations, with an error
message of

of_serial: probe of e0004500.serial failed with error -22

which wasn't seen before.

Not sure if replacing a potential problem with a real one is really an
improvement.`

Guenter

 ---
>  drivers/tty/serial/8250/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 15c2c5463835..d7737dca0e48 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -484,6 +484,7 @@ config SERIAL_8250_PXA
>  config SERIAL_OF_PLATFORM
>  	tristate "Devicetree based probing for 8250 ports"
>  	depends on SERIAL_8250 && OF
> +	default SERIAL_8250
>  	help
>  	  This option is used for all 8250 compatible serial ports that
>  	  are probed through devicetree, including Open Firmware based
> -- 
> 2.7.4
