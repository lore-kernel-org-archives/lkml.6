Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BAEECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57BB42084A
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57BB42084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732896AbeGTQTS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:19:18 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:39051 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731147AbeGTQTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:19:18 -0400
Received: by mail-io0-f196.google.com with SMTP id o22-v6so9186069ioh.6;
        Fri, 20 Jul 2018 08:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B01XMkdAIvf99g+q+YU7+CqcsYRS4IMR1vb0UpcVzXo=;
        b=jpTHE5UM3OnxDoKEfflh1NKKfISscHiPETeFRRZDLV1guXNck7ZPElw8ZYJQcQ78UJ
         oUMAlhh4kBJAi8AHuJHld1nW/E+VzkZrm61HpKjYdGlUDZCyQI0RForcMlMTedzY0rpH
         9L2O+TjF9BQiCrIHLJASUz4XcnITRAcM1RMWy0tSyy1GAkeEu38hyU0AAbgOBEiAJfKA
         JPtsYr6jUG/Tm+H2bVisIIbvp/FqDm4Ul41F1EpSzXatMUSoaUxKncp3uxiikg5q0oAD
         YplfLC+uk2PgBnChk2YHARG6E45rEbP7mUPNu+vmDtNeydkF5LGEMt6IiZugCGNISVyG
         FhDg==
X-Gm-Message-State: AOUpUlG5kiv+HQfxbnD57Ub9oThVzCQVlnttk+dIiNK9dVJ9HqbtQvC7
        ArluBzU9deuAxRUQpNI+9Wz92PM=
X-Google-Smtp-Source: AAOMgpeb8bT067vBg0NMT1S2rCPcnaHQ4dj5cSqvDMPypz3tzK9MW7AWZu73y6tZZwsAuQOTn7C63w==
X-Received: by 2002:a6b:3d7:: with SMTP id e84-v6mr1954815ioi.297.1532100629149;
        Fri, 20 Jul 2018 08:30:29 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id b129-v6sm1256263ioa.75.2018.07.20.08.30.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:30:28 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:30:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jiri Slaby <jslaby@suse.com>, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] serial: 8250_ingenic: Add support for the JZ4725B SoC
Message-ID: <20180720153027.GA11978@rob-hp-laptop>
References: <20180713143840.9721-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713143840.9721-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 04:38:40PM +0200, Paul Cercueil wrote:
> The UART in the jz4725b works just like in the other JZ SoCs, so this
> commit simply adds a new compatible string.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/serial/ingenic,uart.txt | 1 +
>  drivers/tty/serial/8250/8250_ingenic.c                    | 5 +++++
>  2 files changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/serial/ingenic,uart.txt b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> index c3c6406d5cfe..a0b34fd3b602 100644
> --- a/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> +++ b/Documentation/devicetree/bindings/serial/ingenic,uart.txt
> @@ -3,6 +3,7 @@
>  Required properties:
>  - compatible : One of:
>    - "ingenic,jz4740-uart",
> +  - "ingenic,jz4725b-uart",
>    - "ingenic,jz4760-uart",
>    - "ingenic,jz4770-uart",
>    - "ingenic,jz4775-uart",
> diff --git a/drivers/tty/serial/8250/8250_ingenic.c b/drivers/tty/serial/8250/8250_ingenic.c
> index 15a8c8dfa92b..760266559a5a 100644
> --- a/drivers/tty/serial/8250/8250_ingenic.c
> +++ b/drivers/tty/serial/8250/8250_ingenic.c
> @@ -133,6 +133,10 @@ EARLYCON_DECLARE(jz4740_uart, ingenic_early_console_setup);
>  OF_EARLYCON_DECLARE(jz4740_uart, "ingenic,jz4740-uart",
>  		    ingenic_early_console_setup);
>  
> +EARLYCON_DECLARE(jz4725b_uart, ingenic_early_console_setup);
> +OF_EARLYCON_DECLARE(jz4725b_uart, "ingenic,jz4725b-uart",
> +		    ingenic_early_console_setup);
> +

This shouldn't be necessary. Looks like it should be compatible with 
ingenic,jz4740-uart.

>  EARLYCON_DECLARE(jz4770_uart, ingenic_early_console_setup);
>  OF_EARLYCON_DECLARE(jz4770_uart, "ingenic,jz4770-uart",
>  		    ingenic_early_console_setup);
> @@ -330,6 +334,7 @@ static const struct ingenic_uart_config jz4780_uart_config = {
>  
>  static const struct of_device_id of_match[] = {
>  	{ .compatible = "ingenic,jz4740-uart", .data = &jz4740_uart_config },
> +	{ .compatible = "ingenic,jz4725b-uart", .data = &jz4740_uart_config },

And this too.

>  	{ .compatible = "ingenic,jz4760-uart", .data = &jz4760_uart_config },
>  	{ .compatible = "ingenic,jz4770-uart", .data = &jz4760_uart_config },
>  	{ .compatible = "ingenic,jz4775-uart", .data = &jz4760_uart_config },
> -- 
> 2.11.0
> 
