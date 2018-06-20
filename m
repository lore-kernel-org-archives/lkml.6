Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FB5C1B0F2
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46D13208B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 08:32:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKnDAaea"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46D13208B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753276AbeFTIcj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 04:32:39 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42247 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751327AbeFTIcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 04:32:32 -0400
Received: by mail-lf0-f65.google.com with SMTP id z207-v6so3628454lff.9;
        Wed, 20 Jun 2018 01:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/BY7Qc7MkqVbDkxcyECo22hsj6nyre0WO1YJgaFlslo=;
        b=RKnDAaeaNRGibezqSVzu7GJcqX4eWIJ6+jlGVnuDR2LMGNnxpKN5TGjp43IM9eqt4u
         HZoLfQB25+OY1iiH0UByFBYECJveAJ+/j+Q0CJCeH1qbm2lgjJkzK3pXz7UfJgLUg0EV
         /VcNs9IqzwGgCboLGNeOREJZgkcnsEOpqA54tUDXUWyodCQcYBUZqPfl8kKkcdQvnKA9
         KOf8OxPCeEO3Xal+8NafG0Vv8zVe8b2MPfgL6sZAiskcvcldqd8Bh3Z4v0t/xTInO6eh
         fibiJ6UfqPYB/q9MqZ7WCWdJdQUsTV91ew/lcL1rAJnbo2tCn4VvS4ct3CaSNFEzcFXx
         z8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=/BY7Qc7MkqVbDkxcyECo22hsj6nyre0WO1YJgaFlslo=;
        b=koTIf95aSNJvPjbw82VT/iu/oj9q/mW0z8gjUD1kffz5g12rw+tJujkiJIrwwBznkm
         qXKmIdDyPYw1njUQJBhcetn9xcxHNMlo/tmFzY8ee2agkCiS4BSzjY2QN3KJ9+bOQNbW
         ekCuw23KJ69RyDJxv0lmoFMTn8gjCT8zLw4hnbdVX7cDoFLY/zgZ3hWpuL661xCRin69
         QzTRxE1U8ySw2taa4vXazwm4vRLaDKb2Ugn3t4223CzreNu4PChAeSLHzF5H3IeYICET
         1TSr40HXutN6NHVUIuwXFAwvzkbJOHE7UcnQ5c8l3vZwAp6Jo7skTQxHQmJqBrok+ui+
         QQ7Q==
X-Gm-Message-State: APt69E1oPMsAq30hHGghzV/B2TacWUEtrzDHaOwRIBXSGPAcJ5L9AJCi
        k20N+6KYQjj1VF6Llcx4Gpw=
X-Google-Smtp-Source: ADUXVKJLmoj9om0m+RskqBINPy5qnTVCf7Tfo4paRXghORgT19zCl38DBIR10rYGO7u8IbcjD+NZVw==
X-Received: by 2002:a2e:4dcc:: with SMTP id c73-v6mr12949789ljd.135.1529483137193;
        Wed, 20 Jun 2018 01:25:37 -0700 (PDT)
Received: from xi.terra (c-8bb2e655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.178.139])
        by smtp.gmail.com with ESMTPSA id q66-v6sm308152lfg.17.2018.06.20.01.25.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 01:25:36 -0700 (PDT)
Received: from johan by xi.terra with local (Exim 4.90_1)
        (envelope-from <johan@kernel.org>)
        id 1fVYQN-0002y4-Ax; Wed, 20 Jun 2018 10:25:07 +0200
Date:   Wed, 20 Jun 2018 10:25:07 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Karoly Pados <pados@pados.hu>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] USB: serial: cp210x: Implement GPIO support for CP2102N
Message-ID: <20180620082507.GO32411@localhost>
References: <20180617182503.23080-1-pados@pados.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180617182503.23080-1-pados@pados.hu>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 17, 2018 at 08:25:03PM +0200, Karoly Pados wrote:
> Pretty much what the title says. No other functions/devices
> touched. Tested on CP2102N-QFN28.
> 
> Limitation: Even though the QFN28 package has 7 GPIOs,
> this patch allows to control only the first 4.
> What I've found using reverse engineering regarding the
> other 3 pins collides both with reality and with other
> documented functions, so I did not dare to just use my
> findings because I cannot test on other packages.
> Instead, I decided to play it safe and only support 4 GPIOs.

Thanks for the patch. Nice to see this finally be implemented for
further device types.

You're gonna need to unify a lot of this with the current implementation
for cp2105 however.

