Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB82C433F5
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050CA20644
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 03:03:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="DixRIvfP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 050CA20644
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeH3HDL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 03:03:11 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:41306 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeH3HDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 03:03:11 -0400
Received: by mail-oi0-f66.google.com with SMTP id k12-v6so12904792oiw.8
        for <linux-kernel@vger.kernel.org>; Wed, 29 Aug 2018 20:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pndU0D59aSmSGGiZkPZwDsQJB9gPYKmH5sZX6IPaWe8=;
        b=DixRIvfP7gHK6tpOwoYXIhf9wbCvijOxlk77p4K+UL5J+vOondTBIA4CBwGiijrxBN
         YrA6EaqiigCZ1mi8BsAv/wIj8wSKKh8kPR9J47QizGeRWdPQBgAUZs2nzDkQSFfklG3O
         9c0SerzJfYFg6eiGqNi6njSJNO3q6EEtvr9EU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pndU0D59aSmSGGiZkPZwDsQJB9gPYKmH5sZX6IPaWe8=;
        b=Lu/2MyuLkpUhAZl6HKUAHEU6XYKWgoXkM7aiVmCCFzX4p/Tw6rmtPaGoRY9SDVbnDy
         MeUif5KHZdQpA9miq1Om6yILv5Y98k0aJcPVsUImaNnIoGWxVtgNM28a0LTkuEXtCUa6
         lVKfzxDDxBzqVFQvKbRe1t5zxH7IIclEhqTDyIS1qhWEmLNS2LyLHPHPqqcMwrdXXF90
         eHbz3zmSff1g4+ALdC5RNc4IC4GeD4U0h8JvBKtv676nBJO5+oNSdDFjZYw8XI8hKhgC
         1T52Q5ueUD93+Rj+EyHOYe/fa664J3zon0iD1K3WvFfVtJV8jHlFN8MLMhLjMxezk2Vw
         pjiA==
X-Gm-Message-State: APzg51C5xYPx1JRRY8RTtWqstV17fZWFNL9UKyAHmv1PGSOvnEJX49N2
        CPCrfFNSec1OXiFV7eEFXWj2BqIzf4FGdgMXiNTt1Q==
X-Google-Smtp-Source: ANB0VdYdkM6RkHDjWz30vRz2vutsPoMJyzGKcEJNARDslOCs2bwHVyhH/GXJO7VJfGCxTeD4TYFq1lgEnrEi7n4JPwQ=
X-Received: by 2002:aca:c42:: with SMTP id i2-v6mr680208oiy.219.1535598195083;
 Wed, 29 Aug 2018 20:03:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:590c:0:0:0:0:0 with HTTP; Wed, 29 Aug 2018 20:03:10
 -0700 (PDT)
In-Reply-To: <CAJKOXPd9-aLYFLBHwUyNecneHA6X+VbnZSK4paXsMcmvobnGhA@mail.gmail.com>
References: <5fcd93bbbcd55a5c23f1c75effdc3670ce7a811b.1535446321.git.baolin.wang@linaro.org>
 <CAJKOXPd9-aLYFLBHwUyNecneHA6X+VbnZSK4paXsMcmvobnGhA@mail.gmail.com>
From:   Baolin Wang <baolin.wang@linaro.org>
Date:   Thu, 30 Aug 2018 11:03:10 +0800
Message-ID: <CAMz4kuL8cSkBRb1C779u4gi93TwJ1M0aNV_nkRQoX16=7HK5wA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: power: Add Spreadtrum SC2731 charger documentation
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
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

Hi Krzysztof,

On 29 August 2018 at 22:08, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Tue, 28 Aug 2018 at 11:04, Baolin Wang <baolin.wang@linaro.org> wrote:
>>
>> This patch adds the binding documentation for Spreadtrum SC2731 charger
>> device.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  .../bindings/power/supply/sc2731_charger.txt       |   14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>  create mode 100644 Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
>>
>> diff --git a/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
>> new file mode 100644
>> index 0000000..02b616c
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/power/supply/sc2731_charger.txt
>> @@ -0,0 +1,14 @@
>> +Spreadtrum SC2731 PMIC battery charger binding
>> +
>> +Required properties:
>> + - compatible: Should be "sprd,sc2731-charger".
>> + - reg: Address offset of charger register.
>> + - phys: Contains a phandle to the USB phy.
>> +
>> +Example:
>> +
>> +       charger@0 {
>> +               compatible = "sprd,sc2731-charger";
>> +               reg = <0x0>;
>
> Can you include also few lines of parent node? You use this "reg"
> later as a base address so probably your parent node requires address
> mapping. It would be nice to see it in example.
>

Sorry that I forgot adding the parent node, and will add it in next
version. Thanks.

-- 
Baolin Wang
Best Regards
