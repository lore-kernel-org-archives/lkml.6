Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D914C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:02:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAF6E218AC
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549015372;
	bh=ICGGKhbn9LO+49uX+DcKnHEkJJDCbfyeROqgjAvVrgk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WqdCUQDo87irozx9tz6ydZJMeCL+ckO9V+dokrwme9q4ZKDbl7kfc6EtutfOgwQRu
	 7ZHxpfwT0yJ2IwhSGESvDNoTgT0r06XNiJ6DsPLEz0Fcl7LD4sOY+sYw3zSzkxHxTB
	 Pos3NlETMy3/5/gGMbH63f6z2yU+LEAZdiBrSq/U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728396AbfBAKCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:02:50 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39061 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAKCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:02:50 -0500
Received: by mail-lf1-f67.google.com with SMTP id n18so4597791lfh.6;
        Fri, 01 Feb 2019 02:02:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kWbHgvn3C22K94Ooa0wNfkVw7TfrlunSrxqw5snEbI0=;
        b=WfAeD7Nvh8qegFD8InUYQ3lXEHNbPUYRRKJxOT+qE6sobV0C1xF7P1lyJzZct8OKZI
         410CSb6sTHd2nPoeYq7BlAdOwIUItn6iFD+IWYzNAgYUeHh2oWqjtzjsUVKkLuDLjLRn
         d+xlxo56bjWa+VkzA5mXMBjSM8znzyW1SYOCp5zEy6PGxb4saEoPOF7R9XYYwMtuSy4e
         erSWGGfqzjjwUSf8e/xtcxNWCNe2fRXeS/0J3Zt8CksAxyX7o1y+pcpUjDRhdnmlUZdA
         KGs92ig6Hj98/B3rAYyn3aTEP6P1PKbY+h24JMlNeMf9LELMH8kCYNxjKHhs5eXvyiTQ
         JfYA==
X-Gm-Message-State: AJcUukdioQv+bDwzcbbjhPStOKbs4tD6q8RCX10i1JAAh4dXj3oCZtqD
        Vo1ywZ2rqhCO0qHaarpAAe0=
X-Google-Smtp-Source: ALg8bN5ZOTFfCixNOzIQvcj+bmh8tVkNcTrd72DhyOhGnifHE+Ygs6B936uJM1jgIITcnnObU1Gvmg==
X-Received: by 2002:a19:c345:: with SMTP id t66mr27843886lff.55.1549015368155;
        Fri, 01 Feb 2019 02:02:48 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id l63sm1287323lfl.76.2019.02.01.02.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 02:02:46 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gpVem-0003ay-MC; Fri, 01 Feb 2019 11:02:44 +0100
Date:   Fri, 1 Feb 2019 11:02:44 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org,
        tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 1/2] arm: dts: gta04: add ldo 3v3 regulator
Message-ID: <20190201100244.GC3691@localhost>
References: <20190131180640.14480-1-andreas@kemnade.info>
 <20190131180640.14480-2-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131180640.14480-2-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 07:06:39PM +0100, Andreas Kemnade wrote:
> Required for completeness sake to be able to specify
> a regulator for devices having a non-optional regulator
> property. It corresponds to the "3V3" net in the
> schematics.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> new in v3
> 
>  arch/arm/boot/dts/omap3-gta04.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index e53d32691308..02d8274a2f47 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -32,6 +32,14 @@
>  		display1 = &tv0;
>  	};
>  
> +	ldo_3v3: fixedregulator {

A suffix, even if its just to rename as "fixedregulator0", would allow
further fixed regulators to be added later, but I guess that can be
handled then.

> +		compatible = "regulator-fixed";
> +		regulator-name = "ldo_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		regulator-always-on;
> +	};
> +
>  	/* fixed 26MHz oscillator */
>  	hfclk_26m: oscillator {
>  		#clock-cells = <0>;

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