> Signed-off-by: Karoly Pados <pados@pados.hu>
> ---
>  drivers/usb/serial/cp210x.c | 259 +++++++++++++++++++++++++++++++++++-
>  1 file changed, 257 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/serial/cp210x.c b/drivers/usb/serial/cp210x.c
> index 793b86252c46..adb450185ce8 100644
> --- a/drivers/usb/serial/cp210x.c
> +++ b/drivers/usb/serial/cp210x.c
> @@ -6,7 +6,8 @@
>   *
>   * Support to set flow control line levels using TIOCMGET and TIOCMSET
>   * thanks to Karl Hiramoto karl@hiramoto.org. RTSCTS hardware flow
> - * control thanks to Munir Nassar nassarmu@real-time.com
> + * control thanks to Munir Nassar nassarmu@real-time.com.
> + * GPIO support for CP2102N thanks to Karoly Pados.

No need to thank yourself here. This was added by the original author
(who appears to have partly been developing this driver out-of-tree) to
credit contributers.

The git logs will keep a record of your contributions.

>   *
>   */
>  
> @@ -229,11 +230,16 @@ struct cp210x_serial_private {
>  	struct gpio_chip	gc;
>  	u8			config;
>  	u8			gpio_mode;
> +	u8			gpio_control;
> +	u8			gpio_dir;
>  	bool			gpio_registered;
>  #endif
>  	u8			partnum;
>  };
>  
> +#define CP2102N_PIN_OPENDRAIN(var, pin)	(!((var) & BIT(pin)))
> +#define CP2102N_PIN_GPIO(var, pin)	(!((var) & BIT(pin)))

These are in fact not cp2102n specific. If they are at all needed in the
end they should be implemented as generic static functions.

> +
>  struct cp210x_port_private {
>  	__u8			bInterfaceNumber;
>  	bool			has_swapped_line_ctl;
> @@ -349,6 +355,7 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  #define CP210X_GET_PORTCONFIG	0x370C
>  #define CP210X_GET_DEVICEMODE	0x3711
>  #define CP210X_WRITE_LATCH	0x37E1
> +#define CP210X_READ_2NCONFIG	0x000E

Keep the defines sorted by value.

>  /* Part number definitions */
>  #define CP210X_PARTNUM_CP2101	0x01
> @@ -362,6 +369,14 @@ static struct usb_serial_driver * const serial_drivers[] = {
>  #define CP210X_PARTNUM_CP2102N_QFN20	0x22
>  #define CP210X_PARTNUM_UNKNOWN	0xFF
>  
> +#define	IS_CP2102N(partnum)   (((partnum) == CP210X_PARTNUM_CP2102N_QFN28) || \
> +			       ((partnum) == CP210X_PARTNUM_CP2102N_QFN24) || \
> +			       ((partnum) == CP210X_PARTNUM_CP2102N_QFN20))

So reuse the static helper I mentioned in my comments to the baudrate
patch.

> +
> +#define CP210X_2NCONFIG_GPIO_CONTROL_IDX	600
> +#define CP210X_2NCONFIG_GPIO_MODE_IDX		581
> +#define CP210X_2NCONFIG_GPIO_RSTLATCH_IDX	587

Sort by value.

> +
>  /* CP210X_GET_COMM_STATUS returns these 0x13 bytes */
>  struct cp210x_comm_status {
>  	__le32   ulErrors;
> @@ -1455,6 +1470,235 @@ static void cp210x_gpio_remove(struct usb_serial *serial)
>  	}
>  }
>  
> +static int cp2102n_gpio_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	int result;
> +	u8 buf;
> +
> +	result = cp210x_read_vendor_block(serial, REQTYPE_DEVICE_TO_HOST,
> +					  CP210X_READ_LATCH, &buf, sizeof(buf));
> +	if (result < 0)
> +		return result;
> +
> +	return !!(buf & BIT(gpio));
> +}

This should be handled in cp210x_gpio_get() by making the control
request type depend on the device type.

Make the cp2102n behaviour the default as it is used also by some legacy
devices, and explicitly check for the cp2105 odd bird. We'll deal with
cp2108, which 16 gpios and hence uses 16-bit mask, when we get there.

