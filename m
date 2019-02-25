Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04AF3C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:59:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8D8F2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 16:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551113967;
	bh=4x2oT9qDAUb/eDcf3xRr5iE0uUwv7VHIchs2W+e/zyM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=rBfH3bTqxHZhhgQz+jo9P8NTak4uBNF1Z4YfUfogdaTwiKxaQ4B+83g3QQ3VA8m90
	 sRk58MMFY0/cIv2Q42FqDJfjQxuLEZoUhF/a7lUq6+6SYpptZBY9pQFezll9Cxid0y
	 o5gE9TxkgsyWEIKtIIkFdkOEBJnTkc//PSUrmY4E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfBYQ70 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 11:59:26 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:45268 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728028AbfBYQ7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 11:59:25 -0500
Received: by mail-ot1-f67.google.com with SMTP id 32so8404162ota.12;
        Mon, 25 Feb 2019 08:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2RBCMiEy+kJYk+2c0TTn1AShixVsUQnWkM1WqCdTG+E=;
        b=tQtoNgj/4sDtfCJvyEJcEvm/jtQjTao2LHpV93KWjn4Z+KXfFPVwlxhNW36JjgrQat
         2diHa8GOPtskIHYNkRpHMCws2oV6RcxAc4FnEM0ffi22YX6+S80KFrH9yXeXcthHXXM1
         TqgBojsp6BZpixPfXWofJdNmaPY2oydRThPBZ4vG1RYFUNfus38ps4r6Ge4hAN80sdCd
         Rfqjrf/NJ/UlzTVjIbH8Nt4rMvSJBgcllHRlmRu7NhPwqaXqReTAjAc6j2XPIqbBmRXz
         r1F+6Kk0s2Cs7WmHqciyDUl8Dfnz7Daq0VRwvW6ROagYUYYJuD1ZSbkDlYErAeHZVW1y
         wekg==
X-Gm-Message-State: AHQUAuaiCI1DNjNHgnWQXKT7qMxR54BO3kcYOgVHgPbQ0S7K5uo+/39U
        a3H0ImV+UVV8JFlILKselQ==
X-Google-Smtp-Source: AHgI3IYxqis4izTqFRp8MXg/EKZVHCVgPCo60N0iU4Kl09l65++2vqtQPzGbRfhOXqYak/Yks73WuQ==
X-Received: by 2002:a9d:6394:: with SMTP id w20mr12777649otk.72.1551113964654;
        Mon, 25 Feb 2019 08:59:24 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t2sm4796981otb.79.2019.02.25.08.59.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 25 Feb 2019 08:59:24 -0800 (PST)
Date:   Mon, 25 Feb 2019 10:59:23 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     heiko@sntech.de, hjc@rock-chips.com, airlied@linux.ie,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: rockchip: add document for rk3066
 hdmi
Message-ID: <20190225165923.GA2578@bogus>
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20190201123235.1693-1-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201123235.1693-1-jbx6244@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 01, 2019 at 01:32:35PM +0100, Johan Jonker wrote:
> This patch adds a binding that describes the HDMI controller for
> rk3066.

This is not using the DW block like other Rockchip SoCs (IIRC)? 

> 
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
> ---
>  .../display/rockchip/rk3066_hdmi-rockchip.txt      | 60 ++++++++++++++++++++++

Using the compatible string plus '.txt' is the preferred naming.

>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> new file mode 100644
> index 000000000..6a8f3754f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
> @@ -0,0 +1,60 @@
> +Rockchip specific extensions for rk3066 HDMI
> +============================================
> +
> +Required properties:
> +- compatible:
> +	"rockchip,rk3066-hdmi";
> +- reg:
> +	Physical base address and length of the controller's registers.
> +- clocks, clock-names:
> +	Phandle to HDMI controller clock, name should be "hclk".
> +- interrupts:
> +	HDMI interrupt number.
> +- power-domains:
> +	Phandle to the RK3066_PD_VIO power domain.
> +- rockchip,grf:
> +	This soc uses GRF regs to switch the HDMI TX input between vop0 and vop1.
> +- ports:
> +	Contains one port node with two endpoints, numbered 0 and 1,
> +	connected respectively to vop0 and vop1.

You should have an output port to an hdmi-connector node (or bridge) as 
well.

> +- pinctrl-0, pinctrl-name:
> +	Switch the iomux for the HPD/I2C pins to HDMI function.
> +
> +Example:
> +	hdmi: hdmi@10116000 {
> +		compatible = "rockchip,rk3066-hdmi";
> +		reg = <0x10116000 0x2000>;
> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru HCLK_HDMI>;
> +		clock-names = "hclk";
> +		power-domains = <&power RK3066_PD_VIO>;
> +		rockchip,grf = <&grf>;
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
> +		status = "disabled";

Don't show status in examples.

> +
> +		hdmi_in: port {
> +			#address-cells = <1>;
> +			#size-cells = <0>;
> +			hdmi_in_vop0: endpoint@0 {
> +				reg = <0>;
> +				remote-endpoint = <&vop0_out_hdmi>;
> +			};
> +			hdmi_in_vop1: endpoint@1 {
> +				reg = <1>;
> +				remote-endpoint = <&vop1_out_hdmi>;
> +			};
> +		};
> +	};
> +
> +&pinctrl {
> +		hdmi {
> +			hdmi_hpd: hdmi-hpd {
> +				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
> +			};
> +			hdmii2c_xfer: hdmii2c-xfer {
> +				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
> +						<0 RK_PA2 1 &pcfg_pull_none>;
> +			};
> +		};
> +};
> -- 
> 2.11.0
> 
