Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4FEC46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7962E2171F
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 17:45:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7962E2171F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbeHMU3A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 16:29:00 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51615 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeHMU3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 16:29:00 -0400
Received: by mail-it0-f65.google.com with SMTP id e14-v6so14269391itf.1;
        Mon, 13 Aug 2018 10:45:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VYwpQ2XDkpyaej9qVjPVDPyWhCRnjLssY3E+T5zo4/Q=;
        b=HyvUuk97wkFhP0Mxit8yqp3mydbYHY0XgDupX0dm6Te81fH7XdXZvVTibZhS88uHy3
         0qGIBKoyqQsbB3UFuw30rZoRQjkFa2Zzkvw6KA6lAJ0M5aBZ6oNeE9gOSHz67Y3JPz1s
         3hux5vkgif7W62aHzvG7lGhUjGD5xnqxzho7WcSwOqSwEc5Fu7kvBLutrXgK+XBDcSvS
         WLk5tOZNC169LiyByKlEkzZdmnpuTO1nMeFjDRrGHx4hAKcPVuAI9i07c5Yr0+Ghyc1C
         6mRM5cXtOdySqm2FL+frfYGUhThJXVfs6996UQFJQ9M9owFNUlqo8LMcmRp4lFL0prRJ
         /5Ww==
X-Gm-Message-State: AOUpUlFuL/mvQ17DXCE80UskwhItZ0J2JUjUVROrs+O+jusAZA+v8Cev
        D3v4wjbhb+8SHnpuwkfQFA==
X-Google-Smtp-Source: AA+uWPziuxWrE7iyJwkNOI82gruFcXjfwSE6J8zJA8rLrX0PDqwwTgYRF4bktpfTETMEDm4dpXlNxA==
X-Received: by 2002:a24:a045:: with SMTP id o66-v6mr11450116ite.127.1534182346340;
        Mon, 13 Aug 2018 10:45:46 -0700 (PDT)
Received: from localhost ([24.51.61.72])
        by smtp.gmail.com with ESMTPSA id t64-v6sm5197608ita.13.2018.08.13.10.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 13 Aug 2018 10:45:45 -0700 (PDT)
Date:   Mon, 13 Aug 2018 11:45:44 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        mchehab@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] dt-bindings: media: adv748x: Document re-mappable
 addresses
Message-ID: <20180813174544.GA11379@rob-hp-laptop>
References: <20180809192944.7371-1-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809192944.7371-1-kieran.bingham@ideasonboard.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 09, 2018 at 08:29:44PM +0100, Kieran Bingham wrote:
> The ADV748x supports configurable slave addresses for its I2C pages.
> Document the page names, and provide an example for setting each of the
> pages explicitly.

It would be good to say why you need this. The only use I can think of 
is if there are other devices on the bus and you need to make sure the 
addresses don't conflict. Arguably, that information could be figured 
out without this in DT.

Regardless,

Reviewed-by: Rob Herring <robh@kernel.org>

> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
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
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
