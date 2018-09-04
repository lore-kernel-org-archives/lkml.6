Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4119EC433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:27:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C71206BA
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=openedev.com header.i=@openedev.com header.b="I5eDeWcV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9C71206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=openedev.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727751AbeIDTwj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:52:39 -0400
Received: from se14t.web-hosting.com ([162.255.118.155]:36282 "EHLO
        se14t.web-hosting.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbeIDTwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:52:39 -0400
X-Greylist: delayed 3365 seconds by postgrey-1.27 at vger.kernel.org; Tue, 04 Sep 2018 15:52:38 EDT
Received: from [68.65.123.203] (helo=server153.web-hosting.com)
        by se14.registrar-servers.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <jagan@openedev.com>)
        id 1fxCM2-000CMI-Um; Tue, 04 Sep 2018 07:31:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=openedev.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q2rJaMISrQdqZdU1O44kefHOeQah8WUTywkLWafh9mM=; b=I5eDeWcVAiwxbTlm6HcmQfDnxJ
        JJZDGjicaG7klRti9Am5nHj7ZHPFeMN+kHefaVcGx8Wx8MyFzz8skwR8cYCP+sibgANrJpk6kE1h2
        S/LfiGbWX/IpJI5PuFQXAhJ/wNbBs8/uiqxtS/z/0Dq6lrHbSWTvjuEGeHsebqmaaMnlaKWn3MNYy
        sWn8DIewE/W6gosNgzQt5YJ2tfckZOjNBlD+38YhCmuBNuYoEQILRNsvvrlmgmVnVLKSu+0OnNOOG
        QT3GD8F7OHKWbegeSMyb930DjdRNf1k/FCia2zJsYaPIr58wZKxLztQt1ZvmZ4MpkWnFeH/osbxvE
        7pDItyjg==;
Received: from [27.7.51.1] (port=55414 helo=[192.168.0.10])
        by server153.web-hosting.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.91)
        (envelope-from <jagan@openedev.com>)
        id 1fxCLs-001gXu-A0; Tue, 04 Sep 2018 10:30:49 -0400
Subject: Re: [linux-sunxi] Re: [PATCH] arm64: allwinner: h6: Add OrangePi One
 Plus initial support
To:     wens@csie.org, Jagan Teki <jagan@amarulasolutions.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        devicetree <devicetree@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
References: <20180728182615.20845-1-jagan@amarulasolutions.com>
 <20180730090048.gl7fkduztjkxacqq@flea>
 <CAGb2v67wKFp2Fntm2O0xGXZjbyTZ_3YjRrD6b612jer1DDXxZw@mail.gmail.com>
 <CAMty3ZBNM7mdtkBSq5BGuGoa5jKdSuuSVxkOoqPhDJZ-NM2THQ@mail.gmail.com>
 <CAGb2v66Br9-KB-AD+N9mqRQ7rhrzYqUAQDkiepf2+3=FOgWKLg@mail.gmail.com>
 <CAGb2v670WNu8tz+e0DqO5eiSvi8EEfhCrz3ksaAzvyxQvCGkgQ@mail.gmail.com>
