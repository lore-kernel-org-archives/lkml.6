Return-Path: <linux-serial-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-421240-1524059190-2-638998212589702700
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US', FromHeader='de',
  MailFrom='org'
X-Spam-charsets: from='iso-8859-1', plain='iso-8859-1'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-serial-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524059189; b=i1z6TQn2UR4IyJxQma2dWbxe1SStEHSAP3SqP5Vu64gSVHqzYq
    DR5DJtxdQ2rjfjEWjrd9x8Srflpa6L4q6zZDSWRhsnx4MEI/98Dun97oW6rOkh0n
    p/WlU7+zaRGVHdNajI91p9ftm6EGLsH8mbnZbbWdColYyUq1EjIGqmADJL9IyRWR
    gN54Z83wpkpzHBFs7rgzSMsUsDWgMaBTqpvCrXECz/NNPP/w6LGmsekuVP8pQMk5
    YPoPS6C2j1MF6GP1F4yzfOpbIdDWhiAl+sBqaIM94SOSyTxi08brz+GNfTWR4li0
    rzBxFa2nTWTeC9WDxgJOSTUUTHVRVyFytoyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:content-transfer-encoding
    :in-reply-to:sender:list-id; s=fm2; t=1524059189; bh=LFhpqtXMfV7
    qcxLnKNDHxC+JZPkFIU45T42bPRPQI6M=; b=wcx3XDxSK7zJv7VpyD++xXjqdWO
    phd3zniBqD9TTjKoi8h0a6qHhYgbLgROJ49O8mdJZNi3s0fgsziOhHw+ztGXnW2I
    +2y+k7HVkf1OAo2I6u+OZZIx2Fat/xh6cbU5U/sGF+TXKs4netzO25fKwzlMXgSz
    BhgDtzFSKm2SsabBAc5T+OcZPBlpwtLgkhDbIPftdfy9DS8eCz2Ay2f3IFFWQYkO
    Aj6WavDOBZjaJkkmQuGIRhsMzZwsH+kd3daHfICS7KTyHdtlvMocf8CKZgtrS5ty
    fNwyq+bUgL8bYcch0Yp1n5wt1wEx701+c/KGkEsHT0V49ZuCxRjwLYZB+Ww==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=pengutronix.de;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-serial-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=pengutronix.de header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfCFv/ZTbKFFxww8yQVOcRvcJsr+KWoJA9bUUXXeXJp4E3gIV7f8CWqBffqwTd+1ujhQHmAkIQ9uh3bwSBhIHqJs0FMGs6mEHbkvQwpaPGROJCkRuS+vo
    NY06ZTkIknMaWXPlhfW0ZZj+/PW2eCgPHeWaW9gaFmB5xn0tmOH9R/WIong54v996gweAuVRzSmxMEAU+2PdkofLdtAT1jh8XPLf11E8qgqt2EN5N30tjJHj
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=8nJEP1OIZ-IA:10 a=xqWC_Br6kY4A:10
    a=Kd1tUaAdevIA:10 a=bGNZPXyTAAAA:8 a=VwQbUJbxAAAA:8 a=FTSrWAyPBPSAFtecld0A:9
    a=wPNLvfGTeEIA:10 a=x8gzFH9gYPwA:10 a=yL4RfsBhuEsimFDS2qtJ:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751580AbeDRNq2 (ORCPT <rfc822;greg@kroah.com>);
        Wed, 18 Apr 2018 09:46:28 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:43015 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750872AbeDRNq2 (ORCPT
        <rfc822;linux-serial@vger.kernel.org>);
        Wed, 18 Apr 2018 09:46:28 -0400
Date: Wed, 18 Apr 2018 15:46:19 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
        <u.kleine-koenig@pengutronix.de>
To: Stefan Agner <stefan@agner.ch>
Cc: gregkh@linuxfoundation.org, lukas@wunner.de, jslaby@suse.com,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: imx: warn user when using unsupported
 configuration
Message-ID: <20180418134619.xubgmbiezzlzbay3@pengutronix.de>
References: <20180418133217.14568-1-stefan@agner.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180418133217.14568-1-stefan@agner.ch>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-serial@vger.kernel.org
Sender: linux-serial-owner@vger.kernel.org
X-Mailing-List: linux-serial@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hello Stefan,

On Wed, Apr 18, 2018 at 03:32:17PM +0200, Stefan Agner wrote:
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index 91f3a1a5cb7f..1ba7e98ddc76 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -1833,6 +1833,10 @@ static int imx_uart_rs485_config(struct uart_port *port,
>  		rs485conf->flags &= ~SER_RS485_ENABLED;
>  
>  	if (rs485conf->flags & SER_RS485_ENABLED) {
> +		/* Enable receiver if low-active RTS signal is requested */
> +		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
> +			rs485conf->flags |= SER_RS485_RX_DURING_TX;
> +

this is wrong if RTS is driven by a GPIO.

>  		/* disable transmitter */
>  		ucr2 = imx_uart_readl(sport, UCR2);
>  		if (rs485conf->flags & SER_RS485_RTS_AFTER_SEND)
> @@ -2265,6 +2269,17 @@ static int imx_uart_probe(struct platform_device *pdev)
>  	    (!sport->have_rtscts && !sport->have_rtsgpio))
>  		dev_err(&pdev->dev, "no RTS control, disabling rs485\n");
>  
> +	/*
> +	 * The RTS (CTS_B) signal cannot be set low during transmission
> +	 * in case the receiver is off (limitation of the i.MX UART IP).
> +	 */
> +	if (sport->port.rs485.flags & SER_RS485_ENABLED && sport->have_rtscts &&
> +	    (!(sport->port.rs485.flags & SER_RS485_RTS_ON_SEND) &&
> +	     !(sport->port.rs485.flags & SER_RS485_RX_DURING_TX)))
> +		dev_err(&pdev->dev,
> +			"low-active RTS not possible when receiver is off, "
> +			"enabling receiver\n");

If you have the choice between breaking a user visible string and a code
line >80 chars, please pick the latter.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
