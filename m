Return-Path: <SRS0=lz5G=Q6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5000DC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:02:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A82920675
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Feb 2019 13:02:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDDGKAZu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfBWNCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Feb 2019 08:02:38 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35382 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726043AbfBWNCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Feb 2019 08:02:37 -0500
Received: by mail-wm1-f65.google.com with SMTP id y15so4272311wma.0;
        Sat, 23 Feb 2019 05:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pg0qPK/7ic2gH9jCLEPOmJCLbTatvZOgY7K0zD6ap84=;
        b=gDDGKAZuArjq6zH7AdO381l6tZQ0mA17Ns6KM1gW7kJjrP52DucMMNvcbVd6LwYqoH
         FQ8oev6BeEhCihNvxvDvyw7/jLweE2TjE4kYz2xjm4g2VpPKJOEsswhPd1qMnyRxw+0Q
         8RjoP1yBRIlso0RBQSEXj6DpN67LwZBw05COWOaccsQ2hFswYAfbVqrWtaYUgDQPFFq3
         y2Tel7JUVlhuuY8tD84Mug6Nuk65/Ix3pNmWkdqz02/Nti9NC5HjzvNgTFJXsW1HlUof
         Et70iVdBBtAk4WaogtIrSbwP0/SZx4MwSNN2Pzq0GaI8rUG5Y//Oav9zJro1MEWhMpHd
         M3nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pg0qPK/7ic2gH9jCLEPOmJCLbTatvZOgY7K0zD6ap84=;
        b=WVNijhSEPoNUVd1tL5izVGs/XI5LJjVBcggPYtHWczqxejSko0YZOiY0H5xcl1tvMV
         ne1dExx0bgftlcmvZknn9+THMp7FUb7c3cR0THvofZjjKlaDptKZqoKyfRb3s9LxXB24
         XxvBG+QZGBjEUpwiUkhP7YP5lQ/pBvWxkViEEI21q01ujfGD8DzG5q3ba0P2EdMJQ0tA
         0zplCla9/1oaV4OTWClfNkE44/qXwXkR/mEou/toTKlya8nVDlSXs7xzeeWifOF4Z1f6
         uhALBnzFr3hnLEzTZF13tTAcSiEhundfShRo+PUuD1li98XWkFshTFCASvQ241yO3sz+
         k9Iw==
X-Gm-Message-State: AHQUAubGDr9XPITF7NaC2hPoEQJJOItHvJfy3kXD9d73zD0mR+yXjHvy
        vLHGgNx04qIrHdBW/2Bd5avxBKY9
X-Google-Smtp-Source: AHgI3IafQmx5S97alHBOL+5ck2HzfLd15NpluXmi1je7R91f/uutzucXtPLr56bjrFDKMrKTFXNxfg==
X-Received: by 2002:a7b:c5d1:: with SMTP id n17mr5440121wmk.152.1550926954757;
        Sat, 23 Feb 2019 05:02:34 -0800 (PST)
Received: from [192.168.1.18] (bkp90.neoplus.adsl.tpnet.pl. [83.28.183.90])
        by smtp.gmail.com with ESMTPSA id l129sm2918259wml.42.2019.02.23.05.02.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Feb 2019 05:02:34 -0800 (PST)
Subject: Re: [PATCH v2 3/8] dt-bindings: leds: Add binding for axp20x-led
 device driver
To:     Rob Herring <robh@kernel.org>, Stefan Mavrodiev <stefan@olimex.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Mark Rutland <mark.rutland@arm.com>,
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
 <20190215115013.11098-4-stefan@olimex.com> <20190222195109.GA17753@bogus>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <07d9d8f2-6263-8966-19da-ecaa761b3db9@gmail.com>
