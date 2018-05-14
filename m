Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-616870-1526295451-2-2980213110611866895
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_FORGED_FROMDOMAIN 0.248, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.249, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES enroda, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='utf-8'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1526295451; b=mBLGXNUf0yX//VLwY2wYsKCyqLgMCXCU7pu59/xgcceu2G2rKE
    NKOjRVBiJuLSPvE13EVAV1rmkAFkPkPQFbeprbSm8Y3VbC/XWpnhblI55PWc3Lm9
    M02+to6r8JMcRywle4zYCjo5rSR4joqiI0Im45F5VtDTRAPJExvPVicd2aGl5Q3Y
    bgHKYCHzm3YZovJPD52Gn5PyBWpObV+VfKE1IE3Gxbz3vJnYTmLZELKa73yDYVDw
    dm/WT5kOyAPHntCIZ/4+VjdoHBQQGNhpt5hEK8yyMXUwea1P1CDnoKhzCVeUdPov
    BAO5NGnhpBz2sIpkxCTiOEa3hTiXZSOrxK0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=subject:to:cc:references:from:message-id
    :date:mime-version:in-reply-to:content-type
    :content-transfer-encoding:sender:list-id; s=fm2; t=1526295451;
    bh=KbECTAoUJTmVXHwW9GfAKqNmQL5SBIEOZjFAJz/4QI4=; b=LjXln/3hhX4F
    Kp9k+QDW4ojF181vcLmlfXpyYMJ1oghsZs4K7y/eyjVxYJczINBXQsaxo4G1lxTO
    oDnbUwNkc3oWqcOVakz/1+uI27bz+Fv0j/7wU5P1gZp8rudtSL9La7waSeZRNeY2
    qfV4/WZc6YKmc2RL+QmZ8HxdLk6oO/rnxakl+e3v1u+7ka8Chw4hshPw4vdYI5zn
    /rx23o//fd2mj6XAcFDel287beppuL60sDCEM07sMNgk23Z8SILMt5KznwAGVxDQ
    ZXnZH1z/G0wj/ReSGQxsacjhg0AvLy4Kz4VtwCkB3MiSBUDabvqE/DXEJ3eALABt
    PY3/ZS3giw==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=gmail.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=gmail.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOCtTWypSi9E7/E4WmjmlTt/e6mUESavx/XlYtQn/O/k3dGNCgFp7wnR7X2cRsJa7An4lAD5cNykmwTayXgDCykYNt2GPMlXlwgP15hl6EE1K2o/QPIC
    qksY53dYnrn5XIgzTV7cvuj1CsNW71HBDeYhaqy2CtwD9ru9LtzfGsv5ZjWV66iRtI/EOhPjyvROAJ7F8y+IOSnp/hgYESM2KALr3Q5a9p7mmqeMWr5IYHL2
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=x7bEGLp0ZPQA:10
    a=dXFxZaXSprYA:10 a=VUJBJC2UJ8kA:10 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8
    a=VX2pW7jPrce8d0iPRuQA:9 a=QEXdDO2ut3YA:10 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeENK5a (ORCPT <rfc822;greg@kroah.com>);
        Mon, 14 May 2018 06:57:30 -0400
