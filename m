Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752246AbeDJIMD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 04:12:03 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:51046 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751983AbeDJIMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 04:12:02 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 10 Apr 2018 16:12:00 +0800
From: yuankuiz@codeaurora.org
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-pm@vger.kernel.org, rjw@rjwysocki.net, fweisbec@gmail.com,
        peterz@infradead.org, aulmck@linux.vnet.ibm.com, mingo@kernel.org,
        len.brown@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Subject: [PATCH] [PATCH] time: tick-sched: use bool for
 tick_stopped
In-Reply-To: <alpine.DEB.2.21.1804100946060.2058@nanos.tec.linutronix.de>
References: <891d4f632fbff5052e11f2d0b6fac35d@codeaurora.org>
 <alpine.DEB.2.21.1804100946060.2058@nanos.tec.linutronix.de>
Message-ID: <e1ef27ca497614463d4eb9a32eadfc00@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-04-10 03:55 PM, Thomas Gleixner wrote:
> On Tue, 10 Apr 2018, yuankuiz@codeaurora.org wrote:
> 
>> From: John Zhao <yuankuiz@codeaurora.org>
>> 
>> Variable tick_stopped returned by tick_nohz_tick_stopped
>> can have only true / forse values. Since the return type
>> of the tick_nohz_tick_stopped is also bool, variable
>> tick_stopped nice to have data type as bool in place of int.
> 
> The data type is not int.
[ZJ] Yes. Per newest tip in branch of linux-pm-cpuidle, it is unsigned 
int with 1 bit in width.
There is typo in commit message, "int" at here should be "unsigned int"

> It's part of an integer bitfield and occupies
> exactly one bit of storage, while bool has an architecture dependend 
> size
> and is at least 1 byte, i.e. 8 bit. So with alignment effects you grew 
> the
> size of the data structure and therefore the cache foot print.
[ZJ] So, 1 bit in width is specified as:
+	bool				tick_stopped	: 1;
      This patch is based on the linux-pm-cpuidle branch which has
already gathered available space in the structure of tick_sched.

> 
> This is not about 'nice to have' ....
> 
> Thanks,
> 
> 	tglx
