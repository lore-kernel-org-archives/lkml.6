Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AD0DC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21CB42184A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 18:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aEdK3vzg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbfB0SEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 13:04:47 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44665 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbfB0SEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 13:04:47 -0500
Received: by mail-ed1-f65.google.com with SMTP id b20so14662472edw.11;
        Wed, 27 Feb 2019 10:04:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BdzkyGp5mYzWWO91OQstRt0k7blJSkNigDgCUBHpKIQ=;
        b=aEdK3vzgLEyVKm83by4D/w724GInWR5W7piF3kMuE6ridj17JZyvzCXif7740gBbd/
         u+R2pSW/YuS+xFZT/tGPayKCaD5rCfVZy0ED32V/IfmasESkhhlLorVAjNUGJM1TIZLJ
         fGnhgREmM5XLSY/1WHmQKQjBOssjyw3VE7mH4MCEfz9RTkZUHmyvzP4FCurcRa/edmDi
         wJR/uXj/XLEj60u3Z+vqqd1D9arScQGWiof1uZAbXXPp2qQUjFM8txFt9xR1uHBM+DU7
         7tYe72WViExlRLceey1ffRtM8pb7AUzBbM5CEbS3dBCrUb6aosKzUJ0o+PEO9wy3fIGA
         re6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BdzkyGp5mYzWWO91OQstRt0k7blJSkNigDgCUBHpKIQ=;
        b=qWsv78vMskoybX6EokNv1/po5JPsiNphm4vKDxtBGf1xvpLPkjir01Z2fGuhKgthap
         QCF8W6NOiOdgVRXiNrLxWkPUFJ49bszo/kv3bctlMM1g6OkWoFQDN8ZLFE+mpCa4ml85
         kIYo/oWQwTOypbS7uZam0GTTHlMNqXll918k5Zjmn9+Dda8VFyo/1N32+Pav5y6377y6
         meeqUvJWhvRxZeLgpAATI4vi3b2U9ia0hR8hawcNUwvH1qf10hkG+8KbyFoZZh+xJWRI
         lapL4i/R915sboNgXAOTdQtBU2nnNQyk6E6jKJnbCE/Rup1QaX96hedJL7pMpZIE9RHa
         Y3Iw==
X-Gm-Message-State: AHQUAubvJggARWtSu20DC2tkG9FWnU8/7vC9uDkSUyVQ+i/4y/7Npj2M
        /0DMlws/405Doi6Oh9tQoU1b7l6x
X-Google-Smtp-Source: AHgI3IZzoFafUmskIcPxA5LS7kB3ssJdLBRN4OIjLZarBmh8jTyiKx+cEgi+8+ZaN/cfgd5VlsPOOA==
X-Received: by 2002:a17:906:90c6:: with SMTP id v6mr2460294ejw.241.1551290684242;
        Wed, 27 Feb 2019 10:04:44 -0800 (PST)
