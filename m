Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751308AbeDYHHf (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 03:07:35 -0400
Received: from foss.arm.com ([217.140.101.70]:34790 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750929AbeDYHHe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 03:07:34 -0400
Subject: Re: Affinity for GIC irq line
To: valmiki <valmikibow@gmail.com>, linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, jason@lakedaemon.net,
        Catalin Marinas <catalin.marinas@arm.com>
References: <2880aee6-704c-a5aa-e193-75bba1bce43d@gmail.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <2d9f0678-ec5c-2b09-7ddd-407dd37c55a1@arm.com>
Date: Wed, 25 Apr 2018 08:07:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2880aee6-704c-a5aa-e193-75bba1bce43d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/04/18 04:23, valmiki wrote:
> Hi all,
> 
> When an IRQ line is set affinity using irq_set_affinity, which calls 
> irq_do_set_affinity, this API copies affinity mask to affinity variable 
> in irq_common_data of this irq descriptor.

It does a wee bit more. Crucially, it contains the line:

        ret = chip->irq_set_affinity(data, mask, force);

> But as per ARM GICv2 document in order to drive a interrupt to a 
> specific CPU we need to program GICD_ITARGETSRn register.
> 
> But irq_set_affinity isn't writing to this register.Please correct me if 
> I'm wrong i did not find code for this register being updated in 
> irq_set_affinity flow.
> So how affinity is being set for an IRQ line ?

I would have though that a function name such as "gic_set_affinity" was
clear enough?

> If affinity was set successfully on what CPU does asm_do_IRQ run ?

It runs on the CPU that the interrupt targets, I'd say.

	M.
-- 
Jazz is not dead. It just smells funny...
