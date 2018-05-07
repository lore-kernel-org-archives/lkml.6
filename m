Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-474343-1525680181-2-394590958791216947
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no ("Email failed DMARC policy for domain")
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, RCVD_IN_DNSWL_HI -5, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: to='iso-8859-1', plain='iso-8859-1'
X-IgnoreVacation: yes ("Email failed DMARC policy for domain")
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1525680181; b=N+0vcrS9SQeJBaSQi7z52j7j456DHNAv76p6bPiqDWx+uRSRV2
    9IviyB36E22TY3xaXvjZrRNQgwFb8p3lg1BEIBQm0jJ/3+Bybq7nQIwzWCQwCRZ1
    c3HZQ3UpH7XOjCJ+bncBbUjQYaap/OuIHuu8A98fhUSVPNUa02fdt0IgrmgEcQjp
    HBGYjzHQiHwdmFgi77eh6FPl2mx7y5OuO6f7pT26Y7eYSGvchufuQSjWXB5dDBOo
    /9GoZstbnoYJu+MD+Arl/1Z7E0YRb0XMmjEur+stUV2EqZuEtQIVesixv2VBHZYn
    3aKnVi60mfB1XtnDkqPV8ihcJua1K8UB+/3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1525680181; bh=OEsy5Z37y/x
    lnKW1ioME8Nycn5yQs0SLZ8prHjcxPaw=; b=PUnf/xgeiMPiW9BQMQHBH/q07YS
    KbCjFLeWs2VqoxYb3VfO/LXFikFuNx2U6g7/nx+h9M2CxSro9meECLVnQuFIBWh9
    7sfLyF+6Q4+9MitBTXABFPlc+8bxH+on43hZwdi8mmMWyZk62NT3i0zZy0cp2I/a
    /+FmQBDo5kXAycu6l/LHWSRET+4dHYF1+bR8WmXGQF6bYskxR7EuiYwS9yF4Hhx3
    GM+zEgtQH1TZdajPvZ0eSXi2f1/7ceSzHkaQJfGvJQWZNS/KMBTRddRQcxlQlw3i
    rhoDODnub5FC2Q8UmN9oJjwfl3x8xWw3WGIS5OXaCCZ5SjMBnOGFQR+jbDg==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
    header.d=gmail.com header.i=@gmail.com header.b=GAOAtBZF x-bits=2048
    x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
    smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
    header.d=1e100.net header.i=@1e100.net header.b=pFiO1VAa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
    smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
    header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (message has been altered, 2048-bit rsa key sha256)
      header.d=gmail.com header.i=@gmail.com header.b=GAOAtBZF x-bits=2048
      x-keytype=rsa x-algorithm=sha256 x-selector=20161025;
    dmarc=fail (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org
      smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (message has been altered, 2048-bit rsa key)
      header.d=1e100.net header.i=@1e100.net header.b=pFiO1VAa;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass
      smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no
      header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfExGMA/fPYuMkh2NHSqwRNFGMB9lFQUfxHMRaWraEw+Qn9iCtz916GhbEizdNrjPNfME5wZ1YJPOHmMCiiBNvZf/6gxXpoCYxgxaOZ/tH/8iCGHhwsW5
    om/rS0pTSjLbBexaCwbATfbYp3zUQ8cmzlkDDiufXRXdpReDcfSY9IBbYMz5pSr4+ymDr/2nwUzi/+jYRoEefzKf063NYpmrrm9P/GoGWTxOFMuSoazmVbZH
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=VUJBJC2UJ8kA:10
    a=VwQbUJbxAAAA:8 a=PFl7De6MLHmjanGSNZsA:9 a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751894AbeEGIC7 (ORCPT <rfc822;greg@kroah.com>);
        Mon, 7 May 2018 04:02:59 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:37760 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751900AbeEGIC5 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Mon, 7 May 2018 04:02:57 -0400
X-Google-Smtp-Source: AB8JxZqYU7BRn54RBk0BJIafnC/RpwRY5F3sC0VwhwctbDLTLoR5L/I+OkplvRAnqIUbNM6ZgLPkFQ==
Date: Mon, 7 May 2018 10:02:52 +0200
From: Johan Hovold <johan@kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
Cc: linux-serial@vger.kernel.org,
        One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-arm-kernel@lists.infradead.org,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2] tty: implement led triggers