> +
> +static void cp2102n_gpio_set(struct gpio_chip *gc, unsigned int gpio, int value)
> +{
> +	int result;
> +	struct cp210x_gpio_write buf;
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +
> +	/* Ignore request if pin is not in our control */
> +	if (!CP2102N_PIN_GPIO(priv->gpio_control, gpio)) {
> +		dev_warn(&serial->interface->dev,
> +			 "Cannot control GPIO with active alternate function.\n");
> +		return;
> +	}

No need to check for this in every callback; move to
cp210x_gpio_request().

> +
> +	buf.state = (value == 1) ? BIT(gpio) : 0;
> +	buf.mask = BIT(gpio);
> +
> +	result = usb_control_msg(serial->dev,
> +				 usb_sndctrlpipe(serial->dev, 0),
> +				 CP210X_VENDOR_SPECIFIC,
> +				 REQTYPE_HOST_TO_DEVICE,
> +				 CP210X_WRITE_LATCH,
> +				 *(u16 *)&buf,

AFAICT this will work also on big-endian machines, but the implicit
endian conversions involved makes my head spin. ;)

It may be better to just encode the masks explicitly for the default
(non-cp2105) case that use wIndex:

	buf.state << 8 | buf.mask

when merging this with cp210x_gpio_set.

> +				 NULL, 0, USB_CTRL_SET_TIMEOUT);
> +
> +	if (result < 0) {
> +		dev_err(&serial->interface->dev,
> +			"Failed to set GPIO value.\n");
> +	}
> +}
> +
> +static int cp2102n_gpio_direction_get(struct gpio_chip *gc, unsigned int gpio)
> +{
> +	struct usb_serial *serial = gpiochip_get_data(gc);
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);
> +
> +	return priv->gpio_dir & BIT(gpio);
> +}

So for cp2105 we decided against implementing an input mode. We at least
need to be consistent here, so I suggest starting with dropping those
bits of the implementation and we can have that discussion again and,
depending on the outcome, possibly enable it for all cp210x devices
later.

> +static u16 fletcher16(u8 *data, u16 bytes)
> +{
> +	u16 sum1 = 0xff, sum2 = 0xff;
> +	u16 tlen;
> +
> +	while (bytes) {
> +		tlen = bytes >= 20 ? 20 : bytes;
> +		bytes -= tlen;
> +		do {
> +			sum2 += sum1 += *data++;
> +		} while (--tlen);
> +		sum1 = (sum1 & 0xff) + (sum1 >> 8);
> +		sum2 = (sum2 & 0xff) + (sum2 >> 8);
> +	}
> +	/* Second reduction step to reduce sums to 8 bits */
> +	sum1 = (sum1 & 0xff) + (sum1 >> 8);
> +	sum2 = (sum2 & 0xff) + (sum2 >> 8);
> +	return sum2 << 8 | sum1;
> +}

I was going to comment on the odd coding style above, when I noticed
that you've copied this implementation from a silabs forum post. Not
good at all (as there was no indication of any license).

Please remove.

Fortunately, the below checksum is redundant so no need for you to
reimplement this yourself.

