Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_MED,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E7BC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01B7820C03
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 08:37:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ragnatech-se.20150623.gappssmtp.com header.i=@ragnatech-se.20150623.gappssmtp.com header.b="MVFKB0l2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B7820C03
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ragnatech.se
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390075AbeHPLd5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 07:33:57 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:40920 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389331AbeHPLd5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 07:33:57 -0400
Received: by mail-lf1-f67.google.com with SMTP id y200-v6so2799964lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Aug 2018 01:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ragnatech-se.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=MoB0lk2XbyPhjBuBgxxUK6WjgDPG5O2vtxm2M1rtRkg=;
        b=MVFKB0l2xxdaZOCmRMFdNbEDDeHvkWkHtUpq7VdaXJTIFPRu1K1UnAe4fEgR0qTV4j
         4OMqFQC1OQB5NFGgXY9RRCBZc0BzucxgGxeHddM9UI+JQOP4s0Yjf5SNJyZBVir+Tm8v
         Gs/OTFaR9+Tj+Fu8utht9IBGacaqzxmR/2ViUXsLGEyGaMpxU2OQLmQ/fnTANIrFeJ6u
         2I47swdxZKRZYsWxdME9gJvscHBMv1du5bsDE7dw4+s7xkDdeOkoprd3omLmdMHGksRP
         1DEcOgz2dWJjOSi54v7wr5MKAId0y5i//G2pHjA2Wd/3c6sV7lJRfqQ/d8eta/BkIGIy
         r5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=MoB0lk2XbyPhjBuBgxxUK6WjgDPG5O2vtxm2M1rtRkg=;
        b=Sq57+J9Y5J9BCs2Hq5FLWyLsHB9bRZ8a4q2aJjjf3xSjwVSVZf+aoPSGKxRUIlLZaS
         ADGFyqIgg1rjmpfGdZ5noh21hbKVY5yTuLiu/4+Lp0Totq3CPitYl/p/MVIIj34LpbYu
         H6o30XJKO4NHpE6MEgBFIWuW0wOkAjVKgb3IfuUro4d21ehBdkwZmVopnMH/rq1g+MzS
         ptICs6HcCJuWTArex7NYH/UcmCYC9KFWW6kW0V+uxX7sz9suBSEYNWeiwLbwyUju9e9j
         HY+YDISUq33WbCGHTheP+OmkFMTfp7QEGWeazOILV7F5uSUYw52m7eBL2AhuJtJAm+Vy
         cxLg==
X-Gm-Message-State: AOUpUlGND/4cIujpMsUO82a4TGJ+mNxdUHq9gaWdHVlz7//6pRJHAjWX
        T+iTsRmT/xozTgsHIYumtibwrQ==
X-Google-Smtp-Source: AA+uWPzfY2Fjm/fZmyROrt5qygmDwd0jFHKr+bPCDOQuaFBCFrlDTfRMLdGRLjEU7361yAM6NWTYPQ==
X-Received: by 2002:a19:cf95:: with SMTP id f143-v6mr19667960lfg.101.1534408619993;
        Thu, 16 Aug 2018 01:36:59 -0700 (PDT)
Received: from localhost (89-233-230-99.cust.bredband2.com. [89.233.230.99])
        by smtp.gmail.com with ESMTPSA id j140-v6sm4926554lfg.16.2018.08.16.01.36.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Aug 2018 01:36:58 -0700 (PDT)
Date:   Thu, 16 Aug 2018 10:36:58 +0200
From:   Niklas =?iso-8859-1?Q?S=F6derlund?= 
        <niklas.soderlund@ragnatech.se>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: media: adv748x: Document re-mappable
 addresses
Message-ID: <20180816083658.GP1635@bigcity.dyn.berto.se>
References: <20180809192944.7371-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180809192944.7371-1-kieran.bingham@ideasonboard.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thanks for your patch.

On 2018-08-09 20:29:44 +0100, Kieran Bingham wrote:
> The ADV748x supports configurable slave addresses for its I2C pages.
> Document the page names, and provide an example for setting each of the
> pages explicitly.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

> 
> ---
> v2:
>  - Fix commit message
>  - Extend documentation for the "required property" reg:
> 
> v3
>  - Fix missing comment from Laurent.
>  - correct the reg descrption
> ---
>  .../devicetree/bindings/media/i2c/adv748x.txt    | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/i2c/adv748x.txt b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
> index 21ffb5ed8183..25a02496f4ba 100644
> --- a/Documentation/devicetree/bindings/media/i2c/adv748x.txt
> +++ b/Documentation/devicetree/bindings/media/i2c/adv748x.txt
> @@ -10,7 +10,11 @@ Required Properties:
>      - "adi,adv7481" for the ADV7481
>      - "adi,adv7482" for the ADV7482
>  
> -  - reg: I2C slave address
> +  - reg: I2C slave addresses
> +    The ADV748x has up to twelve 256-byte maps that can be accessed via the
> +    main I2C ports. Each map has it own I2C address and acts as a standard
> +    slave device on the I2C bus. The main address is mandatory, others are
> +    optional and remain at default values if not specified.
>  
>  Optional Properties:
>  
> @@ -18,6 +22,11 @@ Optional Properties:
>  		     "intrq3". All interrupts are optional. The "intrq3" interrupt
>  		     is only available on the adv7481
>    - interrupts: Specify the interrupt lines for the ADV748x
> +  - reg-names : Names of maps with programmable addresses.
> +		It shall contain all maps needing a non-default address.
> +		Possible map names are:
> +		  "main", "dpll", "cp", "hdmi", "edid", "repeater",
> +		  "infoframe", "cbus", "cec", "sdp", "txa", "txb"
>  
>  The device node must contain one 'port' child node per device input and output
>  port, in accordance with the video interface bindings defined in
> @@ -47,7 +56,10 @@ Example:
>  
>  	video-receiver@70 {
>  		compatible = "adi,adv7482";
> -		reg = <0x70>;
> +		reg = <0x70 0x71 0x72 0x73 0x74 0x75
> +		       0x60 0x61 0x62 0x63 0x64 0x65>;
> +		reg-names = "main", "dpll", "cp", "hdmi", "edid", "repeater",
> +			    "infoframe", "cbus", "cec", "sdp", "txa", "txb";
>  
>  		#address-cells = <1>;
>  		#size-cells = <0>;
> -- 
> 2.17.1
> 

-- 
Regards,
Niklas Söderlund
