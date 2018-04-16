Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3053989-1523879036-2-17561873355988587690
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5, LANGUAGES unknown,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523879035; b=uotYaOKoSZruRSCtHCTdAAwzenMMVYADCBh+vWZgtNFzEYUPju
    ItReOwKTdAdSrSTiBNS48fsF5A5oG50UrtvNWHL7vIJFQMAtyDT8yVudAXcDXf21
    4LbTg6JVXDoMqKAb7c7u2BVWr4rwS2KX8lBEsLqww0GaYNpsx1YhF2uXwq25qvG7
    WlBoP2KGz7SMKRjmWyyD6gPlDWtXFtOf/kk0AhnH0mGB22L9S86lXo+CXbwbD9Pn
    2NtYwy7QMBi7131twsOl0JSuqZPjM/qK3EcCCgtYhQCMk1U4zfjn8P1VM+CoUzRQ
    ct+ihXZJyrIcZBLYinSzR9Y1ddGj1TWuiAxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523879035; bh=iuUxhwVbCH9IqSkCSKAqLc1J1Oof5T
    Q0XDImXtYZn+E=; b=nDaAu4v4jR1ZFHq5c7tlqphs6etlWENnEa5kQ2kHgNOWnm
    tXj6Gal0n+Snsuu1SRs1aVxpD/FSaRITWqQdLra6WpKuxHuMQPjnWYkKyGyJTXSl
    BxaJpzzBRNq3CLcTWfMk6+vFHitRWuymu/h5SdJcciV7TvZFgVsKLPsuT40yKz7O
    HbPK7WtsUK7cptW9DAf76y/PcUo23sk3HDcM91B4YRyA0gqmtMoVfTL0PHaMrCV/
    Er8it8UycXtUx3hwV9y9GYuOo8qLbXJ7AUwc06qVB9bHyNqvA5hUwp9mCsFHucvB
    1AkerPjUBshnqIy+eltGpvIW7U93ZPHWfSJ3PZBQ==
ARC-Authentication-Results: i=1; mx1.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx1.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfNsolCDcaA+EcY8jnfYmvHShdoFkoRRh0AEIo4/MidLZH25GxxD8IVDmOi1p7Sr3lB920c9GAvbcoPi0h8+tMi7+32m+CL0PGycq6Rw749idLlaSIWP/
    jNWCqYLIvF9TSlwz2OGKoeTxsBT1PSj6bb5IBGFKceszk7IYPJ4B5VJ4DXS6PBr7Fs/EXf/lSKKrWT/mTGVfeGDPUpvmOgmZZHbzR94xEC4zF8mbEfKJIHLo
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=9w1kwzZOPmcUxL75cUMA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753950AbeDPLne (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 07:43:34 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:37429 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751199AbeDPLne (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 07:43:34 -0400
X-IronPort-AV: E=Sophos;i="5.48,459,1517900400";
   d="scan'208";a="12954567"
Date: Mon, 16 Apr 2018 13:42:56 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Romain Izard <romain.izard.pro@gmail.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 1/3] usb: gadget: udc: atmel: GPIO inversion is handled
 by gpiod
Message-ID: <20180416114256.GC2750@rfolt0960.corp.atmel.com>
Mail-Followup-To: Romain Izard <romain.izard.pro@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-usb@vger.kernel.org
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
 <20180416093405.16612-2-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180416093405.16612-2-romain.izard.pro@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:34:03AM +0200, Romain Izard wrote:
> When converting to GPIO descriptors, gpiod_get_value automatically
> handles the line inversion flags from the device tree.

Thanks, I totally missed it.

Regards

> 
> Do not invert the line twice.
> 
> Fixes: 3df034081021fa4b6967ce3364bc7d867ec1c870
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>

> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 3 +--
>  drivers/usb/gadget/udc/atmel_usba_udc.h | 1 -
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index 27c16399c7e8..0fe3d0feb8f7 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -417,7 +417,7 @@ static inline void usba_int_enb_set(struct usba_udc *udc, u32 val)
>  static int vbus_is_present(struct usba_udc *udc)
>  {
>  	if (udc->vbus_pin)
> -		return gpiod_get_value(udc->vbus_pin) ^ udc->vbus_pin_inverted;
> +		return gpiod_get_value(udc->vbus_pin);
>  
>  	/* No Vbus detection: Assume always present */
>  	return 1;
> @@ -2076,7 +2076,6 @@ static struct usba_ep * atmel_udc_of_init(struct platform_device *pdev,
>  
>  	udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, "atmel,vbus",
>  						GPIOD_IN);
> -	udc->vbus_pin_inverted = gpiod_is_active_low(udc->vbus_pin);
>  
>  	if (fifo_mode == 0) {
>  		pp = NULL;
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.h b/drivers/usb/gadget/udc/atmel_usba_udc.h
> index 969ce8f3c3e2..d7eb7cf4fd5c 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.h
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.h
> @@ -326,7 +326,6 @@ struct usba_udc {
>  	const struct usba_udc_errata *errata;
>  	int irq;
>  	struct gpio_desc *vbus_pin;
> -	int vbus_pin_inverted;
>  	int num_ep;
>  	int configured_ep;
>  	struct usba_fifo_cfg *fifo_cfg;
> -- 
> 2.14.1
> 
