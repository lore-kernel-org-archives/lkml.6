Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754437AbeBBSXX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 13:23:23 -0500
Received: from foss.arm.com ([217.140.101.70]:33498 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752470AbeBBRC2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 12:02:28 -0500
Subject: Re: [PATCH RFC v2 2/3] dt-bindings/interrupt-controller: pdc: descibe
 PDC device binding
To: Lina Iyer <ilina@codeaurora.org>
Cc: tglx@linutronix.de, jason@lakedaemon.net, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, sboyd@codeaurora.org,
        rnayak@codeaurora.org, asathyak@codeaurora.org,
        devicetree@vger.kernel.org
References: <20180202142200.6229-1-ilina@codeaurora.org>
 <20180202142200.6229-3-ilina@codeaurora.org>
 <396cfc2f-7deb-0c93-7178-d9f5524f110e@arm.com>
 <20180202164643.GC5319@codeaurora.org>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <35ce761e-c9ac-6280-cc72-eccd1dded609@arm.com>
Date: Fri, 2 Feb 2018 17:02:24 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180202164643.GC5319@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/02/18 16:46, Lina Iyer wrote:
> On Fri, Feb 02 2018 at 16:28 +0000, Marc Zyngier wrote:
>> On 02/02/18 14:21, Lina Iyer wrote:
>>> From: Archana Sathyakumar <asathyak@codeaurora.org>
>>>
>>> Add device binding documentation for the PDC Interrupt controller on
>>> QCOM SoC's like the SDM845. The interrupt-controller can be used to
>>> sense edge low interrupts and wakeup interrupts when the GIC is
>>> non-operational.
>>>
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Archana Sathyakumar <asathyak@codeaurora.org>
>>> Signed-off-by: Lina Iyer <ilina@codeaurora.org>
>>> ---
>>>  .../bindings/interrupt-controller/qcom,pdc.txt     | 78 ++++++++++++++++++++++
>>>  1 file changed, 78 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>>> new file mode 100644
>>> index 000000000000..7bf40cb6a4f8
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc.txt
>>> @@ -0,0 +1,78 @@
>>> +PDC interrupt controller
>>> +
>>> +Qualcomm Technologies Inc. SoCs based on the RPM Hardened architecture have a
>>> +Power Domain Controller (PDC) that is on always-on domain. In addition to
>>> +providing power control for the power domains, the hardware also has an
>>> +interrupt controller that can be used to help detect edge low interrupts as
>>> +well detect interrupts when the GIC is non-operational.
>>> +
>>> +GIC is parent interrupt controller at the highest level. Platform interrupt
>>> +controller PDC is next in hierarchy, followed by others. Drivers requiring
>>> +wakeup capabilities of their device interrupts routed through the PDC, must
>>> +specify PDC as their interrupt controller and request the PDC port associated
>>> +with the GIC interrupt. See example below.
>>> +
>>> +Properties:
>>> +
>>> +- compatible:
>>> +	Usage: required
>>> +	Value type: <string>
>>> +	Definition: Should contain "qcom,<soc>-pdc"
>>> +		    - "qcom,sdm845-pdc": For SDM845
>>> +
>>> +- reg:
>>> +	Usage: required
>>> +	Value type: <prop-encoded-array>
>>> +	Definition: Specifies the base physical address for PDC hardware.
>>> +
>>> +- interrupt-cells:
>>> +	Usage: required
>>> +	Value type: <u32>
>>> +	Definition: Specifies the number of cells needed to encode an interrupt
>>> +		    source.
>>> +		    The value must match that of the parent interrupt
>>> +		    controller defined in the DT.
>>> +		    The encoding of these cells are same as described in [1].
>>
>> There shouldn't be such a requirement. These are two independent pieces
>> of HW, and the first parameter doesn't mean anything for the PDC.
>>
> Wouldn't that be confusing - that we have different definitions for
> interrupts in the same DT? I agree that they are different interrupt
> controllers, but it just feels odd.

I think it feels more bizarre to have pointless fields in the interrupt
specifier. And most DTs have some sort of secondary interrupt controller
that only take two (or even one) parameters. I don't think we should
treat this any differently.

> I will change this to just take 2 cells.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
