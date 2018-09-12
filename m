Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71570C4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27D3320880
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 07:44:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="c9LLykcu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 27D3320880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727680AbeILMrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 08:47:21 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:32912 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbeILMrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 08:47:21 -0400
Received: by mail-wm0-f68.google.com with SMTP id r1-v6so9712040wmh.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 00:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=djGagg9HA78x49UWeyGib64DnFHHFS1cZLnTH/Dm7sg=;
        b=c9LLykcuW+fbcKWlj8nsciL7AfcB8dvmIIdsxpOiUSyCYK9YwPJagRsNbZgKaD+OQ4
         xvJ21h9puCxCjIJm1YPlqRZfGehiVgTPyhJR9h75Pwc9i9F7SDY3srxtZ4twas+VyPd7
         /yRFJyufKD2D8qiEagw9L+TgLyIn7X/CsBbCI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=djGagg9HA78x49UWeyGib64DnFHHFS1cZLnTH/Dm7sg=;
        b=W0XjPyqTKitWQXCjhK1M/zYPjM97e2NfSWe0Ng8H6O7T2caX9dZzAvu/jXt9JX9gqJ
         RKRSXVDGZR3QLZtzkdYeKDVgVTSCvczdwgd4zbMDPCDOiClrn62Ohzv45SercOfFsi50
         fAwqmFabWfs9UyGZjLAL3chkwuwqMwZM+dE7W8fyUodc00H7lzkBDeTR+9u70NF5aUFO
         I6EgTE68MesMWRQl9jlSDZ8DP43rc8Yr3REDehPEIaNwZdFQD9rhA12LCCQK8eRObzOw
         PC+LAUg5uPpzaEzcdPKjvjI36z2zDp6yDRueYuYT26FhoiIOwT4SyUi0yHoYK6zK25aw
         syVw==
X-Gm-Message-State: APzg51BdzqgOvcmqpORE4m0AO/2UEU3Fl8zdsgX5927a+Ta0RKhCb6Mb
        Hw7vlqOz6CacpWgQAhKJtdYrYg==
X-Google-Smtp-Source: ANB0VdYQLlagatLnOrtzw9dHnwgYgvEbTCGAuUw8wQ/yD9scvQOrG98F56bza5ea6nTGW2VwQjee5A==
X-Received: by 2002:a1c:1d87:: with SMTP id d129-v6mr712132wmd.34.1536738242902;
        Wed, 12 Sep 2018 00:44:02 -0700 (PDT)
Received: from [192.168.0.12] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id d12-v6sm569385wru.36.2018.09.12.00.44.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 00:44:02 -0700 (PDT)
Subject: Re: [PATCH v3 10/13] ASoC: dt-bindings: Add WCD9335 MBHC specific
 properties
To:     Rob Herring <robh@kernel.org>
Cc:     lee.jones@linaro.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-11-srinivas.kandagatla@linaro.org>
 <20180910200652.GA20896@bogus>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <7de84d92-bc35-d0ea-217c-403ff2f28ee7@linaro.org>
Date:   Wed, 12 Sep 2018 08:44:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180910200652.GA20896@bogus>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your review,

On 10/09/18 21:06, Rob Herring wrote:
> On Tue, Sep 04, 2018 at 11:24:57AM +0100, Srinivas Kandagatla wrote:
>> This patch add new bindings required to support MBHC
>> (Multi Button Headset Control) block in the codec.
>> This block is used for jack insert/removal detection,
>> headset type detection and 8 button press/release events.
>>
>> All these properties are very much specific to board.
>>
>> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
>> ---
>>   .../bindings/sound/qcom,wcd9335.txt           | 20 +++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
>> index 5d6ea66a863f..4d56c3ca9fa8 100644
>> --- a/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
>> +++ b/Documentation/devicetree/bindings/sound/qcom,wcd9335.txt
>> @@ -55,6 +55,26 @@ Required properties with SLIMbus Interface:
>>   	Value type: <string>
>>   	Definition: Must contain "mclk", "mclk2" and "slimbus" strings.
>>   
>> +- o qcom,mbhc-vthreshold:
> 
> Needs unit suffix.

Make sense, I will modify it

qcom,mbhc-vthreshold-millivolt

 >
> 
>> +	Usage: Optional, only required if headset button support required.
>> +	Value type: <u32 array>
>> +	Definition: Must contain an array of 8 threshold voltages in mV for
>> +		 8 buttons detection on headset.
>> +
>> +- qcom,hphl-jack-type-normally-open:
>> +	Usage: Optional, only required if headset button support required.
> 
> It's not required if the pin is NC, right?


> 
>> +	Value type: <boolean>
>> +	Definition: present if hphl pin on jack is a NO (Normally Open).
>> +		If not specified, then its assumed that hphl pin on jack
>> +		is NC (Normally Closed).
> 
> Is the not specified case the more common case? If not, it should be.
Yes, that is correct. In normal uscases we do not need these properties.
> 
>> +
>> +- qcom,gnd-jack-type-normally-open:
>> +	Usage: Optional, only required if headset button support required.
> 
> Same here.

> 
>> +	Value type: <boolean>
>> +	Definition: present if gnd pin on jack is NO (Normally Open).
>> +		 If not specified, then its assumed that gnd pin on
>> +		 jack is NC  (Normally Closed).
>> +
>>   - vdd-buck-supply:
>>   	Usage: required
>>   	Value type: <phandle>
>> -- 
>> 2.18.0
>>