From:   Jagan Teki <jagan@openedev.com>
Message-ID: <3f31bff7-689a-3cf6-8e55-cfd98a19ad50@openedev.com>
Date:   Tue, 4 Sep 2018 20:00:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAGb2v670WNu8tz+e0DqO5eiSvi8EEfhCrz3ksaAzvyxQvCGkgQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-OutGoing-Spam-Status: No, score=-1.0
X-Originating-IP: 68.65.123.203
X-SpamExperts-Domain: nctest.net
X-SpamExperts-Username: whmcalls3
Authentication-Results: registrar-servers.com; auth=pass (login) smtp.auth=whmcalls3@nctest.net
X-SpamExperts-Outgoing-Class: ham
X-SpamExperts-Outgoing-Evidence: Combined (0.02)
X-Recommended-Action: accept
X-Filter-ID: EX5BVjFpneJeBchSMxfU5t1zCI3qHc5wmEx8wuDVHIl602E9L7XzfQH6nu9C/Fh9KJzpNe6xgvOx
 q3u0UDjvO0Ma0zdKrj2HeYAO9pcN4rBgaa/6KAnDjbDW9Kfk8S67rc0diZKnmpMa4igsMUptb3ws
 3TRjaC42FtNJuTWwh7xKmH2sfIL+Gt5oALTv4iTezNuDg9qhrek1VDTOXu3/5SyoOv4ayNch+d6T
 bjnEf/UPlmMF2uxnBmv8AP3A5TPjDxtyIoJXB7URNiYZ50vCiWixanZQ2i7ieK1YvvsTHZEdZUKO
 4wuyRglFB/BD6nArChUMJTt5/zUwKtKCX31rG8u/Nx/xqwEVeKEfKL+gGcOZ0jFNVNFK53TFH2ZT
 TSrEBe1bCawrm8TiglMK9DrLfVMoaMSbUPqhAbNjiOo4N6MEybI1sOftHmSKUCHCvcq0f/1bxtoy
 dmMxRWzqqOmAYpLOJnypRc2Q/WMdHuO5mB12XN6qAseowdwxD2E3+DaJLnQKyOOdNV2reR3vzxDX
 NzDt3skp6X1z4vnXAvsYlMbwgn3cxqjQiWJvLJ1LCTkYmgjCa8Q0z411CtB1U74Ub4SbE1l0jCSq
 wqiEbnL4lT4je/y9FB9UVdGVpQvLSXLC7O13bK8F3Ub7/sMm0uANcEVrS0dDJ9gEsqV0wk3wKYrF
 WT1ROcYC8FxG576lHCGHG2FxlqBH2d0BjlkdA+pIpmsLhBxQoa5Nf/bcTwDKoqpd+iq1dwuU+8AD
 kf7k11D33EIdqFl+yO+gMp2pBF4TuimiXv/PFsPAUhXN4WClZ0FzHDeqqFz43py4SDhdaHkWEiOc
 vT7EI/KlcDFF8GvXQ+uq/i5zcDeTgLCMsytQyvCmpPZh58dtBrikBrVm+7Ub2bRkWbJQMsEazexA
 znFikT3TcyJU1n9vZrGfKkCHXILSLgsRnqDMxKK4aJOe0I9J6DkTJvbm12Or17A57hFR5tM+m4Wp
 RRDP6YzwkAPgQJZFTPvCKbcDstvOdJ3nRQv7GfBpLYH9ajYhIn0oWP+NbVMU1O3Z5aBphxOpH0xf
 AKplpW+KcRDUgx3g3gYkBmOIT6AGhOVtFcFT5KasV9k7aX6m+UeFXprlCOm3BAEbJtDXasD+1yJI
 1QyowJGGU9JFhKo8HnFOLjItMeOuxETzQmCI6y95aUyb0ByL/85xvAx7MhTMkYm4d+X1Bs/QNMEN
 +011qJUxNTwVgnYLaY5oDIFYXeHojjUb1j2h0kB4HvD6IOTrszIaO4dNr4KSu1lT
