Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753297AbeBSP7p (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:59:45 -0500
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33799 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753109AbeBSP7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:59:43 -0500
X-Google-Smtp-Source: AH8x2275elUzocIZcPosv5YW09NSVJNS2/JkMJ757WSzHduDMCzfZl13YhJIEQRWZn22ymAQJSmtqw==
Date: Mon, 19 Feb 2018 09:59:39 -0600
From: Rob Herring <robh@kernel.org>
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, mark.rutland@arm.com, sre@kernel.org,
        Moritz Fischer <mdf@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: power: reset: gpio-poweroff: Add
 'timeout' property
Message-ID: <20180219155939.uutemv6wnlxqa7oy@rob-hp-laptop>
References: <20180215204926.23347-1-moritz.fischer@ettus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180215204926.23347-1-moritz.fischer@ettus.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 12:49:25PM -0800, Moritz Fischer wrote:
> From: Moritz Fischer <mdf@kernel.org>
> 
> Add 'timeout' property to support boards where the 3s timeout that the
> current driver defaults to is too short.
> 
> Signed-off-by: Moritz Fischer <mdf@kernel.org>
> ---
>  Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> index e62d53d844cc..c2459c7d45d5 100644
> --- a/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> +++ b/Documentation/devicetree/bindings/power/reset/gpio-poweroff.txt
> @@ -27,6 +27,8 @@ Optional properties:
>    it to an output when the power-off handler is called. If this optional
>    property is not specified, the GPIO is initialized as an output in its
>    inactive state.
> +- timeout: Time to wait before asserting a WARN_ON(1). If nothing is
> +           specified, 3000 ms is used.

Needs unit suffix as defined in property-units.txt.

>  
>  Examples:
>  
> @@ -34,3 +36,9 @@ gpio-poweroff {
>  	compatible = "gpio-poweroff";
>  	gpios = <&gpio 4 0>;
>  };
> +
> +gpio-poweroff {
> +	compatible = "gpio-poweroff";
> +	gpios = <&gpio 4 0>;
> +	timeout = <3000>;

Just add to the existing example.

> +};
> -- 
> 2.16.1
> 
