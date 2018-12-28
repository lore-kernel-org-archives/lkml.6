Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35225C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:51:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0605B218F0
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546037487;
	bh=G2NoP0NlSIvk2BP/PIpfMjDuwhEZiGK7D7BKDEnmzdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fmhIvV4+oDnhbIZvmSo/DIXqVbs6SBm1K/YNP/n1uLOkRAwuRXZ+hWRh/Hvm+D1Gi
	 jb75R4g8uAToNeA/82MW4ncxmJZGLcAEe/ef4zZ6wronaw6Qwu9b3LlkCpJ8JM7FOq
	 eVjCnMkkdX4F+CeQ5kLarE9mMaZqQfyL14COjNZ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727463AbeL1Wv0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:51:26 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:34772 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727163AbeL1WvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:51:25 -0500
Received: by mail-io1-f68.google.com with SMTP id l22so5940346ioh.1;
        Fri, 28 Dec 2018 14:51:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FLjIU5RPwLWRwCCUYJ+m06BrwO+kbC6STmpZ5MdbL1g=;
        b=kIEvp3xGtqTnqi/p8T1aYAf45NbygSGbi2p8RQ8yWmXD5bIcCXKouYLlB75srpEnxt
         WH+fDRan177wUhj1zi7TmOTo9pcBzrBoiMIWlWAlVIo3vEP0dbbX6QlSB8tW9ErMTNuS
         BU9Dbz6e6MApMAQhhdxialcAv80U4RUWPK0YeasWfcesvJa3Xlb0Q/BxzVx2kW945oKO
         JNG1fMrTU5U4TGgVir+jXhqoQg93h03q2Xn/RpsA32SS9GX0EFWdO/N4N9Px8H8FJ6f6
         2PJAD8cB0NCHvpVyrrs20gQrZ7lBhgNjZFJso7hFaL4LmhTKRc0kioU1Ch2FDBpDbsCd
         nAnQ==
X-Gm-Message-State: AJcUukdMSfBbnp8G6JHb+dqa5Kn/F8r6w1dgILCN5mszbbGopCyLd2jB
        b2ff0PWm/GmKqlPxUtE+lA==
X-Google-Smtp-Source: ALg8bN5Id1K79dRyDAWcpJN7xSXe1osVnyWuE4YXdSUbOdMWT4jT0v50/ab2g19ApDVPynmLxVKQCw==
X-Received: by 2002:a6b:6a0a:: with SMTP id x10mr8538034iog.87.1546037484880;
        Fri, 28 Dec 2018 14:51:24 -0800 (PST)
Received: from localhost ([24.51.61.172])
        by smtp.gmail.com with ESMTPSA id b192sm16485941itb.12.2018.12.28.14.51.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 28 Dec 2018 14:51:24 -0800 (PST)
Date:   Fri, 28 Dec 2018 16:51:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: extend tps65218 bindings
Message-ID: <20181228225123.GA10598@bogus>
References: <1545120356-7749-1-git-send-email-Christian.Hohnstaedt@wago.com>
 <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1545120356-7749-2-git-send-email-Christian.Hohnstaedt@wago.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 18, 2018 at 09:05:55AM +0100, Christian Hohnstaedt wrote:
> Add input voltage configuration options
> 
> Signed-off-by: Christian Hohnstaedt <Christian.Hohnstaedt@wago.com>
> ---
>  Documentation/devicetree/bindings/regulator/tps65218.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/regulator/tps65218.txt b/Documentation/devicetree/bindings/regulator/tps65218.txt
> index 02f0e9b..a9ee377 100644
> --- a/Documentation/devicetree/bindings/regulator/tps65218.txt
> +++ b/Documentation/devicetree/bindings/regulator/tps65218.txt
> @@ -16,12 +16,22 @@ Required properties:
>    regulator-dcdc5, regulator-dcdc6, regulator-ldo1, regulator-ls3.
>    Each regulator is defined using the standard binding for regulators.
>  
> +Optional properties:
> +  If any of these properties is absent, the setting will not be touched.
> +- strict-supply-voltage: <1|0> Set/Reset STRICT flag in CONFIG1
> +- under-voltage-limit: Select 2.75, 2.95, 3.25 or 3.35V as UVLO in CONFIG1
> +- under-voltage-hysteresis: Select 200mV or 400mV UVLOHYS in CONFIG2

These need vendor prefixes and unit suffixes (as defined in 
property-units.txt).

> +
>  Example:
>  tps65218: tps65218@24 {
>  	reg = <0x24>;
>  	compatible = "ti,tps65218";
>  	interrupts = <GIC_SPI 7 IRQ_TYPE_NONE>; /* NMIn */
>  	interrupt-controller;
> +	strict-supply-voltage = <1>;
> +	under-voltage-hysteresis = <400000>;
> +	under-voltage-limit = <3350000>;
> +
>  	#interrupt-cells = <2>;
>  
>  	dcdc1: regulator-dcdc1 {
> -- 
> 2.7.4
> 
