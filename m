Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AC73ECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5536D206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 15:31:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5536D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387771AbeGTQUV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 12:20:21 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34959 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732146AbeGTQUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 12:20:21 -0400
Received: by mail-io0-f196.google.com with SMTP id w11-v6so4733051iob.2;
        Fri, 20 Jul 2018 08:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=iSVY/SHZEC/+HjFMNB9GbZzkmABUGXu0Lg5x5/hcz3M=;
        b=UlQtOwYCjrbIki1XQDwf0fEDZH6YerOfv3kzaAU2lx2qhbH69DEL3sJ2jkk8dGSQui
         NPL1C8xhI+uiPKL+s2zSef7euWSlA0JMfxEokKLXQklvQhBTnz7Nu9h/DmcgYyHcu3cf
         hlhrObWRmYlHlPjK0OLPEeQxyzqCrZIf+rTxrdx2ftC+L7Shh/pKwUViBCb1wDsDtAcO
         III633k5KuGl3rCdUkGHKKkClrgwHoMVvcXd3TcqgynUTRKjFXToVydsmVFPbt5a/pZk
         vn5s90a6gBpOPXLlqTwn+JvYW8oS845/ifFyJrJ2cFnKP+Qx7BWgDQ9T3n9GXB6N5S9M
         dsjQ==
X-Gm-Message-State: AOUpUlEJuDNerSw2Pea7mcmb9Tl2H25tQCqBWO4MH3TM60dEL3mVCJVJ
        ajpYAPuR5DuvffzapZvXe75l4gU=
X-Google-Smtp-Source: AAOMgpfbIEMj4aHCShNLPwvKrGqi1oMNNWnzW78VkuHwJvBS57OI/HqoUYsJZHMl7bdzi0rfVQXTpA==
X-Received: by 2002:a6b:7517:: with SMTP id l23-v6mr1833084ioh.89.1532100692746;
        Fri, 20 Jul 2018 08:31:32 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id w130-v6sm1168553iow.67.2018.07.20.08.31.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Jul 2018 08:31:32 -0700 (PDT)
Date:   Fri, 20 Jul 2018 09:31:31 -0600
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] irqchip: ingenic: Add support for the JZ4725B SoC
Message-ID: <20180720153131.GA14532@rob-hp-laptop>
References: <20180713144909.10657-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180713144909.10657-1-paul@crapouillou.net>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2018 at 04:49:09PM +0200, Paul Cercueil wrote:
> The interrupt controller of the JZ4725B works the same way as the other
> JZ SoCs from Ingenic; so we just add a new compatible string.

This one too should have a fallback compatible and then the driver 
change isn't needed.

> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt | 1 +
>  drivers/irqchip/irq-ingenic.c                                           | 1 +
>  2 files changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
> index 5f89fb635a1b..f97fd8ab5e45 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/ingenic,intc.txt
> @@ -4,6 +4,7 @@ Required properties:
>  
>  - compatible : should be "ingenic,<socname>-intc". Valid strings are:
>      ingenic,jz4740-intc
> +    ingenic,jz4725b-intc
>      ingenic,jz4770-intc
>      ingenic,jz4775-intc
>      ingenic,jz4780-intc
> diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
> index fc5953dea509..2ff08986b536 100644
> --- a/drivers/irqchip/irq-ingenic.c
> +++ b/drivers/irqchip/irq-ingenic.c
> @@ -165,6 +165,7 @@ static int __init intc_1chip_of_init(struct device_node *node,
>  	return ingenic_intc_of_init(node, 1);
>  }
>  IRQCHIP_DECLARE(jz4740_intc, "ingenic,jz4740-intc", intc_1chip_of_init);
> +IRQCHIP_DECLARE(jz4725b_intc, "ingenic,jz4725b-intc", intc_1chip_of_init);
>  
>  static int __init intc_2chip_of_init(struct device_node *node,
>  	struct device_node *parent)
> -- 
> 2.11.0
> 
