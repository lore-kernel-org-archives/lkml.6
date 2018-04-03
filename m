Return-Path: <afd@ti.com>
X-Google-Smtp-Source: AIpwx4+MJTyK0gRPuWNGKc7EmIt/2LWamq7Cm7ReKLk6YIssK8COLD8v0tpWQDoSszx5orcdGZxr
ARC-Seal: i=1; a=rsa-sha256; t=1522781789; cv=none;
        d=google.com; s=arc-20160816;
        b=a/SNtVIK9wesT7bj+cGp6fMV+EjuIQOiPSTtmCVc5gl6GMwWRkAftvnGLJc65tSh5m
         M9u3IH0h0fKGA+i+yUn4OheFZhT5b1szNAfIps0DGMZh0Jz+XEwQnIsoJwjqfZNkNZNb
         SEwhEtVTYAVqrwXvxTh+mqThzwWwsi/5h20mzvl/nm8Mc0J4sMgXPH+G3izZvMF2W+Xe
         BNKifnatxmqt0qT6NfnRSEItsBa4LOb2bI7yXRnok7Gss+8JDw2y27z03SqICbwt4WHY
         TnJsHZiXqSLhDH6AaoD9Kw4xqnKu+AfF44lDYdZ9j50eEreRKUOkXcioHkBk+GnDs3FB
         SDUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=MGA6KHRNzyL2QMCzjcuIU+rrjGdFDTAbWP1I+iRc5u4=;
        b=bdeD8wyptSnHYr8lxBuQDVNC4q30JskIgkS0L0R1GUEZ5F70Z7XbLSu/AOFblpgbT3
         +2ZYm3sY/Ny9a/9e9E6XGYeNP8fMMQiPS3hX0QnD5kCo1uhcVX6X9INwi5nkIdlHc9Xm
         5iVb8+y1jyuwyDEQBzvnwbaYBLCBJhixFzyhOJrh1IrGJ9JcAcwI5zafGEB+Y5Io0Cfl
         ERd0BFY09VL9/V55jhOptUyOAol8065x0s/jdnRyCp62Fi8rdOdeE+9SzkK75h3h3ION
         /SPn2JTwNPsfexUlWoFC1owdC0dQKCwGlY2naDkFfx9FARq+pby1uxcDyZ+PfK3EC52B
         173w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=E8Ta4UWq;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=E8Ta4UWq;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.19.16 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH v2 0/2] iio: add unit converter
To: Peter Rosin <peda@axentia.se>, <linux-kernel@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland
	<mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro
 Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap
	<rdunlap@infradead.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        Phil Reid <preid@electromag.com.au>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20180403153635.8228-1-peda@axentia.se>
 <93a6f7fc-4a53-c65c-422c-1649732fed50@ti.com>
 <5c18fa2a-0b10-5365-4868-ead6b61b45b2@axentia.se>
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <05f62c0d-4088-dfd1-4a6a-f3ed308824d7@ti.com>
Date: Tue, 3 Apr 2018 13:55:52 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5c18fa2a-0b10-5365-4868-ead6b61b45b2@axentia.se>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1596739875121160497?=
X-GMAIL-MSGID: =?utf-8?q?1596752437876295312?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/03/2018 01:09 PM, Peter Rosin wrote:
> On 2018-04-03 19:41, Andrew F. Davis wrote:
>> On 04/03/2018 10:36 AM, Peter Rosin wrote:
>>> Hi!
>>>
>>> This driver implements support for voltage dividers and current
>>> sense circuits. It's pretty generic and should be easily adaptable
>>> to other linear scaling purposes...
>>>
>>
>> I really like this idea, defining channel scaling / channel type
>> conversion in DT will be very useful. So much so that I would recommend
>> this not be a use specific driver but instead moved into the IIO core.
>>
>> This would allow defining these channel conversions in the device node
>> itself, so as to not need a separate node just for the converter (the
>> conversion is not a device and probably should not have it's own node
>> anyway). It would also help with enabling this support for buffered
>> readers/writers and not just devices only supporting _raw reads/writes.
> 
> In my case, the voltage dividers and the current sense circuit are very
> much real, and I can point my finger at them on the board. Sure, they
> are not ICs, but to not call them devices is wrong IMHO, and the ADC
> which is involved have very little to do with the voltage dividers and
> the fact that it is involved in sensing current. 


I would argue support resistors are still part of the "current sensing
device", even if they are physically external to the ADC IC. As you say
though, it doesn't really matter that much to this discussion.


> This is not an argument
> for not moving the functionally to the core though, but that has some
> problems AFAICT. Because you need some kind of clever and generic
> binding to make the core do its thing, and it might not be easy to come
> up with something that fits all devices? And if we do put this in the
> core, that opens the door for more complex unit converters later on
> (non-linear etc), further complicating the generic bindings.
> 


For the simple case of linear scaling of the channel input/output, and
type conversion I don't see much problem. They will not need to be
extended, new bindings can be added for more complex cases. When more
complex cases show up additional bindings will be needed either way.


> That said, I'm obviously biased since I want this to get in sooner
> rather than later...
> 


Adding this functionality to the IIO core doesn't really block this
patch-set, it will just make this patch-set unneeded in the future
if/when support goes into the core..

Andrew


> Cheers,
> Peter
> 
