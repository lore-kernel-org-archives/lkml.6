Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:52:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 610022176F
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 19:52:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545335552;
	bh=UvrkK3fBd+7vPjQkEYixh+w33w7psYrc2c+PNlJar4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=1s6WrZxDDsLXbaRG6z73VF0wC8A4Ksawe49BBuh7iX04IY79BsbByRZb0TdBOcWGe
	 nwmFUN1Xs0PfAbUa0oG1OoFK0XvE4bi4hL0tU6TWYaBdpxtmlh/LecIF3H4xAbJV9D
	 tHQAHb+xEry6KYYH3KtGQbKNUsx+3DyMmktSB8Vw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389527AbeLTTwb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 14:52:31 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:42004 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbeLTTwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 14:52:31 -0500
Received: by mail-oi1-f196.google.com with SMTP id w13so2888716oiw.9;
        Thu, 20 Dec 2018 11:52:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=24BoR+RxY5BGrbZKEBLkjKqR1VsXUja9f0axGQKK+Nc=;
        b=k2IgAxcz6EgPxw6ofPYrjpadjdMq8+FbZqqN+KoTjUnnthQqA2q4K9wuNuTR8mbf0R
         Ax8V1JWZUtyIttQlcBWDvhwUgE6gzTtsYfYBkqd4okwTuB01BMwtQZgoXDEiVwNF72Co
         2lEe4RN+d6mU0KfK+R2MKNK4wvjfAjd42zSdciG/3JaImW3J6E6ERlDWhxcVggwRsxmR
         ZSZxfCARmOItDsNWaiZ/pIm+RVhO23dg007VqUbEFseANgsKw1IcCcIN8rTMBLnpeZq2
         ubyhaswLAQcq39TTk6/oD31NJxGjK+MWEXM4OXTWeeO4f7PXeqn9gI6YIMJzgqX41HMD
         DwqA==
X-Gm-Message-State: AJcUukfw2GXpnk3Sav09OIb/NSxaBNl4BiGs2zpKptNWfSfbXORkMpF7
        w5ExP2uHKTg3AdKrt56g97RrI+M=
X-Google-Smtp-Source: AFSGD/UCP0m+Wl3wBjVSkcHbNMxV2MlnqZtYM+FJISKW2QIPvuPW5PdJj1sX9T+Zo7pOQDpsao97QA==
X-Received: by 2002:a54:4088:: with SMTP id i8mr65490oii.324.1545335549842;
        Thu, 20 Dec 2018 11:52:29 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id c78sm16305114oig.30.2018.12.20.11.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 11:52:29 -0800 (PST)
Date:   Thu, 20 Dec 2018 13:52:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Maxime Jourdan <mjourdan@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: meson: add specific simplefb bindings
Message-ID: <20181220195228.GA17561@bogus>
References: <20181210090640.4495-1-mjourdan@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210090640.4495-1-mjourdan@baylibre.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 10, 2018 at 10:06:39AM +0100, Maxime Jourdan wrote:
> Similar to simple-framebuffer-sunxi, we support different display pipelines
> that the firmware is free to choose from.
> 
> This documents the "amlogic,simple-framebuffer" compatible and the
> "amlogic,pipeline" extension.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  .../display/simple-framebuffer-meson.txt      | 33 +++++++++++++++++++
>  1 file changed, 33 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> new file mode 100644
> index 000000000000..122a5c005cd9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer-meson.txt
> @@ -0,0 +1,33 @@
> +Meson specific Simple Framebuffer bindings
> +
> +This binding documents meson specific extensions to the simple-framebuffer
> +bindings. The meson simplefb u-boot code relies on the devicetree containing
> +pre-populated simplefb nodes.
> +
> +These extensions are intended so that u-boot can select the right node based
> +on which pipeline is being used. As such they are solely intended for
> +firmware / bootloader use, and the OS should ignore them.
> +
> +Required properties:
> +- compatible: "amlogic,simple-framebuffer"

And a fallback?

> +- amlogic,pipeline, one of:
> +  "vpu-cvbs"
> +  "vpu-hdmi"
> +
> +Example:
> +
> +chosen {
> +	#address-cells = <2>;
> +	#size-cells = <2>;
> +	ranges;
> +
> +	framebuffer@0 {

Without 'reg', you shouldn't have a unit-address.

> +		compatible = "amlogic,simple-framebuffer",
> +			     "simple-framebuffer";
> +		amlogic,pipeline = "vpu-hdmi";
> +		clocks = <&clkc CLKID_HDMI_PCLK>,
> +			 <&clkc CLKID_CLK81>,
> +			 <&clkc CLKID_GCLK_VENCI_INT0>;
> +		power-domains = <&pwrc_vpu>;
> +	};
> +};
> -- 
> 2.19.2
> 