Received: from [192.168.2.1] (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id z23sm4420102edz.50.2019.02.27.10.04.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 10:04:43 -0800 (PST)
Subject: Re: [PATCH] dt-bindings: display: rockchip: add document for rk3066
 hdmi
To:     Rob Herring <robh@kernel.org>
Cc:     heiko@sntech.de, hjc@rock-chips.com, airlied@linux.ie,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <20181229133318.18128-1-jbx6244@gmail.com>
 <20190201123235.1693-1-jbx6244@gmail.com> <20190225165923.GA2578@bogus>
From:   Johan Jonker <jbx6244@gmail.com>
Message-ID: <b183d099-dcb3-9c3f-7031-2bd54d7fe5bb@gmail.com>
Date:   Wed, 27 Feb 2019 19:04:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190225165923.GA2578@bogus>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your advice.

On 2/25/19 5:59 PM, Rob Herring wrote:> On Fri, Feb 01, 2019 at
01:32:35PM +0100, Johan Jonker wrote:
>> This patch adds a binding that describes the HDMI controller for
>> rk3066.
>
> This is not using the DW block like other Rockchip SoCs (IIRC)?

As outsider it's a little bit difficult to comment on that.
Maybe an insider can give a better answer.
The rk3066 is there early model.
Reusing blocks like in the later improved models wasn't in the fashion
yet I think.
Also comparing the rk3066-hdmi driver to the inno driver gives too many
differences in registers, sound support and irqs.
If it was similar they would have combined it in there own kernel.
Given the age there won't come any other support for it.
This is what we have...

>
>>
>> Signed-off-by: Johan Jonker <jbx6244@gmail.com>
>> ---
>>  .../display/rockchip/rk3066_hdmi-rockchip.txt      | 60
++++++++++++++++++++++
>
> Using the compatible string plus '.txt' is the preferred naming.

Will change that in V2.
rk3066-hdmi      -> rk3066-hdmi-rockchip.txt

How about the other documents?
rk3036-inno-hdmi -> inno_hdmi-rockchip.txt
rk3288-dw-hdmi   -> dw_hdmi-rockchip.txt
rk3288-dp        -> analogix_dp-rockchip.txt
etc.

>
>>  1 file changed, 60 insertions(+)
>>  create mode 100644
Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
>>
>> diff --git
a/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
>> new file mode 100644
>> index 000000000..6a8f3754f
>> --- /dev/null
>> +++
b/Documentation/devicetree/bindings/display/rockchip/rk3066_hdmi-rockchip.txt
>> @@ -0,0 +1,60 @@
>> +Rockchip specific extensions for rk3066 HDMI
>> +============================================
>> +
>> +Required properties:
>> +- compatible:
>> +	"rockchip,rk3066-hdmi";
>> +- reg:
>> +	Physical base address and length of the controller's registers.
>> +- clocks, clock-names:
>> +	Phandle to HDMI controller clock, name should be "hclk".
>> +- interrupts:
>> +	HDMI interrupt number.
>> +- power-domains:
>> +	Phandle to the RK3066_PD_VIO power domain.
>> +- rockchip,grf:
>> +	This soc uses GRF regs to switch the HDMI TX input between vop0 and
vop1.
>> +- ports:

Should "ports" be replaced by: "hdmi_in: port"?
What is preferred?

There are two different methods in use:
-1
		hdmi_in: port {

-2
		ports {
			hdmi_in: port {

>> +	Contains one port node with two endpoints, numbered 0 and 1,
>> +	connected respectively to vop0 and vop1.
>
> You should have an output port to an hdmi-connector node (or bridge) as
> well.

Which hdmi-connector node?
Could you explane with an example?
The Rockchip hdmi nodes I'm aware off only use the port nodes as a way
to switch the hdmi input between the vop's.
The vop nodes can have multiple outputs.

>
>> +- pinctrl-0, pinctrl-name:
>> +	Switch the iomux for the HPD/I2C pins to HDMI function.
>> +
>> +Example:
>> +	hdmi: hdmi@10116000 {
>> +		compatible = "rockchip,rk3066-hdmi";
>> +		reg = <0x10116000 0x2000>;
>> +		interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
>> +		clocks = <&cru HCLK_HDMI>;
>> +		clock-names = "hclk";
>> +		power-domains = <&power RK3066_PD_VIO>;
>> +		rockchip,grf = <&grf>;
>> +		pinctrl-names = "default";
>> +		pinctrl-0 = <&hdmii2c_xfer>, <&hdmi_hpd>;
>> +		status = "disabled";
>
> Don't show status in examples.

Will change that in V2.

>
>> +
>> +		hdmi_in: port {
>> +			#address-cells = <1>;
>> +			#size-cells = <0>;
>> +			hdmi_in_vop0: endpoint@0 {
>> +				reg = <0>;
>> +				remote-endpoint = <&vop0_out_hdmi>;
>> +			};
>> +			hdmi_in_vop1: endpoint@1 {
>> +				reg = <1>;
>> +				remote-endpoint = <&vop1_out_hdmi>;
>> +			};
>> +		};
>> +	};
>> +
>> +&pinctrl {
>> +		hdmi {
>> +			hdmi_hpd: hdmi-hpd {
>> +				rockchip,pins = <0 RK_PA0 1 &pcfg_pull_default>;
>> +			};
>> +			hdmii2c_xfer: hdmii2c-xfer {
>> +				rockchip,pins = <0 RK_PA1 1 &pcfg_pull_none>,
>> +						<0 RK_PA2 1 &pcfg_pull_none>;
>> +			};
>> +		};
>> +};
>> --
>> 2.11.0
>>

