Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3053989-1523879119-2-16253099011020027493
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, BODY_URI_ONLY 0.999, HEADER_FROM_DIFFERENT_DOMAINS 0.25,
  MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES unknown, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523879118; b=HVVahDRWBXGGrzM2NeTklHVDf8Cf+HwkVDSpt6L48JlqAUWwcq
    7c8kbQ3Z3Xj3Q5NE8Yg2PFgn9cEZF9n+c4zquHSTnT3gM/hhhK0U5utcJzE6/xKY
    HM4r7NwuVM+kiOJhCsWSbLFY8rdvfWZ12zveJGT9DZAeAjxVQryj7aM4FzHTjpos
    EzoydXSvKfLvys/jnZgwzl36oSHhVvUVmA12YT1PAuwF6jsy3zkP1bc5OETEgz5I
    tHaTOJtiP02pT464nKomoAil60AWPh19Di6et6EDVgcgRftfkn5k0pwi+mK6vL+U
    /rxdPt+4mmiAdozOuNWGgIDGiTbwx4GR/IPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523879118; bh=RQHxEkoVv1NHMlCZDGcwdcgCPyd8Z3
    ezK8Y7ye538j8=; b=Iof3hXgvEgEDqjEsfvw0+ddhbV2AY+d5cLEb1ypOoyCgip
    HJXrOwboNAt0tDlSi1ByFlRHjhrZH19yqCbh53J+OFEW3kslxzoousIJK12yzdGU
    IcDMCZHLDyl2PJ+c+voGadN5tSXFAqWLcR1WGPjO+zC8Lzzt0g63JddTx/YHQeB8
    ooxaNYZSQwzX28qea7BJ+LgKm9cTPjSrbQN38QBB0o+2qmF0e5UbZKVerV+HNtF3
    8CIV6KJ1fsvnJv8IekfUBJ+UAXV1aI47TinRc/5PkxGB3OmNDgqu8yCyi+ki4KxK
    mGq7eup9ZoCH654NvMP93sa1VOCj2uthqU/TsyQg==
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
X-CM-Envelope: MS4wfMXirO80aTNnt91rki146FzAFJYEGT9up/caw+McFif5tUGC7ADLMn/RvjBBDdKG6r6fiC3jGSk0xNo92OLMSWVQv3oEZW907ZzApmnAUIc/arloIgUx
    h11Ao2TT5ZZnxYL2bwLwzSUJVcUXb+CyVueaMh3iZV/QcFTIvyvjuhESndAawwn5rswHfbdMrBLHxl8wnnFxbTnyFsPUNH3EGzaSZbVSKLkRAROCFVRTovTS
X-CM-Analysis: v=2.3 cv=WaUilXpX c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=pGLkceISAAAA:8 a=XYAwZIGsAAAA:8 a=JfrnYn6hAAAA:8 a=VwQbUJbxAAAA:8
    a=_SUMqSMbnH_t1_kV6cgA:9 a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10
    a=E8ToXWR_bxluHZ7gmE-Z:22 a=1CNFftbPRP8L7MoqJWF3:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755118AbeDPLpE (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 07:45:04 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:30747 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755114AbeDPLpE (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 07:45:04 -0400
X-IronPort-AV: E=Sophos;i="5.48,459,1517900400";
   d="scan'208";a="11092060"
Date: Mon, 16 Apr 2018 13:44:27 +0200
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Romain Izard <romain.izard.pro@gmail.com>
CC: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 3/3] usb: gadget: udc: atmel: Fix indenting
Message-ID: <20180416114427.GE2750@rfolt0960.corp.atmel.com>
Mail-Followup-To: Romain Izard <romain.izard.pro@gmail.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20180416093405.16612-1-romain.izard.pro@gmail.com>
 <20180416093405.16612-4-romain.izard.pro@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180416093405.16612-4-romain.izard.pro@gmail.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 16, 2018 at 11:34:05AM +0200, Romain Izard wrote:
> Fix the fallout of the conversion to GPIO descriptors in 3df034081021.
> 
> Signed-off-by: Romain Izard <romain.izard.pro@gmail.com>
Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> ---
>  drivers/usb/gadget/udc/atmel_usba_udc.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/usb/gadget/udc/atmel_usba_udc.c b/drivers/usb/gadget/udc/atmel_usba_udc.c
> index b9623e228609..2f586f2bda7e 100644
> --- a/drivers/usb/gadget/udc/atmel_usba_udc.c
> +++ b/drivers/usb/gadget/udc/atmel_usba_udc.c
> @@ -2277,15 +2277,15 @@ static int usba_udc_probe(struct platform_device *pdev)
>  	if (udc->vbus_pin) {
>  		irq_set_status_flags(gpiod_to_irq(udc->vbus_pin), IRQ_NOAUTOEN);
>  		ret = devm_request_threaded_irq(&pdev->dev,
> -					gpiod_to_irq(udc->vbus_pin), NULL,
> -					usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
> -					"atmel_usba_udc", udc);
> -			if (ret) {
> -				udc->vbus_pin = NULL;
> -				dev_warn(&udc->pdev->dev,
> -					 "failed to request vbus irq; "
> -					 "assuming always on\n");
> -			}
> +				gpiod_to_irq(udc->vbus_pin), NULL,
> +				usba_vbus_irq_thread, USBA_VBUS_IRQFLAGS,
> +				"atmel_usba_udc", udc);
> +		if (ret) {
> +			udc->vbus_pin = NULL;
> +			dev_warn(&udc->pdev->dev,
> +				 "failed to request vbus irq; "
> +				 "assuming always on\n");
> +		}
>  	}
>  
>  	ret = usb_add_gadget_udc(&pdev->dev, &udc->gadget);
> -- 
> 2.14.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
