Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A68C169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6F5320823
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 08:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbfBFI5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 03:57:16 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:62060 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbfBFI5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 03:57:15 -0500
X-IronPort-AV: E=Sophos;i="5.56,564,1539673200"; 
   d="scan'208";a="26364403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 06 Feb 2019 01:57:14 -0700
Received: from localhost (10.10.76.4) by chn-sv-exch02.mchp-main.com
 (10.10.76.38) with Microsoft SMTP Server id 14.3.352.0; Wed, 6 Feb 2019
 01:57:14 -0700
Date:   Wed, 6 Feb 2019 09:56:59 +0100
From:   Ludovic Desroches <ludovic.desroches@microchip.com>
To:     Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>
CC:     "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/7] add support for SAM9X60 pin controller
Message-ID: <20190206085659.5rjaz73hb25smpbz@M43218.corp.atmel.com>
Mail-Followup-To: Claudiu Beznea - M18063 <Claudiu.Beznea@microchip.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Nicolas Ferre - M43238 <Nicolas.Ferre@microchip.com>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1548951466-26297-1-git-send-email-claudiu.beznea@microchip.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 05:18:00PM +0100, Claudiu Beznea - M18063 wrote:
> From: Claudiu Beznea <claudiu.beznea@microchip.com>

Minor comment for patch 1.

Acked-by: Ludovic Desroches <ludovic.desroches@microchip.com> for the
whole series.

> 
> This series adds drive strenght and slew rate support for SAMX60's pin
> controller. For drive strenght we could have 2 values: low, high.
> For slew rate we could have 2 values: enable, disabled.
> 
> Besides this I took the chance and adapt the documentation for at91 pinctrl
> driver.
> 
> Changes in v2:
> - s/microchip,sam9x60-pictrl/microchip,sam9x60-pinctrl in patches 3/7, 5/7
> 
> Claudiu Beznea (7):
>   pinctrl: at91: add option to use drive strength bits
>   pinctrl: at91: add drive strength support for SAM9X60
>   pinctrl: at91: add compatibles for SAM9X60 pin controller
>   dt-bindings: add documentation for banks
>   dt-bindings: add bindings for SAM9X60
>   pinctrl: at91: add slewrate support for SAM9X60
>   dt-bindings: add documentation for slew rate
> 
>  .../bindings/pinctrl/atmel,at91-pinctrl.txt        |  27 ++++-
>  drivers/pinctrl/pinctrl-at91.c                     | 134 +++++++++++++++++++--
>  drivers/pinctrl/pinctrl-at91.h                     |   3 +
>  include/dt-bindings/pinctrl/at91.h                 |   4 +
>  4 files changed, 155 insertions(+), 13 deletions(-)
> 
> -- 
> 2.7.4
> 
