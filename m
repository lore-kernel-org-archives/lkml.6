Return-Path: <SRS0=UfG/=NY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1AF1C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92893223AE
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Nov 2018 20:57:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dKb5obM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92893223AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbeKNG5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 01:57:21 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:37701 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725748AbeKNG5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 01:57:20 -0500
Received: by mail-ed1-f65.google.com with SMTP id h15so6956159edb.4;
        Tue, 13 Nov 2018 12:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iZc/1N8ULqlb+KEZMW+hKDFpHQZ+ic+440af96BInwA=;
        b=dKb5obM2DDp8ExjKWcibp/aROXRQ8CNvx8R/BarVq+SPk3yemwbTFcdUkO4ecJF9Px
         S83ubO/qXQ12NplRS0v6wHK6NpTan2wq8A4/4mERcBwN0nmACw076XNnIMc+G8RB2V0G
         cfmPe4lwFuj9jxoj9ASnoLBjKjJL+gUsn6pzrQoLvnmN723YkY9Cdaoz7ZihfQyyYQ8L
         My/fOZF6BaxnZiP/6ShixV+teB9QhE5IypRhh5J15eIvmQFnltRCTjlYnwvejizd8Hms
         bnSwcAH9Q4l6gqHH5JqNeXFfMUVlh7qXAg70xComgURS09S/tnj3ThnQaqJGGQLyo7f0
         914g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iZc/1N8ULqlb+KEZMW+hKDFpHQZ+ic+440af96BInwA=;
        b=G9MGAYgeBRsaBdXrR4QXeFil4v3T5NDqgcAtRoD09Od3sn9/htjxm13K5QDu/+XX2m
         oD9QeJy33V6srooV4oJcwK/X1TiW/sgEcW86hGWmy9+uCL5YmjLvH3j3Oiijh6SFma/a
         3O6ChdDeSfFLOyUjOUmDqJVRqk1u1qpoOnLpEOtSR1otEqUqiX321sQpj4IxoaC7dD1b
         SK1vAwz8A1r+vTXL+CnSogR5TMCPj0rEQVxdOSRGIuQJg38cXM9cYVkMppVwGyKMWNl4
         6UMetvOggQNkGBluKlz/yvCaH87ySG0XTw2ieIhOyc91e8gXdSdZ6aWi/1fOgQ289WfC
         uyVw==
X-Gm-Message-State: AGRZ1gLnu6RIN/kMOVXhM2OI/4IqxD4HVwt0F/b1/J9JF69q+fXEzu8L
        LAT7cH0Q/dhuR2BMSVEoK8M=
X-Google-Smtp-Source: AJdET5cPXFRbq9fDn716QvEu+IVbvkSOhL9iXRzFLUY94OR2R1150T6uyD2G+WrdyEjO2mpQIlH3hw==
X-Received: by 2002:a50:90c6:: with SMTP id d6mr9211189eda.15.1542142644053;
        Tue, 13 Nov 2018 12:57:24 -0800 (PST)
Received: from [192.168.1.18] (dma68.neoplus.adsl.tpnet.pl. [83.24.56.68])
        by smtp.gmail.com with ESMTPSA id t10-v6sm2441673ejg.41.2018.11.13.12.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Nov 2018 12:57:23 -0800 (PST)
Subject: Re: [PATCH 04/24] dt-bindings: leds: Add function and color
 properties
To:     Rob Herring <robh@kernel.org>
Cc:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, pavel@ucw.cz,
        Baolin Wang <baolin.wang@linaro.org>,
        Daniel Mack <daniel@zonque.org>, Dan Murphy <dmurphy@ti.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleh Kravchenko <oleg@kaa.org.ua>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Simon Shields <simon@lineageos.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>
References: <1541542052-10081-1-git-send-email-jacek.anaszewski@gmail.com>
 <1541542052-10081-5-git-send-email-jacek.anaszewski@gmail.com>
 <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com>
From:   Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <dfb5bd23-bcb9-7501-a608-969cb0464168@gmail.com>
Date:   Tue, 13 Nov 2018 21:57:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <5bea0eb8.1c69fb81.6b921.80e6@mx.google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/2018 07:27 PM, Rob Herring wrote:
> On Tue, Nov 06, 2018 at 11:07:12PM +0100, Jacek Anaszewski wrote:
>> Introduce dedicated properties for conveying information about
>> LED function and color. Mark old "label" property as deprecated.
>>
>> Signed-off-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
>> Cc: Baolin Wang <baolin.wang@linaro.org>
>> Cc: Daniel Mack <daniel@zonque.org>
>> Cc: Dan Murphy <dmurphy@ti.com>
>> Cc: Linus Walleij <linus.walleij@linaro.org>
>> Cc: Oleh Kravchenko <oleg@kaa.org.ua>
>> Cc: Sakari Ailus <sakari.ailus@linux.intel.com>
>> Cc: Simon Shields <simon@lineageos.org>
>> Cc: Xiaotong Lu <xiaotong.lu@spreadtrum.com>
>> ---
>>  Documentation/devicetree/bindings/leds/common.txt | 52 +++++++++++++++++++----
>>  1 file changed, 44 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/leds/common.txt b/Documentation/devicetree/bindings/leds/common.txt
>> index aa13998..3efc826 100644
>> --- a/Documentation/devicetree/bindings/leds/common.txt
>> +++ b/Documentation/devicetree/bindings/leds/common.txt
>> @@ -10,14 +10,20 @@ can influence the way of the LED device initialization, the LED components
>>  have to be tightly coupled with the LED device binding. They are represented
>>  by child nodes of the parent LED device binding.
>>  
>> +
>>  Optional properties for child nodes:
>>  - led-sources : List of device current outputs the LED is connected to. The
>>  		outputs are identified by the numbers that must be defined
>>  		in the LED device binding documentation.
>> +- function: LED functon. Use one of the LED_FUNCTION_* prefixed definitions
>> +	    from the header include/dt-bindings/leds/functions.h.
>> +	    If there is no matching LED_FUNCTION available, add a new one.
>> +- color : Color of the LED.
>>  - label : The label for this LED. If omitted, the label is taken from the node
>>  	  name (excluding the unit address). It has to uniquely identify
>>  	  a device, i.e. no other LED class device can be assigned the same
>> -	  label.
>> +	  label. This property is deprecated - use 'function' and 'color'
>> +	  properties instead.
> 
> I don't know if I'd go as far a deprecating.
> 
> One thing to consider is how we handle multiple of the same function? Do 
> we allow an index on function names? What if an index isn't meaningful 
> and we need "front" vs. "rear" for example? Maybe label is still needed 
> there. 

I believe that 'label' property with its old semantics must be preserved
for backwards compatibility - it so far has been used inconsistently for
conveying variations of devicename:color:function sections. If provided,
then it's been taken as-is for LED class device name, or concatenated
with the devicename hard-coded in the driver.

Regarding the differentiation between the LEDs with functions of
same kind - OK, I agree, we will need another section.

What seems to fits the best is the reference to the device it is
logically associated with.

The question is whether the devicename should be provided in DT
literally, or by phandle, and then retrieved in runtime, basing on the
sysfs entry, like in case of input-leds bridge which for USB keyboard
creates LEDs named e.g.:

input5::capslock
input5::numlock
input5::scrolllock

Probably we will have to allow for some flexibility in this regard,
to allow for providing devicename literally like "rear", "front",
or like above input case.

-- 
Best regards,
Jacek Anaszewski
