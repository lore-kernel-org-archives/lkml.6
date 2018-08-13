Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66B5C4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 88BEA21719
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 22:31:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88BEA21719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732212AbeHNBPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 21:15:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:52687 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729230AbeHNBPT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 21:15:19 -0400
Received: by mail-it0-f65.google.com with SMTP id d9-v6so15589329itf.2;
        Mon, 13 Aug 2018 15:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/ixxyV+zZ5lpUR/tC3df0LJWkBDWprKeVxR8Rsg3d/s=;
        b=SB5SBP3ReuLw9NRTJ4U0QO7QEmvoVN1NMzctgoIqzBzzwUK3bAS1+tujKEIv+HhtVg
         mulUNDCXPik3KTLPpXggvEfor9Njl5lKTb3go7N2iZO2ujZ6vaJWo+IX1Hsps4lDmh47
         GsOoslFEQkfC/tGkbZMdhmfrvGSu6nA97HrlmXQXP6lnjzslT9dGmymHsAJsY/jhooEs
         GIitHMmQcByAXYvPJRNaQ+ByykiDNKnUpophytxAPtJpdDgIGvKDXLpl5rKwGtiVehPu
         q9c1ytyDI9ubNFbElhV8VYL7mjWZPzd+mpOVrwO2ztdlPuyQTi+ZvYqxhQ0tc+blhXbb
         ENxw==
X-Gm-Message-State: AOUpUlHHWdwuiccq7vM/as6rWwqfghFVpFPYhzZ3M0gLGlrfdbIJBBOQ
        uRtAswRq1UoiOCzMqD8Xuw==
X-Google-Smtp-Source: AA+uWPyj1dRllgCWFyDNgTTzfqbEcwgUtUIULAvSHjK3Q0fWN/uozfV99VJtOJPvo4BkU7vH2+h27g==
X-Received: by 2002:a24:6302:: with SMTP id j2-v6mr12862803itc.8.1534199465429;
        Mon, 13 Aug 2018 15:31:05 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id h12-v6sm2788029ioj.57.2018.08.13.15.31.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 15:31:04 -0700 (PDT)
Date:   Mon, 13 Aug 2018 16:31:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Quentin Schulz <quentin.schulz@bootlin.com>
Cc:     alexandre.belloni@bootlin.com, ralf@linux-mips.org,
        paul.burton@mips.com, jhogan@kernel.org, mark.rutland@arm.com,
        davem@davemloft.net, kishon@ti.com, andrew@lunn.ch,
        f.fainelli@gmail.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, allan.nielsen@microsemi.com,
        thomas.petazzoni@bootlin.com
Subject: Re: [PATCH net-next 02/10] dt-bindings: net: ocelot: remove hsio
 from the list of register address spaces
Message-ID: <20180813223103.GA16669@rob-hp-laptop>
References: <cover.aa759035f6eefdd0bb2a5ae335dab5bd5399bd46.1532954208.git-series.quentin.schulz@bootlin.com>
 <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3558e538b55a2249b0a179c04c27e9d3715bbbaa.1532954208.git-series.quentin.schulz@bootlin.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 30, 2018 at 02:43:47PM +0200, Quentin Schulz wrote:
> HSIO register address space should be handled outside of the MAC
> controller as there are some registers for PLL5 configuring,
> SerDes/switch port muxing and a thermal sensor IP, so let's remove it.
> 
> Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
> ---
>  Documentation/devicetree/bindings/mips/mscc.txt       | 16 ++++++++++++-
>  Documentation/devicetree/bindings/net/mscc-ocelot.txt |  9 ++-----
>  2 files changed, 19 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mips/mscc.txt b/Documentation/devicetree/bindings/mips/mscc.txt
> index ae15ec3..bc817e9 100644
> --- a/Documentation/devicetree/bindings/mips/mscc.txt
> +++ b/Documentation/devicetree/bindings/mips/mscc.txt
> @@ -41,3 +41,19 @@ Example:
>  		compatible = "mscc,ocelot-cpu-syscon", "syscon";
>  		reg = <0x70000000 0x2c>;
>  	};
> +
> +o HSIO regs:
> +
> +The SoC has a few registers (HSIO) handling miscellaneous functionalities:
> +configuration and status of PLL5, RCOMP, SyncE, SerDes configurations and
> +status, SerDes muxing and a thermal sensor.
> +
> +Required properties:
> +- compatible: Should be "mscc,ocelot-hsio", "syscon", "simple-mfd"
> +- reg : Should contain registers location and length
> +
> +Example:
> +	syscon@10d0000 {
> +		compatible = "mscc,ocelot-hsio", "syscon", "simple-mfd";

simple-mfd is not appropriate without child nodes, so drop it.

> +		reg = <0x10d0000 0x10000>;
> +	};
> diff --git a/Documentation/devicetree/bindings/net/mscc-ocelot.txt b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> index 0a84711..9e5c17d 100644
> --- a/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> +++ b/Documentation/devicetree/bindings/net/mscc-ocelot.txt
> @@ -12,7 +12,6 @@ Required properties:
>    - "sys"
>    - "rew"
>    - "qs"
> -  - "hsio"
>    - "qsys"
>    - "ana"
>    - "portX" with X from 0 to the number of last port index available on that
> @@ -45,7 +44,6 @@ Example:
>  		reg = <0x1010000 0x10000>,
>  		      <0x1030000 0x10000>,
>  		      <0x1080000 0x100>,
> -		      <0x10d0000 0x10000>,
>  		      <0x11e0000 0x100>,
>  		      <0x11f0000 0x100>,
>  		      <0x1200000 0x100>,
> @@ -59,10 +57,9 @@ Example:
>  		      <0x1280000 0x100>,
>  		      <0x1800000 0x80000>,
>  		      <0x1880000 0x10000>;
> -		reg-names = "sys", "rew", "qs", "hsio", "port0",
> -			    "port1", "port2", "port3", "port4", "port5",
> -			    "port6", "port7", "port8", "port9", "port10",
> -			    "qsys", "ana";
> +		reg-names = "sys", "rew", "qs", "port0", "port1", "port2",
> +			    "port3", "port4", "port5", "port6", "port7",
> +			    "port8", "port9", "port10", "qsys", "ana";
>  		interrupts = <21 22>;
>  		interrupt-names = "xtr", "inj";
>  
> -- 
> git-series 0.9.1
