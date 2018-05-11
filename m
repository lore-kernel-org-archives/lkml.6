Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeEKNfk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 09:35:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:36288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752983AbeEKNfh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 09:35:37 -0400
X-Google-Smtp-Source: AB8JxZqy11yIKJB7R7uc2+NGUO1MrpyMiDl9Pk5oIzbg9kK7LnSSLWJrHAjCmQ/XO+c9M+5Fst1mYkRpGvMnBsp4aLM=
MIME-Version: 1.0
In-Reply-To: <CAPoXtQK2s-G3sPHOQQcEQe+O9LGBWBv3Jrsy_NTVNo_nAtd1bg@mail.gmail.com>
References: <20180505213448.8180-1-andrea.greco.gapmilano@gmail.com>
 <20180508161636.GA23960@rob-hp-laptop> <CAPoXtQK2s-G3sPHOQQcEQe+O9LGBWBv3Jrsy_NTVNo_nAtd1bg@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 11 May 2018 08:35:15 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLU9EMKWTgLSuW-xekEmfOXfpAYtLpxXXp25AidSg7ejA@mail.gmail.com>
Message-ID: <CAL_JsqLU9EMKWTgLSuW-xekEmfOXfpAYtLpxXXp25AidSg7ejA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] arcnet: com20020: Add memory map of com20020
To: Andrea Greco <andrea.greco.gapmilano@gmail.com>
Cc: Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Andrea Greco <a.greco@4sigma.it>, Mark Rutland <mark.rutland@arm.com>,
        netdev <netdev@vger.kernel.org>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 11, 2018 at 5:50 AM, Andrea Greco
<andrea.greco.gapmilano@gmail.com> wrote:
> On 05/08/2018 06:16 PM, Rob Herring wrote:
>> On Sat, May 05, 2018 at 11:34:45PM +0200, Andrea Greco wrote:
>>> From: Andrea Greco <a.greco@4sigma.it>
>>>
>>> Add support for com20022I/com20020, memory mapped chip version.
>>> Support bus: Intel 80xx and Motorola 68xx.
>>> Bus size: Only 8 bit bus size is supported.
>>> Added related device tree bindings
>>>
>>> Signed-off-by: Andrea Greco <a.greco@4sigma.it>
>>> ---
>>>   .../devicetree/bindings/net/smsc-com20020.txt      |  23 +++
>>
>> Please split bindings to separate patch.
>
> Ok
>>
>>>   drivers/net/arcnet/Kconfig                         |  12 +-
>>>   drivers/net/arcnet/Makefile                        |   1 +
>>>   drivers/net/arcnet/arcdevice.h                     |  27 ++-
>>>   drivers/net/arcnet/com20020-membus.c               | 191 +++++++++++++++++++++
>>>   drivers/net/arcnet/com20020.c                      |   9 +-
>>>   6 files changed, 253 insertions(+), 10 deletions(-)
>>>   create mode 100644 Documentation/devicetree/bindings/net/smsc-com20020.txt
>>>   create mode 100644 drivers/net/arcnet/com20020-membus.c
>>>
>>> diff --git a/Documentation/devicetree/bindings/net/smsc-com20020.txt b/Documentation/devicetree/bindings/net/smsc-com20020.txt
>>> new file mode 100644
>>> index 000000000000..39c5b19c55af
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/net/smsc-com20020.txt
>>> @@ -0,0 +1,23 @@
>>> +SMSC com20020, com20022I
>>
>> What does this device do?
>>
>
> Changed in:
> SMSC com20020 Arcnet network controller
>
>>> +
>>> +timeout: Arcnet timeout, checkout datashet
>>> +clockp: Clock Prescaler, checkout datashet
>>
>> s/datashet/datasheet/
>>
>>> +clockm: Clock multiplier, checkout datasheet
>>
>> Would these 3 properties be common for arcnet devices? If not, then they
>> should have a vendor prefix.
>>
>
> Timeout is arcnet propelty:
> Other is smsc params, then become:
> - timeout: Arcnet timeout

Needs unit suffix as defined in property-units.txt.

> - smsc-clockp: Clock Prescaler
> - smsc-clockm: Clock multiplier
> - smsc-backplane: Controller use backplane mode inside of transceiver

Vendor properties are <vendor>,<prop-name>.

>
> I forget backplane propelty, but is required
>
>>> +
>>> +phy-reset-gpios: Chip reset ppin
>>
>> Use 'reset-gpios' as that is standard.
>>
>>> +phy-irq-gpios: Chip irq pin
>>
>> Use 'interrupts'. Interrupt capable gpio controllers are also interrupt
>> controllers.
>>
>
> Ok, change to standard
>
>>> +
>>> +com20020_A@0 {
>>
>> Node names should be generic based on the class of device. I don't think
>> we have one defined, but how about 'arcnet'.
>>
>> Unit addresses must have a corresponding reg property. How is this
>> device accessed?
>>
>
> Then: arcnet@28000000
>
>>> +    compatible = "smsc,com20020";
>>
>> Not documented.
>>
> I miss something? Where add this doc?
> Is not this file?

Yes, this file up above with all the other properties. The example is
just an example, not a binding definition.

Rob
