Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeBLS1r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:27:47 -0500
Received: from foss.arm.com ([217.140.101.70]:44892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751527AbeBLS1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:27:45 -0500
Subject: Re: [PATCH 2/2] arm64: dts: juno: Describe the full GICv2m region
To: Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20180207143255.17003-1-marc.zyngier@arm.com>
 <20180207143255.17003-3-marc.zyngier@arm.com>
 <d10fa874-1de2-1b95-dae1-42a336b98fa2@arm.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <a0707972-f984-7aea-98fb-8cd8382f8287@arm.com>
Date: Mon, 12 Feb 2018 18:27:42 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <d10fa874-1de2-1b95-dae1-42a336b98fa2@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudeep,

On 12/02/18 18:17, Sudeep Holla wrote:
> 
> 
> On 07/02/18 14:32, Marc Zyngier wrote:
>> From: Robin Murphy <robin.murphy@arm.com>
>>
>> Juno's GICv2m implementation consists of four frames providing 32
>> interrupts each. Since it is possible to plug in enough PCIe endpoints
>> to consume more than 32 MSIs, and the driver already has a bodge to
>> handle multiple frames, let's expose the other three as well.
>>
> 
> Change on it own looks good. So if you want to merge via your tree:
> 
> Acked-by: Sudeep Holla <sudeep.holla@arm.com>
> 
> Let me know if you decide not to take it via your tree and you want me
> to send it to arm-soc.

If this would usually go via arm-soc, feel free to take it via this
route. I'll drop the patch from my tree.

> On the side note I just noticed the Juno TRM[1] has 64k for each of
> these MSI frames(page 3-24 section 3.3.5 Application memory map summary)
> 
> I am not sure if TRM is wrong. This patch is just copying the 4k size
> from frame 0 which got added with initial Juno DTS.

I can't see why the TRM would be wrong. This is actually consistent with
the expected practice of aligning all devices on a 64kB boundary and
size so that you don't get any nasty surprise when passing the device to
a VM (*cough* GIC400 *cough*).

Robin, any chance you could check this?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
