Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A55DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4620A21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 08:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551256428;
	bh=eyGi7s1w0qgMO6QFPgxFlxcnE5MF8e34vooyi5wWwFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M99L0Qwx1e0mMJl5Lya+jrQo0CTxcKXtNse4OqcU81ehmgrN5z2toeF7N65D1z7Cf
	 loW2axtjEVddnLg/h4R22JVFrT8Qja5t6UTZsMr6YSz4dUYicKaanuDJWwjhRdjhnY
	 1XtztqREXfd6kBjJhSvJY8uAm4y+baV9gmbb+qQM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729574AbfB0Idq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 03:33:46 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34646 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726724AbfB0Idq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 03:33:46 -0500
Received: by mail-lj1-f196.google.com with SMTP id l5so13238664lje.1;
        Wed, 27 Feb 2019 00:33:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=gRQy1GOD//vk/FRQZ4HAou7kCR7ZSdmUQX2LG/w4pAY=;
        b=BxTZkdvzNV4iIkhTe0YtBQhZVPMHSkAOu5u2Uv8AC4iv1EMwmW9IDEgrkP27xj+Mq3
         i7u1trUPGazLTNgATo7TEhUDvjSQxCjBBP7YT6JByG3XF1Lkm2JJ+kghpHmNsYwhAHSB
         60txiqCG2zGLB1VOcd3e9G1bNjpQpZgIBuSauQ3/Ur7hMVc/YuXrmy/28F3HmHpQ/35K
         /NleSvYJrFwNuxZQXVaHf9OGuCHd9wDCwckAYo2URU1BrmBapSF/W7VArIMdK5B0t9bQ
         5hEWEaQiPJ7mpigoulSuxN3dmHcb/wOp1T3zK964l30qG2LiRnonE92hKQe5jov0bUaa
         yKCA==
X-Gm-Message-State: AHQUAuYZQ8/UnPQgm0w+6cbmRVVuiZvrADJIcLkdItkYKfRl1Z/vnATR
        Mvb3NH/GI2NZF0Hs/CQ6iedEVRM2
X-Google-Smtp-Source: APXvYqyqHcoH8Z7H7Vrc6BtaZlmkr9LR0FKqIg7z1LIlntpvuaYX/xDJTKeo0f0yEPh8kJ/BTCndGg==
X-Received: by 2002:a2e:9204:: with SMTP id k4mr729181ljg.0.1551256423827;
        Wed, 27 Feb 2019 00:33:43 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id w6sm100227lfl.14.2019.02.27.00.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 00:33:43 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gyues-0006lZ-9R; Wed, 27 Feb 2019 09:33:42 +0100
Date:   Wed, 27 Feb 2019 09:33:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Mans Rullgard <mans@mansr.com>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: option: set driver_info for SIM5218 and
 compatibles
Message-ID: <20190227083342.GJ4747@localhost>
References: <20190226170710.12709-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190226170710.12709-1-mans@mansr.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 26, 2019 at 05:07:10PM +0000, Mans Rullgard wrote:
> The SIMCom SIM5218 and compatible devices have 5 USB interfaces, only 4
> of which are serial ports.  The fifth is a network interface supported
> by the qmi-wwan driver.  Furthermore, the serial ports do not support
> modem control signals.  Add driver_info flags to reflect this.
> 
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/usb/serial/option.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/serial/option.c b/drivers/usb/serial/option.c
> index fb544340888b..af4cbfecc3ff 100644
> --- a/drivers/usb/serial/option.c
> +++ b/drivers/usb/serial/option.c
> @@ -1066,7 +1066,8 @@ static const struct usb_device_id option_ids[] = {
>  	  .driver_info = RSVD(3) },
>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x6613)}, /* Onda H600/ZTE MF330 */
>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x0023)}, /* ONYX 3G device */
> -	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000)}, /* SIMCom SIM5218 */
> +	{ USB_DEVICE(QUALCOMM_VENDOR_ID, 0x9000), /* SIMCom SIM5218 */
> +	  .driver_info = NCTRL(0) | NCTRL(1) | NCTRL(2) | NCTRL(3) | RSVD(4) },
>  	/* Quectel products using Qualcomm vendor ID */
>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC15)},
>  	{ USB_DEVICE(QUALCOMM_VENDOR_ID, QUECTEL_PRODUCT_UC20),

Could you please provide the output of usb-devices (or lsusb -v) for
this device?

Thanks,
Johan
