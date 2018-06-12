Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id A6BD9C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 660912086E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 21:06:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660912086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933984AbeFLVGr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 17:06:47 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:42652 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932985AbeFLVGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 17:06:44 -0400
Received: by mail-pl0-f66.google.com with SMTP id w17-v6so182434pll.9;
        Tue, 12 Jun 2018 14:06:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eL+ftIOKStrPhTB+K0wcuaXNY/kAHokEi1YC6t+2jt8=;
        b=HDvKJedt560iV5isQ6+spL5rBg7vbMrz3r7+feQPpMiiH9TdAXMuQzjtTkaB+xT9hD
         1GnwmLz+ziDyCzmTjC1M3T09Ba4My16/8cC/5L3SRXk9uX6CCsUDb3mnyH6VEDBdVSCx
         wgy2nLjwWFyyRy4qAlgrjPrPUucfstEGOIU3CFMw9UJdJLaqc9mp5nNZXimPr+h22xO2
         eAaWsSriahk+decyOQh8mpxHU3leJ+XdfjMS/eMHDMyRgfEvw6Qj79jpUAoyvnoQYaRw
         C9inW2fui/J/yzhYnI3NApC4WONBrt5JyRCisWowf2K/l5+xvJjqvRqwy5EYkWUOypmv
         iI5Q==
X-Gm-Message-State: APt69E25T4RA4C3kjAhTUCUH6UiOTzFjEwc4/hw/DhjFryyl8ll2E0xu
        3yOBK/94Y6tNmjFeM7f4sQ==
X-Google-Smtp-Source: ADUXVKJLeWSY9Ie5oXWQCeU6TX4lcruQkm4TE6BIFfuQvRC527UhXmbsKS/85noqSB1rGbvtv/FisQ==
X-Received: by 2002:a17:902:5991:: with SMTP id p17-v6mr2056332pli.191.1528837604314;
        Tue, 12 Jun 2018 14:06:44 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id c19-v6sm1200962pfn.182.2018.06.12.14.06.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 14:06:43 -0700 (PDT)
Date:   Tue, 12 Jun 2018 15:06:41 -0600
From:   Rob Herring <robh@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tony Lindgren <tony@atomide.com>, Vignesh R <vigneshr@ti.com>,
        Tero Kristo <t-kristo@ti.com>,
        Russell King <linux@armlinux.org.uk>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: Re: [RFC PATCH 3/6] serial: 8250_omap: Add support for AM654 UART
 controller
Message-ID: <20180612210640.GA20728@rob-hp-laptop>
References: <20180605060125.9518-1-nm@ti.com>
 <20180605060125.9518-4-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605060125.9518-4-nm@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 01:01:22AM -0500, Nishanth Menon wrote:
> AM654 uses a UART controller that is compatible (partially) with
> existing 8250 UART, however, has a few differences with respect to DMA
> support and control paths. Introduce a base definition that allows us
> to build up the differences in follow on patches.
> 
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Vignesh R <vigneshr@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> ---
>  Documentation/devicetree/bindings/serial/omap_serial.txt | 1 +
>  drivers/tty/serial/8250/8250_omap.c                      | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/omap_serial.txt b/Documentation/devicetree/bindings/serial/omap_serial.txt
> index 4b0f05adb228..c35d5ece1156 100644
> --- a/Documentation/devicetree/bindings/serial/omap_serial.txt
> +++ b/Documentation/devicetree/bindings/serial/omap_serial.txt
> @@ -1,6 +1,7 @@
>  OMAP UART controller
>  
>  Required properties:
> +- compatible : should be "ti,am654-uart" for AM654 controllers

Not compatible with any existing TI 8250 UARTs?

>  - compatible : should be "ti,omap2-uart" for OMAP2 controllers
>  - compatible : should be "ti,omap3-uart" for OMAP3 controllers
>  - compatible : should be "ti,omap4-uart" for OMAP4 controllers
> diff --git a/drivers/tty/serial/8250/8250_omap.c b/drivers/tty/serial/8250/8250_omap.c
> index 1b337fee07ed..a019286f8bb6 100644
> --- a/drivers/tty/serial/8250/8250_omap.c
> +++ b/drivers/tty/serial/8250/8250_omap.c
> @@ -1115,6 +1115,7 @@ static const u8 am3352_habit = OMAP_DMA_TX_KICK | UART_ERRATA_CLOCK_DISABLE;
>  static const u8 dra742_habit = UART_ERRATA_CLOCK_DISABLE;
>  
>  static const struct of_device_id omap8250_dt_ids[] = {
> +	{ .compatible = "ti,am654-uart" },
>  	{ .compatible = "ti,omap2-uart" },
>  	{ .compatible = "ti,omap3-uart" },
>  	{ .compatible = "ti,omap4-uart", .data = &omap4_habit, },
> -- 
> 2.15.1
> 
