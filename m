Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD474C28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A8FD2064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 08:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="oQHlyNvp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A8FD2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729099AbeGZJyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 05:54:09 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:54174 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727951AbeGZJyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 05:54:09 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 66B2E5C1E35;
        Thu, 26 Jul 2018 10:38:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1532594300;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H4QprCSPV0llWaAJhl+uoMJFvOsPnLVJLWEOi4CI/9A=;
        b=oQHlyNvpeviEfoZbC3qRde9D1FEPPTh03MGkD1VQOoB1yS+nPx6uW9dzFev483nzGHQRrZ
        Kff51sdQu9Ee6A4VQ8t7/2W3OQ9F4US1WbwDop1aaur6CrfZ5y6G067gPVRt4pyEB/fwHK
        +Tq9XCf61Wj1Gl0qebTFKB0wZnduCaw=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 26 Jul 2018 10:38:20 +0200
From:   Stefan Agner <stefan@agner.ch>
To:     Marcel Ziswiler <marcel@ziswiler.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-tegra-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] ARM: dts: tegra20: restore address order
In-Reply-To: <20180720163426.4410-1-marcel@ziswiler.com>
References: <20180720163426.4410-1-marcel@ziswiler.com>
Message-ID: <f62f73d659eecb8fe96983038e83621a@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
X-Spamd-Result: default: False [-1.60 / 15.00];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MID_RHS_MATCH_FROM(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[];
         TAGGED_RCPT(0.00)[dt];
         MIME_GOOD(-0.10)[text/plain];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_SEVEN(0.00)[10];
         FROM_EQ_ENVFROM(0.00)[];
         DKIM_SIGNED(0.00)[];
         TO_DN_SOME(0.00)[];
         RCVD_COUNT_ZERO(0.00)[0];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         ARC_NA(0.00)[]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.07.2018 18:34, Marcel Ziswiler wrote:
> From: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> 
> Commit 6c468f109884 ("ARM: dts: tegra: add Tegra20 NAND flash
> controller node") introduced the nand-controller node. However, it got
> added at the wrong spot not honoring the address order. Fix this.
> 
> Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Reviewed-by: Stefan Agner <stefan@agner.ch>

> 
> ---
> 
>  arch/arm/boot/dts/tegra20.dtsi | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 979f38293fe5..a22c6a8f8f83 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -419,19 +419,6 @@
>  		status = "disabled";
>  	};
>  
> -	gmi@70009000 {
> -		compatible = "nvidia,tegra20-gmi";
> -		reg = <0x70009000 0x1000>;
> -		#address-cells = <2>;
> -		#size-cells = <1>;
> -		ranges = <0 0 0xd0000000 0xfffffff>;
> -		clocks = <&tegra_car TEGRA20_CLK_NOR>;
> -		clock-names = "gmi";
> -		resets = <&tegra_car 42>;
> -		reset-names = "gmi";
> -		status = "disabled";
> -	};
> -
>  	nand-controller@70008000 {
>  		compatible = "nvidia,tegra20-nand";
>  		reg = <0x70008000 0x100>;
> @@ -447,6 +434,19 @@
>  		status = "disabled";
>  	};
>  
> +	gmi@70009000 {
> +		compatible = "nvidia,tegra20-gmi";
> +		reg = <0x70009000 0x1000>;
> +		#address-cells = <2>;
> +		#size-cells = <1>;
> +		ranges = <0 0 0xd0000000 0xfffffff>;
> +		clocks = <&tegra_car TEGRA20_CLK_NOR>;
> +		clock-names = "gmi";
> +		resets = <&tegra_car 42>;
> +		reset-names = "gmi";
> +		status = "disabled";
> +	};
> +
>  	pwm: pwm@7000a000 {
>  		compatible = "nvidia,tegra20-pwm";
>  		reg = <0x7000a000 0x100>;
