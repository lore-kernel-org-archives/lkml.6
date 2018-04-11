Return-Path: <afd@ti.com>
X-Google-Smtp-Source: AIpwx489dg50V5T6N4soVFcvp661x0BRrondb35qCxrx46R68DifWnp6ifWJzt5yEI3U320jhyGG
ARC-Seal: i=1; a=rsa-sha256; t=1523463228; cv=none;
        d=google.com; s=arc-20160816;
        b=Z73cfyQaGaCkZuPVlVIjCCl/17diU/aSDcN3S3v0WRjvbMcithpF2VeH2Ph0sov3L+
         /yvK425R1DGeeV9x8pTaJqIYubFdXtfowNIF+jW6mM8qGYiyd441GCx2NnkH9I9cTIzz
         8fyCzCs5rxH/0gbDLXmn8MBl6vt5Ky5UbZQvOVBp5yHvvbTgfSYTI4KwIJXeWROQB9Jz
         iWn3De4IcWCDma0h4uEnpTq8a7bI16od6pq/chO4r2TU0Htt/goOYrdo/e+tIe+zsHGn
         9iYJGlWvyKmEQ901osWXeOAWFwkkRBl8MMdAtmnO3Zt1hXm7yrIHBkpbsmj7r05vmbhy
         +nZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=R0UEnlfuCjWuAurEB+qUAojZJU/hl56t11H+ozBGfYQ=;
        b=LP8UjnRcerFWOmw5l8k9JGu4k7QJZs7S9xGd/ZorAHllZgVUJYgNgaNQD3FFEEsI+y
         cWob2GQJm4UoGBpNZD/t53d7yQBnHPa3gJfx4mm+2VRUUy4QPkzXtl5ui5LQFoZobLC8
         GOct635cJDFCus8J6gTUuH8vxW8Gz87zOkq88Rp8ZFQHDc8G5Cz1IVOjCv6S4H93kpE9
         nNjW6u5EbOpZHCKH8SErUQ8r45rAOVCZb0d7S9mopHG4ii+Y+BDVkReQ3POumA3s/pwr
         AS0LYku7UKVISjF4YBAhb6a1GfwzRPa8vJJAeWl/NF9/Ang+p7F8OKiwiwjTF5y11JoA
         xxuQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=cnk4khzJ;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=cnk4khzJ;
       spf=pass (google.com: domain of afd@ti.com designates 198.47.27.77 as permitted sender) smtp.mailfrom=afd@ti.com;
       dmarc=pass (p=QUARANTINE sp=NONE dis=NONE) header.from=ti.com
Subject: Re: [PATCH 2/2] iio: afe: unit-converter: add support for adi,lt6106
To: Lars-Peter Clausen <lars@metafoo.de>, Peter Rosin <peda@axentia.se>,
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
From: "Andrew F. Davis" <afd@ti.com>
Message-ID: <19aeb920-ce5a-4e81-1264-9005e220c237@ti.com>
Date: Wed, 11 Apr 2018 11:13:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <5d9421cc-5c7b-fcdf-a11f-e97127a3d5bd@metafoo.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597459598272065653?=
X-GMAIL-MSGID: =?utf-8?q?1597466978318522809?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/11/2018 10:51 AM, Lars-Peter Clausen wrote:
> On 04/11/2018 05:43 PM, Andrew F. Davis wrote:
>> On 04/11/2018 09:15 AM, Peter Rosin wrote:
>>> This is a current sense amplifier from Analog Devices.
>>>
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  drivers/iio/afe/Kconfig              |  3 +-
>>>  drivers/iio/afe/iio-unit-converter.c | 54 ++++++++++++++++++++++++++++++++++++
>>>  2 files changed, 56 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/iio/afe/Kconfig b/drivers/iio/afe/Kconfig
>>> index 642ce4eb12a6..0e10fe8f459a 100644
>>> --- a/drivers/iio/afe/Kconfig
>>> +++ b/drivers/iio/afe/Kconfig
>>> @@ -10,7 +10,8 @@ config IIO_UNIT_CONVERTER
>>>  	depends on OF || COMPILE_TEST
>>>  	help
>>>  	  Say yes here to build support for the IIO unit converter
>>> -	  that handles voltage dividers and current sense shunts.
>>> +	  that handles voltage dividers, current sense shunts and
>>> +	  the LT6106 Current Sense Amplifier from Analog Devices.
>>
>> Could work better to split these out into separate drivers. Maybe a
>> iio-shunt-resistor.c that does just voltage->current with the
>> appropriate scaling. Then make a a separate lt6106.c.
> 
> I don't think we need a separate driver here. There are tons of circuits
> that all work the same way and all require the same properties. If we'd add
> a driver for each of them we'd get buried in boilerplate code.
> 

Fair enough, then it should at least be renamed to something generic
like current-sense-amplifier, as you said lots of circuits do this, not
just lt6106s. We will have then have support for:

current-sense-amplifier
current-sense-shunt
voltage-divider

compatibles in this driver called "unit-converter" which is still a
misnomer IMHO.

Andrew
