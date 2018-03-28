Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753327AbeC1NsE (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:48:04 -0400
Received: from foss.arm.com ([217.140.101.70]:44366 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753284AbeC1Nrx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:47:53 -0400
Subject: Re: [PATCH 2/6] drivers/irqchip: Update supports_deactivate static
 key to modern api
To: Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        mingo@kernel.org, akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, Davidlohr Bueso <dbueso@suse.de>
References: <20180326210929.5244-1-dave@stgolabs.net>
 <20180326210929.5244-3-dave@stgolabs.net>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <39333f71-699c-b3b4-ec9d-eb6e83585b3d@arm.com>
Date: Wed, 28 Mar 2018 14:47:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180326210929.5244-3-dave@stgolabs.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/03/18 22:09, Davidlohr Bueso wrote:
> No changes in semantics -- key init is true; replace
> 
> static_key_slow_dec       with   static_branch_disable
> static_key_true           with   static_branch_likely
> 
> The first is because we never actually do any couterpart incs,
> thus there is really no reference counting semantics going on.
> Use the more proper static_branch_disable() construct.
> 
> Also added a '_key' suffix to supports_deactivate, for better
> self documentation.
> 
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Signed-off-by: Davidlohr Bueso <dbueso@suse.de>

Looks good to me. How do you want to get this patch merged? Either you
deal with it as part of this series, (and in which case please add my
Ack on it), or I can take it via the irqchip tree.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
