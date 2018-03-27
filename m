Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751713AbeC0I1q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 04:27:46 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39219 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751078AbeC0I1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 04:27:42 -0400
X-Google-Smtp-Source: AIpwx48tKC/AndY+4f4mDsXugVf/AFQgiW0O7F9keAFqFuRj/djEq0mXuUzJ5gN0H9wp0eDpinEoIg==
Subject: Re: [PATCH v6 1/3] dt-bindings: display: bridge: Document
 THC63LVD1024 LVDS decoder
To: jacopo mondi <jacopo@jmondi.org>, Andrzej Hajda <a.hajda@samsung.com>
Cc: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>,
        Jacopo Mondi <jacopo+renesas@jmondi.org>,
        Rob Herring <robh@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        architt@codeaurora.org, airlied@linux.ie, horms@verge.net.au,
        magnus.damm@gmail.com, geert@linux-m68k.org,
        niklas.soderlund@ragnatech.se, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1521213399-31947-1-git-send-email-jacopo+renesas@jmondi.org>
 <1521213399-31947-2-git-send-email-jacopo+renesas@jmondi.org>
 <4060923.7DxT9ae38L@avalon> <20180326222249.tvjiutyd4amlibpa@rob-hp-laptop>
 <CGME20180327061536epcas5p40faf6caf0d9825e6c33cd3e6ba9d8378@epcas5p4.samsung.com>
 <a1b0e678-38b8-dd29-b441-e2a09b565105@mentor.com>
 <1dd27170-153c-90f6-e13f-949ba7d0d4a9@samsung.com>
 <20180327073332.GI27746@w540>
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <70826dc1-d9ea-dc98-f591-c80f1904806a@cogentembedded.com>
Date: Tue, 27 Mar 2018 11:27:39 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180327073332.GI27746@w540>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 3/27/2018 10:33 AM, jacopo mondi wrote:
[...]
>>>>>> Document Thine THC63LVD1024 LVDS decoder device tree bindings.
>>>>>>
>>>>>> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
>>>>>> Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>
>>>>>> Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
>>>>>> ---
>>>>>>   .../bindings/display/bridge/thine,thc63lvd1024.txt | 66 +++++++++++++++++++
>>>>>>   1 file changed, 66 insertions(+)
>>>>>>   create mode 100644
>>>>>> Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>>>>
>>>>>> diff --git
>>>>>> a/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>>>> new file mode 100644
>>>>>> index 0000000..8225c6a
>>>>>> --- /dev/null
>>>>>> +++
>>>>>> b/Documentation/devicetree/bindings/display/bridge/thine,thc63lvd1024.txt
>>>>>> @@ -0,0 +1,66 @@
>>>>>> +Thine Electronics THC63LVD1024 LVDS decoder
>>>>>> +-------------------------------------------
>>>>>> +
>>>>>> +The THC63LVD1024 is a dual link LVDS receiver designed to convert LVDS
>>>>>> streams
>>>>>> +to parallel data outputs. The chip supports single/dual input/output modes,
>>>>>> +handling up to two two input LVDS stream and up to two digital CMOS/TTL
>>>>>> outputs.
>>>>>> +
>>>>>> +Single or dual operation modes, output data mapping and DDR output modes
>>>>>> are
>>>>>> +configured through input signals and the chip does not expose any control
>>>>>> bus.
>>>>>> +
>>>>>> +Required properties:
>>>>>> +- compatible: Shall be "thine,thc63lvd1024"
>>>>>> +
>>>>>> +Optional properties:
>>>>>> +- vcc-supply: Power supply for TTL output and digital circuitry
>>>>>> +- cvcc-supply: Power supply for TTL CLOCKOUT signal
>>>>>> +- lvcc-supply: Power supply for LVDS inputs
>>>>>> +- pvcc-supply: Power supply for PLL circuitry
>>>>> As explained in a comment to one of the previous versions of this series, I'm
>>>>> tempted to make vcc-supply mandatory and drop the three other power supplies
>>>>> for now, as I believe there's very little chance they will be connected to
>>>>> separately controllable regulators (all supplies use the same voltage). In the
>>>>> very unlikely event that this occurs in design we need to support in the
>>>>> future, the cvcc, lvcc and pvcc supplies can be added later as optional
>>>>> without breaking backward compatibility.
>>>> I'm okay with that.
>>>>
>>>>> Apart from that,
>>>>>
>>>>> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
>>>>>
>>>>>> +- pdwn-gpios: Power down GPIO signal. Active low
>>>> powerdown-gpios is the semi-standard name.
>>>>
>>> right, I've also noticed it. If possible please avoid shortenings in
>>> property names.
>>
>> It is not shortening, it just follow pin name from decoder's datasheet.
>>
>>>
>>>>>> +- oe-gpios: Output enable GPIO signal. Active high
>>>>>> +
>>> And this one is also a not ever met property name, please consider to
>>> rename it to 'enable-gpios', for instance display panels define it.
>>
>>
>> Again, it follows datasheet naming scheme. Has something changed in DT
>> conventions?
> 
> Seconded. My understanding is that the property name should reflect
> what reported in the the chip manual. For THC63LVD1024 the enable and
> power down pins are named 'OE' and 'PDWN' respectively.

    But don't we need the vendor prefix in the prop names then, like 
"renesas,oe-gpios" then?

> Thanks
>     j

MBR, Sergei
