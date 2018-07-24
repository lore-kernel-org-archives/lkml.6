Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF65ECDFB8
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEB9620852
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 02:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbqdTwcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB9620852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbeGXDmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 23:42:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46878 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388233AbeGXDmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 23:42:20 -0400
Received: by mail-pg1-f194.google.com with SMTP id p23-v6so1728835pgv.13;
        Mon, 23 Jul 2018 19:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YpQG+kHHfZIRf0dEbwRXo3fvCIwj1Bf1Ur0SDxo6RXk=;
        b=PbqdTwcu9m4NRydRjXaDEpDnVhROi8xA8TwqDUpxlxjh39CAMkVNV+rPJ+RLlOhDPZ
         QX6d8SG5y7GoITvOjXXKg3ywgAesnLb4bZYgahXfh3CjOmRaavFP37xc8MRcaI3j9dFR
         hGZR+/z1z5mrkM98t4QRX6x1GEjqsuR+DpgDYtkQNUDPRpEhsEMdCTf35cVVA9M1OSzl
         R+dlwbo2OAMurC4EsRraudIrvz6MYAKTvzcqbBYebjYgVaY/tD05MThc4dtdfZKpunI1
         dp2eBYvqHfsFqGUxzs+Dbz77rpdyV2/FqH0DYwN0KIzdj7773+mgGVRI0N/5bQeeQymP
         DMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=YpQG+kHHfZIRf0dEbwRXo3fvCIwj1Bf1Ur0SDxo6RXk=;
        b=ekBvxeUByIm/UWQwf30zMExlaD4ePV4mIjwEG90HZdSGTtqNkcvqP8WCPVBCOc22Js
         RfOisHSdMI4bn2V8bQ88VtRmWmeNmhFU1TdCMSMZ47CDbYsGJLkcslUflH9nD3acz7zY
         7SOUv7XO4nx48jIE5VVVLr73bbh7bkMaXNhUGOvhzioTyYUqnU7XheWU9stEDfr3nE8T
         Z286DPDl7lftE4Q9CS6tYDbyZd6oeY85vmAUmTQ23Yf6BEwoxRL4JGeW9haSD+eXLI+g
         CCjdWVg+YkW28xMzJoHgy64JDWQRpZjRo+tj+J64f3rCWo3gehJFs8lIPH+vc7NooN54
         Y5tA==
X-Gm-Message-State: AOUpUlEAwfDdiLcBOtZVhGtLcHYJl1Vh9Rxctv3AgHYg99JqxUKH9hQq
        atUFM4RXk0c11c2VlAMsg1I=
X-Google-Smtp-Source: AAOMgpeyStOFKu3oPOYMM8+6gZEPARDbu07we1BH8TcO8Lm5mAm61aM1vuGdKpPVGYm/SGN/ZKeWxg==
X-Received: by 2002:a63:f206:: with SMTP id v6-v6mr14508850pgh.319.1532399890637;
        Mon, 23 Jul 2018 19:38:10 -0700 (PDT)
Received: from localhost ([146.74.94.74])
        by smtp.gmail.com with ESMTPSA id f18-v6sm20853976pff.29.2018.07.23.19.38.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Jul 2018 19:38:09 -0700 (PDT)
Date:   Tue, 24 Jul 2018 02:38:04 +0000
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] input: pxrc - do not store USB device in private struct
Message-ID: <20180724023804.6mnbstzdrcp74rev@penguin>
References: <20180716144014.6331-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180716144014.6331-1-marcus.folkesson@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcus,

On Mon, Jul 16, 2018 at 04:40:14PM +0200, Marcus Folkesson wrote:
> The USB device is only needed during setup, so put it back after
> initialization and do not store it in our private struct.
> 
> Also, the USB device is a parent of USB interface so our driver
> model rules ensure that USB device should not disappear while
> interface device is still there.
> So not keep a refcount on the device is safe.
> 
> Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/input/joystick/pxrc.c | 22 ++++++++++++----------
>  1 file changed, 12 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxrc.c
> index 07a0dbd3ced2..46a7acb747bf 100644
> --- a/drivers/input/joystick/pxrc.c
> +++ b/drivers/input/joystick/pxrc.c
...

> @@ -204,23 +204,25 @@ static int pxrc_probe(struct usb_interface *intf,
>  		return -ENOMEM;
>  
>  	mutex_init(&pxrc->pm_mutex);
> -	pxrc->udev = usb_get_dev(interface_to_usbdev(intf));
> +	udev = usb_get_dev(interface_to_usbdev(intf));

There is really no need to "get" device for the probe duration, or in
general, when you are not storing the reference to it.

I posted series with an updated version of this patch plus couple more
cleanups/fixes, and would appreciate if you could give it a spin.

Thanks.

-- 
Dmitry