X-Report-Abuse-To: spam@se16.registrar-servers.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 03 September 2018 11:05 AM, Chen-Yu Tsai wrote:
> On Tue, Jul 31, 2018 at 9:42 PM Chen-Yu Tsai <wens@csie.org> wrote:
>>
>> On Tue, Jul 31, 2018 at 9:41 PM, Jagan Teki <jagan@amarulasolutions.com> wrote:
>>> On Mon, Jul 30, 2018 at 2:47 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>>>> On Mon, Jul 30, 2018 at 5:00 PM, Maxime Ripard
>>>> <maxime.ripard@bootlin.com> wrote:
>>>>> Hi,
>>>>>
>>>>> On Sat, Jul 28, 2018 at 11:56:15PM +0530, Jagan Teki wrote:
>>>>>> OrangePi One Plus is Allwinner H6 based open-source SBC,
>>>>>> which support:
>>>>>> - Allwinner H6 Quad-core 64-bit ARM Cortex-A53
>>>>>> - GPU Mali-T720
>>>>>> - 1GB LPDDR3 RAM
>>>>>> - AXP805 PMIC
>>>>>> - 1Gbps GMAC via RTL8211
>>>>>> - USB 2.0 Host, OTG
>>>>>> - HDMI port
>>>>>> - 5V/2A DC power supply
>>>>>>
>>>>>> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
>>>>>> ---
>>>>>>   arch/arm64/boot/dts/allwinner/Makefile        |   1 +
>>>>>>   .../allwinner/sun50i-h6-orangepi-one-plus.dts | 150 ++++++++++++++++++
>>>>>>   2 files changed, 151 insertions(+)
>>>>>>   create mode 100644 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>>>>>
>>>>>> diff --git a/arch/arm64/boot/dts/allwinner/Makefile b/arch/arm64/boot/dts/allwinner/Makefile
>>>>>> index 9ffa7a038791..c38f326e7fec 100644
>>>>>> --- a/arch/arm64/boot/dts/allwinner/Makefile
>>>>>> +++ b/arch/arm64/boot/dts/allwinner/Makefile
>>>>>> @@ -15,4 +15,5 @@ dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-pc2.dtb
>>>>>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-prime.dtb
>>>>>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus.dtb
>>>>>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h5-orangepi-zero-plus2.dtb
>>>>>> +dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-orangepi-one-plus.dtb
>>>>>>   dtb-$(CONFIG_ARCH_SUNXI) += sun50i-h6-pine-h64.dtb
>>>>>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>>>>> new file mode 100644
>>>>>> index 000000000000..0612c19cd994
>>>>>> --- /dev/null
>>>>>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-one-plus.dts
>>>>>> @@ -0,0 +1,150 @@
>>>>>> +// SPDX-License-Identifier: (GPL-2.0+ or MIT)
>>>>>> +/*
>>>>>> + * Copyright (C) 2018 Amarula Solutions
>>>>>> + * Author: Jagan Teki <jagan@amarulasolutions.com>
>>>>>> + */
>>>>>> +
>>>>>> +/dts-v1/;
>>>>>> +
>>>>>> +#include "sun50i-h6.dtsi"
>>>>>> +
>>>>>> +#include <dt-bindings/gpio/gpio.h>
>>>>>> +
>>>>>> +/ {
>>>>>> +     model = "OrangePi One Plus";
>>>>>> +     compatible = "xunlong,orangepi-one-plus", "allwinner,sun50i-h6";
>>>>>> +
>>>>>> +     aliases {
>>>>>> +             serial0 = &uart0;
>>>>>> +     };
>>>>>> +
>>>>>> +     chosen {
>>>>>> +             stdout-path = "serial0:115200n8";
>>>>>> +     };
>>>>>> +};
>>>>>> +
>>>>>> +&mmc0 {
>>>>>> +     pinctrl-names = "default";
>>>>>> +     pinctrl-0 = <&mmc0_pins>;
>>>>>> +     vmmc-supply = <&reg_cldo1>;
>>>>>> +     cd-gpios = <&pio 5 6 GPIO_ACTIVE_LOW>;
>>>>>> +     bus-width = <4>;
>>>>>> +     status = "okay";
>>>>>> +};
>>>>>> +
>>>>>> +&r_i2c {
>>>>>> +     status = "okay";
>>>>>> +
>>>>>> +     axp805: pmic@36 {
>>>>>> +             compatible = "x-powers,axp805", "x-powers,axp806";
>>>>>> +             reg = <0x36>;
>>>>>> +             interrupt-parent = <&r_intc>;
>>>>>> +             interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
>>>>>> +             interrupt-controller;
>>>>>> +             #interrupt-cells = <1>;
>>>>>> +             x-powers,self-working-mode;
>>>>>> +
>>>>>> +             regulators {
>>>>>> +                     reg_aldo1: aldo1 {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <3300000>;
>>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>>> +                             regulator-name = "vcc-pl";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_aldo2: aldo2 {
>>>>>> +                             regulator-min-microvolt = <3300000>;
>>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>>> +                             regulator-name = "vcc-ac200";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_aldo3: aldo3 {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <3300000>;
>>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>>> +                             regulator-name = "vcc25-dram";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_bldo1: bldo1 {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <1800000>;
>>>>>> +                             regulator-max-microvolt = <1800000>;
>>>>>> +                             regulator-name = "vcc-bias-pll";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_bldo2: bldo2 {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <1800000>;
>>>>>> +                             regulator-max-microvolt = <1800000>;
>>>>>> +                             regulator-name = "vcc-efuse-pcie-hdmi-io";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_bldo3: bldo3 {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <1800000>;
>>>>>> +                             regulator-max-microvolt = <1800000>;
>>>>>> +                             regulator-name = "vcc-dcxoio";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     bldo4 {
>>>>>> +                             /* unused */
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_cldo1: cldo1 {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <3300000>;
>>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>>> +                             regulator-name = "vcc-3v3";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_cldo2: cldo2 {
>>>>>> +                             regulator-min-microvolt = <3300000>;
>>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>>> +                             regulator-name = "vcc-wifi-1";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_cldo3: cldo3 {
>>>>>> +                             regulator-min-microvolt = <3300000>;
>>>>>> +                             regulator-max-microvolt = <3300000>;
>>>>>> +                             regulator-name = "vcc-wifi-2";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_dcdca: dcdca {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <810000>;
>>>>>> +                             regulator-max-microvolt = <1080000>;
>>>>>> +                             regulator-name = "vdd-cpu";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_dcdcc: dcdcc {
>>>>>> +                             regulator-min-microvolt = <810000>;
>>>>>> +                             regulator-max-microvolt = <1080000>;
>>>>>> +                             regulator-name = "vdd-gpu";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_dcdcd: dcdcd {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <960000>;
>>>>>> +                             regulator-max-microvolt = <960000>;
>>>>>> +                             regulator-name = "vdd-sys";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     reg_dcdce: dcdce {
>>>>>> +                             regulator-always-on;
>>>>>> +                             regulator-min-microvolt = <1200000>;
>>>>>> +                             regulator-max-microvolt = <1200000>;
>>>>>> +                             regulator-name = "vcc-dram";
>>>>>> +                     };
>>>>>> +
>>>>>> +                     sw {
>>>>>> +                             /* unused */
>>>>>> +                     };
>>>>>
>>>>> Can't we have a DTSI for this PMIC too?
>>>>
>>>> Back when we started adding the regulators, Mark wasn't too happy with
>>>> all the placeholders we put in the dtsi. I think we got away with it
>>>> because we had other things in there as well. That's not true for this
>>>> particular PMIC.
>>>
>>> So we need separate dtsi for this PMIC as well?
>>
>> I don't think we do. We don't gain much.
> 
> Merged with Maxime's ack, and the subject prefix fixed.
> Also squashed in the Ethernet patch for this board.

H6 EMAC node changes still in ML.
