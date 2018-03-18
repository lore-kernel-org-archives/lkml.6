Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754151AbeCRPYM (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 11:24:12 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.228]:16978 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754127AbeCRPYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 11:24:05 -0400
Subject: Re: [PATCH v4 1/3] dt-bindings: pinctrl: bcm2835-gpio: Add generic
 pinctrl support
To: Rob Herring <robh@kernel.org>
Cc: stefan.wahren@i2se.com, eric@anholt.net, linus.walleij@linaro.org,
        mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <483687035.384686.1520596004410@email.1und1.de>
 <1520615640-9153-1-git-send-email-matheus@castello.eng.br>
 <1520615640-9153-2-git-send-email-matheus@castello.eng.br>
 <20180318124820.xea5etlb3wu7wnpw@rob-hp-laptop>
From: Matheus Castello <matheus@castello.eng.br>
Message-ID: <f500b25c-eea0-9f01-7d7b-5a9dd90c50fa@castello.eng.br>
Date: Sun, 18 Mar 2018 11:23:49 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180318124820.xea5etlb3wu7wnpw@rob-hp-laptop>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - br164.hostgator.com.br
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - castello.eng.br
X-BWhitelist: no
X-Source-IP: 191.189.21.134
X-Source-L: No
X-Exim-ID: 1exaAE-000GDJ-Dr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.0.11]) [191.189.21.134]:4439
X-Source-Auth: matheus@castello.eng.br
X-Email-Count: 6
X-Source-Cap: Y2FzdGUyNDg7Y2FzdGUyNDg7YnIxNjQuaG9zdGdhdG9yLmNvbS5icg==
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

sorry I used allwinner,sunxi-pinctrl.txt from Maxime Ripard as a base, I 
used the same words, I thought it would be correct.

I will modify this to:

The BCM2835 pin configuration and multiplexing supports the generic 
bindings. For details on each properties, you can refer to
./pinctrl-bindings.txt.

If it's okay for you let me know, so I can send the v5 patch.

Best Regards
Matheus Castello


On 03/18/2018 08:48 AM, Rob Herring wrote:
> On Fri, Mar 09, 2018 at 01:13:58PM -0400, Matheus Castello wrote:
>> Added generic pin configuration and multiplexing support,
>> and shoud be preferred than brcm legacy one.
>>
>> Signed-off-by: Matheus Castello <matheus@castello.eng.br>
>> ---
>>   .../devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
>> index 2569866..58b4720 100644
>> --- a/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
>> +++ b/Documentation/devicetree/bindings/pinctrl/brcm,bcm2835-gpio.txt
>> @@ -36,6 +36,25 @@ listed. In other words, a subnode that lists only a mux function implies no
>>   information about any pull configuration. Similarly, a subnode that lists only
>>   a pul parameter implies no information about the mux function.
>>   
>> +This driver supports the generic pin multiplexing and configuration
> 
> Bindings describe h/w, not drivers.
> 
>> +bindings. For details on each properties, you can refer to
>> +./pinctrl-bindings.txt.
>> +
>> +Required sub-node properties:
>> +  - pins
>> +  - function
>> +
>> +Optional sub-node properties:
>> +  - bias-disable
>> +  - bias-pull-up
>> +  - bias-pull-down
>> +  - output-high
>> +  - output-low
>> +
>> +Legacy pin configuration and multiplexing binding:
>> +*** (Its use is deprecated, use generic multiplexing and configuration
>> +bindings instead)
>> +
>>   Required subnode-properties:
>>   - brcm,pins: An array of cells. Each cell contains the ID of a pin. Valid IDs
>>     are the integer GPIO IDs; 0==GPIO0, 1==GPIO1, ... 53==GPIO53.
>> -- 
>> 2.7.4
>>
