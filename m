Return-Path: <SRS0=ZOiK=MF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E5BC433F4
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:36:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37218214C2
	for <linux-kernel@archiver.kernel.org>; Sun, 23 Sep 2018 06:36:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZX/4rmq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37218214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726094AbeIWMcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 23 Sep 2018 08:32:47 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:46564 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbeIWMcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Sep 2018 08:32:46 -0400
Received: by mail-pl1-f195.google.com with SMTP id v19-v6so61543ply.13;
        Sat, 22 Sep 2018 23:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cCNrHjK3TCzMxpCR5wDKyBVT86tuf1MIQZYhsGlUbr0=;
        b=XZX/4rmqn6M90chpCH+jrwdL1sNqLeHjSsOH0HDXokeugvKdxGF+L48gOh1zTsukA+
         sg3NQe0gldmewd53Go+08GNvesWh3kwzGvdtPCFRz0cpFvQihBG7GLwXTcvRZVKmm7qV
         Sb/HTn2KL/iQHJwM+BTCTmKcVTv5cWw4QGw/QZSwEzToBiJ/AsNn14AFYi/tj83PAwFS
         1DwS3EVSrk0HgzZzqu9XpPzjklgz6ucRh66xLkjnW6udw/BnQ5pT/Kh29UXBoPm/jG1p
         q9vyAqttDv+YWx4EOBsrlfTbj8DMF1ZpqhalFoTXYANa8TNyyoEbpF5K3NUNmu0HObPy
         1uqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cCNrHjK3TCzMxpCR5wDKyBVT86tuf1MIQZYhsGlUbr0=;
        b=gY4qvJW8nGxdwmqU/h4RG6Yc85zxriUO6t9XlC2vK9U3y+0673j/F+aanh6++mV1PZ
         VLhvyUCycvmon1pPOq26kydBL5elHYK7mARzOAr8hyIIimM9nywxDX7sBAK3mGuF0QL3
         uiDbQhOpochlBJm1slmG7tKaOlNGvOsjznh4i7HEQiDmEYLNnXrqkaMmqiKQEV5jSrgn
         9KtY6b8+jFigHB19o6YvgTt3v219/WOke9Dv4B9sL4x/EHQIFwrdzf+IYRrjjnh7ZhVP
         ZELGOTngqgGwC5oL7bBlR2hK4y70r/swt/bLek/jRIpV8xDNcCzbn2+kot8uhv6kyRJO
         T/3g==
X-Gm-Message-State: ABuFfohYBWiiX+zfUCD+ZmC0yl8j2r3bmHQ9LHfigVutbKBXP+PPnWXP
        y8dbv+3Jaw+Mw+TI+VLkI9iNomGw
X-Google-Smtp-Source: ACcGV61um+6HeQNXFFJXFupmaAnEt4DFt+v/+SfwasRZS9YAhSv7E5wsNiEtDM0oUBgIJd8fveeAgw==
X-Received: by 2002:a17:902:744c:: with SMTP id e12-v6mr2156314plt.186.1537684585328;
        Sat, 22 Sep 2018 23:36:25 -0700 (PDT)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v6-v6sm51441019pfa.28.2018.09.22.23.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 22 Sep 2018 23:36:24 -0700 (PDT)
Subject: Re: [PATCH v4 1/2] dt-bindings: hwmon: Add ina3221 documentation
To:     Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     jdelvare@suse.com, robh+dt@kernel.org, mark.rutland@arm.com,
        corbet@lwn.net, afd@ti.com, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
References: <20180923041118.8743-1-nicoleotsuka@gmail.com>
 <20180923041118.8743-2-nicoleotsuka@gmail.com>
 <353ccbbd-94c8-72eb-eb98-8a0507431e15@roeck-us.net>
 <20180923053151.GB9960@Asurada>
 <ce76fdf2-2894-96ad-d2f5-b2c25f197ee4@roeck-us.net>
 <20180923060120.GA8872@Asurada-Nvidia.nvidia.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <fe5c9570-70f8-d54d-509e-fce3733a4145@roeck-us.net>
Date:   Sat, 22 Sep 2018 23:36:22 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180923060120.GA8872@Asurada-Nvidia.nvidia.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/22/2018 11:01 PM, Nicolin Chen wrote:
> On Sat, Sep 22, 2018 at 10:45:49PM -0700, Guenter Roeck wrote:
>> On 09/22/2018 10:31 PM, Nicolin Chen wrote:
>>> On Sat, Sep 22, 2018 at 10:19:42PM -0700, Guenter Roeck wrote:
>>>>> +2) child nodes
>>>>> +  Required properties:
>>>>> +  - input-id: Must be 1, 2 or 3
>>>>> +
>>>>> +  Optional properties:
>>>>> +  - input-label: Name of the input source

Just noticed the "input-" here. Please just use "label".

>>>>> +  - shunt-resistor: Shunt resistor value in micro-Ohm
>>>>> +  - status: Should be "disabled" if no input source
>>>>> +
>>>>> +  Example:
>>>>> +
>>>>> +  input1 {
>>>>> +          input-id = <0x1>;
>>>>
>>>> We'll have to find a better name for this. Feel free to look up examples in the
>>>> existing devicetree descriptions. The one that seems to be used most of the time
>>>> to indicate a channel index or id is "reg". It should also start with 0 - there
>>>> is no real reason for it to start with 1; it only makes the code more complex.
>>>
>>> The reason is that the port start from 1 in the datasheet.
>>>
>>
>> Maybe, but for me I'll want to have something that we can reuse for other chips.
>> Having the index start with 0 for one chip and with 1 for another would be
>> confusing. It is bad enough that we have in[0..n] for voltages and temp[1..n]
>> for temperatures. I would not want to see the same in devicetree files,
>> and much less so on a per-device basis. It is also pretty common to start
>> channel numbers with 0 in devicetree files.
> 
> Understood. I search a bit and saw most of "*-id" start from 0,
> although I cannot be sure whether their Datasheet/RM/schematics
> are counting from 0 or 1.
> 
> And I also found a transposing example:
>      Documentation/devicetree/bindings/serial/mrvl,pxa-ssp.txt
> 

You'll always find an example for anything in the kernel. In this case,
it is for one specific chip. I'll want this to be reusable as template for
_all_ hardware monitoring chips.

Thanks,
Guenter

> Probably should be better to wait for doc maintainers' input.
> 
> Thanks
> Nicolin
> 