Message-ID: <20180507080252.GO2285@localhost>
References: <0c1bb915-bd92-4433-61ec-78fdba453396@arm.com>
 <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180503201952.16592-1-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 03, 2018 at 10:19:52PM +0200, Uwe Kleine-König wrote:
> The rx trigger fires when data is pushed to the ldisc. This is a bit later
> than the actual receiving of data but has the nice benefit that it
> doesn't need adaption for each driver and isn't in the hot path.
> 
> Similarily the tx trigger fires when data taken from the ldisc.

You meant copied from user space, or written to the ldisc, here.

Note that the rx-path is shared with serdev, but the write path is not.
So with this series, serdev devices would only trigger the rx-led.

> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Changes since v1, sent with Message-Id: 
> 20180503100448.1350-1-u.kleine-koenig@pengutronix.de:
> 
>  - implement tx trigger;
>  - introduce Kconfig symbol for conditional compilation;
>  - set trigger to NULL if allocating the name failed to not free random
>    pointers in case the port struct wasn't zeroed;
>  - use if/else instead of goto

> @@ -499,6 +500,7 @@ static void flush_to_ldisc(struct work_struct *work)
>  		struct tty_buffer *head = buf->head;
>  		struct tty_buffer *next;
>  		int count;
> +		unsigned long delay = 50 /* ms */;

Comment after the semicolon?

>  
>  		/* Ldisc or user is trying to gain exclusive access */
>  		if (atomic_read(&buf->priority))

> diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
> index 25d736880013..f042879a597c 100644
> --- a/drivers/tty/tty_port.c
> +++ b/drivers/tty/tty_port.c
> @@ -16,6 +16,7 @@
>  #include <linux/wait.h>
>  #include <linux/bitops.h>
>  #include <linux/delay.h>
> +#include <linux/leds.h>
>  #include <linux/module.h>
>  #include <linux/serdev.h>
>  
> @@ -157,6 +158,30 @@ struct device *tty_port_register_device_attr_serdev(struct tty_port *port,
>  
>  	tty_port_link_device(port, driver, index);
>  
> +#ifdef CONFIG_TTY_LEDS_TRIGGER
> +	port->led_trigger_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
> +					      driver->name, index);
> +	if (port->led_trigger_rx_name) {
> +		led_trigger_register_simple(port->led_trigger_rx_name,
> +					    &port->led_trigger_rx);
> +	} else {
> +		port->led_trigger_rx = NULL;
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +	}
> +
> +	port->led_trigger_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
> +					      driver->name, index);
> +	if (port->led_trigger_tx_name) {
> +		led_trigger_register_simple(port->led_trigger_tx_name,
> +					    &port->led_trigger_tx);
> +	} else {
> +		port->led_trigger_tx = NULL;
> +		pr_err("Failed to allocate trigger name for %s%d\n",
> +		       driver->name, index);
> +	}
> +#endif

Besides the ugly ifdefs here, you're leaking the above LED resources in
the error paths below (e.g. on probe deferrals).

>  	dev = serdev_tty_port_register(port, device, driver, index);
>  	if (PTR_ERR(dev) != -ENODEV) {
>  		/* Skip creating cdev if we registered a serdev device */

> @@ -249,6 +249,13 @@ struct tty_port {
>  						   set to size of fifo */
>  	struct kref		kref;		/* Ref counter */
>  	void 			*client_data;
> +
> +#ifdef CONFIG_TTY_LEDS_TRIGGER
> +	struct led_trigger	*led_trigger_rx;
> +	char			*led_trigger_rx_name;

const?

> +	struct led_trigger	*led_trigger_tx;
> +	char			*led_trigger_tx_name;

ditto.

> +#endif

Johan
