Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752208AbeEOEz7 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 00:55:59 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:58660 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752130AbeEOEz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 00:55:57 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 15 May 2018 10:25:55 +0530
From: kgunda@codeaurora.org
To: Pavel Machek <pavel@ucw.cz>
Cc: bjorn.andersson@linaro.org, Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH V1 2/5] backlight: qcom-wled: Add support for WLED4
 peripheral
In-Reply-To: <20180514165755.GB27984@xo-6d-61-c0.localdomain>
References: <1525341432-15818-1-git-send-email-kgunda@codeaurora.org>
 <1525341432-15818-3-git-send-email-kgunda@codeaurora.org>
 <20180514165755.GB27984@xo-6d-61-c0.localdomain>
Message-ID: <e7e26e85a7b95d1d0cb67e0d6197e897@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-14 22:27, Pavel Machek wrote:
> Hi!
> 
>> WLED4 peripheral is present on some PMICs like pmi8998
>> and pm660l. It has a different register map and also
>> configurations are different. Add support for it.
>> 
>> Signed-off-by: Kiran Gunda <kgunda@codeaurora.org>
>> ---
>>  .../bindings/leds/backlight/qcom-wled.txt          | 172 ++++-
>>  drivers/video/backlight/qcom-wled.c                | 749 
>> +++++++++++++++------
>>  2 files changed, 696 insertions(+), 225 deletions(-)
>> 
>> diff --git 
>> a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt 
>> b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> index fb39e32..0ceffa1 100644
>> --- a/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> +++ b/Documentation/devicetree/bindings/leds/backlight/qcom-wled.txt
>> @@ -1,30 +1,129 @@
>>  Binding for Qualcomm Technologies, Inc. WLED driver
>> 
>> -Required properties:
>> -- compatible: should be "qcom,pm8941-wled"
>> -- reg: slave address
>> -
>> -Optional properties:
>> -- default-brightness: brightness value on boot, value from: 0-4095
>> -	default: 2048
>> +- compatible
>> +	Usage:        required
>> +	Value type:   <string>
>> +	Definition:   should be "qcom,pm8941-wled" or "qcom,pmi8998-wled".
>> +		      or "qcom,pm660l-wled".
>> +
>> +- reg
>> +	Usage:        required
>> +	Value type:   <prop encoded array>
>> +	Definition:   Base address of the WLED modules.
> 
> I'm not sure if this change of format is good idea here...
> 
> 									Pavel
> --
This format is clean and easily readable. That's why I have moved to 
this format.
To avoid confusion, I will move out the existing properties 
(pm8941-wled.c) to other
patch. So that it will be easy to review.

> To unsubscribe from this list: send the line "unsubscribe 
> linux-arm-msm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
