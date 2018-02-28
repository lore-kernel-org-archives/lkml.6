Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-40036-1519821489-2-14280125712590551237
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES enroda,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1519821488; b=LrYRoomBYjhS4UNGOw+vYESzVF+SLMzPLnAtTJ8ooi7eS0W
    3P9O6CYLaPBWTAilmNKnVZwJc7SVIa/ji4CKKxG/I9KkP4zDSdqLW/RUjPiff/N6
    uhImaEZBjFQxnUdSs0r7YaHxyiENXTkYKdLJW1uwSsUqIQDBTDkZvTfVTVaGNUz+
    GBNOrBef/Cur+Io0GmaImV4qdJ6NYUwqr0L53uqtx0lt6/a+9xUZmREJA0ZeTFG8
    Jjeyuzdm3yld6G/Sp7cwHr/J5aZZoNKWtyunHi+YoWfrlpJ3hrd5SYE2UB7nG3ny
    I9NeQi23N2cOP//3ms0HjKmKuPmGF/WYPYMZWzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1519821488; bh=qqS7IwAojKAeeS6i4jfPxN7cgd
    TtttjraG3hIv8rjXg=; b=ZWSpvOwRz5mhUI1QQFDeYVeNzW3YmDKC9Y7Z0NotGz
    5bLDMhAkvCV1IDGBAayHIE8OcULfbOWH8Z+R4swHVFJ6VqoOLKwKtkipE5/Bz6Ds
    1PVD/EQxz1cP88UrNnvny7dGNZDuYgM2uESY0E+U9Niu1+lRkWqbLuR9w0Smkdx3
    nK2Gk2Jw6jy/4JNDhfyKgTkvcKEDBI/+hg41jYbE+LSayVtWUf6VJue/51VuFkY3
    wP2pcCUlQJ1Y1ykwsCBtKdLluohv2+VruDJev0i5JpvXbn1ky77HsRjpB2FXsMd8
    hlipPBZhZuH/uJhx9MrOUSELfU+6A1Yhso2FS0ndy5hA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=linuxfoundation.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=linuxfoundation.org header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752513AbeB1Mhy (ORCPT <rfc822;greg@kroah.com>);
        Wed, 28 Feb 2018 07:37:54 -0500
