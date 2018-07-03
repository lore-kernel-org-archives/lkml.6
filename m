Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 811D9C6778C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:59:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 460942478E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 20:59:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 460942478E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753303AbeGCU7k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 16:59:40 -0400
Received: from mail-yb0-f195.google.com ([209.85.213.195]:39521 "EHLO
        mail-yb0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752949AbeGCU7h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 16:59:37 -0400
Received: by mail-yb0-f195.google.com with SMTP id k127-v6so1265282ybk.6;
        Tue, 03 Jul 2018 13:59:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uJ3hr9wiOHgzA1pSDcnKCnQYz37kQE5ldpc9yAG9Bi4=;
        b=YzbPPz0Nzb3xwJBPeYf54237ycg3ixIrE1lpiZ3eZwkuAAzdTY+Bh15htBPaRcEslK
         g/fphM7fejAwjtvq7EZCnMsCBG7WmJ/OLnzMyIklun4F8ZfBzrkjTGlXHDB8YK/r+SsH
         RwX7u8HQZUpH2KEh2a0oRWbszAgL8dZ6BVbHk1Y8e0gyNu7NWOS2KhoI5b45PuxTEBoI
         AJEcA14zs15bQyflZHuIow0eN/24IK/sxSd1EZZqGNReqGvjKnmDym5KYl/+5zNrwrW7
         8G6NorGyNW6xUaZV8hZdHdY9LevI2g3TQm3YxPF7sGMDOma/54KLvf9gDnjyN2XP2xbX
         xkfA==
X-Gm-Message-State: APt69E1w2Z5xlIZdwFvVWohGM7q8Rxy2qc4le5p1tGaLxhaCPYvJyMkG
        CJ6uu4+9iSPWDLv7M6A3kQ==
X-Google-Smtp-Source: AAOMgpfX9e7Vut4/nSBLh55rD5EfFaS7W7Ntb3Es+9u7L7kxh5sv+g6C+48YM0bLMpWe1GNWvMZj/Q==
X-Received: by 2002:a25:3cc7:: with SMTP id j190-v6mr2057742yba.220.1530651576159;
        Tue, 03 Jul 2018 13:59:36 -0700 (PDT)
Received: from localhost (24-223-123-72.static.usa-companies.net. [24.223.123.72])
        by smtp.gmail.com with ESMTPSA id 200-v6sm754791ywo.54.2018.07.03.13.59.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 13:59:35 -0700 (PDT)
Date:   Tue, 3 Jul 2018 14:59:32 -0600
From:   Rob Herring <robh@kernel.org>
To:     David Lechner <david@lechnology.com>
Cc:     linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Sekhar Nori <nsekhar@ti.com>,
        Kevin Hilman <khilman@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] dt-bindings: add bindings for TI PRU as remoteproc
Message-ID: <20180703205932.GA28054@rob-hp-laptop>
References: <20180623210810.21232-1-david@lechnology.com>
 <20180623210810.21232-5-david@lechnology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180623210810.21232-5-david@lechnology.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2018 at 04:08:06PM -0500, David Lechner wrote:
> This adds a new binding for the TI Programmable Runtime Unit (PRU)
> as a remoteproc device.
> 
> Signed-off-by: David Lechner <david@lechnology.com>
> ---
>  .../bindings/remoteproc/ti_pru_rproc.txt      | 51 +++++++++++++++++++
>  1 file changed, 51 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> new file mode 100644
> index 000000000000..0e80a8db46d0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/remoteproc/ti_pru_rproc.txt
> @@ -0,0 +1,51 @@
> +TI Programmable Realtime Unit (PRU)
> +===================================
> +
> +Some TI Sitara SoCs contain a Programmable Realtime Unit subsystem with two
> +processor cores that can be used for hard-realtime tasks.
> +
> +
> +Required properties:
> +--------------------
> +The following are the mandatory properties:
> +
> +- compatible:		Should be one of the following,
> +			    "ti,da850-pru-rproc" for AM18xx/OMAPL138 SoCs
> +			    "ti,am3352-pru-rproc" for AM355x SoCs
> +
> +- reg:			Should contain the memory region for the PRUSS
> +
> +- interrupts: 		Should contain the interrupt number used to receive the
> +			virtualqueue kick interrupts from the PRU (i.e.
> +			PRU_EVTOUT0 and PRU_EVTOUT1)
> +
> +- interrupt-names	Should contain "pru0-vq", "pru1-vq"
> +
> +Optional properties:
> +--------------------
> +
> +- power-domains:	A phandle to the power domain that powers the PRUSS

Only for da850?

> +
> +- ti,hwmods:		Name of the hwmod associated to the PRUSS, which is
> +			typically "pruss"

Only for am3352?

typically? You should enumerate possible values.

> +
> +Example:
> +--------
> +
> +	// AM18xx
> +	pru_rproc: cpu@30000 {

cpu is reserved for cpu nodes.

> +		compatible = "ti,da850-pru-rproc";
> +		reg = <0x30000 0x10000>;
> +		interrupts = <3>, <4>;
> +		interrupt-names = "pru0-vq", "pru1-vq";
> +		power-domains = <&psc0 13>;
> +	};
> +
> +	// AM335x
> +	pru_rproc: cpu@4a300000 {
> +		compatible = "ti,am3352-pru-rproc";
> +		reg = <0x4a300000 0x80000>;
> +		interrupts = <20>, <21>;
> +		interrupt-names = "pru0-vq", "pru1-vq";
> +		ti,hwmods = "pruss";
> +	};

Really need 2 examples?

> -- 
> 2.17.1
> 
