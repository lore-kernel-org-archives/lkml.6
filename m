Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9494C4360F
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:52:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 946BE2070D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550865144;
	bh=/HBUMM1JijhKOQNxyCpEz37Zt62b8EgssjOAeCBipA4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iIhrd3TeRfKXrlnDhWXyu1vS8EsOOsn3wZWAewsPrZxbIGYd7XkVbo0hEYPVqaf4v
	 DeeVkOwkUjHlyZi6S/m+HXPPHQyd7oXCgkUpbCxryoCfemnFBVmctve9j7sMS30AJT
	 IJhJkgnc3pteYMPWkoW8GJFbw6eddtREaP39bQhk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbfBVTwX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Feb 2019 14:52:23 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:35578 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725878AbfBVTwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Feb 2019 14:52:23 -0500
Received: by mail-oi1-f196.google.com with SMTP id u128so2676903oie.2;
        Fri, 22 Feb 2019 11:52:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RJLijQIatPprK/EeXUxIUsczKkEoyqe2raHhNi3taxE=;
        b=GnXxk14kNj2n/Gr5TEKY/98WElT55NovtEiobcnuDpB49GJ/AWhaVtHGn8zziMoxBj
         Eiy8VoWjo3v9sGcOlxRpZcLu9M3rezmT+CrN5b4CH/Bs7uSiiFAJe3uxOfuhI3kHlnsn
         krL0bEP7i+5McDZ0tR3Os3+t22cZRaK45JJPivyMlGpezMAnnP+N20W2E1ZgQpuy1iyn
         kBSc0e3JwQasWjZmKsZ9CKgB8OHLw90SYP6q5Jum6BSCP9epICUs0TVSSZAy7ngym6qe
         jvLjrWzZjeRNdG30Yr+/YVmJxRfHLlfGPty46sb96RtO8ekODzv8QHCRl8AebishVjCc
         bLEw==
X-Gm-Message-State: AHQUAubhOsbfiOhbumZxFirD3EDiSDhooc9FK14p0aVpnJjH0ESj9J8l
        1ycf0ZH3+QKsJnD4S9X3LQ==
X-Google-Smtp-Source: AHgI3IYNyFfvO/d9yPGhIdnav5W2AIEB3TTrGc2BnoOJ5/xu+/wWL596R6ywolHedwXIk4qq65Gfpw==
X-Received: by 2002:aca:c41:: with SMTP id i1mr3503210oiy.52.1550865139183;
        Fri, 22 Feb 2019 11:52:19 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id d10sm927282otl.69.2019.02.22.11.52.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Feb 2019 11:52:18 -0800 (PST)
Date:   Fri, 22 Feb 2019 13:52:17 -0600
From:   Rob Herring <robh@kernel.org>
To:     Anson Huang <anson.huang@nxp.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Aisheng Dong <aisheng.dong@nxp.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        "horms+renesas@verge.net.au" <horms+renesas@verge.net.au>,
        "heiko@sntech.de" <heiko@sntech.de>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "jagan@amarulasolutions.com" <jagan@amarulasolutions.com>,
        "enric.balletbo@collabora.com" <enric.balletbo@collabora.com>,
        "marc.w.gonzalez@free.fr" <marc.w.gonzalez@free.fr>,
        "olof@lixom.net" <olof@lixom.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH RESEND V2 1/4] dt-bindings: fsl: scu: add watchdog binding
Message-ID: <20190222195217.GA22194@bogus>
References: <1550472539-16590-1-git-send-email-Anson.Huang@nxp.com>
 <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1550472539-16590-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 18, 2019 at 06:53:48AM +0000, Anson Huang wrote:
> Add i.MX8QXP system controller watchdog binding.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> Changes since V1:
> 	- update dts node name to "watchdog";
> ---
>  Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> index 4b79751..f388ec6 100644
> --- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> +++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
> @@ -136,6 +136,12 @@ Required properties:
>  			   resource id for thermal driver to get temperature via
>  			   SCU IPC.
>  
> +Watchdog bindings based on SCU Message Protocol
> +------------------------------------------------------------
> +
> +Required properties:
> +- compatible: should be "fsl,imx8qxp-sc-wdt";
> +
>  Example (imx8qxp):
>  -------------
>  lsio_mu1: mailbox@5d1c0000 {
> @@ -188,6 +194,10 @@ firmware {
>  			tsens-num = <1>;
>  			#thermal-sensor-cells = <1>;
>  		};
> +
> +		watchdog: watchdog {
> +			compatible = "fsl,imx8qxp-sc-wdt";

As-is, there's no reason for this to be in DT. The parent node's driver 
can instantiate the wdog.

> +		};
>  	};
>  };
>  
> -- 
> 2.7.4
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
