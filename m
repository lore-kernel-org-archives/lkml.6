Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3893C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:22:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F73021905
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 20:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545337373;
	bh=sHoMP/yI0t+WcCx5Kf6pqJtzMo7u0e4Gvzoh0C8tJIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=hgNSjU4Kuo061F0UWNEczZrRyhicezjBBcV5uJR02pE91sgO1AxSweUxHQGAY2qhc
	 MwaFgUKfAMedquDew1ByIxUNLid3xJJlcFwUEq2HyAbVP+LXgTn7qQwc7ecq9zRx/c
	 UWzPgk2BvIXuG8oz2p/pCB/IYc4xpzxIyamJwnS0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732326AbeLTUWw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 15:22:52 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:44654 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730043AbeLTUWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 15:22:52 -0500
Received: by mail-oi1-f193.google.com with SMTP id m6so2949907oig.11;
        Thu, 20 Dec 2018 12:22:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BTrzvBPxiwd4pvfl3PlEXOfLlqgTOynPTw2iwWne1yM=;
        b=lScGfzSAU/n5VxrmNnegDs2V2R66IoVzgz8m8zio0Fb1bc+BErD+Qoc4xS/3v0O+AO
         SF5v5alNuaav7Fe2oci4cKRmVcJVxV1nhuiZyiwEngQw+GyYNm0TQwCA300nG0wavnP3
         bzJL7o6ni/YMgIKBVGOl93ewB+MgwYBV8A93w+1CRGbOJf7sOZiuKkSqlHCPvEHovwyd
         w3jN725YdAMP7z/o61H/EcEOmIjM/+MslJAw9HFpRi7vg+RQ9PwUiMa3dDzbkAHSRsqU
         NXsIdW4E9KAHIVrmQXOEtz2jqwmcPuqHiuoc1PqFee66aFrSI3Liy2GSO8l2G50aN7Zt
         wyWg==
X-Gm-Message-State: AA+aEWYMvIIh5Jym885IXH1rhnwsfqrGDyOcolky6gw+s82HQ5KT+cYp
        /uV8WpD8Z61qJBN1ibgDC8WDlFE=
X-Google-Smtp-Source: AFSGD/XNRPaBhvSwT2N/pboJ7/o/iQE7LNcBq7BTf9DtDOfk73CoOKuQj8a9XHH3a3XWdPFPBU003Q==
X-Received: by 2002:aca:bb8b:: with SMTP id l133mr120011oif.357.1545337370262;
        Thu, 20 Dec 2018 12:22:50 -0800 (PST)
Received: from localhost ([2607:fb90:20d2:a5e2:49af:e73e:5a36:3b50])
        by smtp.gmail.com with ESMTPSA id k130sm10728005oia.47.2018.12.20.12.22.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 12:22:49 -0800 (PST)
Date:   Thu, 20 Dec 2018 14:22:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Joakim Zhang <qiangqing.zhang@nxp.com>
Cc:     "mkl@pengutronix.de" <mkl@pengutronix.de>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        Aisheng Dong <aisheng.dong@nxp.com>
Subject: Re: [PATCH 1/2] Documentation: can: flexcan: add PE clock source
 property to device tree
Message-ID: <20181220202247.GA26362@bogus>
References: <20181213070537.25095-1-qiangqing.zhang@nxp.com>
 <20181213070537.25095-2-qiangqing.zhang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181213070537.25095-2-qiangqing.zhang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2018 at 07:07:57AM +0000, Joakim Zhang wrote:
> From: Dong Aisheng <aisheng.dong@nxp.com>
> 
> The FlexCAN controller can parse clock source property from DTS file to
> select PE clock source.
> 
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
> ---
>  Documentation/devicetree/bindings/net/can/fsl-flexcan.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> index bc77477c6878..a04168605998 100644
> --- a/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> +++ b/Documentation/devicetree/bindings/net/can/fsl-flexcan.txt
> @@ -32,6 +32,13 @@ Optional properties:
>  		 ack_gpr is the gpr register offset of CAN stop acknowledge.
>  		 ack_bit is the bit offset of CAN stop acknowledge.
>  
> +- fsl,clk-source: Select the clock source to the CAN Protocol Engine (PE).
> +		  It's SoC Implementation dependent. Refer to RM for detailed

If SoC dependent, then it should be implied by the SoC specific 
compatible. Also, seems like you should add clock binding support here 
if you need more clock control.

> +		  definition. If this property is not set in device tree node
> +		  then driver selects clock source 1 by default.
> +		  0: clock source 0 (oscillator clock)
> +		  1: clock source 1 (peripheral clock)
> +
>  Example:
>  
>  	can@1c000 {
> @@ -40,4 +47,5 @@ Example:
>  		interrupts = <48 0x2>;
>  		interrupt-parent = <&mpic>;
>  		clock-frequency = <200000000>; // filled in by bootloader
> +		fsl,clk-source = <0>; // select clock source 0 for PE
>  	};
> -- 
> 2.17.1
> 
