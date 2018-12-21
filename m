Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69268C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32537218FE
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 02:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NM1c+Qfg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390884AbeLUChT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 21:37:19 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33518 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388736AbeLUChT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 21:37:19 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so1790899pgu.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 18:37:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1FKU2VnaVUrF8mvg01F+2EVZF5Lm4oPl3ZBbFPmuK/8=;
        b=NM1c+Qfgs2DBiCnB+WYwV6wHbMgf1+IWcn+gFarudTc0Dj2xDoVCFI4lvmcuHadkD7
         OL7jv4Umes3O9GdjTv1d1mooZfPvUFBCaf+o5eNvkeMSRCZbElcYUfZ3bbuO4u3P/kte
         AKwtP6OXQA1LQYURTcEtxfG5NGtqkdwpBp374=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1FKU2VnaVUrF8mvg01F+2EVZF5Lm4oPl3ZBbFPmuK/8=;
        b=p3w3BgFN6zctWz6gI4ijpq/BBRdCVbROvZCdiBF4OqPSKwS8R6gR7BpWbqWgwVUwGD
         HHJ9MtanwZX3LSq9HCRa9eBu38OIyv0+0UBvqJEYixyrdbHEGfDp0WR9PodhMYhyvh+d
         4BH4xDoaE9vu8gN7Xq9VByspZ0BD5prQNFiOKw6Bm9g0yxipgccgPfalUmlZyBiy4/ii
         bQHW6E0A3EfsT5GB4Dz+g65YwoIyHqoRwdiLfH4InSReQMi0tg5nJizRO2eUx1b74ICi
         OVkbf9MNStrgm1iM3AgvCrj4HoQ87hfnPBH4h8fZZCldm4vMJvoDRAmwnSDKSr9Po4JJ
         4pig==
X-Gm-Message-State: AA+aEWbnrsV6fZSdCsBjV9I7D5kzf9HvwgdahQT0DchXIf4A4NbDcJ6w
        DZJxO7iKeDHhb7vrHGI6qJyf
X-Google-Smtp-Source: AFSGD/WlLo0zGagcnWNYzQMDNTBeirR3zEMHwrIqI6NLk7AccGxdgC2IBeSk5L4M3qWiuyLW8bQW1w==
X-Received: by 2002:a62:75d1:: with SMTP id q200mr678265pfc.254.1545359838693;
        Thu, 20 Dec 2018 18:37:18 -0800 (PST)
Received: from Mani-XPS-13-9360 ([2409:4072:810:d868:55e9:25e8:dbda:255b])
        by smtp.gmail.com with ESMTPSA id a195sm14667864pfa.7.2018.12.20.18.37.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Dec 2018 18:37:18 -0800 (PST)
Date:   Fri, 21 Dec 2018 08:07:08 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     michal.simek@xilinx.com
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-soc@vger.kernel.org, daniel.thompson@linaro.org,
        amit.kucheria@linaro.org, linus.walleij@linaro.org,
        koen.kooi@linaro.org, nicolas.dechesne@linaro.org
Subject: Re: [PATCH v3 6/7] arm64: dts: xilinx: ultra96: Standardize LED
 labels and triggers
Message-ID: <20181221023708.GC3233@Mani-XPS-13-9360>
References: <20181029094245.7886-1-manivannan.sadhasivam@linaro.org>
 <20181029094245.7886-7-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029094245.7886-7-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2018 at 03:12:44PM +0530, Manivannan Sadhasivam wrote:
> For all 96Boards, the following standard is used for onboard LEDs.
> 
> green:user1  default-trigger: heartbeat
> green:user2  default-trigger: mmc0/disk-activity(onboard-storage)
> green:user3  default-trigger: mmc1 (SD-card)
> green:user4  default-trigger: none, panic-indicator
> yellow:wlan  default-trigger: phy0tx
> blue:bt      default-trigger: hci0-power
> 
> So lets adopt the same for Ultra96, which is one of the 96Boards
> CE and AI platform. Since the WLAN and BT LEDs are hardwired onboard,
> consolidate only User LEDs.
> 

Hello,

Any update on this patch?

Regards,
Mani

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> index eb5e8bddb610..c08a8753215b 100644
> --- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> +++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu100-revC.dts
> @@ -57,29 +57,30 @@
>  	leds {
>  		compatible = "gpio-leds";
>  		ds2 {
> -			label = "ds2";
> +			label = "green:user1";
>  			gpios = <&gpio 20 GPIO_ACTIVE_HIGH>;
>  			linux,default-trigger = "heartbeat";
>  		};
>  
>  		ds3 {
> -			label = "ds3";
> +			label = "green:user2";
>  			gpios = <&gpio 19 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "phy0tx"; /* WLAN tx */
> +			linux,default-trigger = "mmc0";
>  			default-state = "off";
>  		};
>  
>  		ds4 {
> -			label = "ds4";
> +			label = "green:user3";
>  			gpios = <&gpio 18 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "phy0rx"; /* WLAN rx */
> +			linux,default-trigger = "mmc1";
>  			default-state = "off";
>  		};
>  
>  		ds5 {
> -			label = "ds5";
> +			label = "green:user4";
>  			gpios = <&gpio 17 GPIO_ACTIVE_HIGH>;
> -			linux,default-trigger = "bluetooth-power";
> +			linux,default-trigger = "none";
> +			panic-indicator;
>  		};
>  
>  		vbus_det { /* U5 USB5744 VBUS detection via MIO25 */
> -- 
> 2.17.1
> 
