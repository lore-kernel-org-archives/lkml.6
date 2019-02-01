Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D8C282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 640BF218AF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 10:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549015464;
	bh=HDbC5uqMVjQMgpi5gZmTGqJjudIvnrHiZpOweYcG714=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ItH6799iE08jGimzN5N7lajpHK0VqCtzQQvra1gthfaNfxHocLZaAGU3V1Hq528CO
	 XtYJmn0idbIujtuOMDIhVQW9yLeYLHQpV5hvss8wmk4lfgK/xGd1QseZrxD+KGZ22y
	 ZEqSZRn5XH9PMXTZhd6ObrpiG4ZgeU0BQcjAhZCA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728716AbfBAKEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 05:04:23 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:34866 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725765AbfBAKEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 05:04:22 -0500
Received: by mail-lj1-f194.google.com with SMTP id x85-v6so5309606ljb.2;
        Fri, 01 Feb 2019 02:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z9sO8U2aDjiNWi2qzrewkcmRD8Z0BWz3kI3klO60jXc=;
        b=p4EkMeOYOhNulUlAledRhNkIPA4iPn1N3siNX3EFKhUE1RGWRrKeLKifiABCUfHQSP
         b4lHWLuN4KMSeLH5E8Gl5chX7amnFrJl6zGsetBg3NIkSnXCH1zQB+5LvCYKNiLGkuyy
         Mr8xXoR5Mud/n7TviGXoEIe/t/ZHDnk6q3b+813TFFJl3DWJiNS5slRZt+oUkgIw8wG7
         mMOOmWcxgFakXl3WBqx5qjXzm+Y3ninfObCoh6SPzBFtDG2YDQwaP0v8BGcoiUwH0sta
         A+m9qCs3fM8IS5A4mgV7y+DXbofFO/qJkvYNg1Fofo9PdN0fSHNgiaCTsBNwQtSehj/Z
         Z6OA==
X-Gm-Message-State: AJcUukegfgpfRAyFOa2I3APXTzgk0Qqg0JiSpZZ34D3oy6CibGdLGWOw
        s8feYKzYyK58C+hQ3G12UYA=
X-Google-Smtp-Source: ALg8bN7Eo2oEaECD8bG3ljJ9LMvw9LQF8M8ayvtsXicFFI7p0LjHsPH+GR37RAc1wmXtd5qoC+VTDg==
X-Received: by 2002:a2e:9457:: with SMTP id o23-v6mr30917488ljh.7.1549015459592;
        Fri, 01 Feb 2019 02:04:19 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id w4sm1264372lfk.83.2019.02.01.02.04.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 02:04:18 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1gpVgG-0003bk-50; Fri, 01 Feb 2019 11:04:16 +0100
Date:   Fri, 1 Feb 2019 11:04:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     Johan Hovold <johan@kernel.org>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, letux-kernel@openphoenux.org,
        tony@atomide.com, linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bcousson@baylibre.com, linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 2/2] arm: dts: gta04: add gps support
Message-ID: <20190201100416.GD3691@localhost>
References: <20190131180640.14480-1-andreas@kemnade.info>
 <20190131180640.14480-3-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131180640.14480-3-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 31, 2019 at 07:06:40PM +0100, Andreas Kemnade wrote:
> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> which one is mounted so use the compatibility entry for w2sg0004
> for all which will work for both.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> Changes in v3:
> - converted to a patchset
> - added vcc-supply
> 
> Changes in v2:
> - some s/gps/gnss/
> - not added vcc-supply because the regulator is not modelled
>   in dts at all
> 
> w2sg0004 bindings are in next-20190129
> 
>  arch/arm/boot/dts/omap3-gta04.dtsi | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index 02d8274a2f47..4ea0f7dc37c6 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -320,6 +320,12 @@
>  		>;
>         };
>  
> +	gps_pins: pinmux_gps_pins {

s/gps/gnss/ would be more consistent, but whatever.

> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* gpio145 */
> +		>;
> +	};
> +
>  	hdq_pins: hdq_pins {
>  		pinctrl-single,pins = <
>  			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
> @@ -652,6 +658,14 @@
>  &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart2_pins>;
> +	gnss: gnss {
> +		compatible = "wi2wi,w2sg0004";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gps_pins>;
> +		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +		lna-supply = <&vsim>;
> +		vcc-supply = <&ldo_3v3>;
> +	};

Reviewed-by: Johan Hovold <johan@kernel.org>

Johan
