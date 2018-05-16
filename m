Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752146AbeEPVPr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 17:15:47 -0400
Received: from mail.micronovasrl.com ([212.103.203.10]:55710 "EHLO
        mail.micronovasrl.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751389AbeEPVPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 17:15:45 -0400
Authentication-Results: mail.micronovasrl.com (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=micronovasrl.com
X-Spam-Flag: NO
X-Spam-Score: -2.9
Subject: Re: [PATCH v5 4/4] rtc: ds1307: add frequency_test_enable sysfs
 attribute to check tick on m41txx
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-rtc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180516103251.74707-1-giulio.benetti@micronovasrl.com>
 <20180516103251.74707-4-giulio.benetti@micronovasrl.com>
 <CAHp75VdC74jW+Vox2ogDVzG17Z3kD0Vg-1du4SeK30WajT7N-Q@mail.gmail.com>
 <836407b4-8c51-5efa-8e29-f487bbcb528d@micronovasrl.com>
 <20180516211001.GC24496@piout.net>
From: Giulio Benetti <giulio.benetti@micronovasrl.com>
Message-ID: <b6e9be1c-3f69-cec9-909b-48d8167a2a54@micronovasrl.com>
Date: Wed, 16 May 2018 23:15:43 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180516211001.GC24496@piout.net>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Language: it
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Il 16/05/2018 23:10, Alexandre Belloni ha scritto:
> On 16/05/2018 23:02:16+0200, Giulio Benetti wrote:
>>>> +static ssize_t frequency_test_enable_show(struct device *dev,
>>>> +                                         struct device_attribute *attr,
>>>> +                                         char *buf)
>>>> +{
>>>
>>>> +       int freq_test_en = 0;
>>>
>>>> +       if (ctrl_reg & M41TXX_BIT_FT)
>>>> +               freq_test_en = true;
>>>> +       else
>>>> +               freq_test_en = false;
>>>> +
>>>> +       return sprintf(buf, "%d\n", freq_test_en);
>>>
>>> So, is it boolean or integer? This code makes it confusing a lot.
>>
>> It is a boolean, so now I've updated with this:
>>
>> if (ctrl_reg & M41TXX_BIT_FT)
>> 	return scnprintf(buf, PAGE_SIZE, "on\n");
>> else
>> 	return scnprintf(buf, PAGE_SIZE, "off\n");
>>
> 
> No, it has to be consistent with what you write.
> 
> Here, you'd write 0 or 1 in the file and read off or on...

I'm submitting too many patches, without waiting, sorry.
I've submitted v6 patchset(too early), can you please take a look there 
and tell if I'm on the right path? On that I've change also _store 
function with kstrtobool().

I'm sorry I'm doing so much confusion.
I'm trying to learn to make it the best way.

> 
> 
