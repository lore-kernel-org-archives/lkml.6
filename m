Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954C6ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 324DE214D5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 20:45:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KbCJHd+X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 324DE214D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728461AbeIRCOJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 22:14:09 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39178 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728202AbeIRCOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 22:14:09 -0400
Received: by mail-oi0-f68.google.com with SMTP id c190-v6so20203413oig.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 13:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=vjsuWbMnPCvZk6cZ4Tx9/b8wF2F5yAEPSXlz19WMxWI=;
        b=KbCJHd+X5gLE6iapnoZl9Bw/IOQ3TMvtctKAqXLDVcBs06leAk6RKzlfNnYWGyQTP5
         CudWCXK+ohMIVdNiPWRAujQ6XDPMHyFKZLUwTMGWJDG6RUTQozKsPPCgtEBl55YvIwJG
         h5MchpjhfcVdJ5pV8iz4eYFp9abNJZlfoUwV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=vjsuWbMnPCvZk6cZ4Tx9/b8wF2F5yAEPSXlz19WMxWI=;
        b=Lfh0V7Cgl0/zbie2z0MlKe7UmH3VBUGd5vgVlmlTt7eNyD1knt43Lb7wEwr1E9asLZ
         kPZf9V/kOYJ6NeDtlDDxscEcYkhhIG2Wik1L3QZQGfLzmj/tXt1WoNMwNPL+BQi8sLYE
         WRGd0iQySA9G7reExezzTxiKBJ20Ln+etePqmZgFZh9zo0ULxJoHKeigXi7iZmU9YK0M
         RGD1X3FEsbfc5Os3oFTR4mx/ubrVU4ZSqxKUkKC6od633zafvwIiAsqijXIfqmOpDDLU
         lPhdAesAneDX3AWXdtPU4AIZIp9dhniVur+mxKRWCVr5YhHRroMEaiJvIn+jr87j+/2M
         aDcg==
X-Gm-Message-State: APzg51A9LQFJTQhHHjkJKCWtmLXU72tqLL1KHZdRY12HDd+oiDfZMqG6
        LYWFr6wSB1wku4jtMSUoLNaWjnrkOZQO5Jdy9lo0JA==
X-Google-Smtp-Source: ANB0VdY545A4tX/o55SWoxLuUdyR8is37RAYZxndZ8QTlBOnwfLzXS3z7xxq50w9uiz4EnYEB4rQSo3JpF9w+f+B1gg=
X-Received: by 2002:aca:c0c1:: with SMTP id q184-v6mr18588924oif.61.1537217109875;
 Mon, 17 Sep 2018 13:45:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3ec8:0:0:0:0:0 with HTTP; Mon, 17 Sep 2018 13:45:09
 -0700 (PDT)
In-Reply-To: <20180917032625.GA25442@bogus>
References: <1b3f165e2a806dd3d4b7712160ee3bda72f7d675.1536736399.git.baolin.wang@linaro.org>
 <20180917032625.GA25442@bogus>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Tue, 18 Sep 2018 04:45:09 +0800
Message-ID: <CAMz4kuLQJq4LzB9ovt7cyr5ufY9KdKe7kF9n8ezyH4gB2Zu6oA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC27XX fuel gauge
 unit documentation
To:     Rob Herring <robh@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux PM list <linux-pm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, yuanjiang.yu@unisoc.com,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On 17 September 2018 at 11:26, Rob Herring <robh@kernel.org> wrote:
> On Wed, Sep 12, 2018 at 03:29:38PM +0800, Baolin Wang wrote:
>> This patch adds the binding documentation for Spreadtrum SC27XX series PMICs
>> fuel gauge unit device, which is used to calculate the battery capacity.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  .../devicetree/bindings/power/supply/sc27xx-fg.txt |   55 ++++++++++++++++++++
>>  1 file changed, 55 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> new file mode 100644
>> index 0000000..7447bae
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/sc27xx-fg.txt
>> @@ -0,0 +1,55 @@
>> +Spreadtrum SC27XX PMICs Fuel Gauge Unit Power Supply Bindings
>> +
>> +Required properties:
>> +- compatible: Should be one of the following:
>> +  "sprd,sc2720-fgu",
>> +  "sprd,sc2721-fgu",
>> +  "sprd,sc2723-fgu",
>> +  "sprd,sc2730-fgu",
>> +  "sprd,sc2731-fgu".
>> +- reg: The address offset of fuel gauge unit.
>> +- bat-detect-gpio: GPIO for battery detection.
>
> We already have sbs,battery-detect-gpios, let's drop the 'sbs,' and copy
> that.

Sure.

>
>> +- io-channels: Specify the IIO ADC channel to get temperature.
>> +- io-channel-names: Should be "bat-temp".
>> +- sprd,inner-resist: Specify the the battery inner resistance (mOhm).
>
> If this is a property of the battery, then why a sprd vendor prefix?
> This should perhaps be a common property.
>
> Minimally, it needs a unit suffix as defined in property-units.txt.

Right. As Sebastian pointed out previously we should add one common
property to describe the battery  inner resistance.

>
>> +- sprd,ocv-cap-table: Provide the battery capacity percent with corresponding
>> +  open circuit voltage (ocv) of the battery, which is used to look up current
>> +  battery capacity according to current baterry ocv values.
>
> Sounds like another battery property.

Yes.

>
>> +- monitored-battery: Phandle of battery characteristics devicetree node.
>
> If the battery is represented in another node, why are properties of the
> battery in this node.

Sure. I can remove these properties which are belonging to the battery
node. Thanks.

>
>> +  The fuel gauge uses the following battery properties:
>> +- charge-full-design-microamp-hours: battery design capacity.
>> +- constant-charge-voltage-max-microvolt: maximum constant input voltage.
>> +  See Documentation/devicetree/bindings/power/supply/battery.txt
>> +
>> +Example:
>> +
>> +     bat: battery {
>> +             compatible = "simple-battery";
>> +             charge-full-design-microamp-hours = <1900000>;
>> +             constant-charge-voltage-max-microvolt = <4350000>;
>> +             ......
>> +     };
>> +
>> +     sc2731_pmic: pmic@0 {
>> +             compatible = "sprd,sc2731";
>> +             reg = <0>;
>> +             spi-max-frequency = <26000000>;
>> +             interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>;
>> +             interrupt-controller;
>> +             #interrupt-cells = <2>;
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             fgu@a00 {
>> +                     compatible = "sprd,sc2731-fgu";
>> +                     reg = <0xa00>;
>> +                     bat-detect-gpio = <&pmic_eic 9 GPIO_ACTIVE_HIGH>;
>> +                     io-channels = <&pmic_adc 5>;
>> +                     io-channel-names = "bat-temp";
>> +                     sprd,inner-resist = <250>;
>> +                     sprd,ocv-cap-table = <4185 100>, <4113 95>, <4066 90>, <4022 85>, <3983 80>, <3949 75>, <3917 70>,
>> +                             <3889 65>, <3864 60>, <3835 55>, <3805 50>, <3787 45>, <3777 40>, <3773 35>, <3770 30>,
>> +                             <3765 25>, <3752 20>, <3724 15>, <3680 10>, <3605 5>, <3400 0>;
>> +                     monitored-battery = <&bat>;
>> +             };
>> +     };
>> --
>> 1.7.9.5
>>
>



-- 
Baolin Wang
Best Regards
