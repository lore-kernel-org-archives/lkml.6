Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754073AbeCRMsd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:48:33 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:44539 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754046AbeCRMsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:48:23 -0400
X-Google-Smtp-Source: AG47ELuQQfINfzOnYO5oRDh+Eqjnh4p5UY2gKa7hYMR1FZcmW0XZOO2gMeIxK3kkz7vk0GW3OJDETw==
Date: Sun, 18 Mar 2018 07:48:20 -0500
From: Rob Herring <robh@kernel.org>
To: Matheus Castello <matheus@castello.eng.br>
Cc: stefan.wahren@i2se.com, eric@anholt.net, linus.walleij@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v4 1/3] dt-bindings: pinctrl: bcm2835-gpio: Add generic
 pinctrl support
Message-ID: <20180318124820.xea5etlb3wu7wnpw@rob-hp-laptop>
References: <483687035.384686.1520596004410@email.1und1.de>
 <1520615640-9153-1-git-send-email-matheus@castello.eng.br>
 <1520615640-9153-2-git-send-email-matheus@castello.eng.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520615640-9153-2-git-send-email-matheus@castello.eng.br>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 01:13:58PM -0400, Matheus Castello wrote:
> Added generic pin configuration and multiplexing support,
> and shoud be preferred than brcm legacy one.
> 
> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
> ---
>  .../devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> index 2569866..58b4720 100644
> --- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
> @@ -36,6 +36,25 @@ listed. In other words, a subnode that lists only a mux function implies no
>  information about any pull configuration. Similarly, a subnode that lists only
>  a pul parameter implies no information about the mux function.
>  
> +This driver supports the generic pin multiplexing and configuration

Bindings describe h/w, not drivers.

> +bindings. For details on each properties, you can refer to
> +./pinctrl-bindings.txt.
> +
> +Required sub-node properties:
> +  - pins
> +  - function
> +
> +Optional sub-node properties:
> +  - bias-disable
> +  - bias-pull-up
> +  - bias-pull-down
> +  - output-high
> +  - output-low
> +
> +Legacy pin configuration and multiplexing binding:
> +*** (Its use is deprecated, use generic multiplexing and configuration
> +bindings instead)
> +
>  Required subnode-properties:
>  - brcm,pins: An array of cells. Each cell contains the ID of a pin. Valid IDs
>    are the integer GPIO IDs; 0==GPIO0, 1==GPIO1, ... 53==GPIO53.
> -- 
> 2.7.4
> 
