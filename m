Return-Path: <SRS0=01Bl=QN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D58FC169C4
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:06:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01732218A3
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Feb 2019 06:06:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbfBFGGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 01:06:17 -0500
Received: from olimex.com ([184.105.72.32]:49339 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726001AbfBFGGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 01:06:17 -0500
Received: from 195.238.85.143 ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Tue, 5 Feb 2019 22:06:13 -0800
Subject: Re: [PATCH 5/5] arm: dts: axpxx: add charge led node
To:     Chen-Yu Tsai <wens@csie.org>, Stefan Mavrodiev <stefan@olimex.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>
References: <20190131082308.22522-1-stefan@olimex.com>
 <20190131082308.22522-5-stefan@olimex.com>
 <CAGb2v66B3X=hyCCanUv6yGziVcu3WrRcKODBp266ODL+yQ4m1w@mail.gmail.com>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <4493d1cb-d1bb-bcc9-c37d-68c79f33e762@olimex.com>
Date:   Wed, 6 Feb 2019 08:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAGb2v66B3X=hyCCanUv6yGziVcu3WrRcKODBp266ODL+yQ4m1w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/5/19 6:16 PM, Chen-Yu Tsai wrote:
> On Thu, Jan 31, 2019 at 4:25 PM Stefan Mavrodiev <stefan@olimex.com> wrote:
>> Add dt node for axp20x-led driver controlling CHGLED.
>> Default status is disabled, since it may be not used.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> Please include a cover letter for such a patch series.
Sorry, I will.
>
> Also, do any boards actually use this? I know the Pine64 does, but the
> LED is left to the user to populate. I would really like to have an in
> kernel user of this function, so that we can verify it.

All boards made by Olimex has this led populated. The development and the
testing of the driver was done on A64-OLinuXino board.

Should I make another patch, enabling the LED for the mention board?

Best regards,
Stefan Mavrodiev

>
> ChenYu
>
>> ---
>>   arch/arm/boot/dts/axp209.dtsi | 5 +++++
>>   arch/arm/boot/dts/axp22x.dtsi | 5 +++++
>>   arch/arm/boot/dts/axp81x.dtsi | 5 +++++
>>   3 files changed, 15 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
>> index 0d9ff12bdf28..f972b6f3ecd0 100644
>> --- a/arch/arm/boot/dts/axp209.dtsi
>> +++ b/arch/arm/boot/dts/axp209.dtsi
>> @@ -69,6 +69,11 @@
>>                  #gpio-cells = <2>;
>>          };
>>
>> +       axp_led: led {
>> +               compatible = "x-powers,axp20x-led";
>> +               status = "disabled";
>> +       };
>> +
>>          battery_power_supply: battery-power-supply {
>>                  compatible = "x-powers,axp209-battery-power-supply";
>>                  status = "disabled";
>> diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
>> index 65a07a67aca9..92a0b64252b1 100644
>> --- a/arch/arm/boot/dts/axp22x.dtsi
>> +++ b/arch/arm/boot/dts/axp22x.dtsi
>> @@ -62,6 +62,11 @@
>>                  #io-channel-cells = <1>;
>>          };
>>
>> +       axp_led: led {
>> +               compatible = "x-powers,axp20x-led";
>> +               status = "disabled";
>> +       };
>> +
>>          battery_power_supply: battery-power-supply {
>>                  compatible = "x-powers,axp221-battery-power-supply";
>>                  status = "disabled";
>> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
>> index bd83962d3627..22e243cc40d5 100644
>> --- a/arch/arm/boot/dts/axp81x.dtsi
>> +++ b/arch/arm/boot/dts/axp81x.dtsi
>> @@ -74,6 +74,11 @@
>>                  };
>>          };
>>
>> +       axp_led: led {
>> +               compatible = "x-powers,axp20x-led";
>> +               status = "disabled";
>> +       };
>> +
>>          battery_power_supply: battery-power-supply {
>>                  compatible = "x-powers,axp813-battery-power-supply";
>>                  status = "disabled";
>> --
>> 2.17.1
>>
