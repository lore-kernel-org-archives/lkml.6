Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0343C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:57:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AEB12085A
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 08:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547542670;
	bh=f+0iYVnA8B/HO6pt8XH/uLKe3g4bXF1ZPQHeuwxI41U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=l7VufXZ05ZiU6vcQCFquUdKfqkmiYWPz8dtzdBlUWPFMQslVXbhhSyimMcM9sMX9g
	 j4G7jp4C5XiohvCTHlWi5Tyv9Qjxe2MKcWyWJEVHf1ptwpiAh+/N9ssH4wY2+fwKsl
	 TyUfEWU2yeqxSOCIWWPosJsYi67PoG0K299v5Y7M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfAOI5s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 03:57:48 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36846 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfAOI5r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 03:57:47 -0500
Received: by mail-lj1-f194.google.com with SMTP id g11-v6so1639641ljk.3;
        Tue, 15 Jan 2019 00:57:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=b5//Zwbsi7+bQn+/6vARBKNpo+W5NCBDx3oJkJD2Nz0=;
        b=Bf5/r+OoUMu0Apyw87P1s3jXctwEw0dnBcimixZuOekGNr843KwXYnoh3mfwt1efdY
         6F8S+z/vNz+c4UCYveRTHPT/m3R+xBTFXO4eMkGg3w/u3RCqHBzLgE5+hulUyflehrZr
         r94xxnDtrZVNG45vMw2IlYaUN3hxRl1LQ340BQBVCZmUfKkxC8v3hhYcFLdfECoyEICB
         SFAIwOTr8tu8Dj7mYzerAzHIZvceq2vip3u+JckgZHPsgl7qBIpMuCcX6tOY4kIXvwru
         oPCvcGKPi9aGXmowyPRSm0cYCY1bwq5WSFazyzoXb98vs4bcAi1wTKk0K7d6tIOHz+Y2
         Y93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=b5//Zwbsi7+bQn+/6vARBKNpo+W5NCBDx3oJkJD2Nz0=;
        b=GEvsnI6TYrGdQKqs/2PLEt7abyQbrcxX6mr4cAV4CIZFiRdrwQC9pkRIJ96gEg7MhV
         DUgJX1tBwpkIyel6xSLYym69F9QsNrBum08eaCAe7S0UXe49LGdeF/9I9enOne6aAAzX
         RDLMA6liHQ0jzkD5Z6I7CptuJJ3DrGCTuZqEuPxEjVfkqsFMzEv0ts9+Iulw8f7sC1Hv
         gYO3p9X1JJ45RI/4553X1oCljn07+2+MMzAjVcWFmDvas+ozB82xHpBOb7hPktRmIkGc
         MvFgiY2HT5OTdkbwkW2KrdQKoK7wxxxGLks1XW8C+d5pDfIyOHQY4m29XhUpzR9FTE5K
         EZSQ==
X-Gm-Message-State: AJcUukf2Mzz81+8D5aIkXoRAbZdl4yVB4hRRd7CoeV/7yzew6KfjwEXy
        e3zt8IwjqLQSO7ABG6gI8dr+ljiq
X-Google-Smtp-Source: ALg8bN5x7YibIr+laspsxQVGEd8n+1nicCnbkObR5qIcGGDDE7e3tY7nytLjbsAVrxvADsSDN82d0Q==
X-Received: by 2002:a2e:3308:: with SMTP id d8-v6mr1797452ljc.38.1547542665353;
        Tue, 15 Jan 2019 00:57:45 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id k3-v6sm472467lja.8.2019.01.15.00.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 15 Jan 2019 00:57:44 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gjKXX-0008P0-Dv; Tue, 15 Jan 2019 09:57:44 +0100
Date:   Tue, 15 Jan 2019 09:57:43 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Fix GPIO in autosuspend
Message-ID: <20190115085743.GL3691@localhost>
References: <20190114194352.4579-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190114194352.4579-1-pados@pados.hu>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2019 at 08:43:52PM +0100, Karoly Pados wrote:
> Current GPIO code in cp210x fails to take USB autosuspend into account,
> making it practically impossible to use GPIOs with autosuspend enabled
> without user configuration. Fix this like for ftdi_sio in a previous patch.
> Tested on a CP2102N.
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
>  drivers/usb/serial/cp210x.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index c0777a374a88..8f974eabce63 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -598,9 +598,15 @@ static int cp210x_read_vendor_block(struct usb_serial *serial, u8 type, u16 val,
>  	void *dmabuf;
>  	int result;
>  
> +	result = usb_autopm_get_interface(serial->interface);
> +	if (result)
> +		return result;
> +

> @@ -702,9 +709,15 @@ static int cp210x_write_vendor_block(struct usb_serial *serial, u8 type,
>  	void *dmabuf;
>  	int result;
>  
> +	result = usb_autopm_get_interface(serial->interface);
> +	if (result)
> +		return result;
> +

I think it's better to add the autopm call to gpio210x_gpio_get/set
only. This will allow for a simpler patch, and keeps the autopm handling
confined to the gpio paths.

> @@ -1383,6 +1397,7 @@ static void cp210x_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
>  	} else {
>  		u16 wIndex = buf.state << 8 | buf.mask;
>  
> +		usb_autopm_get_interface(serial->interface);

Also make sure to always check for errors from autopm_get().

>  		result = usb_control_msg(serial->dev,
>  					 usb_sndctrlpipe(serial->dev, 0),
>  					 CP210X_VENDOR_SPECIFIC,

Thanks,
Johan
