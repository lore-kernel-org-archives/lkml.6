Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8014C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:19:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 899D52152D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 11:19:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 899D52152D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=KARO-electronics.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731417AbeHWOsx convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 10:48:53 -0400
Received: from smtprelay07.ispgateway.de ([134.119.228.104]:20987 "EHLO
        smtprelay07.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729260AbeHWOsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 10:48:53 -0400
Received: from [89.1.81.74] (helo=ipc1.ka-ro)
        by smtprelay07.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.90_1)
        (envelope-from <LW@KARO-electronics.de>)
        id 1fsneK-000539-I7; Thu, 23 Aug 2018 13:19:36 +0200
Date:   Thu, 23 Aug 2018 13:19:35 +0200
From:   Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Michal =?UTF-8?B?Vm9rw6HEjQ==?= <michal.vokac@ysoft.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [RFC PATCH 1/2] dt-bindings: pwm: imx: Allow switching PWM
 output between PWM and GPIO
Message-ID: <20180823131935.1eae184f@ipc1.ka-ro>
In-Reply-To: <20180823123759.68b78e9f@jawa>
References: <1534862333-27950-1-git-send-email-michal.vokac@ysoft.com>
        <1534862333-27950-2-git-send-email-michal.vokac@ysoft.com>
        <20180823123759.68b78e9f@jawa>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Lukasz Majewski <lukma@denx.de> wrote:

> Hi Michal,
> 
> > Output of the PWM block of i.MX SoCs is always zero volts when the
> > block is disabled. This can caue issues when inverted PWM polarity is
> > needed. With inverted polarity a duty cycle = 0% corresponds to solid
> > high level on the output. If the PWM is dissabled its output
> > instantly goes to solid zero which corresponds to duty cycle = 100%.
> > 
> > To have a trully inverted PWM output configure the PWM pad as a GPIO
> > with pull-up. Then switch the pad to PWM output whenever non-zero
> > duty cycle is needed.  
> 
> Just to ask - Is your display equipped with power supply enable/disable
> pin?
> 
> As fair as I remember the trick to avoid flickering the display
> was to disable the display (enable-gpio property) and set the PWM PIN
> as GPIO to high in u-boot.
> 
Unfortunately there are both types of displays. Some with an ENABLE
pin, some without.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