Received: from mout01.posteo.de ([185.67.36.141]:46276 "EHLO mout01.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752385AbeENK53 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Mon, 14 May 2018 06:57:29 -0400
Subject: Re: [PATCH v3 6/6] tty/serial: atmel: changed the driver to work
 under at91-usart mfd
To: Radu Pirea <radu.pirea@microchip.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org
Cc: mark.rutland@arm.com, robh+dt@kernel.org, lee.jones@linaro.org,
        gregkh@linuxfoundation.org, jslaby@suse.com,
        richard.genoud@gmail.com, alexandre.belloni@bootlin.com,
        nicolas.ferre@microchip.com, broonie@kernel.org
References: <20180511103822.31698-1-radu.pirea@microchip.com>
 <20180511103822.31698-7-radu.pirea@microchip.com>
From: Richard Genoud <richard.genoud@gmail.com>
Message-ID: <4a75568e-a52e-3872-f465-d707372a5c12@sorico.fr>
Date: Mon, 14 May 2018 12:57:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511103822.31698-7-radu.pirea@microchip.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi,

On 11/05/2018 12:38, Radu Pirea wrote:
> This patch modifies the place where resources and device tree properties
> are searched.
> 
> Signed-off-by: Radu Pirea <radu.pirea@microchip.com>
> ---
>  drivers/tty/serial/Kconfig        |  1 +
>  drivers/tty/serial/atmel_serial.c | 29 +++++++++++++++--------------
>  2 files changed, 16 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 3682fd3e960c..25e55332f8b1 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -119,6 +119,7 @@ config SERIAL_ATMEL
>  	depends on ARCH_AT91 || COMPILE_TEST
>  	select SERIAL_CORE
>  	select SERIAL_MCTRL_GPIO if GPIOLIB
> +	select MFD_AT91_USART
>  	help
>  	  This enables the driver for the on-chip UARTs of the Atmel
>  	  AT91 processors.
> diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
> index df46a9e88c34..6b4494352853 100644
> --- a/drivers/tty/serial/atmel_serial.c
> +++ b/drivers/tty/serial/atmel_serial.c
> @@ -193,8 +193,8 @@ static struct console atmel_console;
>  
>  #if defined(CONFIG_OF)
>  static const struct of_device_id atmel_serial_dt_ids[] = {
> -	{ .compatible = "atmel,at91rm9200-usart" },
> -	{ .compatible = "atmel,at91sam9260-usart" },
> +	{ .compatible = "atmel,at91rm9200-usart-serial" },
> +	{ .compatible = "atmel,at91sam9260-usart-serial" },
>  	{ /* sentinel */ }
>  };
>  #endif
> @@ -1631,7 +1631,7 @@ static void atmel_tasklet_tx_func(unsigned long data)
>  static void atmel_init_property(struct atmel_uart_port *atmel_port,
>  				struct platform_device *pdev)
>  {
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.parent->of_node;
>  
>  	/* DMA/PDC usage specification */
>  	if (of_property_read_bool(np, "atmel,use-dma-rx")) {
> @@ -2223,7 +2223,8 @@ static const char *atmel_type(struct uart_port *port)
>  static void atmel_release_port(struct uart_port *port)
>  {
>  	struct platform_device *pdev = to_platform_device(port->dev);
> -	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
> +	int size = to_platform_device(pdev->dev.parent)->resource[0].end -
> +		to_platform_device(pdev->dev.parent)->resource[0].start + 1;
I think it may be simpler with something like:
+	struct platform_device *mfd_pdev = to_platform_device(port->dev->parent);
+	int size = mfd_pdev->resource[0].end - mfd_pdev->resource[0].start + 1;

>  
>  	release_mem_region(port->mapbase, size);
>  
> @@ -2239,7 +2240,8 @@ static void atmel_release_port(struct uart_port *port)
>  static int atmel_request_port(struct uart_port *port)
>  {
>  	struct platform_device *pdev = to_platform_device(port->dev);
> -	int size = pdev->resource[0].end - pdev->resource[0].start + 1;
> +	int size = to_platform_device(pdev->dev.parent)->resource[0].end -
> +		to_platform_device(pdev->dev.parent)->resource[0].start + 1;
>  
ditto

>  	if (!request_mem_region(port->mapbase, size, "atmel_serial"))
>  		return -EBUSY;
> @@ -2345,23 +2347,23 @@ static int atmel_init_port(struct atmel_uart_port *atmel_port,
Here, we could also add:
+	struct device *mfd_dev = pdev->dev.parent;
+	struct platform_device *mfd_pdev = to_platform_device(mfd_dev);

>  	atmel_init_property(atmel_port, pdev);
>  	atmel_set_ops(port);
>  
> -	uart_get_rs485_mode(&pdev->dev, &port->rs485);
> +	uart_get_rs485_mode(pdev->dev.parent, &port->rs485);
...and use them here

>  
>  	port->iotype		= UPIO_MEM;
>  	port->flags		= UPF_BOOT_AUTOCONF | UPF_IOREMAP;
>  	port->ops		= &atmel_pops;
>  	port->fifosize		= 1;
>  	port->dev		= &pdev->dev;
> -	port->mapbase	= pdev->resource[0].start;
> -	port->irq	= pdev->resource[1].start;
> +	port->mapbase		= to_platform_device(pdev->dev.parent)->resource[0].start;
> +	port->irq		= to_platform_device(pdev->dev.parent)->resource[1].start;
and here
I think it would be easier to read.

>  	port->rs485_config	= atmel_config_rs485;
> -	port->membase	= NULL;
> +	port->membase		= NULL;
>  
>  	memset(&atmel_port->rx_ring, 0, sizeof(atmel_port->rx_ring));
>  
>  	/* for console, the clock could already be configured */
>  	if (!atmel_port->clk) {
> -		atmel_port->clk = clk_get(&pdev->dev, "usart");
> +		atmel_port->clk = clk_get(pdev->dev.parent, "usart");
and here

>  		if (IS_ERR(atmel_port->clk)) {
>  			ret = PTR_ERR(atmel_port->clk);
>  			atmel_port->clk = NULL;
> @@ -2656,7 +2658,7 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
>  	atmel_port->rts_low = 0;
>  	atmel_port->rts_high = 0;
>  
> -	if (of_property_read_u32(pdev->dev.of_node,
> +	if (of_property_read_u32(pdev->dev.parent->of_node,
>  				 "atmel,fifo-size",
>  				 &atmel_port->fifo_size))
>  		return;
> @@ -2694,11 +2696,10 @@ static void atmel_serial_probe_fifos(struct atmel_uart_port *atmel_port,
>  static int atmel_serial_probe(struct platform_device *pdev)
>  {
>  	struct atmel_uart_port *atmel_port;
> -	struct device_node *np = pdev->dev.of_node;
> +	struct device_node *np = pdev->dev.parent->of_node;
>  	void *data;
>  	int ret = -ENODEV;
>  	bool rs485_enabled;
> -
I think this line feed wasn't so bad.

>  	BUILD_BUG_ON(ATMEL_SERIAL_RINGSIZE & (ATMEL_SERIAL_RINGSIZE - 1));
>  
>  	ret = of_alias_get_id(np, "serial");
> @@ -2845,7 +2846,7 @@ static struct platform_driver atmel_serial_driver = {
>  	.suspend	= atmel_serial_suspend,
>  	.resume		= atmel_serial_resume,
>  	.driver		= {
> -		.name			= "atmel_usart",
> +		.name			= "atmel_usart_serial",
>  		.of_match_table		= of_match_ptr(atmel_serial_dt_ids),
>  	},
>  };
> 

After your patch, the DMA is not selected anymore:
atmel_usart_serial atmel_usart_serial.0.auto: TX channel not available, switch to pio
instead of:
atmel_usart fffff200.serial: using dma1chan2 for tx DMA transfers

And the kernel doesn't log anymore on the serial console, despite the loglevel=8
(after reverting this series, the kernel logs reappears on the serial console)

(tests done on sam9g35)

regards,
Richard

