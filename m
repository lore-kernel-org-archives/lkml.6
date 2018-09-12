Return-Path: <SRS0=BZo9=L2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C733DC4646A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:11:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80DB720882
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Sep 2018 11:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="JNm5uVm7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80DB720882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbeILQPn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Sep 2018 12:15:43 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:54095 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727943AbeILQPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Sep 2018 12:15:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id b19-v6so1928605wme.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 Sep 2018 04:11:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=d02ucg8ZY0msAMQmOsEJSgbvvHDF8xLjWfxa+CcpiAk=;
        b=JNm5uVm7LyXZymSwrY4yeePwD2dAStbeJwMJ4yQVDXnGqIn6lMf+YB12Wfntzxo0Rp
         KRyARoG/9STxtd/ULlCGv3lIFAtIvSdYibtq4qwfis2JTaYOba3++CGyX3eQD+BWt6Gt
         4qCwAJzr1n2BLPQSc4EnMjS24yxWRy4bLr1js=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=d02ucg8ZY0msAMQmOsEJSgbvvHDF8xLjWfxa+CcpiAk=;
        b=ebS9GR4G/3lOLdHYlttF/o5Ppy+yDWoXr0lpiHMO072wsQUfKluHzmlWICrsJp0bky
         4tZNPFqJ8TzTe2Aub4F+V3s322zn3YG0Vmgb8c8y/3utr+QMQ0yOuvMUDtfL0u46EAST
         O6QmMcRWuegF9DLrzJKC1jmK5/AIdwPF/OA8rWzUWjbzR2AU4pmXq8abGQBppon72awp
         QejsjTmLhuB6gngBdvtCkFgL821o0z40H6YiEc4rF31A2yzm/1hLRKLzzKvNSx2Ibbwf
         D26m7i7nroF12x1vO6DEvdH3ou3v+BtfjFmUGxzoouVNShoFMDvEUU3UleHbu12QluZq
         LrIA==
X-Gm-Message-State: APzg51CAaQwI3aTfFRpRfI6OvnA8ayYafXYGas6aelDzQOSE2kHwgLmG
        kqJnfVkB8soHuJvTqyXjueBp1I3p/Qg=
X-Google-Smtp-Source: ANB0VdaCbl8v4m2xsJvGbwG5lawNVIUyVCh504leVExGUgRusYf+eVO8bGLxFXdiVCRlC9vz7tmGww==
X-Received: by 2002:a1c:65c5:: with SMTP id z188-v6mr1230081wmb.57.1536750698159;
        Wed, 12 Sep 2018 04:11:38 -0700 (PDT)
Received: from [192.168.0.18] (cpc90716-aztw32-2-0-cust92.18-1.cable.virginm.net. [86.26.100.93])
        by smtp.googlemail.com with ESMTPSA id 94-v6sm1184611wrc.10.2018.09.12.04.11.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Sep 2018 04:11:37 -0700 (PDT)
Subject: Re: [PATCH v3 02/13] mfd: wcd9335: add support to wcd9335 core
To:     Lee Jones <lee.jones@linaro.org>
Cc:     robh+dt@kernel.org, broonie@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, bgoswami@codeaurora.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkoul@kernel.org, alsa-devel@alsa-project.org
References: <20180904102500.30318-1-srinivas.kandagatla@linaro.org>
 <20180904102500.30318-3-srinivas.kandagatla@linaro.org>
 <20180911153340.GY4185@dell>
 <94c68436-b618-40fc-46d6-165799312289@linaro.org>
 <20180912085848.GP4185@dell>
 <b4ddfd10-360c-a844-8542-1f81a1cc9c6b@linaro.org>
 <20180912105941.GS4185@dell>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Message-ID: <11f213e5-8c93-f75f-1b74-517f00cd9a96@linaro.org>
Date:   Wed, 12 Sep 2018 12:11:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <20180912105941.GS4185@dell>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/09/18 11:59, Lee Jones wrote:
>> On 12/09/18 09:58, Lee Jones wrote:
>>>>>> +static const struct mfd_cell wcd9335_devices[] = {
>>>>>> +	{ .name = "wcd9335-codec", },
>>>>>> +};
>>>>> Are there more devices to come?
>>>>>
>>>> Yes, that is the plan, we are kind of limited in hardware setup to test few
>>>> things like soundwire controller. We are exploring other ways to test these.
>>> I normally don't accept MFDs with just one device enabled.  Since it's
>>> not really an MFD (M == Multi) until it has more than one function.
>>>
>> WCD9335 Codec hw itself has multiple hw blocks.
>>
>> If the issue is about adding more entries to mfd cells then we should be
>> able to add below entry:
>>
>> 	{ .name = "wcd9335-soundwire-controller", },
>>
>> Actual driver for soundwire controller is not something We can test with
>> regular dragon boards, it needs special hw for smart speakers. Once we have
>> that we can test and post the drivers for that.
>>
>> Otherwise
>>
>> Are you suggesting that I move everything to  sound/soc/codecs and then back
>> to mfd once soundwire controller driver is added?
> My preference would be for you to add at least one other (tested)
> device.  However, in your case I know where you live, so I can throw
> tomatoes at your house if you don't upstream more device support
> promptly!;)
> 
> When will you be enabling more devices?  If the answer is 'never',
> then creating an MFD is a waste of time.

Vinod Koul is exploring this and ATM we are trying to sort out the hw 
setup. Hopefully we should be sorted with Qcom help!


> 
>>> [...]
>>>
>>>>>> +	struct device_node *ifc_dev_np;
>>>>> ifc isn't very forthcoming.  Any way you can improve the name?
>>>> ifc was suggested in dt bindings by Rob,  I can proably rename to
>>>> interface_node.
>>> ifc is a horrible variable name - just sayin'.
>>>
>>> [...]
>>>
>>>>>> +	ret = wcd9335_bring_up(wcd);
>>>>> So the device_status call-back brings up the hardware?
>>>>>
>>>> device status reports the device status at runtime. We can not communicate
>>>> with the device until it is up, enumerated by slimbus and a logical address
>>>> is assigned to it. So the best place to initialize it is in status callback
>>>> where all the above are expected to be done.
>>> Right, I understand what's happening.  I just think the semantics are
>>> wrong.  The Subsystem (I'm assuming it's a Subsystem) requests for
>>> status and it ends up initiating a start-up sequence.  Just from a
>>> purist's point of view (I understand that it "works"), it's not good
>>> practice.
>>>
>>>> Probe is expected to setup the external configurations like regulators/pins
>>>> and so on which gets the device out of reset and ready to be enumerated by
>>>> the slimbus controller.
>>> I suggest fully starting the device in probe() is a better approach.
>>>
>> Its catch-22 situation, without device being powered up and reset correctly
>> there is no way to enumerate it.
> Isn't power-up and reset also done in probe()?
> 
> What am I missing?

There are two parts for device to be ready to talk at bus level:
1> power up and reset,
2> enumerate and assign a logical address by the slimbus controller.

First part as you said is already done in probe.
When second part happens when status callback is invoked, that is when 
the slimdevice is ready for any kind of communication at bus level.

--srini
> 
