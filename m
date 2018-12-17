Return-Path: <SRS0=+VtO=O2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8058FC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EE8821783
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Dec 2018 22:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545087051;
	bh=wpMRzmT5l80ObPa0/0jB0LSUGmKb/wnpg+HyuS7PKH0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wr25794j7K5reQ3YNXS6VXOC1HRuS24mnYMWWN5vurxIOUaD3gBFid3HwncQDzauI
	 bGbvjZZucVUHIVT6ECBFhDo8paoAeuCDwGEqL3gHefj53oAeYn3u0d0EmL10tn5hyg
	 XvoXE+T5a45Gqs+aUW48S7eTUNfMb/lKY4H5Chs4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732301AbeLQWuu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Dec 2018 17:50:50 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35636 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732214AbeLQWur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Dec 2018 17:50:47 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so13833381otj.2;
        Mon, 17 Dec 2018 14:50:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=qq9RWe0o0AwcBrBkMiHV/TYpBZUXDqrNISSfY4PEHKw=;
        b=fZwEQGfYJ//rTIAK0utX7psqL/9xOQrZmgJDqXNNETIPl3H+CuNO+4RV4/F2s7ApZL
         KqFPWkjHQwudvetP+eSVH/uhS2PGg+UHIzL49hLowK2CoRH8eAzXDax36/iWNFE/S15E
         qOsiMWos3KVmXD+/PMjGSOFzIt1p39+7rQ1DHIP17RR6My8KoazjIW7Zza1ogzyozCSs
         xWhI2FUXgKR4rWmyl+FRBKM2gg06vyWTehsJFv6gRCJJmLrtqawedHqkkBOo/wAFmrtt
         olN3wJDVpY/HEHL+SUqwa4OBy4EVK3EEKln9Rze/UTE36e0X63fw0U/i4JyPAT4Wbm+Y
         6hng==
X-Gm-Message-State: AA+aEWardxD6/RsG5QJ/ZF/YEfeUb25RyqeACjLQEN4rVz2/xqhL/aYK
        MhZ7zdbPOWf8Y6fjAm93Eg==
X-Google-Smtp-Source: AFSGD/Uy0/PDtV85R3dYiMENowAmvV0y/y+2yLxz3mUD12V1btwpToPPKOYDhysi0quw5ldDK1qR9w==
X-Received: by 2002:a9d:191a:: with SMTP id j26mr1577700ota.81.1545087045319;
        Mon, 17 Dec 2018 14:50:45 -0800 (PST)
Received: from localhost (cpe-70-114-214-127.austin.res.rr.com. [70.114.214.127])
        by smtp.gmail.com with ESMTPSA id v3sm14103455oib.57.2018.12.17.14.50.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 14:50:44 -0800 (PST)
Date:   Mon, 17 Dec 2018 16:50:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?iso-8859-1?Q?Miqu=E8l?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: ap806: add the cluster clock node in
 the syscon file
Message-ID: <20181217225044.GA25148@bogus>
References: <20181216094147.6468-1-gregory.clement@bootlin.com>
 <20181216094147.6468-2-gregory.clement@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181216094147.6468-2-gregory.clement@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 16, 2018 at 10:41:42AM +0100, Gregory CLEMENT wrote:
> Document the device tree binding for the cluster clock controllers found
> in the Armada 7K/8K SoCs.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
> ---
>  .../arm/marvell/ap806-system-controller.txt   | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> index 3fd21bb7cb37..8f281816a6b8 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> +++ b/Documentation/devicetree/bindings/arm/marvell/ap806-system-controller.txt
> @@ -136,3 +136,25 @@ ap_syscon1: system-controller@6f8000 {
>  		#thermal-sensor-cells = <1>;
>  	};
>  };
> +
> +Cluster clocks:
> +---------------
> +
> +Device Tree Clock bindings for cluster clock of AP806 Marvell. Each
> +cluster contain up to 2 CPUs running at the same frequency.
> +
> +Required properties:
> +- compatible: must be  "marvell,ap806-cpu-clock";
> +- #clock-cells : should be set to 1.
> +- clocks : shall be the input parents clock phandle for the clock.
> +
> +ap_syscon1: system-controller@6f8000 {
> +	compatible = "syscon", "simple-mfd";
> +	reg = <0x6f8000 0x1000>;
> +
> +	cpu_clk: clock-cpu {

There's not a register address range you can use even if Linux happens 
to not need it (currently)?

There's already a clock node under this syscon? Are they really separate 
sub-blocks?

> +		compatible = "marvell,ap806-cpu-clock";
> +		clocks = <&ap_clk 0>, <&ap_clk 1>;
> +		#clock-cells = <1>;
> +	};
> +};
> -- 
> 2.19.2
> 
