Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE39ECE565
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A412146D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 09:17:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VDGXXm2o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38A412146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729578AbeIROtY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 10:49:24 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51130 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIROtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 10:49:24 -0400
Received: by mail-wm1-f66.google.com with SMTP id s12-v6so1632989wmc.0;
        Tue, 18 Sep 2018 02:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=zrG7OFX/9Xt99vtwm6B2QfyZrQOPypuA0sB7U/dKv0A=;
        b=VDGXXm2oOc5IedZtvJP2AStpk5aDpz9XdNdGasN5qbEaspA5Qdt5BKegSsjnmeTd08
         wyVUdDY0LoUTMV2mDW3kgY3QVUvMkcQGbtJ6icoi6u66hsgNRRaiNi03ubDuDu/JXpzZ
         2XXTwC6Od0ZyWG7rRAKW1Yc8hWPrDd+sYyc6XrlqGG7V9LfT/qJHPG2GfpFoOqK5bNhS
         +nW1aZXykmH6wQhcCFrx3Mn6KIZaNCWqgZU+DlXNyD0z+Ysf3mS3YP/us6WStiFGUy/v
         TzBW1E8Fj0S2ZolakHUmAkkK7/m0FTY6FHcWQBiaVG0XZsXKm1KE/bqAfU7CcGl/NA0e
         KGLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=zrG7OFX/9Xt99vtwm6B2QfyZrQOPypuA0sB7U/dKv0A=;
        b=USk5NEKBRkbNTfhXtpTk+CTZxgpSDSaFEHX3+nK1cBv762ld57RGd19VoJXqm+MXq5
         P+BllqJKKNvzyPUg6lrvnlLqjc87oDOebRxQ5il8STPNf6nnyLgIMgW9SF3eMn6iXrOC
         UqHX4wO3J8EXWuI4vBQXlr7u6G0VIpoSUuWJj3r8pRbyEKo1z7k8z8+3wS+lpNr+Ht6Q
         stMf4nkWOhhTmkidPBgehk/5sTvMuE+WNpyRoUufXYXFCVXYTCqJ1JefjlKQ7kyTHraP
         fS4Whx86AyTBWhUPfTljRrdRcW17Ly134tRTQi+g7T+HU5mbcfAU/C8fRn4zc5GiLI7Q
         vxjQ==
X-Gm-Message-State: APzg51BUYMmno1EH7i/yXVZWffE3LWyqe45FpRmTRp1QZZCdHp+Jgrm6
        SI9g1WkXhg3C7JXT1YJ3kFg=
X-Google-Smtp-Source: ANB0VdYRW8lhikm/HgqoIkiRLDpK3ER2Fq0Jppgy5WQ4JLlNtTa4d0/XUzQUQ6Dj/ucsTlK6z/GTGQ==
X-Received: by 2002:a1c:e382:: with SMTP id a124-v6mr14333565wmh.121.1537262259085;
        Tue, 18 Sep 2018 02:17:39 -0700 (PDT)
Received: from pi ([185.208.64.4])
        by smtp.gmail.com with ESMTPSA id 88-v6sm15800593wrf.95.2018.09.18.02.17.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Sep 2018 02:17:38 -0700 (PDT)
X-Google-Original-Sender: <johan@kernel.org>
Received: from johan by pi with local (Exim 4.90_1)
        (envelope-from <johan@pi>)
        id 1g2C7W-0003XG-Db; Tue, 18 Sep 2018 11:16:34 +0200
Date:   Tue, 18 Sep 2018 11:16:34 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>
Subject: Re: [PATCH v4] USB: serial: ftdi_sio: implement GPIO support for
 FT-X devices
