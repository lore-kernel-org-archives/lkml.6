Return-Path: <SRS0=wmYC=LT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB4E5C43334
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40B7F20652
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Sep 2018 10:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3oPfNV0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40B7F20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727762AbeIEPGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Sep 2018 11:06:19 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:44573 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeIEPGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Sep 2018 11:06:19 -0400
Received: by mail-lf1-f68.google.com with SMTP id g6-v6so5513442lfb.11;
        Wed, 05 Sep 2018 03:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ZuElKqwSqn3xAtTi3w1D1C9d5KOhaiA77yrxWWWS11E=;
        b=l3oPfNV0Cx88ra0tDDFId0s8XlrK6JWYv82IA4EDvFLWW7XFdd+iKL3AgOzU8Ky/nl
         w2vqnPda1SGNUVJb3IZ4DCTJezw4qQoTr6fAygdgek+2EXQoC0p0REHbJ8WyYIH44Kv2
         Vo+FO3gpRT/Cb5TCOHvXlEPaBz+UUmZ9oELUokubVf4QbRaGaq24mHyVXOfcY476L9Vg
         pS7MMrOCjTi6z5SN5szS04WZOqkdOfVd3TWEoysO/c/K8EVsw4HOjBykYHP8vQBFa4rx
         0dIDXzzM96AgNp19AyigzE4vSSNKX01j3p3P1KygAq/vUagpQlxpBZN1I5/SvjBKa3GJ
         8mOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ZuElKqwSqn3xAtTi3w1D1C9d5KOhaiA77yrxWWWS11E=;
        b=hFS6NJStMFMhlg+4IgCw0vhtRpcErmdMF/9FCDgylua/eCMIvaqd7OB16fiLdnt2NP
         7jEgVGTie/v1uHUoFO82d7IeLLQGu9ERMXw1F9PrjfkwkubBWkbavugmII5eC82eQuKt
         E0QDHrOTGjNKGPVjWZM7Kt+l6q5Yn3boRXsi1l6POKcviRhwsuWdeQX6IAXDEKvquiwo
         OOzNpZrZmuomQ2Ki70KE4G6PPH+zHvpEzZ6ooZ7dXTBqPSQplUgTzLXolwC91KwQYdUH
         WgtRBAM9j559BIOaeKi+ys1IbB5xDGnQypiv9NLCuNGNBPaG3hGhM7hrB7SZyz0gZhyS
         oMAw==
X-Gm-Message-State: APzg51B1UItYOfttlubDHl0CZ4jV0cVmdwtrtfOGig4BsTHgfd4r8RYL
        mTjbGuEfHJaUYmCm7f6esrc=
X-Google-Smtp-Source: ANB0VdZceb+fWrclxBAA7B8SmQzGEES3ikPmmXYUBpxAiWtWjxsYZsgg3EYgL61CFrPbeO0l/8R0HQ==
X-Received: by 2002:a19:16d8:: with SMTP id 85-v6mr24371146lfw.142.1536143800503;
        Wed, 05 Sep 2018 03:36:40 -0700 (PDT)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id o184-v6sm245960lff.95.2018.09.05.03.36.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Sep 2018 03:36:39 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1fxVB4-0002NS-7W; Wed, 05 Sep 2018 12:36:50 +0200
Date:   Wed, 5 Sep 2018 12:36:50 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        andy.shevchenko@gmail.com, ajaykuee@gmail.com,
        daniel.thompson@linaro.org
Subject: Re: [PATCH] USB: serial: ftdi_sio: implement GPIO support for FT230X
Message-ID: <20180905103650.GA1089@localhost>
References: <20180825204744.2307-1-pados@pados.hu>
 <20180904124924.GA7278@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180904124924.GA7278@localhost>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 04, 2018 at 02:49:24PM +0200, Johan Hovold wrote:
> On Sat, Aug 25, 2018 at 10:47:44PM +0200, Karoly Pados wrote:

Here are some more comments on the setup functions, after having
prepared a patch adding support to FT232R.

> > +static int ftx_gpioconf_init(struct usb_serial_port *port)

Perhaps rename rename this using an ftdi_ prefix as well for consistency
with the current device-specific functions.

> > +{
> > +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> > +	struct usb_serial *serial = port->serial;
> > +	const u16 config_size = 0x24;
> > +	u8 *config_buf;
> > +	int result;
> > +	u8 i;
> > +

[...]

> > +	/*
> > +	 * All FT-X devices have at least 1 GPIO, some have more.
> > +	 * Chip-type guessing logic based on libftdi.
> > +	 */
> > +	priv->gc.ngpio = 1;
> > +	if (serial->dev->descriptor.bcdDevice == 0x1000)  /* FT230X */
> 
> Missing le16_to_cpu().
> 
> > +		priv->gc.ngpio = 4;
> 
> Shouldn't this be handled the other way round? IIRC there are two FTX
> device types with four pins, and one type where only one pin is
> accessible.
> 
> > +
> > +	/* Determine which pins are configured for CBUS bitbanging */
> > +	priv->gpio_altfunc = 0xff;
> > +	for (i = 0; i < priv->gc.ngpio; ++i) {
> > +		if (config_buf[0x1A + i] == FTDI_SIO_CBUS_MUX_GPIO)
> 
> 0x1a warrants a define; but you shouldn't be reading 0x24 bytes from
> offset 0 above when the pinconfig is stored in just a couple of words.
> 
> > +			priv->gpio_altfunc &= ~BIT(i);
> > +	}
> > +
> > +	kfree(config_buf);
> > +
> > +	return 0;
> > +}

How about returning the number of gpios instead of having every
device-specific function mess with priv->gc?

> > +
> > +static int ftdi_sio_gpio_init(struct usb_serial_port *port)
> > +{
> > +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> > +	struct usb_serial *serial = port->serial;
> > +	int result;
> > +
> > +	/* Device-specific initializations */
> > +	switch (priv->chip_type) {
> > +	case FTX:
> > +		result = ftx_gpioconf_init(port);
> > +		break;
> > +	default:
> > +		return 0;
> > +	}
> > +
> > +	if (result < 0)
> > +		return result;
> > +
> > +	/* Register GPIO chip to kernel */
> > +	priv->gc.label = "ftdi_sio";
> 
> Maybe we shouldn't use the legacy sio suffix here; "ftdi" or "ftdi-cbus"
> should do.
> 
> > +	priv->gc.request = ftdi_sio_gpio_request;
> > +	priv->gc.get_direction = ftdi_sio_gpio_direction_get;
> > +	priv->gc.direction_input = ftdi_sio_gpio_direction_input;
> > +	priv->gc.direction_output = ftdi_sio_gpio_direction_output;
> > +	priv->gc.get = ftdi_sio_gpio_get;
> > +	priv->gc.set = ftdi_sio_gpio_set;
> > +	priv->gc.owner = THIS_MODULE;
> > +	priv->gc.parent = &serial->interface->dev;
> > +	priv->gc.base = -1;
> > +	priv->gc.can_sleep = true;
> > +
> > +	result = gpiochip_add_data(&priv->gc, port);
> > +	if (!result)
> > +		priv->gpio_registered = true;
> > +
> > +	return result;
> > +}

> > +#define FTDI_SIO_CBUS_MUX_GPIO		8

And this one needs to have an FTX infix as it's FTX specific (e.g.
rename as FTDI_FTX_CBUS_MUX_IOMODE, which I believe better matches with
the various docs).

Johan
