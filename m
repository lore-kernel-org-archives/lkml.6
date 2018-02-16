Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751054AbeBPS0w (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 13:26:52 -0500
Received: from lelnx193.ext.ti.com ([198.47.27.77]:46036 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750836AbeBPS0u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 13:26:50 -0500
Subject: Re: [v4.14-rt][report] arm: just another rcu_note_context_switch
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Steven Rostedt <rostedt@goodmis.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <6f2e005d-26c1-19ca-283a-5f5e441e2f80@ti.com>
 <20180216113045.4zzay3oluuc2altu@linutronix.de>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <1399f473-b743-8030-bf3e-9835596522e7@ti.com>
Date: Fri, 16 Feb 2018 12:26:36 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216113045.4zzay3oluuc2altu@linutronix.de>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [128.247.59.147]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/16/2018 05:30 AM, Sebastian Andrzej Siewior wrote:
> On 2018-02-14 16:12:42 [-0600], Grygorii Strashko wrote:
>> Hi All,
> Hi,
> 
>> I can see below warning during boot on few TI boards am437x-idk, am335x-evm, am335x-ice
>> All of them are non-SMP
> 
> I somehow missed the !SMP kernel… What about this:
> 
> Subject: [PATCH] RCU: skip the "schedule() in RCU section" warning on UP, too
> 
> In "RCU: we need to skip that warning but only on sleeping locks" we
> skipped a warning on SMP systems in case we schedule out in a RCU
> section while attempt to obtain a sleeping lock. This is also required
> on UP systems.
> In order to do so, I introduce a tiny version of migrate_disable() +
> _enable() which only update the counters which we then can check against
> on RT && !SMP.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---

Thanks. I do not see errors any more.
Tested-by: Grygorii Strashko <grygorii.strashko@ti.com>



-- 
regards,
-grygorii
