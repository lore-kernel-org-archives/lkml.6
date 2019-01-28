Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8400DC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5346720881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 07:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548662047;
	bh=iCvL//YYetpelVpJxCLBTUxzIFukhm4CIFEVSBjgM68=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=FgzWUFeczLCuvGoK3hvMIJdvWjz5i/HzA+K4iYBice03R1Vxi0ozpyu+aT8g2Vo0d
	 gaT5Zx7dxmy//iiKDCW4kbS+3bh64zDtKE0cC8Fmvt14sEu5nUUx29gGZrlV5p7yv9
	 aBATCh3PXX6W2Za7wzkyT9R6sywy22yoF5XOQWA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfA1HyF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 02:54:05 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:38990 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbfA1HyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 02:54:05 -0500
Received: by mail-lj1-f193.google.com with SMTP id t9-v6so13328726ljh.6;
        Sun, 27 Jan 2019 23:54:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5d5z7YJ+QIkJKJh8YBd60GvrST4LwX3jt6JysFLbk5s=;
        b=JKbkBiMaVXeg2FZo8QoDsB+/dTUwUSLUzCwynb0WGNmnM4WilUq8MJRAo0BXT0VIO/
         yMlOdydpYbwsJC1lnfHlxEAvFN2wD3Pal8jwaYWY108pPk95q/PGIZwhVZGazQ4l4asN
         FjCxpmdwvrsipQXJvRK4kp1owrj2p0UaXyfoq1grUCw+yiGDpeyUOgZYf14JtQ16GzdA
         2rvyxCmv9OCknZF3Z/LeVTaVYCEgu8+s8zn8Vo3xtXP0HwpT2Hlyt3cZ+Zho2FLqOesS
         vKz9b0r/zGkKPVL5LkcA8+N3faWi6jjbRVksbf1FJcOizpY1jqJWskGuQX/j7/Bw8Pp8
         b6bw==
X-Gm-Message-State: AHQUAubn/D6S+ObvQ+MuyIRwqaCXdphh0YxoU7aYir+ZbQ7P0eK+47GB
        vPrOC8m5jS1OQVxUv6W7j9w=
X-Google-Smtp-Source: ALg8bN73fJOi2eofDlj80GGnYATJ5GUYo8XbxHNaQEAY6LjFGAzeEbqeFkzH7v5WAMWEM8u4A6DQpQ==
X-Received: by 2002:a2e:6a13:: with SMTP id f19-v6mr10174995ljc.41.1548662042946;
        Sun, 27 Jan 2019 23:54:02 -0800 (PST)
Received: from xi.terra (c-74bee655.07-184-6d6c6d4.bbcust.telenor.se. [85.230.190.116])
        by smtp.gmail.com with ESMTPSA id u11sm2801357lfb.85.2019.01.27.23.54.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 23:54:02 -0800 (PST)
Received: from johan by xi.terra with local (Exim 4.91)
        (envelope-from <johan@kernel.org>)
        id 1go1jw-0000PT-8i; Mon, 28 Jan 2019 08:53:56 +0100
Date:   Mon, 28 Jan 2019 08:53:56 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Andreas Kemnade <andreas@kemnade.info>
Cc:     bcousson@baylibre.com, tony@atomide.com, robh+dt@kernel.org,
        mark.rutland@arm.com, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        letux-kernel@openphoenux.org
Subject: Re: [PATCH] arm: dts: gta04: add gps support
Message-ID: <20190128075356.GJ3691@localhost>
References: <20190125194310.11170-1-andreas@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125194310.11170-1-andreas@kemnade.info>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 25, 2019 at 08:43:10PM +0100, Andreas Kemnade wrote:
> The GTA04 has a w2sg0004 or w2sg0084 gps chip. Not detectable
> which one is mounted so use the compatibility entry for w2sg0004
> for all which will work for both.
> 
> Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
> ---
> w2sg0004 bindings (together with the corresponding support is in
> https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss gnss-next)
>  arch/arm/boot/dts/omap3-gta04.dtsi | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/omap3-gta04.dtsi b/arch/arm/boot/dts/omap3-gta04.dtsi
> index e53d32691308..d58c117e429f 100644
> --- a/arch/arm/boot/dts/omap3-gta04.dtsi
> +++ b/arch/arm/boot/dts/omap3-gta04.dtsi
> @@ -312,6 +312,12 @@
>  		>;
>         };
>  
> +	gps_pins: pinmux_gps_pins {
> +		pinctrl-single,pins = <
> +			OMAP3_CORE1_IOPAD(0x2176, PIN_OUTPUT_PULLDOWN | MUX_MODE4) /* gpio145 */
> +		>;
> +	};
> +
>  	hdq_pins: hdq_pins {
>  		pinctrl-single,pins = <
>  			OMAP3_CORE1_IOPAD(0x21c6, PIN_INPUT_PULLUP | MUX_MODE0) /* i2c3_sda.hdq */
> @@ -644,6 +650,13 @@
>  &uart2 {
>  	pinctrl-names = "default";
>  	pinctrl-0 = <&uart2_pins>;
> +	gps: gps {

The node should be named "gnss" as per the binding.

> +		compatible = "wi2wi,w2sg0004";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&gps_pins>;
> +		sirf,onoff-gpios = <&gpio5 17 GPIO_ACTIVE_HIGH>;
> +		lna-supply = <&vsim>;

Also, the vcc-supply is a required property.

> +	};
>  };
>  
>  &uart3 {

Johan
