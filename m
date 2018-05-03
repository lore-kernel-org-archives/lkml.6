Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2326437-1525342253-2-7091754497605463081
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, T_TVD_MIME_EPI 0.01, LANGUAGES enda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='cz',
  MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-Attached: signature.asc
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525342252; b=JXdY5fDdpHfYQSr1R6TmYEW1LKFL0DXDrHwRyRGHCHsmcnroLS
    LQibOpGVdDLnxEaKkOrK7g838FfGPhVvRddfiR8naHk/kg9bxwbBs+MIPaCHmMgO
    jMXwWJqSusaFiy+SDOSIyF3tg7qsPavubQb6xxlGcbL4eis8RVd0/3AzE2xWm9my
    YuDUSHVCWf4RdK/idHaPsG3o4vYhMTIPgoa8KLcQAymZc25/CEN/dLL0LFWJUIFB
    MFxMAVt/mFUAMGyZs2zUqHj0bBvBYOrUDnLZEu0ph4/ZpU8umTjdlw4HV7O86lSk
    be/gz8Q73FwjJm7EL4QXiMlkcDbQeMkHRaYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1525342252; bh=Y9PD0q1nX1GwC9WQwxY9Rnr339FCr7
    mZUHtHaya/fEk=; b=YvsqLyW8bspJrKPyuV86Ek7gjwDv7sL5mx9riE5F7U2jX2
    6zcw8sMuBJAMfvQH+IoQ0XVg/k4VYbGaTIfuXiuDiMlnxfWjephwQj7BYxw8PXTL
    TVKBcWEDl5VHdhgM/J6RZTzCxFRnpKiluOe54/m77SZep9mWTyhLPYCpVkWPlAw+
    07ZMTHr97BUDLNhyry95HKO/P8CxXcRMgoFCtH6QMruO5z/xacWvcZF1CX4LwuUX
    AXPlhXJMmjiiXUGYTU4kMskCMCkL/rY0sa+FXVOQC4hq+fIw+slTzHzyNSYoCTLl
    fP6aPsAU9IfMquc/f0uzQwT7SFX+EEw6TiTEAM6g==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=ucw.cz;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=ucw.cz header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-51 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfMV5JXDEB1qdQEeM+ahKvdXmJCCBD5jLEnK9Fd7lxh3S///DahzbRHfslnX/gux8DjzsWyeBXu/rP2m/r5ShpVll4iEl1qo6Q2KzPMZ7m4tcQEVE5RXD
    YT7YCTUYn49GwqB+xoCb6lRl2Tc7PXnLeZ8Z7RYy/3GcdmXgw8JLxIGjRlxc1F6k4jgBPPcG4WND7IeN7Nldx/k0P45WC787A5MA2JogIh0dmtG5vBXHopxn
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=VUJBJC2UJ8kA:10 a=M8rcC2nyAAAA:8
    a=RXnXJx7MAAAA:8 a=sEGx8BZ9FX8iUDCLfCYA:9 a=hNRphw4WXlbpX645:21
    a=QJDrle308BM4i2KR:21 a=wPNLvfGTeEIA:10 a=0dxXHNIcbWwA:10 a=gA6IeH5FQcgA:10
    a=NWVoK91CQyQA:10 a=3NzYuyWAS7xzxHFERCgA:9 a=ONNS8QRKHyMA:10 a=VwQbUJbxAAAA:8
    a=_3iAN5dmJPxjh_Nw_akA:9 a=x8gzFH9gYPwA:10 a=K9tzwgKBnWaK51F8Cre1:22
    a=U_UV0sFCMgXoaKVbI-EZ:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751484AbeECKKu (ORCPT <rfc822;greg@kroah.com>);
        Thu, 3 May 2018 06:10:50 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:42999 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751141AbeECKKt (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Thu, 3 May 2018 06:10:49 -0400
Date: Thu, 3 May 2018 12:10:47 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org, kernel@pengutronix.de,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Subject: Re: [PATCH] tty: implement a rx led trigger
Message-ID: <20180503101047.GF32180@amd>
References: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="XStn23h1fwudRqtG"
Content-Disposition: inline
In-Reply-To: <20180503100448.1350-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


--XStn23h1fwudRqtG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The trigger fires when data is pushed to the ldisc. This is a bit later
> than the actual receiving of data but has the nice benefit that it
> doesn't need adaption for each driver and isn't in the hot path.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Well, why not, but there certainly should be config option? Because I
really don't see many people wanting to use this trigger.

> diff --git a/drivers/tty/tty_buffer.c b/drivers/tty/tty_buffer.c
> index c996b6859c5e..4d364b77b1a7 100644
> --- a/drivers/tty/tty_buffer.c
> +++ b/drivers/tty/tty_buffer.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/module.h>
>  #include <linux/ratelimit.h>
> +#include <linux/leds.h>
> =20
> =20
>  #define MIN_TTYB_SIZE	256
> @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
>  		struct tty_buffer *head =3D buf->head;
>  		struct tty_buffer *next;
>  		int count;
> +		unsigned long delay =3D 50 /* ms */;
> =20
>  		/* Ldisc or user is trying to gain exclusive access */
>  		if (atomic_read(&buf->priority))
> @@ -521,6 +523,8 @@ static void flush_to_ldisc(struct work_struct *work)
>  			continue;
>  		}
> =20
> +		led_trigger_blink_oneshot(port->led_trigger_rx, &delay, &delay, 0);
> +
>  		count =3D receive_buf(port, head, count);
>  		if (!count)
>  			break;
> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 25d736880013..51b78a585417 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -16,6 +16,7 @@
>  #include <linux/wait.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/serdev.h>
> =20
> @@ -157,6 +158,18 @@ struct device *tty_port_register_device_attr_serdev(=
struct tty_port *port,
> =20
>  	tty_port_link_device(port, driver, index);
> =20
> +	port->led_trigger_rx_name =3D kasprintf(GFP_KERNEL, "%s%d-rx",
> +					      driver->name, index);
> +	if (!port->led_trigger_rx_name) {
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +		goto skip_trigger;
> +	}
> +
> +	led_trigger_register_simple(port->led_trigger_rx_name,
> +				    &port->led_trigger_rx);
> +
> +skip_trigger:
>  	dev =3D serdev_tty_port_register(port, device, driver, index);
>  	if (PTR_ERR(dev) !=3D -ENODEV) {
>  		/* Skip creating cdev if we registered a serdev device */
> @@ -206,6 +219,9 @@ void tty_port_unregister_device(struct tty_port *port,
>  	if (ret =3D=3D 0)
>  		return;
> =20
> +	led_trigger_unregister_simple(port->led_trigger_rx);

Is it ok to unregister if it was not registered in the first place?

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--XStn23h1fwudRqtG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAlrq4CcACgkQMOfwapXb+vKkDgCeJqhQln+cMJ4UzWGgP6Ho7Pe3
zOEAoIZ57G3On5bNOXQKREFXGEt8bxYc
=AyCO
-----END PGP SIGNATURE-----

--XStn23h1fwudRqtG--
