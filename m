Return-Path: <preid@electromag.com.au>
X-Google-Smtp-Source: AIpwx49SrYn0GTpMkW5mSm7v9wP1NuLEsdOsXVjibkhhuhOld1b8zZKlBixQVO8w+/jIJ9CQ0jiB
ARC-Seal: i=1; a=rsa-sha256; t=1522204160; cv=none;
        d=google.com; s=arc-20160816;
        b=MQl5emVWw1Zs65o3jvGRRSV/6sKxvq3lIS4/nGqiVFYhVSXOwcnRfEIunSXKXxFBix
         l3y/ewyRx4wroI9aOd9B+gTibTQNJeRa/i3x4wg9srq3pTndL2sHgIehuI8Y3AkSUzO5
         AgpWUTByMqnQdmHz6LzI9wrrSrjiEPqFcXrML9fd4Vs7+CLNB5bKj239txL9TjqbKd0R
         09jW1d6xJeRL4PgRmuZbQ3F7ZrWcIk2QpRYDJm2MTNjD/mDT7z+4kGizzHK0fZdtz0VV
         xVEf600suzeExD50lMIpRTeYJYMrh9Wtt0uaQM/zXgxOUDQpQ75HOpHWnoeqdniRwmEJ
         E+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=+GGowhwJ7LCkZp8NHvzo3mdqFZkv7x+Df+1sHiOHafk=;
        b=gv50DhKgKUk3NWdeoCsensSq1Q5LVpAiTtZHHvL1cA016sdXSFyXof/qXnp7bZseUX
         fgkhroJe0OHGMT1/QLNqBEvB5BaG1G8tVmkzrRx8tOwrKbEMH5x1kB9QGtM9l/Al8ADT
         j5Lho55sp0HtPkDoNyCBuGaVzBNcdrV/V3H1dGWnoGwvf2a+5HzWaIlKQ+poRnRV7YtM
         jBPQ2AWNj0dQhhIClj2Ue25tbbeH4JALBBcKyPWCHLvFJKEtpi3PAHBCnVFxlBTG2mc8
         ryNYng5MiZwkNB/Gk5/dstfhdXjypYgSJkawzMOO2yFm9ypB86Omzdfd/rPHIB1RMHAw
         8HPg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=neutral (google.com: 203.30.46.146 is neither permitted nor denied by best guess record for domain of preid@electromag.com.au) smtp.mailfrom=preid@electromag.com.au
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 203.30.46.146 is neither permitted nor denied by best guess record for domain of preid@electromag.com.au) smtp.mailfrom=preid@electromag.com.au
Subject: Re: [PATCH 2/3] dt-bindings: iio: wrapper: add
 io-channel-unit-converter
To: Peter Rosin <peda@axentia.se>, Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
  Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
  Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
  Mark Rutland <mark.rutland@arm.com>,
  "David S. Miller" <davem@davemloft.net>,
  Mauro Carvalho Chehab <mchehab@kernel.org>,
  Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
  Linus Walleij <linus.walleij@linaro.org>,
  Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
  devicetree@vger.kernel.org
References: <20180319170246.26830-1-peda@axentia.se>
 <20180319170246.26830-3-peda@axentia.se>
 <20180326222326.sxdeawy5x5bjkla4@rob-hp-laptop>
 <986a7404-e157-6a1b-0610-07d1e127465f@axentia.se>
From: Phil Reid <preid@electromag.com.au>
Message-ID: <69103fe3-c5dd-7987-abf4-8759b2219751@electromag.com.au>
Date: Wed, 28 Mar 2018 10:29:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <986a7404-e157-6a1b-0610-07d1e127465f@axentia.se>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-AU
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386352511078978?=
X-GMAIL-MSGID: =?utf-8?q?1596146748758406464?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 27/03/2018 16:01, Peter Rosin wrote:
> On 2018-03-27 00:23, Rob Herring wrote:
>> On Mon, Mar 19, 2018 at 06:02:45PM +0100, Peter Rosin wrote:
>>> Allow linear scaling and modification of the type of an io-channel.
>>>
>>> When an ADC channel measures the midpoint of a voltage divider, the
>>> interesting voltage is often the voltage over the full resistance
>>> of the divider. Likewise, measuring the voltage over a resistor is
>>> often a way to get to the current through it.
>>>
>>> This binding allows description of such hardware which is external
>>> to the ADC.
>>>

*snip*

>>> +++ b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>> @@ -0,0 +1,84 @@
>>> +I/O channel unit converter bindings
>>> +
>>> +Allow linear scaling and modification of the type of an io-channel.
>>> +
>>> +When an ADC channel measures the midpoint of a voltage divider, the
>>> +interesting voltage is often the voltage over the full resistance
>>> +of the divider. Likewise, measuring the voltage over a resistor is
>>> +often a way to get to the current through it.
>>> +
>>> +Required properties:
>>> +- compatible : "io-channel-unit-converter"
>> Would this apply to something besides ADCs?
> Not that I can think of. At the moment.
> 

I like the concept. I can think of use case on my end to set a RADC (digital pot)
to set a threshold voltage. Being able to define the hardware scaling in the dt would be nice.
Which would allow all the hardware definition to be in the dt which would nice.
So this would be voltage -> resistance.

Setting a DAC voltage to set output current is also a distinct possibility.


-- 
Regards
Phil Reid
