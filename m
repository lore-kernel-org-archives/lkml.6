Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A906C6778A
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB33F2576C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 17:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j/d7Rw10"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB33F2576C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753828AbeGARuX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 13:50:23 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:44295 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934173AbeGARuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 13:50:15 -0400
Received: by mail-wr0-f194.google.com with SMTP id p12-v6so13279673wrn.11;
        Sun, 01 Jul 2018 10:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=1p5StSfPrw0FZpCTZDaK8igFkL5mWzjUxuAqhhaBv2E=;
        b=j/d7Rw10PO17/yfWW+K7Ih46x+2VMrb9OfwV84N96H8TPtYKAeT5lQlsAjMo2+DKRi
         ii5wHyDidbwyKLAvwpzR/B7HPWDcvOMIN7YWsI5xH5qBaCsZhGq5CbwX0UrnIiyVPiJv
         949llfliwX0/4NhacEfZF8Q22I9h03R9moQe+9lnUF8wH6hnansX/5jqHB2fTUin5KsG
         DgXZoV8XlxxZio+nG0iTtzqsic3Kp/ZToM7nDPfo3AHbc3tVDAe75KQmk3UeAakRjATb
         2xTNWcdZPVv+K/EF3AUcyRBknBBbkbcx0wbdOSfojmy0zIi016jXCXBQUDMWtiL/42m2
         Ga9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1p5StSfPrw0FZpCTZDaK8igFkL5mWzjUxuAqhhaBv2E=;
        b=gVG+DS5biQu7snDKIkJrQBYngbVwUj2oHcgEUXxRu0RNYQ6VYzPfaq1BxSxqESeA/q
         AyruVR+INQZTLHizbl8USP6bBka7/oq2SIMgffaeaeYsE8+j2vYSZg0TBYOQK9qLE5Ma
         n1i/eM+IT0xrldlNjcZjEm796ocoie+AU9o1mS3g9xZYFX7UeW+5zClIu7BIT0QSf+NR
         C3AOtcySe9u51VWJkpLIPfmdeuBMDOUYF4VOr/0jNBMvCh3J8GxfdzZX8WWpK+V8Obn+
         XCfqIKN3J74pdAWxWlfoC0dQELHk0ae5BLHrkb4pGbQGmK0XDcphKjXUnRQfjfkWOTXW
         JcsQ==
X-Gm-Message-State: APt69E3na2D7miiRuO6+iqI+67ahyaiLPOP3n/rSWBcFq77bar4iWM97
        VkkasdFMA2GcO29WS6IboAGU0EIIywc=
X-Google-Smtp-Source: AAOMgpfifqVBfvv5LtF5Gr3DRV3KWdKtUvVJz32plT9E919KavcmbLNkNfXAPPcVUuuAE6GAe5caAw==
X-Received: by 2002:adf:a45d:: with SMTP id e29-v6mr17229320wra.121.1530467412892;
        Sun, 01 Jul 2018 10:50:12 -0700 (PDT)
Received: from [192.168.0.103] (p5B3F6705.dip0.t-ipconnect.de. [91.63.103.5])
        by smtp.gmail.com with ESMTPSA id q14-v6sm11395635wmd.20.2018.07.01.10.50.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 01 Jul 2018 10:50:11 -0700 (PDT)
Subject: Re: [PATCH v2 1/3] arm64: dts: actions: Enable clock controller for
 S700
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     afaerber@suse.de, sboyd@kernel.org, pn@denx.de,
        linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, devicetree@vger.kernel.org
References: <20180626192820.28237-3-sravanhome@gmail.com>
 <20180628191805.3722-1-sravanhome@gmail.com>
 <20180628191805.3722-2-sravanhome@gmail.com>
 <20180630094259.GC7320@Mani-XPS-13-9360>
From:   Saravanan Sekar <sravanhome@gmail.com>
Message-ID: <279840d3-a254-394d-7782-b3f837c59e57@gmail.com>
Date:   Sun, 1 Jul 2018 19:50:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180630094259.GC7320@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mani,


On 06/30/18 11:42, Manivannan Sadhasivam wrote:
> On Thu, Jun 28, 2018 at 09:18:03PM +0200, Saravanan Sekar wrote:
>> Added clock management controller for S700
>>
>> Signed-off-by: Parthiban Nallathambi <pn@denx.de>
>> Signed-off-by: Saravanan Sekar <sravanhome@gmail.com>
>> ---
>>   .../boot/dts/actions/s700-cubieboard7.dts     |   7 -
>>   arch/arm64/boot/dts/actions/s700.dtsi         |   8 ++
>>   include/dt-bindings/clock/actions,s700-cmu.h  | 128 ++++++++++++++++++
>>   3 files changed, 136 insertions(+), 7 deletions(-)
>>   create mode 100644 include/dt-bindings/clock/actions,s700-cmu.h
>>
>> diff --git a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>> index ef79d7905f44..28f3f4a0f7f0 100644
>> --- a/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>> +++ b/arch/arm64/boot/dts/actions/s700-cubieboard7.dts
>> @@ -28,12 +28,6 @@
>>   		device_type = "memory";
>>   		reg = <0x1 0xe0000000 0x0 0x0>;
>>   	};
>> -
>> -	uart3_clk: uart3-clk {
>> -		compatible = "fixed-clock";
>> -		clock-frequency = <921600>;
>> -		#clock-cells = <0>;
>> -	};
> Sourcing CMU clock for UART should be in a separate patch.

