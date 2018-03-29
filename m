Return-Path: <robh@kernel.org>
X-Google-Smtp-Source: AIpwx49pAG64Rf03k79QCpnUAWFyPgl+MJWXvqZF4r2s1oYo33JwelM5JJpcm0AicGStPtoKjHGN
ARC-Seal: i=1; a=rsa-sha256; t=1522331756; cv=none;
        d=google.com; s=arc-20160816;
        b=rGK0DCuZKGrgR/c4VCnh11WEVUog5aGDUbI86TgGTh1OeXcqZQ4iBwYksrJ0WGoZD4
         qC0B3c0G0SUuFe7wsZTFUW9bbQ15nO8etM1RkyAJ6G8zUS5YzYa0yyjmMzkus/UNactD
         Vc/l5yMSURH+OgYbiL8jUJ0yp73vcpemSlLb0IKdwU4loW8EmfUnxtLzYVfOKCbZk9Qx
         /F5XzaINJPyFDXNKvSYFgDF8GKNBEZxsCqhR1Em/v87Uo4CsRhRh/nMiFDcuVMXIQ7Y2
         0LGVcTWDpA/nOvG7wFvRse9+idTgRBHAcyrgLrJUIzAGk7JAWkuAV6BOIlVkGCpBxb6l
         bJ1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dmarc-filter:arc-authentication-results;
        bh=9an9QWHyNn9FsgZAf7veCL6LcM13th3cGI6l4TU0nXg=;
        b=Idw2nFlk2ewFUWAibabuNItmnBWjCw7f2tL9CH8Wu5IMChfWXoZMnbtnhOyLhWNIeU
         /SZZJj3ZiTdutXAUmU5b4nLtGBz/pklGIB7zKLuXkgHkbLRkotRCA9Q6WmJZjFIdkkpI
         ec0VanolmLat5kWuGWGUzuhL9+d5nvEjUgK0Rd1qXaSn2ObNP1KNYUgl7hwDwvH6JfRA
         cC/ObrpLAU0yC4Ib9dCTqKZmvHnyWCBBr6M3K0f0l3W8EvLo3R/lxh837XHCTv21golM
         B6sKPD+g2z7vD4tKCL44VCYaqnDo7azPqXavOIqM9EjlCu8qacslEnjoe4zNRIs62Swl
         shYA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of robh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=robh@kernel.org
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA77221836
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
MIME-Version: 1.0
In-Reply-To: <986a7404-e157-6a1b-0610-07d1e127465f@axentia.se>
References: <20180319170246.26830-1-peda@axentia.se> <20180319170246.26830-3-peda@axentia.se>
 <20180326222326.sxdeawy5x5bjkla4@rob-hp-laptop> <986a7404-e157-6a1b-0610-07d1e127465f@axentia.se>
From: Rob Herring <robh@kernel.org>
Date: Thu, 29 Mar 2018 08:55:34 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ3RZoMX+Q5boK-w3uHc=qgPCye7esXxJuwQcMM0HPLNw@mail.gmail.com>
Message-ID: <CAL_JsqJ3RZoMX+Q5boK-w3uHc=qgPCye7esXxJuwQcMM0HPLNw@mail.gmail.com>
Subject: Re: [PATCH 2/3] dt-bindings: iio: wrapper: add io-channel-unit-converter
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>, Mark Rutland <mark.rutland@arm.com>,
	"David S. Miller" <davem@davemloft.net>, Mauro Carvalho Chehab <mchehab@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linus Walleij <linus.walleij@linaro.org>,
	Randy Dunlap <rdunlap@infradead.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595386352511078978?=
X-GMAIL-MSGID: =?utf-8?q?1596280543691146199?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Mar 27, 2018 at 3:01 AM, Peter Rosin <peda@axentia.se> wrote:
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
>>> Signed-off-by: Peter Rosin <peda@axentia.se>
>>> ---
>>>  .../iio/wrapper/io-channel-unit-converter.txt      | 84 ++++++++++++++++++++++
>>>  MAINTAINERS                                        |  6 ++
>>>  2 files changed, 90 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt b/Documentation/devicetree/bindings/iio/wrapper/io-channel-unit-converter.txt
>>> new file mode 100644
>>> index 000000000000..23af661abe32
>>> --- /dev/null
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
>>
>> Would this apply to something besides ADCs?
>
> Not that I can think of. At the moment.
>
>>> +- io-channels : Channel node of the parent channel.
>>> +- io-channel-names : Should be "parent".
>>> +
>>> +Optional properties:
>>> +- numerator : The parent channel scale is multiplied by this value (default 1).
>>> +- denominator : The parent channel scale is divided by this value (default 1).
>>> +- type : The type of the wrapped channel is modified to this type. The default
>>> +     is to use the same type as the parent channel. Recognized types are:
>>> +            "voltage"
>>> +            "current"
>>
>> This seems overly complicated for just describing a couple of resistors
>> on an ADC. OTOH, keeping the ADC node and what's attached to the ADC
>> separate
>>
>> Perhaps the type should be part of the compatible. For example, if you
>> have a current measurement resistor/circuit, then the compatible should
>> be based on that.
>
> Is a compatible like "current-sense-circuit" too long(ish)?

No, that's fine.

> Is a vendor prefix absolutely required?

No, it can be common.

> Sure, I can use "axentia,"
> because we "implemented" the circuit this time, but it seems like
> the list can grow very long if we should add every vendor that
> may use something like this? Something more generic would be good
> for something as simple as this IMHO.
>
> I propose the compatible "voltage-divider" for the other example,
> but I have the same issue with the vendor prefix. Even more so
> in this case.

"voltage-divider" doesn't really say what the purpose is.
>
> Then the above type can be inferred from the compatible. I suppose
> I should write the above two bindings as two separate files?

One is fine if the only difference is the compatible.

>>> +
>>> +Example 1:
>>> +The system voltage is circa 12V, but divided down with a 22/200
>>> +voltage divider to adjust it to the ADC range.
>>> +
>>> +SYSV        ADC       GND
>>> +  +          +         +
>>> +  |  .-----. | .----.  |
>>> +  '--| 200 |-+-| 22 |--'
>>> +     '-----'   '----'
>>> +
>>> +sysv {
>>> +    compatible = "io-channel-unit-converter";
>>> +    io-channles = <&maxadc 1>;
>>> +    io-channel-names = "parent";
>>
>> parent doesn't seem to describe something about the h/w.
>
> Extrapolating from your first question, you are thinking "adc", right?

I don't really have any suggestion. With only 1 channel, there's not
really much point to having a name at all.

Rob
