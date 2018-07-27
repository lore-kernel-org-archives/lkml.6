Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC02AC6778F
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9324F208B1
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 13:26:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9324F208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=aosc.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731020AbeG0Osf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 10:48:35 -0400
Received: from hermes.aosc.io ([199.195.250.187]:34896 "EHLO hermes.aosc.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730354AbeG0Osf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 10:48:35 -0400
Received: from localhost (localhost [127.0.0.1]) (Authenticated sender: icenowy@aosc.io)
        by hermes.aosc.io (Postfix) with ESMTPSA id EDA599FBE6;
        Fri, 27 Jul 2018 13:26:26 +0000 (UTC)
Date:   Fri, 27 Jul 2018 21:26:11 +0800
In-Reply-To: <20180727125615.ju23ecgm6y4rz7p5@flea>
References: <20180726171257.6688-1-icenowy@aosc.io> <20180726171257.6688-11-icenowy@aosc.io> <20180727125615.ju23ecgm6y4rz7p5@flea>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH v3.1 10/10] arm64: dts: allwinner: a64: Enable HDMI output on A64 boards w/ HDMI
To:     linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@bootlin.com>
CC:     devicetree@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-sunxi@googlegroups.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        linux-clk@vger.kernel.org
From:   Icenowy Zheng <icenowy@aosc.io>
Message-ID: <8DF4600E-DFE4-47CD-B541-FFDD903A65FB@aosc.io>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



于 2018年7月27日 GMT+08:00 下午8:56:15, Maxime Ripard <maxime.ripard@bootlin.com> 写到:
>On Fri, Jul 27, 2018 at 01:12:57AM +0800, Icenowy Zheng wrote:
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> index 1b9b92e541d2..1b972bade9f6 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
>> @@ -62,6 +62,21 @@
>>  	chosen {
>>  		stdout-path = "serial0:115200n8";
>>  	};
>> +
>> +	connector {
>> +		compatible = "hdmi-connector";
>> +		type = "a";
>> +
>> +		port {
>> +			hdmi_con_in: endpoint {
>> +				remote-endpoint = <&hdmi_out_con>;
>> +			};
>> +		};
>> +	};
>> +};
>> +
>> +&de {
>> +	status = "okay";
>>  };
>>  
>>  &ehci0 {
>> @@ -82,6 +97,17 @@
>>  
>>  };
>>  
>> +&hdmi {
>> +	hdmi-supply = <&reg_dldo1>;
>> +	status = "okay";
>> +};
>> +
>> +&hdmi_out {
>> +	hdmi_out_con: endpoint {
>> +		remote-endpoint = <&hdmi_con_in>;
>> +	};
>> +};
>> +
>>  &i2c1 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&i2c1_pins>;
>> @@ -99,6 +125,10 @@
>>  	};
>>  };
>>  
>> +&mixer1 {
>> +	status = "okay";
>> +};
>> +
>>  &mmc0 {
>>  	pinctrl-names = "default";
>>  	pinctrl-0 = <&mmc0_pins>;
>> @@ -238,6 +268,10 @@
>>  	status = "disabled";
>>  };
>>  
>> +&tcon1 {
>> +	status = "okay";
>> +};
>
>Is it working or not on the pine64?

Not tested yet, as my main A64 device is Pine A64-LTS now.

>
>Maxime
