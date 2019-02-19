Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 919EDC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:44:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ED9A21848
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 07:44:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbfBSHoV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 02:44:21 -0500
Received: from olimex.com ([184.105.72.32]:41596 "EHLO olimex.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbfBSHoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 02:44:20 -0500
Received: from 195.238.85.143 ([195.238.85.143])
        by olimex.com with ESMTPSA (ECDHE-RSA-AES128-GCM-SHA256:TLSv1.2:Kx=ECDH:Au=RSA:Enc=AESGCM(128):Mac=AEAD) (SMTP-AUTH username stefan@olimex.com, mechanism PLAIN)
        for <linux-kernel@vger.kernel.org>; Mon, 18 Feb 2019 23:44:15 -0800
Subject: Re: [PATCH v2 5/8] arm64: dts: allwinner: Enable AXP803 CHGLED for
 Olimex boards
To:     Pavel Machek <pavel@ucw.cz>, Stefan Mavrodiev <stefan@olimex.com>
Cc:     Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>,
        "open list:LED SUBSYSTEM" <linux-leds@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "open list:X-POWERS MULTIFUNCTION PMIC DEVICE DRIVERS" 
        <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>
References: <20190215115013.11098-1-stefan@olimex.com>
 <20190215115013.11098-6-stefan@olimex.com> <20190215184916.GA17897@amd>
From:   Stefan Mavrodiev <stefan@olimex.com>
Message-ID: <d01f4cd2-67ef-66dc-4cb9-cad117bae90b@olimex.com>
Date:   Tue, 19 Feb 2019 09:43:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20190215184916.GA17897@amd>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/15/19 8:49 PM, Pavel Machek wrote:
> On Fri 2019-02-15 13:50:10, Stefan Mavrodiev wrote:
>> Teres-I and A64-OLinuXino commes with populated LED connected
>> to AXP803. So to be used as battery indication, pass the LED control
>> to the charger itself in mode 0 ( FULL while charging, OFF no battery
>> or completed).
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts | 6 ++++++
>>   arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts   | 6 ++++++
>>   2 files changed, 12 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> index f7a4bccaa5d4..7d6930319fba 100644
>> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
>> @@ -177,6 +177,12 @@
>>   
>>   #include "axp803.dtsi"
>>   
>> +&axp_led {
>> +	label = "a64-olinuxino:yellow:chgled";
> There's little chance userspace will recognize this led.
>
> Can you make it "platform:yellow:charging" and fix it for other
> boards, too?

Sure.

Best regards,
Stefan Mavrodiev

>
> 									Pavel