> +
> +static int cp2102n_gpio_init(struct usb_serial *serial)
> +{
> +	const u16 CONFIG_SIZE = 0x02A6;
> +	int result;
> +	u16 config_csum;
> +	u8 *config_buf;
> +	u8 gpio_ctrl;
> +	u8 gpio_mode;
> +	u8 gpio_latch;
> +	u8 gpio_rst_latch;
> +	u8 i;
> +	bool config_valid = true;
> +	struct cp210x_serial_private *priv = usb_get_serial_data(serial);

Style nit: Move longer declarations towards the top of the function
(reverse xmas style).

> +
> +	/* Retrieve device configuration from the device.
> +	 * The array received contains all customization settings
> +	 * done at the factory/manufacturer.
> +	 * Format of the array is documented at the time of writing at
> +	 * https://www.silabs.com/community/interface/knowledge-base.entry.html/2017/03/31/cp2102n_setconfig-xsfa
> +	 */

Multi-line comments should use the following format

	/*
	 * blah...
	 */

> +	config_buf = kmalloc(CONFIG_SIZE, GFP_KERNEL);
> +	if (!config_buf)
> +		return -ENOMEM;
> +
> +	result = cp210x_read_vendor_block(serial,
> +					  REQTYPE_DEVICE_TO_HOST,
> +					  CP210X_READ_2NCONFIG,
> +					  config_buf,
> +					  CONFIG_SIZE);
> +	if (result < 0)
> +		return result;
> +
> +	/* Check configuration for validity.
> +	 * The last two bytes of the array contain a fletcher16
> +	 * checksum of all the bytes before, which we can validate.
> +	 */
> +	config_csum = fletcher16(config_buf, CONFIG_SIZE - 2);
> +	if (((config_csum & 0xFF) != config_buf[CONFIG_SIZE - 1]) ||
> +	    ((config_csum >> 8)   != config_buf[CONFIG_SIZE - 2])) {
> +		config_valid = false;
> +		dev_err(&serial->interface->dev,
> +			"Corrupted device configuration received\n");
> +	}

So just drop this for now.

> +
> +	gpio_mode = config_buf[CP210X_2NCONFIG_GPIO_MODE_IDX];
> +	gpio_ctrl = config_buf[CP210X_2NCONFIG_GPIO_CONTROL_IDX];
> +	gpio_rst_latch = config_buf[CP210X_2NCONFIG_GPIO_RSTLATCH_IDX];
> +
> +	kfree(config_buf);
> +
> +	if (!config_valid)
> +		return -EIO;
> +
> +	/* We only support 4 GPIOs even on the QFN28 package because
> +	 * documentation about the CP2102N GetConfig Array
> +	 * does not seem to correspond to reality on this device.
> +	 */

Please be more specific here; what do you mean by not corresponding to
reality.

> +	priv->gc.ngpio = 4;
> +
> +	/* Get default pin states after reset. Needed so we can determine
> +	 * the direction of an open-drain pin.
> +	 */
> +	gpio_latch = (gpio_rst_latch >> 3) & 0x0F;
> +
> +	/* 0 indicates open-drain mode, 1 is push-pull */
> +	priv->gpio_mode = (gpio_mode >> 3) & 0x0F;
> +
> +	/* 0 indicates GPIO mode, 1 is alternate function */
> +	priv->gpio_control = (gpio_ctrl >> 2) & 0x0F;
> +
> +	/* The CP2102N does not strictly has input and output pin modes,
> +	 * it only knows open-drain and push-pull modes which is set at
> +	 * factory. An open-drain pin can function both as an
> +	 * input or an output. We emulate input mode for open-drain pins
> +	 * by making sure they are not driven low, and we do not allow
> +	 * push-pull pins to be set as an input.
> +	 */
> +	for (i = 0; i < priv->gc.ngpio; ++i) {
> +		/* Set direction to "input" iff
> +		 * pin is open-drain and reset value is 1
> +		 */
> +		if (CP2102N_PIN_OPENDRAIN(priv->gpio_mode, i) &&
> +		    (gpio_latch & BIT(i))) {
> +			priv->gpio_dir |= BIT(i);
> +		}
> +	}

So this can be simplified a bit by deferring implementing an input mode.

> +
> +	priv->gc.label = "cp2102n";
> +	priv->gc.get_direction = cp2102n_gpio_direction_get;
> +	priv->gc.direction_input = cp2102n_gpio_direction_input;
> +	priv->gc.direction_output = cp2102n_gpio_direction_output;
> +	priv->gc.get = cp2102n_gpio_get;
> +	priv->gc.set = cp2102n_gpio_set;
> +	priv->gc.owner = THIS_MODULE;
> +	priv->gc.parent = &serial->interface->dev;
> +	priv->gc.base = -1;
> +	priv->gc.can_sleep = true;
> +
> +	result = gpiochip_add_data(&priv->gc, serial);
> +	if (!result)
> +		priv->gpio_registered = true;

And this whole function should be merged with the cp2105 implementation.
Retrieving and parsing the configuration is obviously going to remain
type specific (and live in their own functions), but the above
initialisation and registration can be shared.

> +
> +	return result;
> +}
> +
>  #else
>  
>  static int cp2105_shared_gpio_init(struct usb_serial *serial)
> @@ -1462,6 +1706,11 @@ static int cp2105_shared_gpio_init(struct usb_serial *serial)
>  	return 0;
>  }
>  
> +static int cp2102n_gpio_init(struct usb_serial *serial)
> +{
> +	return 0;
> +}
> +
>  static void cp210x_gpio_remove(struct usb_serial *serial)
>  {
>  	/* Nothing to do */
> @@ -1522,7 +1771,13 @@ static int cp210x_attach(struct usb_serial *serial)
>  
>  	usb_set_serial_data(serial, priv);
>  
> -	if (priv->partnum == CP210X_PARTNUM_CP2105) {
> +	if (IS_CP2102N(priv->partnum)) {
> +		result = cp2102n_gpio_init(serial);
> +		if (result < 0) {
> +			dev_err(&serial->interface->dev,
> +				"GPIO initialisation failed, continuing without GPIO support\n");
> +		}
> +	} else if (priv->partnum == CP210X_PARTNUM_CP2105) {
>  		result = cp2105_shared_gpio_init(serial);
>  		if (result < 0) {
>  			dev_err(&serial->interface->dev,

And this all should be hidden away in a common cp210x_gpio_init()
function.

Thanks,
Johan
