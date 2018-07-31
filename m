Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F776C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2BE220857
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 22:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2BE220857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732588AbeGaX4B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 19:56:01 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34703 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731007AbeGaX4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 19:56:00 -0400
Received: by mail-io0-f196.google.com with SMTP id l7-v6so14424030ioj.1;
        Tue, 31 Jul 2018 15:13:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=w9p7MvX9j5Tm4hhsiYM8zUxLACaWeOiDg/jFf3yORg0=;
        b=AJQcovJ9a9GK7OL7F6bHP3oDor7F/M5F0BWkzXfUjPS1RGRDvZmVCJhFbpAO76rtVQ
         ILSVRjxW7WmLLpcprJI61ENbQGplTkWgJBVZrWt0s+GDoOyW84ICm9yQaT8LGp/2Eks3
         c3RZYnR2D9mbpEBLXoow3AqyFLKNYWuHikupQoawi6cLZK713k2L2ddvYqreMd5oAR6T
         AEYjFneLvOFbdGG+TsN3jlsAc+bwS08qSdtyyuwihHc7YAdqQaZnGo2DJ+Xx4CjG1YmT
         5Mk0qonbtTy0XzUZokpT+BgLSb1ppYTSv+JacZFkoQhZ2BYmLzFEyzu5LU5iUT92X6iE
         7MWQ==
X-Gm-Message-State: AOUpUlEUzjNti2+DRPf3B9EmnlM9N4IEyhzDYaPHM5qIWFKXyIA1kh7J
        jjib6qUvWlp0057bUIzZlPyfF3kiNQ==
X-Google-Smtp-Source: AAOMgpdPYf/yXNBz0nb1goz0BvXo/1te5+2kHJwCiHEYkEt5I0uzW2SNQYWVOOHTGoD4uLEmZzmt4A==
X-Received: by 2002:a6b:6607:: with SMTP id a7-v6mr1374596ioc.145.1533075213834;
        Tue, 31 Jul 2018 15:13:33 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id u139-v6sm1728292ita.1.2018.07.31.15.13.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Jul 2018 15:13:33 -0700 (PDT)
Date:   Tue, 31 Jul 2018 16:13:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     Parthiban Nallathambi <pn@denx.de>
Cc:     tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com,
        mark.rutland@arm.com, afaerber@suse.de, catalin.marinas@arm.com,
        will.deacon@arm.com, manivannan.sadhasivam@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, sravanhome@gmail.com,
        thomas.liau@actions-semi.com, mp-cs@actions-semi.com,
        linux@cubietech.com, edgar.righi@lsitec.org.br,
        laisa.costa@lsitec.org.br, guilherme.simoes@lsitec.org.br,
        mkzuffo@lsi.usp.br
Subject: Re: [PATCH 1/3] dt-bindings: interrupt-controller: Actions external
 interrupt controller
Message-ID: <20180731221332.GA29883@rob-hp-laptop>
References: <20180724150219.1807724-1-pn@denx.de>
 <20180724150219.1807724-2-pn@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724150219.1807724-2-pn@denx.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 24, 2018 at 05:02:17PM +0200, Parthiban Nallathambi wrote:
> Actions Semi OWL family SoC's provides support for external interrupt
> controller to be connected and controlled using SIRQ pins. S500, S700
> and S900 provides 3 SIRQ lines and works independently for 3 external
> interrupt controllers.
> 
> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
> ---
>  .../interrupt-controller/actions,owl-sirq.txt      | 34 ++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> new file mode 100644
> index 000000000000..c5f8a29573c8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/actions,owl-sirq.txt
> @@ -0,0 +1,34 @@
> +Actions Semi Owl SoCs SIRQ interrupt controller
> +
> +S500, S700 and S900 SoC's from Actions provides interface, in which external
> +interrupt controller can be connected. It has the following properties:
> +
> +- inputs three interrupt signal from external interrupt controller
> +
> +Required properties:
> +
> +- compatible: should be one of the following
> +	"actions,s700-sirq"
> +	"actions,s900-sirq"
> +- reg: physical base address of the controller and length of memory mapped.
> +- interrupt-controller: identifies the node as an interrupt controller
> +- #interrupt-cells: specifies the number of cells needed to encode an interrupt
> +  source, should be 2.
> +- interrupts: specifies the interrupt line in the interrupt controller and
> +  interrupt type (level or edge triggered)

Need to state there are 3 interrupts.

> +- sampling-rate-24m: this means the external controller's interrupts can be

Needs a vendor prefix.

> +  sampled at 24MHz. Sampling can be specified for each SIRQ lines, as an array
> +  element. By default, all lines are sampled at 32KHz.
> +
> +Example:
> +
> +sirq: interrupt-controller@e01b0000 {
> +	compatible = "actions,s700-sirq";
> +	reg = <0 0xe01b0000 0 0x1000>;
> +	interrupts = <GIC_SPI 13 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 14 IRQ_TYPE_LEVEL_HIGH>,
> +		<GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
> +	interrupt-controller;
> +	#interrupt-cells = <2>;
> +	sampling-rate-24m = <0 0 1>;
> +};
> -- 
> 2.14.4
> 
