Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-223968-1518021834-2-13908294242927131267
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.001, ME_NOAUTH 0.01,
  RCVD_IN_DNSWL_HI -5, T_RP_MATCHES_RCVD -0.01, LANGUAGES en,
  BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=arctest;
    t=1518021833; b=BiOQDZqV3utZzQLAnySksGpZRncnF07i0F13G7SHH8w/ooB
    JMdjS5XAfJPWBcqwrahCFteeB/Dp9KYQOhpRvqbxs3DhEQmhzb7vB0D7kq2KU9ys
    eGf7SBOvfUnR1q8U3ZVnvjy4nOjO7bx/vOfc2GFLz8G1V4Hl/LcISehNpU3K/NKA
    BnKFpi2fGmpjjllvV8pgej0IiE/6iXhuMUl24d4KaE1ey79mIrHWT2aVpg4rsVfM
    6U3qQuLVD2CMl5IfkUGjnJZq+Ts4n9XXMpsdaxZ0YFOmBbpPBQTH3VWFWfZvDqkN
    KTw6MlBuCjzb/U4hUAV8yMZuO+gQfZhjb0VbOAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=arctest; t=1518021833; bh=hQMWV2n8ttGwQ67XoUi7xaBMmX
    b9awF7aTJqlPV3DqY=; b=UMgqABzO3Rqq0LJA5Np97Z4lT+xxlliEFWnqR5Zzpj
    HlfnsP8II/qAtg89BeUUx5wAhXmyzCJ8gtjlCnr6LCxvpXQjgSnEWR5GLJix1x/A
    iVU+lW5RSw0p/QmqPbuqoAOZgnyAjlhrBiqkqf7+B0D8nHSxKPscTLgnKmZLUbqu
    3PR2i2VbVLeXu6dHiD1soY1GKKVbrSPRgTI62WRUZbgHRgV+wrBTOm7uEjzn63io
    hGebRN5GqeAHb7/X/EjLYGB6ZFZXczmDJqyFNpAi8iEo0s4ppLHyf39zBf3odES+
    OojUOvRG50HWE2k9UJNRHeiibfzMf3REjP4DIfRUCKsw==
ARC-Authentication-Results: i=1; mx5.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Authentication-Results: mx5.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=microchip.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=microchip.com header.result=pass header_is_org_domain=yes
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754688AbeBGQnh (ORCPT <rfc822;greg@kroah.com>);
        Wed, 7 Feb 2018 11:43:37 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:10008 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754421AbeBGQnd (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 7 Feb 2018 11:43:33 -0500
X-IronPort-AV: E=Sophos;i="5.46,473,1511852400";
   d="scan'208";a="11250172"
Date: Wed, 7 Feb 2018 17:43:15 +0100
From: Ludovic Desroches <ludovic.desroches@microchip.com>
To: Linus Walleij <linus.walleij@linaro.org>
CC: Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-usb@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] usb: gadget: udc: atmel: convert to use GPIO
 descriptors
Message-ID: <20180207164315.GJ2580@rfolt0960.corp.atmel.com>
Mail-Followup-To: Linus Walleij <linus.walleij@linaro.org>,
        linux-usb@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Felipe Balbi <balbi@kernel.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20180201093432.21919-1-ludovic.desroches@microchip.com>
 <20180201093432.21919-2-ludovic.desroches@microchip.com>
 <CACRpkdYe-caycymfzosGTgnQUgf2jrLU9vfJEsT+bupqexCAxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CACRpkdYe-caycymfzosGTgnQUgf2jrLU9vfJEsT+bupqexCAxQ@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Feb 07, 2018 at 02:55:35PM +0100, Linus Walleij wrote:
> On Thu, Feb 1, 2018 at 10:34 AM, Ludovic Desroches
> <ludovic.desroches@microchip.com> wrote:
> 
> > Use GPIO descriptors instead of relying on the old method.
> > Include irq.h header since it is needed and was indirectly
> > included through of_gpio.h.
> >
> > Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
> 
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Thank you for doing gpiod conversions. Making the world
> a better place!

Thanks, I wish it would be so easy!

I will send a v2 because I have the same issue that the one pointed by
Andy about the gpiod conversion for the lcd driver.

- udc->vbus_pin = devm_gpiod_get_optional(&pdev->dev, "atmel,vbus", GPIOD_IN);
+ udc->vbus_pin = devm_gpiod_get(&pdev->dev, "atmel,vbus", GPIOD_IN);
+ if (IS_ERR(udc->vbus_pin))
+ 	udc->vbus_pin = NULL;

I am not sure if I should prefer devm_gpiod_get_optional or
devm_gpiod_get.

Regards

Ludovic