Date:   Sat, 23 Feb 2019 14:02:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190222195109.GA17753@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/22/19 8:51 PM, Rob Herring wrote:
> On Fri, Feb 15, 2019 at 01:50:08PM +0200, Stefan Mavrodiev wrote:
>> This adds the devicetree bindings for charge led indicator found
>> on most of X-Powers AXP20X PMICs.
>>
>> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
>> ---
>>   .../devicetree/bindings/leds/leds-axp20x.txt  | 74 +++++++++++++++++++
>>   1 file changed, 74 insertions(+)
>>   create mode 100644 Documentation/devicetree/bindings/leds/leds-axp20x.txt
>>
>> diff --git a/Documentation/devicetree/bindings/leds/leds-axp20x.txt b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
>> new file mode 100644
>> index 000000000000..5a83ad06796d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/leds/leds-axp20x.txt
>> @@ -0,0 +1,74 @@
>> +Device Tree Bindings for LED support on X-Powers PMIC
>> +
>> +Most of the X-Powers PMICs have integrated battery charger with LED indicator.
>> +The output is open-drain, so the state is either high-Z or output-low. The
>> +driver is a subnode of AXP20X MFD driver, since it uses shared bus with all
>> +other cells.
>> +The LED can be controlled either manually or automatically. Then in automatic
>> +(controlled by the charger) there are two indication modes:
>> +
>> +Mode-A
>> +======
>> +- output-low:		Charging
>> +- high-Z		Not charging
>> +- 1Hz flashing:		Abnormal alarm
>> +- 4Hz flashing		Overvoltage alarm
>> +
>> +Mode-B
>> +======
>> +- output-low:		Battery full
>> +- high-Z		Not charging
>> +- 1Hz flashing:		Charging
>> +- 4Hz flashing		Overvoltage or abnormal alarm
>> +
>> +The control and the mode can be changed from sysfs.
>> +
>> +For AXP20X MFD bindings see:
>> +Documentation/devicetree/bindings/mfd/axp20x.txt
>> +
>> +Required properties:
>> +- compatible : Must be "x-powers,axp20x-led"
>> +
>> +Supported common LED properties, see ./common.txt for more informationn
>> +- label : See Documentation/devicetree/bindings/leds/common.txt
>> +- linux,default-trigger : See Documentation/devicetree/bindings/leds/common.txt
>> +- default-state: See Documentation/devicetree/bindings/leds/common.txt
>> +
>> +Optional properties:
>> +- x-powers,charger-mode: 0 for Mode-A, 1 for Mode-B
>> +			 If omitted, then the control is set to manual mode.
>> +			 On invalid value, Mode-A is used.
>> +
>> +
>> +Example:
>> +
>> +	axp803: pmic@3a3 {
>> +		compatible = "x-powers,axp803";
>> +
>> +		...
>> +
>> +		led@0 {
> 
> What's the 0 for? A unit address without a reg property is not valid.

It was done on my request, but now I see it was an omission.

Since this node describes a LED controller, then it should
be called "led-controller".

>> +			compatible = "x-powers,axp20x-led";
>> +			status = "okay";

And below part should be in a child node.

Stefan, please compare
Documentation/devicetree/bindings/leds/common.txt and
other LED bindings.

>> +			label = "axp20x:yellow:chgled";

Moreover "axp20x:" part should be removed from here added in the driver.

Please refer to drivers/leds/leds-cr0014114.c on how we
do that now.

>> +			linux,default-trigger = "timer";
>> +			default-state = "on";
>> +		};
>> +	};
>> +
>> +or
>> +
>> +	axp803: pmic@3a3 {
>> +		compatible = "x-powers,axp803";
>> +
>> +		...
>> +
>> +		led@0 {
>> +			compatible = "x-powers,axp20x-led";
>> +			status = "okay";
>> +
>> +			label = "axp20x:yellow:chgled";
>> +			x-powers,charger-mode = <1>;
>> +		};
>> +	};
>> -- 
>> 2.17.1
>>
> 

-- 
Best regards,
Jacek Anaszewski
