Return-Path: <SRS0=b4qJ=L5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69EBDECE562
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 09:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06DEA20881
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Sep 2018 09:04:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DEA20881
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mentor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbeIOOWr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Sep 2018 10:22:47 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:36382 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726432AbeIOOWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Sep 2018 10:22:47 -0400
Received: from nat-ies.mentorg.com ([192.94.31.2] helo=SVR-IES-MBX-04.mgc.mentorg.com)
        by relay1.mentorg.com with esmtps (TLSv1.2:ECDHE-RSA-AES256-SHA384:256)
        id 1g16Ut-00020L-Cr from Akash_Gajjar@mentor.com ; Sat, 15 Sep 2018 02:04:11 -0700
Received: from [172.30.152.247] (137.202.0.90) by
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4) with Microsoft SMTP Server
 (TLS) id 15.0.1320.4; Sat, 15 Sep 2018 10:04:00 +0100
Subject: Re: [PATCH] arm64: dts: rockchip: add initial dts support for
 Rockpro64 board
To:     Heiko Stuebner <heiko@sntech.de>
CC:     <deepak_das@mentor.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Levin Du <djw@t-chip.com.cn>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-rockchip@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <Akash_Gajjar@mentor.com>
 <1536926957-12432-1-git-send-email-Akash_Gajjar@mentor.com>
 <5171978.eGO5IDoIUo@phil>
From:   agajjar <Akash_Gajjar@mentor.com>
Message-ID: <bdb645c3-d9b7-03e8-7dcf-7d5bda91c4c8@mentor.com>
Date:   Sat, 15 Sep 2018 14:33:57 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <5171978.eGO5IDoIUo@phil>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-03.mgc.mentorg.com (139.181.222.3) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On 9/14/2018 11:23 PM, Heiko Stuebner wrote:
> Hi Akash,
>
> Am Freitag, 14. September 2018, 14:09:09 CEST schrieb Akash Gajjar:
>> Rockpro64 board is a rockchip RK3399 based board from pine64.org.
>> This commit adds initial device tree support for Rockpro64 board.
>>
>> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>
> generally the patch looks great already. Hopefully we will get an Ack
> from the dt-maintaintainers for the binding and I noticed two small
> issues I'll describe below.
>
>
>> ---
>>   Documentation/devicetree/bindings/arm/rockchip.txt |   4 +
>>   arch/arm64/boot/dts/rockchip/Makefile              |   1 +
>>   arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts  | 770 +++++++++++++++++++++
>>   3 files changed, 775 insertions(+)
>>   create mode 100644 arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>>
>> diff --git a/Documentation/devicetree/bindings/arm/rockchip.txt b/Documentation/devicetree/bindings/arm/rockchip.txt
>> index acfd3c7..ac95183 100644
>> --- a/Documentation/devicetree/bindings/arm/rockchip.txt
>> +++ b/Documentation/devicetree/bindings/arm/rockchip.txt
>> @@ -160,6 +160,10 @@ Rockchip platforms device tree bindings
>>       Required root node properties:
>>       - compatible = "pine64,rock64", "rockchip,rk3328";
>>   
>> +- Pine64 RockPro64 board:
>> +    Required root node properties:
>> +    - compatible = "pine64,rockpro64", "rockchip,rk3399";
>> +
>>   - Rockchip PX3 Evaluation board:
>>       Required root node properties:
>>         - compatible = "rockchip,px3-evb", "rockchip,px3", "rockchip,rk3188";
>> diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
>> index b0092d9..03d523a 100644
>> --- a/arch/arm64/boot/dts/rockchip/Makefile
>> +++ b/arch/arm64/boot/dts/rockchip/Makefile
>> @@ -14,5 +14,6 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-firefly.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-bob.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-gru-kevin.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou.dtb
>> +dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-rockpro64.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire.dtb
>>   dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-sapphire-excavator.dtb
>> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>> new file mode 100644
>> index 0000000..9e2d4d9
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/rockchip/rk3399-rockpro64.dts
>> @@ -0,0 +1,770 @@
>> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
>> +/*
>> + * Copyright (c) 2017 Fuzhou Rockchip Electronics Co., Ltd.
> Rockchip copyright from 2017? Where is the original
> dts coming from?

Rockpro64 board is similar to firefly rk-3399 board. DTS is taken from 
firefly board and it is booting fine with minimal changes.

Should I continue with the rockchip rights or update with the mine copy 
rights?

>> + */
>> +
>> +/dts-v1/;
>> +#include <dt-bindings/input/linux-event-codes.h>
>> +#include <dt-bindings/pwm/pwm.h>
>> +#include "rk3399.dtsi"
>> +#include "rk3399-opp.dtsi"
>> +
>> +/ {
>> +	model = "Pine64 RockPro64";
>> +	compatible = "pine64,rockpro64", "rockchip,rk3399";
>> +
>> +	chosen {
>> +		stdout-path = "serial2:1500000n8";
>> +	};
>> +
>> +	backlight: backlight {
>> +		compatible = "pwm-backlight";
>> +		enable-gpios = <&gpio1 RK_PB5 GPIO_ACTIVE_HIGH>;
>> +		pwms = <&pwm0 0 25000 0>;
>> +		brightness-levels = <
>> +			  0   1   2   3   4   5   6   7
>> +			  8   9  10  11  12  13  14  15
>> +			 16  17  18  19  20  21  22  23
>> +			 24  25  26  27  28  29  30  31
>> +			 32  33  34  35  36  37  38  39
>> +			 40  41  42  43  44  45  46  47
>> +			 48  49  50  51  52  53  54  55
>> +			 56  57  58  59  60  61  62  63
>> +			 64  65  66  67  68  69  70  71
>> +			 72  73  74  75  76  77  78  79
>> +			 80  81  82  83  84  85  86  87
>> +			 88  89  90  91  92  93  94  95
>> +			 96  97  98  99 100 101 102 103
>> +			104 105 106 107 108 109 110 111
>> +			112 113 114 115 116 117 118 119
>> +			120 121 122 123 124 125 126 127
>> +			128 129 130 131 132 133 134 135
>> +			136 137 138 139 140 141 142 143
>> +			144 145 146 147 148 149 150 151
>> +			152 153 154 155 156 157 158 159
>> +			160 161 162 163 164 165 166 167
>> +			168 169 170 171 172 173 174 175
>> +			176 177 178 179 180 181 182 183
>> +			184 185 186 187 188 189 190 191
>> +			192 193 194 195 196 197 198 199
>> +			200 201 202 203 204 205 206 207
>> +			208 209 210 211 212 213 214 215
>> +			216 217 218 219 220 221 222 223
>> +			224 225 226 227 228 229 230 231
>> +			232 233 234 235 236 237 238 239
>> +			240 241 242 243 244 245 246 247
>> +			248 249 250 251 252 253 254 255>;
>> +		default-brightness-level = <200>;
> with recent additions to the pwm-backlight we shouldn't need the
> long brightness-levels table and default-brightness-level anymore.
some device support is also needs to be added in this dts. In upcoming 
patch-sets I will update those changes.
>
>
> Heiko
>
warm Regards,

Akash Gajjar

