Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751619AbeEPULq (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 16:11:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36958 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEPULo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 16:11:44 -0400
X-Google-Smtp-Source: AB8JxZoPNz1CIqWwuAUf7eWa1KNTxuB4PkEghqDMaS55CY2Fh9l5ZYHvOwxJOkvrECjvdiex+yNxIg==
Subject: Re: [PATCH v6 1/2] dt: bindings: lm3601x: Introduce the lm3601x
 driver
To: Dan Murphy <dmurphy@ti.com>, robh+dt@kernel.org, mark.rutland@arm.com,
        pavel@ucw.cz
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
References: <20180515154352.20263-1-dmurphy@ti.com>
 <98319f30-2abe-158c-1b51-33d1df80e185@gmail.com>
 <c72494c9-e513-f3d0-3098-83f47aa9367c@ti.com>
From: Jacek Anaszewski <jacek.anaszewski@gmail.com>
Message-ID: <03934462-13ef-59c0-aa27-01a003bf7baa@gmail.com>
Date: Wed, 16 May 2018 22:10:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <c72494c9-e513-f3d0-3098-83f47aa9367c@ti.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dan,

On 05/15/2018 11:29 PM, Dan Murphy wrote:
> Jacek
> 
> On 05/15/2018 04:13 PM, Jacek Anaszewski wrote:
>> Hi Dan,
>>
>> Thanks for the update.
>>
>> On 05/15/2018 05:43 PM, Dan Murphy wrote:
>>> Introduce the device tree bindings for the lm3601x
>>> family of LED torch, flash and IR drivers.
>>>
>>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
>>> ---
>>>
>>> v6 - Removed multiple led child nodes, fixed example to display micro ranges
>>> for corresponding child nodes and added led-sources to define the current driver -
>>> https://patchwork.kernel.org/patch/10392121/
>>>
>>> v5 - No changes - https://patchwork.kernel.org/patch/10391743/
>>> v4 - Added " " around "=", changed strobe to flash on label, removed "support and
>>> register" comment and change ir lable to ir:torch - See v2 patchworks for comments
>>> v3 - Removed wildcard compatible - https://patchwork.kernel.org/patch/10386241/
>>> v2 - No changes - https://patchwork.kernel.org/patch/10384587/
>>>
>>>    .../devicetree/bindings/leds/leds-lm3601x.txt | 47 +++++++++++++++++++
>>>    1 file changed, 47 insertions(+)
>>>    create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3601x.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/leds/leds-lm3601x.txt b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
>>> new file mode 100644
>>> index 000000000000..27930a89e9a5
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/leds/leds-lm3601x.txt
>>> @@ -0,0 +1,47 @@
>>> +* Texas Instruments - lm3601x Single-LED Flash Driver
>>> +
>>> +The LM3601X are ultra-small LED flash drivers that
>>> +provide a high level of adjustability.
>>> +
>>> +Required properties:
>>> +    - compatible : Can be one of the following
>>> +        "ti,lm36010"
>>> +        "ti,lm36011"
>>> +    - reg : I2C slave address
>>> +    - #address-cells : 1
>>> +    - #size-cells : 0
>>> +
>>> +Required child properties:
>>> +    - reg : 0
>>> +    - led-sources:    0 - Indicates a IR mode
>>> +            1 - Indicates a Torch (white LED) mode
>>
>> You don't need led-sources at all. Please use reg as in
>> the previous version. led-sources is useful for describing
>> more complex arrangements. Here reg will do.
> 
> OK.  Thought we would keep consistent with the max IC.
> 
>>
>>> +
>>> +Required properties for flash LED child nodes:
>>> +    See Documentation/devicetree/bindings/leds/common.txt
>>> +    - flash-max-microamp : Range from 11mA -> 1.5A
>>> +    - flash-max-timeout-us : Range from 40ms -> 1600ms
>>> +    - led-max-microamp : Range from 2.4mA -> 376mA
>>
>> Please give also a step in the format like below
>> (taken from max77693):
>>
>>      Valid values: 62500 - 1000000, step by 62500 (rounded down)
> 
> I would do this but the step is not linear.  The step is 40ms from 40 -> 400.
> after that the step goes to 200ms from 400->1600.
> 
> same with the current ranges.

If you're going to apply Andy's formula in the driver, then you can
present it also here. Anyway, please avoid using non-standard "->"
symbol in favor of "to" if you're using "from".

Or even better I propose to list allowed values - there are not
so many of them.

-- 
Best regards,
Jacek Anaszewski
