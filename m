Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E676C31681
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69B7F20879
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 17:49:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548092978;
	bh=xYzy60SJ6owydJaJaccNH+vVii8znHCjO35gEw0XA54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=MWdQVWqfgm58kG6QgFd7I0p6xlGY3Rmnt+DVJzU0hmst3HUsdnoncsuJ1OrSbnzUT
	 3V+ZAcjGzcyF3FelhQc6i+F/XsH1ZL48p3F5u/1VQ7hmYCUibX7QNDhYHJYqOgqb0c
	 XpIfiv6WhOlcmePiV9s7n9gYobl7kq+aN5c6OUuM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfAURth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 12:49:37 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:37782 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfAURtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 12:49:36 -0500
Received: by mail-oi1-f193.google.com with SMTP id y23so15205176oia.4;
        Mon, 21 Jan 2019 09:49:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=6aJ+EQfnstD82yyDJ3WZnLVa3wGpul+raVaGTSHBFMM=;
        b=tcLaO43N7mOB848VuBUqIrMq9UKFBuAHSu8ELj4CvgO2/h0KkiCFdwHFidyvVGq1Xl
         ugO2Dez/xBLyNeAEl3IRqrdVq55eNe1v0uB/B5vXvMSJD+GutGp0egOb70+OGPLO/zd2
         7IpEYFoxUN6tRGVejb/JApY0rMZUeC59yJktO2g3X6czbKUbPOuA9k7w/jrlJe2/7DqV
         //9SC2BGD4jpI/ag6l9oDqx6FnbUBrBCrkxo8VxQf8WlSyuey4GISjyGzhSTZD/S4Wbp
         E4dW27hXY+ELtsjYuudkO8L3gmMVK7p/BpgMzi2WqdEe6KTvny48EpRS+TX73BEbaabB
         f/ZQ==
X-Gm-Message-State: AJcUukcNMW80JZmD24OWWrT/808n2cVgKReujFoylVS5oBY9Tha5Bpn4
        4bn2SPbA3adSv8nsLrwlhA==
X-Google-Smtp-Source: ALg8bN7j2dYFg6CqgfFPp1Nh165waPZOCRIiZbI98KOEBH/Zp6IaDsw3wUHRDD6+vzlKFDRxFnv7Dg==
X-Received: by 2002:a05:6808:493:: with SMTP id z19mr2745049oid.46.1548092975393;
        Mon, 21 Jan 2019 09:49:35 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l6sm5764665otf.56.2019.01.21.09.49.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 09:49:34 -0800 (PST)
Date:   Mon, 21 Jan 2019 11:49:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Wiebe, Wladislav (Nokia - DE/Ulm)" <wladislav.wiebe@nokia.com>
Cc:     "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "mchehab+samsung@kernel.org" <mchehab+samsung@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "nicolas.ferre@microchip.com" <nicolas.ferre@microchip.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "Sverdlin, Alexander (Nokia - DE/Ulm)" <alexander.sverdlin@nokia.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: edac: ARM Cortex A15 L2 asynchronous
 error detection
Message-ID: <20190121174934.GA20608@bogus>
References: <AM6PR0702MB3799A0BC3B07541CDBC4027EFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM6PR0702MB3799A0BC3B07541CDBC4027EFA8A0@AM6PR0702MB3799.eurprd07.prod.outlook.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2019 at 08:10:39AM +0000, Wiebe, Wladislav (Nokia - DE/Ulm) wrote:
> Add property description + example for using the
> Cortex A15 L2 asynchronous error detection driver.
> 
> Signed-off-by: Wladislav Wiebe <wladislav.wiebe@nokia.com>
> ---
>  .../bindings/edac/cortex_a15_l2_async_edac.txt     | 22 ++++++++++++++++++++++
>  MAINTAINERS                                        |  7 +++++++
>  2 files changed, 29 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> 
> diff --git a/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt b/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> new file mode 100644
> index 000000000000..9ad8c2497e70
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> @@ -0,0 +1,22 @@
> +* ARM Cortex A15 L2 internal asynchronous error detection driver
> +
> +Support for L2 internal asynchronous error detection caused by L2 RAM
> +double-bit ECC error or illegal writes to the Interrupt Controller
> +memory-map region on the Cortex A15.
> +
> +Required properties:
> +	- compatible: "arm,cortex-a15-l2-async-edac"

EDAC is a kernel name and shouldn't be in a binding (though, yes that 
is the directory name and there's examples to the contrary). How about 
just "arm,cortex-a15-l2-errirq"?

> +	- interrupts: INTERRIRQ per CPU cluster
> +
> +Example:
> +
> +cortex-a15-l2-async-edac {
> +	compatible = "arm,cortex-a15-l2-async-edac";
> +	interrupts = <0 182 4>,
> +		     <0 183 4>,
> +		     <0 184 4>,
> +		     <0 185 4>;
> +};
> +
> +Reference:
> +Cortex-A15 Technical Reference Manual, 7.7. Asynchronous errors
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b755a89fa325..0796ad6e6490 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1094,6 +1094,13 @@ F:	arch/arm/include/asm/arch_timer.h
>  F:	arch/arm64/include/asm/arch_timer.h
>  F:	drivers/clocksource/arm_arch_timer.c
>  
> +ARM CORTEX A15 L2 INTERNAL ASYNCHRONOUS ERROR DETECTION DRIVER
> +M:	Wladislav Wiebe <wladislav.wiebe@nokia.com>
> +L:	linux-edac@vger.kernel.org
> +L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> +S:	Supported
> +F:	Documentation/devicetree/bindings/edac/cortex_a15_l2_async_edac.txt
> +
>  ARM INTEGRATOR, VERSATILE AND REALVIEW SUPPORT
>  M:	Linus Walleij <linus.walleij@linaro.org>
>  L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> -- 
> 2.16.1
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