sure

>>   };
>>   
>>   &timer {
>> @@ -42,5 +36,4 @@
>>   
>>   &uart3 {
>>   	status = "okay";
>> -	clocks = <&uart3_clk>;
>>   };
>> diff --git a/arch/arm64/boot/dts/actions/s700.dtsi b/arch/arm64/boot/dts/actions/s700.dtsi
>> index 66dd5309f0a2..3530b705df90 100644
>> --- a/arch/arm64/boot/dts/actions/s700.dtsi
>> +++ b/arch/arm64/boot/dts/actions/s700.dtsi
>> @@ -4,6 +4,7 @@
>>    */
>>   
>>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>> +#include <dt-bindings/clock/actions,s700-cmu.h>
>>   
>>   / {
>>   	compatible = "actions,s700";
>> @@ -44,6 +45,12 @@
>>   		};
>>   	};
>>   
>> +	clock: clock-controller@e0168000 {
>> +		compatible = "actions,s700-cmu";
>> +		reg = <0 0xe0168000 0 0x1000>;
>> +		#clock-cells = <1>;
>> +	};
>> +
> There is no fixed rate clock like losc?

losc is 32k, I will add it

>>   	reserved-memory {
>>   		#address-cells = <2>;
>>   		#size-cells = <2>;
>> @@ -129,6 +136,7 @@
>>   			compatible = "actions,s900-uart", "actions,owl-uart";
>>   			reg = <0x0 0xe0126000 0x0 0x2000>;
>>   			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&clock CLK_UART3>;
>>   			status = "disabled";
>>   		};
>>   
>> diff --git a/include/dt-bindings/clock/actions,s700-cmu.h b/include/dt-bindings/clock/actions,s700-cmu.h
>> new file mode 100644
>> index 000000000000..e5b4ea130953
>> --- /dev/null
>> +++ b/include/dt-bindings/clock/actions,s700-cmu.h
>> @@ -0,0 +1,128 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>> +/*
>> + * Actions S700 clock driver
>> + *
>> + * Copyright (c) 2014 Actions Semi Inc.
>> + * Author: David Liu <liuwei@actions-semi.com>
>> + *
>> + * Author: Pathiban Nallathambi <pn@denx.de>
>> + * Author: Saravanan Sekar <sravanhome@gmail.com>
>> + */
>> +
>> +#ifndef __DT_BINDINGS_CLOCK_S700_H
>> +#define __DT_BINDINGS_CLOCK_S700_H
>> +
>> +#define CLK_NONE			0
>> +
>> +/* fixed rate clocks */
>> +#define CLK_LOSC			1
>> +#define CLK_HOSC			2
>> +
>> +/* pll clocks */
>> +#define CLK_CORE_PLL			3
>> +#define CLK_DEV_PLL			4
>> +#define CLK_DDR_PLL			5
>> +#define CLK_NAND_PLL			6
>> +#define CLK_DISPLAY_PLL			7
>> +#define CLK_TVOUT_PLL			8
>> +#define CLK_CVBS_PLL			9
>> +#define CLK_AUDIO_PLL			10
>> +#define CLK_ETHERNET_PLL		11
>> +
> Remove extra new line please.
>
>> +
>> +/* system clock */
>> +#define CLK_SYS_BASE			12
>> +#define CLK_CPU				CLK_SYS_BASE
>> +#define CLK_DEV				(CLK_SYS_BASE+1)
>> +#define CLK_AHB				(CLK_SYS_BASE+2)
>> +#define CLK_APB				(CLK_SYS_BASE+3)
>> +#define CLK_DMAC			(CLK_SYS_BASE+4)
>> +#define CLK_NOC0_CLK_MUX		(CLK_SYS_BASE+5)
>> +#define CLK_NOC1_CLK_MUX		(CLK_SYS_BASE+6)
>> +#define CLK_HP_CLK_MUX			(CLK_SYS_BASE+7)
>> +#define CLK_HP_CLK_DIV			(CLK_SYS_BASE+8)
>> +#define CLK_NOC1_CLK_DIV		(CLK_SYS_BASE+9)
>> +#define CLK_NOC0			(CLK_SYS_BASE+10)
>> +#define CLK_NOC1			(CLK_SYS_BASE+11)
>> +#define CLK_SENOR_SRC			(CLK_SYS_BASE+12)
>> +
>> +/* peripheral device clock */
>> +#define CLK_PERIP_BASE			25
>> +#define CLK_GPIO			(CLK_PERIP_BASE)
>> +#define CLK_TIMER			(CLK_PERIP_BASE+1)
>> +#define CLK_DSI				(CLK_PERIP_BASE+2)
>> +#define CLK_CSI				(CLK_PERIP_BASE+3)
>> +#define CLK_SI				(CLK_PERIP_BASE+4)
>> +#define CLK_DE				(CLK_PERIP_BASE+5)
>> +#define CLK_HDE				(CLK_PERIP_BASE+6)
>> +#define CLK_VDE				(CLK_PERIP_BASE+7)
>> +#define CLK_VCE				(CLK_PERIP_BASE+8)
>> +#define CLK_NAND			(CLK_PERIP_BASE+9)
>> +#define CLK_SD0				(CLK_PERIP_BASE+10)
>> +#define CLK_SD1				(CLK_PERIP_BASE+11)
>> +#define CLK_SD2				(CLK_PERIP_BASE+12)
>> +
>> +#define CLK_UART0			(CLK_PERIP_BASE+13)
>> +#define CLK_UART1			(CLK_PERIP_BASE+14)
>> +#define CLK_UART2			(CLK_PERIP_BASE+15)
>> +#define CLK_UART3			(CLK_PERIP_BASE+16)
>> +#define CLK_UART4			(CLK_PERIP_BASE+17)
>> +#define CLK_UART5			(CLK_PERIP_BASE+18)
>> +#define CLK_UART6			(CLK_PERIP_BASE+19)
>> +
>> +#define CLK_PWM0			(CLK_PERIP_BASE+20)
>> +#define CLK_PWM1			(CLK_PERIP_BASE+21)
>> +#define CLK_PWM2			(CLK_PERIP_BASE+22)
>> +#define CLK_PWM3			(CLK_PERIP_BASE+23)
>> +#define CLK_PWM4			(CLK_PERIP_BASE+24)
>> +#define CLK_PWM5			(CLK_PERIP_BASE+25)
>> +#define CLK_GPU3D			(CLK_PERIP_BASE+26)
>> +
>> +#define CLK_I2C0			(CLK_PERIP_BASE+27)
>> +#define CLK_I2C1			(CLK_PERIP_BASE+28)
>> +#define CLK_I2C2			(CLK_PERIP_BASE+29)
>> +#define CLK_I2C3			(CLK_PERIP_BASE+30)
>> +
>> +
>> +#define CLK_SPI0			(CLK_PERIP_BASE+31)
>> +#define CLK_SPI1			(CLK_PERIP_BASE+32)
>> +#define CLK_SPI2			(CLK_PERIP_BASE+33)
>> +#define CLK_SPI3			(CLK_PERIP_BASE+34)
>> +
>> +#define CLK_USB3_480MPLL0		(CLK_PERIP_BASE+35)
>> +#define CLK_USB3_480MPHY0		(CLK_PERIP_BASE+36)
>> +#define CLK_USB3_5GPHY			(CLK_PERIP_BASE+37)
>> +#define CLK_USB3_CCE			(CLK_PERIP_BASE+48)
>> +#define CLK_USB3_MAC			(CLK_PERIP_BASE+49)
>> +
>> +
>> +#define CLK_LCD				(CLK_PERIP_BASE+50)
>> +#define CLK_HDMI_AUDIO			(CLK_PERIP_BASE+51)
>> +#define CLK_I2SRX			(CLK_PERIP_BASE+52)
>> +#define CLK_I2STX			(CLK_PERIP_BASE+53)
>> +
>> +#define CLK_SENSOR0			(CLK_PERIP_BASE+54)
>> +#define CLK_SENSOR1			(CLK_PERIP_BASE+55)
>> +
>> +#define CLK_HDMI_DEV			(CLK_PERIP_BASE+56)
>> +
>> +#define CLK_ETHERNET			(CLK_PERIP_BASE+59)
>> +#define CLK_RMII_REF			(CLK_PERIP_BASE+60)
>> +
>> +#define CLK_USB2H0_PLLEN		(CLK_PERIP_BASE+61)
>> +#define CLK_USB2H0_PHY			(CLK_PERIP_BASE+62)
>> +#define CLK_USB2H0_CCE			(CLK_PERIP_BASE+63)
>> +#define CLK_USB2H1_PLLEN		(CLK_PERIP_BASE+64)
>> +#define CLK_USB2H1_PHY			(CLK_PERIP_BASE+65)
>> +#define CLK_USB2H1_CCE			(CLK_PERIP_BASE+66)
>> +
>> +
>> +#define CLK_TVOUT			(CLK_PERIP_BASE+67)
>> +
>> +#define CLK_THERMAL_SENSOR		(CLK_PERIP_BASE+68)
>> +
>> +#define CLK_IRC_SWITCH			(CLK_PERIP_BASE+69)
>> +#define CLK_PCM1			(CLK_PERIP_BASE+70)
>> +#define CLK_NR_CLKS			(CLK_PCM1) /* update on adding new clk */
>> +
> Since the index starts from 0, CLK_NR_CLKS should be CLK_PCM1 + 1

0 is for CLK_NONE, so actual clock starts from 1

> Thanks,
> Mani
>
>> +#endif /* __DT_BINDINGS_CLOCK_S700_H */
>> -- 
>> 2.18.0
>>

