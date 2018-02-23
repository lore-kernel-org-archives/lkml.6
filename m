Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751831AbeBWQhV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 11:37:21 -0500
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41284 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751770AbeBWQhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 11:37:18 -0500
X-Google-Smtp-Source: AH8x225NEY8G0wfzRSz+mHgSIQCYP1/DPPH1GG0MhA6lXHLhrPGNyPvItFSCLklLhB5Us4ojUo9EGA==
Date: Fri, 23 Feb 2018 08:37:14 -0800
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Stephen Boyd <sboyd@codeaurora.org>, Rob Herring <robh@kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Timur Tabi <timur@codeaurora.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-gpio@vger.kernel.org, Grant Likely <grant.likely@secretlab.ca>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: pinctrl: Add a reserved-gpio-ranges
 property
Message-ID: <20180223163714.GM93895@bjorns-mbp-2.lan>
References: <20180126011400.2191-1-sboyd@codeaurora.org>
 <20180126011400.2191-2-sboyd@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180126011400.2191-2-sboyd@codeaurora.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Jan 17:13 PST 2018, Stephen Boyd wrote:

+ Rob

> Some qcom platforms make some GPIOs or pins unavailable for use
> by non-secure operating systems, and thus reading or writing the
> registers for those pins will cause access control issues.
> Introduce a DT property to describe the set of GPIOs that are
> available for use so that higher level OSes are able to know what
> pins to avoid reading/writing.
> 
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: <devicetree@vger.kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Acked-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
>  Documentation/devicetree/bindings/gpio/gpio.txt | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/gpio/gpio.txt b/Documentation/devicetree/bindings/gpio/gpio.txt
> index b5de08e3b1a2..c22b56680fc8 100644
> --- a/Documentation/devicetree/bindings/gpio/gpio.txt
> +++ b/Documentation/devicetree/bindings/gpio/gpio.txt
> @@ -151,9 +151,9 @@ in a lot of designs, some using all 32 bits, some using 18 and some using
>  first 18 GPIOs, at local offset 0 .. 17, are in use.
>  
>  If these GPIOs do not happen to be the first N GPIOs at offset 0...N-1, an
> -additional bitmask is needed to specify which GPIOs are actually in use,
> -and which are dummies. The bindings for this case has not yet been
> -specified, but should be specified if/when such hardware appears.
> +additional set of tuples is needed to specify which GPIOs are unusable, with
> +the reserved-gpio-ranges binding. This property indicates the start and size
> +of the GPIOs that can't be used.
>  
>  Optionally, a GPIO controller may have a "gpio-line-names" property. This is
>  an array of strings defining the names of the GPIO lines going out of the
> @@ -178,6 +178,7 @@ gpio-controller@00000000 {
>  	gpio-controller;
>  	#gpio-cells = <2>;
>  	ngpios = <18>;
> +	reserved-gpio-ranges = <0 4>, <12 2>;
>  	gpio-line-names = "MMC-CD", "MMC-WP", "VDD eth", "RST eth", "LED R",
>  		"LED G", "LED B", "Col A", "Col B", "Col C", "Col D",
>  		"Row A", "Row B", "Row C", "Row D", "NMI button",
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
