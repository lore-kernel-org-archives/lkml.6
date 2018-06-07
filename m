Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id icUoAesIGVulVwAAmS7hNA
	; Thu, 07 Jun 2018 10:30:43 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0280B608B8; Thu,  7 Jun 2018 10:30:43 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 6E49660452;
	Thu,  7 Jun 2018 10:30:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6E49660452
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=microchip.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753561AbeFGKak (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 06:30:40 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23818 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750905AbeFGKai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 06:30:38 -0400
X-IronPort-AV: E=Sophos;i="5.49,486,1520924400";
   d="scan'208";a="14946588"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 07 Jun 2018 03:30:31 -0700
Received: from [10.145.4.77] (10.10.76.4) by chn-sv-exch04.mchp-main.com
 (10.10.76.105) with Microsoft SMTP Server id 14.3.352.0; Thu, 7 Jun 2018
 03:30:30 -0700
Subject: Re: [PATCH v4 1/7] dt-bindings: clk: at91: add an I2S mux clock
To: Rob Herring <robh@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Mark Brown <broonie@kernel.org>
CC: <devicetree@vger.kernel.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        <Cristian.Birsan@microchip.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
References: <1527251668-31396-1-git-send-email-codrin.ciubotariu@microchip.com>
 <1527251668-31396-2-git-send-email-codrin.ciubotariu@microchip.com>
 <20180531005827.GA17203@rob-hp-laptop>
 <4f2e6e6a-df3a-b645-093c-b4467b3aa843@microchip.com>
 <CAL_JsqJ=T0p17hHg6=obtydt7T-yrAeOr7C2XAEnDFQ-c0b5XQ@mail.gmail.com>
 <152778070837.144038.4555982304713569160@swboyd.mtv.corp.google.com>
 <CAL_JsqJu6=ORfutZ5tAyNp2q2rH6P+fgJMRKw750RyFy=ptjPw@mail.gmail.com>
From: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Message-ID: <18f6871e-794d-3ea2-487e-32399a8b89b4@microchip.com>
Date: Thu, 7 Jun 2018 13:30:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAL_JsqJu6=ORfutZ5tAyNp2q2rH6P+fgJMRKw750RyFy=ptjPw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31.05.2018 18:56, Rob Herring wrote:
> On Thu, May 31, 2018 at 10:31 AM, Stephen Boyd <sboyd@kernel.org> wrote:
>> Quoting Rob Herring (2018-05-31 07:20:57)
>>> On Thu, May 31, 2018 at 5:25 AM, Codrin Ciubotariu
>>> <codrin.ciubotariu@microchip.com> wrote:
>>>> On 31.05.2018 03:58, Rob Herring wrote:
>>>>>
>>>>> On Fri, May 25, 2018 at 03:34:22PM +0300, Codrin Ciubotariu wrote:
>>>>>>
>>>>>> The I2S mux clock can be used to select the I2S input clock. The
>>>>>> available parents are the peripheral and the generated clocks.
>>>>>>
>>>>>> Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
>>>>>> ---
>>>>>>    .../devicetree/bindings/clock/at91-clock.txt       | 34
>>>>>> ++++++++++++++++++++++
>>>>>>    1 file changed, 34 insertions(+)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/clock/at91-clock.txt
>>>>>> b/Documentation/devicetree/bindings/clock/at91-clock.txt
>>>>>> index 51c259a..1c46b3c 100644
>>>>>> --- a/Documentation/devicetree/bindings/clock/at91-clock.txt
>>>>>> +++ b/Documentation/devicetree/bindings/clock/at91-clock.txt
>>>>>> @@ -90,6 +90,8 @@ Required properties:
>>>>>>          "atmel,sama5d2-clk-audio-pll-pmc"
>>>>>>                  at91 audio pll output on AUDIOPLLCLK that feeds the PMC
>>>>>>                  and can be used by peripheral clock or generic clock
>>>>>> +       "atmel,sama5d2-clk-i2s-mux":
>>>>>> +               at91 I2S clock source selection
>>>>>
>>>>>
>>>>> Is this boolean or takes some values. If latter, what are valid values?
>>>>
>>>>
>>>> This is the compatible string of the clock driver.
>>>
>>> Ah, now I remember. AT91 uses fine grained clock nodes in DT. Is there
>>> still a plan to fix this?
>>
>> I'm also interested in a plan.
>>
>>>>>
>>>>>> +               compatible = "atmel,sama5d2-clk-i2s-mux";
>>>>>> +               #address-cells = <1>;
>>>>>> +               #size-cells = <0>;
>>>>>
>>>>>
>>>>> How do you address this block? My guess is you don't because it is just
>>>>> part of some other block and you are just creating this node to
>>>>> instantiate a driver. Just make the node for the actual h/w block a
>>>>> clock provider and define the clock ids (0 and 1).
>>>>
>>>>
>>>> This block is not addressed, but its children are. The register we access in
>>>> this driver is not part of other block. It's a SFR register, accessed
>>>> through syscon and it has nothing to do with the I2S IP (see SAMA5D2 DS,
>>>> page 1256, fig. 44-1: I2SC Block Diagram) that is the consumer of this
>>>> clock. Adding a clock-id property in the I2S node would be just like v3 of
>>>> this series, with the difference that we use clock-id instead of alias id to
>>>> set the clock parent, which is not how you suggested back then.
>>>
>>> I wasn't suggesting a clock-id property, but a clock specifier (i.e.
>>> make #clock-cells 1).
>>>
>>> But AT91 clocks are all a mess, so I don't know what to tell you.
>>>
>>
>> If #clock-cells of 1 works then we should go with that. It's still weird
>> that we need random nodes to add more clks, but I guess that's how it's
>> going to be for each at91 clk driver until it changes to be one big
>> provider node.
> 
> Seems to me that clock additions could use a new binding and we start
> with a new driver that handles these few clocks initially. But I
> haven't looked whether both can coexist.

Mark already applied to broonie/sound.git the I2S bindings that have a 
phandle to this clock. If I am to change #clock-cells to 1, I will have 
to change the bindings to include the clock-id.
Which approach should I take now?

Thanks and best regards,
Codrin
