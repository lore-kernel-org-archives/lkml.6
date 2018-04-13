Return-Path: <afd@ti.com>
X-Google-Smtp-Source: AIpwx48AG0Avk+GA3XYvN8xPhWAVGlvnR6KOsFafF02hPDqDCnzIIVq/mehoenMqiu9yBJQgVtH3
ARC-Seal: i=1; a=rsa-sha256; t=1523630878; cv=none;
        d=google.com; s=arc-20160816;
        b=YM/jM/NFOZu8TbD+hUOUXjXkF8d3CVRAQ+lTsE5wU4s3QM9QZUSfam3lzV4H8GzQP9
         IChs5I2uFMA3aoXKjgvtHaRhINGS639X28mikeHOmUZ6TF6XNeEuNlmaIVG0I6F14N98
         CxT1nndtITDUdiOt6dH8g4tlwT/oFqjoHl0UTKq2vyWwWk87xVlBZLTvkW2jVRWqbpmz
         MqLeKrjPZDcx9DB5N7IUlhTWs7Udc4xC9BFzk4m7Di9Nib1gRCT0q4gjsKLyYTjeCAf5
         kVPkdmUNrHNPEFXsvfGe1pN6XhcOoBdSwUutyqP8DRPXIV71CFRdrk6ykWoQFPMpZw4S
         Zn+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=DOzrMyOjQVJ3JzP5a6ssz5mniZ4SiFsNWiA/y2GKlrI=;
        b=ZYYLH4uA4cjr20lglwulAzuVKAi/Y+yQOuWgcyLgW2zJDdR2L6uLAjG29e9xhY6155
         03d/uHu6t0VVG8+xKprC1x8bIz/Igmg7LwfdVmXNbRx/jgkz5zmjr1EnvZM8Ej8WSxWC
         QMrzTl16P5OoN/jvtR2MXdAOZohlItj0+0AjClw1ileO9p3RioT+htJ8WMXEQGcDAVPe
         k3uhKdEMNSebyMtG9bp/eGFf5M8jVAMs9Lhf4WI7VlVXYE+cEqm/tOKJXIx1lqDZPecz
         6ZEncp6JddTsv/p4bVTQwLnCPY/Jk5g6eAY0FoWeuKN30i+HEAZ6VaKKf3bcDJp1AW5V
         OkmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Ctk54aLU;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Ctk54aLU;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.80 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: Peter Rosin <peda@axentia.se>, Lars-Peter Clausen <lars@metafoo.de>,
        <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mauro Carvalho Chehab
	<mchehab@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton
	<akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Fabio
 Estevam <festevam@gmail.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20180410152802.30958-1-peda@axentia.se>
 <20180411141555.15044-1-peda@axentia.se>
 <20180411141555.15044-3-peda@axentia.se>
 <a70e8467-d0da-2b37-5dfa-7e14b388634c@ti.com>
 <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
 <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
 <4aac6870-9159-18ba-0aa8-da227c426f38@axentia.se>
 <c2923ac0-5e28-eef0-e32a-1e25ce550a82@ti.com>
 <36e0c96b-89ec-2372-825a-71ead1a43473@axentia.se>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <d59697bb-60bf-deee-65b5-c552c59e8d5a@ti.com>
Date: Fri, 13 Apr 2018 09:47:30 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <36e0c96b-89ec-2372-825a-71ead1a43473@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597642772617434867?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/12/2018 05:31 PM, Peter Rosin wrote:
> On 2018-04-12 17:35, Andrew F. Davis wrote:
>> On 04/12/2018 09:29 AM, Peter Rosin wrote:
>>> On 2018-04-11 18:13, Andrew F. Davis wrote:
>>>> On 04/11/2018 10:51 AM, Lars-Peter Clausen wrote:
>>>>> On 04/11/2018 05:43 PM, Andrew F. Davis wrote:
>>>>>> On 04/11/2018 09:15 AM, Peter Rosin wrote:
>>>>>>> This is a current sense amplifier from Analog Devices.
>>>>>>>
>>>>>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>>>>>> ---
>>>>>>>  drivers/iio/afe/Kconfig              |  3 +-
>>>>>>>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>>>>>>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
>>>>>>> index 642ce4eb12a6..0e10fe8f459a 100644
>>>>>>> --- a/drivers/iio/afe/Kconfig
>>>>>>> +++ b/drivers/iio/afe/Kconfig
>>>>>>> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>>>>>>>  	depends on OF || COMPILE_TEST
>>>>>>>  	help
>>>>>>>  	  Say yes here to build support for the IIO unit converter
>>>>>>> -	  that handles voltage dividers and current sense shunts.
>>>>>>> +	  that handles voltage dividers, current sense shunts and
>>>>>>> +	  the LT6106 Current Sense Amplifier from Analog Devices.
>>>>>>
>>>>>> Could work better to split these out into separate drivers. Maybe a
>>>>>> iio-shunt-resistor.c that does just voltage->current with the
>>>>>> appropriate scaling. Then make a a separate lt6106.c.
>>>>>
>>>>> I don't think we need a separate driver here. There are tons of circuits
>>>>> that all work the same way and all require the same properties. If we'd add
>>>>> a driver for each of them we'd get buried in boilerplate code.
>>>>>
>>>>
>>>> Fair enough, then it should at least be renamed to something generic
>>>> like current-sense-amplifier, as you said lots of circuits do this, not
>>>> just lt6106s. We will have then have support for:
>>>>
>>>> current-sense-amplifier
>>>> current-sense-shunt
>>>> voltage-divider
>>>
>>> For the compatible "current-sense-amplifier", I would advocate the
>>> properties...
>>>
>>>  sense-resistor-micro-ohms
>>>  sense-gain
>>>
>>> (or something close to that)
>>>
>>> ...and not input-resistor-ohms and output-resistor-ohms which are way
>>> more particular to the LT6106.
>>>
>>> But as I said in the cover letter, I didn't go with sense-gain since I
>>> thought I would end up with requests for non-integer gains. There is
>>> yet to be a comment on the non-integer gain problem, and before there
>>> is a path forward for that case, I'm reluctant.
>>>
>>
>> Why not similar to what you had before with the resistor:
>>
>> sense-gain-multiplier
>> sense-gain-divider
>>
>> if either are missing assume they are 1.
> 
> Hmm, how about sense-gain for the normal integer case, and then divide
> by sense-attenuation if needed? I.e. exactly the same functionality as
> you describe, just different names.
> 

I like these names, but I think gain/attenuation sound very analog and I
would be tempted to assume they are floating point numbers or the units
are logarithmic (dB).

To prevent any more needless bike-shedding on my part I'd like to say
either yours, mine, or Lars-Peter's suggestion all work for me.

>>>> compatibles in this driver called "unit-converter" which is still a
>>>> misnomer IMHO.
>>>
>>> I don't remember you having presented your preference, and I think
>>> that goes against the established bike-shedding protocol?
>>>
>>
>> True, how about "current-sense-from-voltage" ?
> 
> Doesn't cover "voltage-divider" (and we don't need separate drivers
> doing the exact same calculations, that's a maintenance nightmare).
> 


The driver name doesn't have to cover every use, just more than the
other name.


> Cheers,
> Peter
> 
