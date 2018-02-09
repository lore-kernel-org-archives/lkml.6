Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752293AbeBIJrG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 04:47:06 -0500
Received: from foss.arm.com ([217.140.101.70]:44886 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750942AbeBIJrE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 04:47:04 -0500
Subject: Re: [PATCH v4 2/2] dt/bindings: Add bindings for Layerscape external
 irqs
To: Rasmus Villemoes <rasmus.villemoes@prevas.dk>,
        Rob Herring <robh@kernel.org>
Cc: Shawn Guo <shawnguo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Mark Rutland <mark.rutland@arm.com>, Andy Tang <andy.tang@nxp.com>,
        Alexander Stein <alexander.stein@systec-electronic.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20180122092133.23177-1-rasmus.villemoes@prevas.dk>
 <20180125150230.7234-1-rasmus.villemoes@prevas.dk>
 <20180125150230.7234-2-rasmus.villemoes@prevas.dk>
 <20180205060705.cg3qywtqs65w74ee@rob-hp-laptop>
 <15ac0da3-e85b-c6be-366a-368934752018@prevas.dk>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <6186117d-ff4f-a64f-9b5e-c3b3fac8bb88@arm.com>
Date: Fri, 9 Feb 2018 09:47:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <15ac0da3-e85b-c6be-366a-368934752018@prevas.dk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/02/18 15:08, Rasmus Villemoes wrote:
> On 2018-02-05 07:07, Rob Herring wrote:
>>> +Example:
>>> +	scfg: scfg@1570000 {
>>> +		compatible = "fsl,ls1021a-scfg", "syscon";
>>> +		...
>>> +		extirq: interrupt-controller {
>>> +			compatible = "fsl,ls1021a-extirq";
>>> +			#interrupt-cells = <3>;
>>> +			interrupt-controller;
>>> +			interrupt-parent = <&gic>;
>>> +			offset = <0x1ac>;
>>
>> Use reg here instead (with a length).
> 
> Hm, ok, but what does the length buy us? Should the driver just ignore
> it, or should it check that it is 4 and bail out if not?
> 
>>> +			interrupts = <163 164 165 167 168 169>;
>>
>> These don't look like GIC interrupt cells. Building this with current 
>> dtc will have errors.
> 
> Indeed, they are not. They simply record which interrupt lines on the
> GIC the external interrupt lines IRQ0...IRQ5 map to (the arm64 socs
> apparently have 12 such lines, but I don't know what they map to). I
> originally had that mapping in the driver, but I was asked to move it to
> DT. Is the problem the use of the name "interrupts" for this property?
> I'm happy to use something else (parent-interrupts, interrupt-mapping,
> ...) I find it very hard to figure out which property names have
> magic/reserved meanings.
> 
> I don't see any warnings/errors from dtc in the 4.14 tree I'm working
> on. Does it require an even newer dtc than that?

Most interrupt controllers use a private property, potentially with a
range (see the recent example of the Qualcomm PDC [1]).

Thanks,

	M.

[1] https://patchwork.kernel.org/patch/10208037/
-- 
Jazz is not dead. It just smells funny...
