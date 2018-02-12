Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753196AbeBLSRT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 13:17:19 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:44746 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751549AbeBLSRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 13:17:18 -0500
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] arm64: dts: juno: Describe the full GICv2m region
To: Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liviu Dudau <liviu.dudau@arm.com>
References: <20180207143255.17003-1-marc.zyngier@arm.com>
 <20180207143255.17003-3-marc.zyngier@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <d10fa874-1de2-1b95-dae1-42a336b98fa2@arm.com>
Date: Mon, 12 Feb 2018 18:17:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180207143255.17003-3-marc.zyngier@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 07/02/18 14:32, Marc Zyngier wrote:
> From: Robin Murphy <robin.murphy@arm.com>
> 
> Juno's GICv2m implementation consists of four frames providing 32
> interrupts each. Since it is possible to plug in enough PCIe endpoints
> to consume more than 32 MSIs, and the driver already has a bodge to
> handle multiple frames, let's expose the other three as well.
> 

Change on it own looks good. So if you want to merge via your tree:

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

Let me know if you decide not to take it via your tree and you want me
to send it to arm-soc.

On the side note I just noticed the Juno TRM[1] has 64k for each of
these MSI frames(page 3-24 section 3.3.5 Application memory map summary)

I am not sure if TRM is wrong. This patch is just copying the 4k size
from frame 0 which got added with initial Juno DTS.

-- 
Regards,
Sudeep

[1]
http://infocenter.arm.com/help/topic/com.arm.doc.ddi0515f/DDI0515F_juno_arm_development_platform_soc_trm.pdf
