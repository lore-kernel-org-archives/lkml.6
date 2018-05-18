Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeERQlS (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:41:18 -0400
Received: from foss.arm.com ([217.140.101.70]:56242 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752513AbeERQlN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:41:13 -0400
Subject: Re: [PATCH v3 0/5]
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Vladimir Murzin <vladimir.murzin@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Stefan Wahren <stefan.wahren@i2se.com>, Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>
References: <20180518143913.26306-1-marc.zyngier@arm.com>
 <alpine.DEB.2.21.1805181222380.11339@macbook-air>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <278cb8b1-d567-2067-2dde-980596821c9c@arm.com>
Date: Fri, 18 May 2018 17:41:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1805181222380.11339@macbook-air>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[/me beats himself for not writing a subject line...]

On 18/05/18 17:29, Vince Weaver wrote:
> On Fri, 18 May 2018, Marc Zyngier wrote:
> 
>> There is also the case of people natively running 32bit kernels on
>> 64bit HW and trying to upstream unspeakable hacks, hoping that the
>> stars will align and that they'll win the lottery (see [1]).
> 
> I've tested these patches on a Raspberry Pi 3B running a 32-bit upstream 
> (4.17-rc5-git) kernel and they work.
> 
> [    0.472906] hw perfevents: enabled with armv8_cortex_a53 PMU driver, 7 counters available
> 
> I only needed to add this to the devicetree
> 
> 	arm-pmu {
> 		compatible = "arm,cortex-a53-pmu";
> 		interrupt-parent = <&local_intc>;
> 		interrupts = <9 IRQ_TYPE_LEVEL_HIGH>;
> 	};

That's definitely the sensible thing to have on such hardware. Why isn't
it in the upstream DT already, irrespective of the state of the kernel
support?

> Tested-by: Vince Weaver <vincent.weaver@maine.edu>

Thanks a lot for testing.

	M.
-- 
Jazz is not dead. It just smells funny...