Message-ID: <20180918091634.GC3943@localhost>
References: <20180916175847.3288-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180916175847.3288-1-pados@pados.hu>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2018 at 07:58:47PM +0200, Karoly Pados wrote:
> This patch allows using the CBUS pins of FT-X devices as GPIO in CBUS
> bitbanging mode. There is no conflict between the GPIO and VCP
> functionality in this mode. Tested on FT230X and FT231X.
> 
> As there is no way to request the current CBUS register configuration
> from the device, all CBUS pins are set to a known state when the first
> GPIO is requested. This allows using libftdi to set the GPIO pins
> before loading this module for UART functionality, a behavior that
> existing applications might be relying upon (though no specific case
> is known to the authors of this patch).
> 
> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
> Changelog:
> - v2: Fix compile error when CONFIG_GPIOLIB is not defined.
> - v3: Incorporate review feedback.
> - v4: Include linux/gpio/driver.h unconditionally.
>       Replace and invert gpio_input with gpio_output.
>       Make ftdi_gpio_direction_get return 0/1.
>       Change dev_err msg in ftdi_set_bitmode_req.
>       Change formatting of error checking in ftdi_gpio_get.
>       Drop dev_err in ftdi_gpio_set.
>       Remove some line breaks and empty lines.
>       Change error handling in ftdi_read_eeprom (and adjust caller).
>       Replace SIO->FTX in FTDI_SIO_CBUS_MUX_GPIO macro name.

Really nice job with this; looks nice and clean over all. Just a few
comments below.

> +static int ftx_gpioconf_init(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +	struct usb_serial *serial = port->serial;
> +	const u16 cbus_cfg_addr = 0x1a;
> +	const u16 cbus_cfg_size = 8;

Looks like you only need to read four bytes.

> +	u8 *cbus_cfg_buf;
> +	int result;
> +	u8 i;
> +
> +	/* Read a part of device EEPROM */
> +	cbus_cfg_buf = kmalloc(cbus_cfg_size, GFP_KERNEL);
> +	if (!cbus_cfg_buf)
> +		return -ENOMEM;
> +
> +	result = ftdi_read_eeprom(serial, cbus_cfg_buf,
> +				  cbus_cfg_addr, cbus_cfg_size);
> +	if (result != 0)

result < 0 would be more informative here.

> +		goto out_free;
> +
> +	/* Chip-type guessing logic based on libftdi. */
> +	priv->gc.ngpio = 4;  /* FT230X, FT231X */
> +	if (le16_to_cpu(serial->dev->descriptor.bcdDevice) != 0x1000)
> +		priv->gc.ngpio = 1;  /* FT234XD */

As I mentioned in my last mail: I've asked FTDI about this, but I fear
that FTX234XD has bcdDevice 0x1000 and we may need to just always
register all four pins after all.

> +	/* Determine which pins are configured for CBUS bitbanging */
> +	priv->gpio_altfunc = 0xff;
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		if (cbus_cfg_buf[i] == FTDI_FTX_CBUS_MUX_GPIO)
> +			priv->gpio_altfunc &= ~BIT(i);
> +	}
> +
> +out_free:
> +	kfree(cbus_cfg_buf);
> +
> +	return result;
> +}

> +static void ftdi_gpio_remove(struct usb_serial_port *port)
> +{
> +	struct ftdi_private *priv = usb_get_serial_port_data(port);
> +
> +	if (priv->gpio_used) {
> +		/* Remark: Exiting CBUS-mode does not reset pin states too */
> +		ftdi_exit_cbus_mode(port);
> +		priv->gpio_used = false;
> +	}

This should go after deregistration or we have a tiny race window here.

> +	if (priv->gpio_registered) {
> +		gpiochip_remove(&priv->gc);
> +		priv->gpio_registered = false;
> +	}
> +}

> diff --git a/drivers/usb/serial/ftdi_sio.h b/drivers/usb/serial/ftdi_sio.h
> index dcd0b6e05baf..6856ccdac9b4 100644
> --- a/drivers/usb/serial/ftdi_sio.h
> +++ b/drivers/usb/serial/ftdi_sio.h
> @@ -35,7 +35,10 @@
>  #define FTDI_SIO_SET_EVENT_CHAR		6 /* Set the event character */
>  #define FTDI_SIO_SET_ERROR_CHAR		7 /* Set the error character */
>  #define FTDI_SIO_SET_LATENCY_TIMER	9 /* Set the latency timer */
> -#define FTDI_SIO_GET_LATENCY_TIMER	10 /* Get the latency timer */
> +#define FTDI_SIO_GET_LATENCY_TIMER	0x0a /* Get the latency timer */
> +#define FTDI_SIO_SET_BITMODE		0x0b /* Set GPIO mode */

Nit: "Set bitbang mode", I think would be more correct here as this
request is also used to configure the asynchronous bitbang mode, etc.

Thanks,
Johan
