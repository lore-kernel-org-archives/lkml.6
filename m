Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933671AbeEWQtg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:49:36 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39984 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932649AbeEWQte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:49:34 -0400
X-Google-Smtp-Source: AB8JxZoX4Xfo5pcDiIXRVI1VZVryYQB0WoSjb5JRSw1BTPC2Y/5VrZ51FTm1xDiGCpXkZEcop4BJfw==
Date: Wed, 23 May 2018 11:49:31 -0500
From: Rob Herring <robh@kernel.org>
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: tobin@apporbit.com, Andrea Greco <a.greco@4sigma.it>,
        Mark Rutland <mark.rutland@arm.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] arcnet: com20020: bindings for smsc com20020
Message-ID: <20180523164931.GA3635@rob-hp-laptop>
References: <20180517130628.2770-1-andrea.greco.gapmilano@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517130628.2770-1-andrea.greco.gapmilano@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 03:06:26PM +0200, Andrea Greco wrote:
> From: Andrea Greco <a.greco@4sigma.it>
> 
> Add devicetree bindings for smsc com20020
> 
> Signed-off-by: Andrea Greco <a.greco@4sigma.it>
> ---
>  .../devicetree/bindings/net/smsc-com20020.txt       | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/smsc-com20020.txt

One typo, otherwise:

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> diff --git a/Documentation/devicetree/bindings/net/smsc-com20020.txt b/Documentation/devicetree/bindings/net/smsc-com20020.txt
> new file mode 100644
> index 000000000000..92360b054873
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/smsc-com20020.txt
> @@ -0,0 +1,21 @@
> +SMSC com20020 Arcnet network controller
> +
> +Required propelty:

property

> +- timeout-ns: Arcnet bus timeout, Idle Time (328000 - 20500)
> +- bus-speed-bps: Arcnet bus speed (10000000 - 156250)
> +- smsc,xtal-mhz: External oscillator frequency
> +- smsc,backplane-enabled: Controller use backplane mode
> +- reset-gpios: Chip reset pin
> +- interrupts: Should contain controller interrupt
> +
> +arcnet@28000000 {
> +    compatible = "smsc,com20020";
> +
> +	timeout-ns = <20500>;
> +	bus-speed-bps = <10000000>;
> +	smsc,xtal-mhz = <20>;
> +	smsc,backplane-enabled;
> +
> +	reset-gpios = <&gpio3 21 GPIO_ACTIVE_LOW>;
> +	interrupts = <&gpio2 10 GPIO_ACTIVE_LOW>;
> +};
> -- 
> 2.14.3
> 