Received: from mail.linuxfoundation.org ([140.211.169.12]:55590 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752226AbeB1Mhw (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 28 Feb 2018 07:37:52 -0500
Date: Wed, 28 Feb 2018 13:37:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tomer Maimon <tomer.maimon@nuvoton.com>,
        Avi Fishman <Avi.Fishman@nuvoton.com>,
        Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH v2] serial: 8250: Add Nuvoton NPCM UART
Message-ID: <20180228123753.GA10114@kroah.com>
References: <20180215021720.14870-1-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215021720.14870-1-joel@jms.id.au>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 15, 2018 at 12:47:20PM +1030, Joel Stanley wrote:
> The Nuvoton UART is almost compatible with the 8250 driver when probed
> via the 8250_of driver, however it requires some extra configuration
> at startup.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  Remove redundant whitespace
>  Use port number 40 to fill in a gap
> 
>  Documentation/devicetree/bindings/serial/8250.txt |  1 +
>  drivers/tty/serial/8250/8250_of.c                 |  1 +
>  drivers/tty/serial/8250/8250_port.c               | 29 +++++++++++++++++++++++
>  include/uapi/linux/serial_core.h                  |  3 +++
>  include/uapi/linux/serial_reg.h                   |  5 ++++
>  5 files changed, 39 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/8250.txt b/Documentation/devicetree/bindings/serial/8250.txt
> index dad3b2ec66d4..aeb6db4e35c3 100644
> --- a/Documentation/devicetree/bindings/serial/8250.txt
> +++ b/Documentation/devicetree/bindings/serial/8250.txt
> @@ -24,6 +24,7 @@ Required properties:
>  	- "ti,da830-uart"
>  	- "aspeed,ast2400-vuart"
>  	- "aspeed,ast2500-vuart"
> +	- "nuvoton,npcm750-uart"
>  	- "serial" if the port type is unknown.
>  - reg : offset and length of the register set for the device.
>  - interrupts : should contain uart interrupt.
> diff --git a/drivers/tty/serial/8250/8250_of.c b/drivers/tty/serial/8250/8250_of.c
> index 160b8906d9b9..9835b1c1cbe1 100644
> --- a/drivers/tty/serial/8250/8250_of.c
> +++ b/drivers/tty/serial/8250/8250_of.c
> @@ -316,6 +316,7 @@ static const struct of_device_id of_platform_serial_table[] = {
>  	{ .compatible = "mrvl,mmp-uart",
>  		.data = (void *)PORT_XSCALE, },
>  	{ .compatible = "ti,da830-uart", .data = (void *)PORT_DA830, },
> +	{ .compatible = "nuvoton,npcm750-uart", .data = (void *)PORT_NPCM, },
>  	{ /* end of list */ },
>  };
>  MODULE_DEVICE_TABLE(of, of_platform_serial_table);
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/8250/8250_port.c
> index 1328c7e70108..a72222f8b005 100644
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -293,6 +293,15 @@ static const struct serial8250_config uart_config[] = {
>  				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
>  		.flags		= UART_CAP_FIFO,
>  	},
> +	[PORT_NPCM] = {
> +		.name		= "Nuvoton 16550",
> +		.fifo_size	= 16,
> +		.tx_loadsz	= 16,
> +		.fcr		= UART_FCR_ENABLE_FIFO | UART_FCR_R_TRIG_10 |
> +				  UART_FCR_CLEAR_RCVR | UART_FCR_CLEAR_XMIT,
> +		.rxtrig_bytes	= {1, 4, 8, 14},
> +		.flags		= UART_CAP_FIFO,
> +	},
>  };
>  
>  /* Uart divisor latch read */
> @@ -2140,6 +2149,15 @@ int serial8250_do_startup(struct uart_port *port)
>  				UART_DA830_PWREMU_MGMT_FREE);
>  	}
>  
> +	if (port->type == PORT_NPCM) {
> +		/*
> +		 * Nuvoton calls the scratch register 'UART_TOR' (timeout
> +		 * register). Enable it, and set TIOC (timeout interrupt
> +		 * comparator) to be 0x20 for correct operation.
> +		 */
> +		serial_port_out(port, UART_NPCM_TOR, UART_NPCM_TOIE | 0x20);
> +	}
> +
>  #ifdef CONFIG_SERIAL_8250_RSA
>  	/*
>  	 * If this is an RSA port, see if we can kick it up to the
> @@ -2462,6 +2480,15 @@ static unsigned int xr17v35x_get_divisor(struct uart_8250_port *up,
>  	return quot_16 >> 4;
>  }
>  
> +/* Nuvoton NPCM UARTs have a custom divisor calculation */
> +static unsigned int npcm_get_divisor(struct uart_8250_port *up,
> +		unsigned int baud)
> +{
> +	struct uart_port *port = &up->port;
> +
> +	return DIV_ROUND_CLOSEST(port->uartclk, 16 * baud + 2) - 2;
> +}
> +
>  static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
>  					   unsigned int baud,
>  					   unsigned int *frac)
> @@ -2482,6 +2509,8 @@ static unsigned int serial8250_get_divisor(struct uart_8250_port *up,
>  		quot = 0x8002;
>  	else if (up->port.type == PORT_XR17V35X)
>  		quot = xr17v35x_get_divisor(up, baud, frac);
> +	else if (up->port.type == PORT_NPCM)
> +		quot = npcm_get_divisor(up, baud);
>  	else
>  		quot = uart_get_divisor(port, baud);
>  
> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
> index 1c8413f93e3d..dce5f9dae121 100644
> --- a/include/uapi/linux/serial_core.h
> +++ b/include/uapi/linux/serial_core.h
> @@ -76,6 +76,9 @@
>  #define PORT_SUNZILOG	38
>  #define PORT_SUNSAB	39
>  
> +/* Nuvoton UART */
> +#define PORT_NPCM	40
> +
>  /* Intel EG20 */
>  #define PORT_PCH_8LINE	44
>  #define PORT_PCH_2LINE	45
> diff --git a/include/uapi/linux/serial_reg.h b/include/uapi/linux/serial_reg.h
> index be07b5470f4b..f82f3c869df9 100644
> --- a/include/uapi/linux/serial_reg.h
> +++ b/include/uapi/linux/serial_reg.h
> @@ -376,5 +376,10 @@
>  #define UART_ALTR_EN_TXFIFO_LW	0x01	/* Enable the TX FIFO Low Watermark */
>  #define UART_ALTR_TX_LOW	0x41	/* Tx FIFO Low Watermark */
>  
> +
> +/* Nuvoton NPCM timeout register */
> +#define UART_NPCM_TOR		7
> +#define UART_NPCM_TOIE		BIT(7)	/* Timeout Interrupt Enable */

Why is this needed in a userspace api file?  That feels very odd for
just a new device.  Please put this somewhere internal.

thanks,

greg k-h
