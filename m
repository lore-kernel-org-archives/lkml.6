Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932607AbeCSJtL (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 05:49:11 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:39589 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755299AbeCSJtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 05:49:09 -0400
X-Google-Smtp-Source: AG47ELvZjz05nn5Qs88h4u6YJ+xZ8tOcm0983qfdwp/reDrRCcP2jtvWX/dzl+pSabJL1a0gnK2INoO9vXYhC/frL50=
MIME-Version: 1.0
In-Reply-To: <20180319094549.GG4043@hirez.programming.kicks-ass.net>
References: <2142751.3U6XgWyF8u@aspire.rjw.lan> <4980385.RayypyZ8dA@aspire.rjw.lan>
 <20180319094549.GG4043@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 19 Mar 2018 10:49:08 +0100
X-Google-Sender-Auth: T8rcv-supiNZJae54R5yGhhod04
Message-ID: <CAJZ5v0jz63BwRR6Hybz1rwXs1HS2WdzqSRDW_bOkd5_3DotLdg@mail.gmail.com>
Subject: Re: [RFT][PATCH v5 6/7] cpuidle: menu: Refine idle state selection
 for running tick
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Thomas Ilsche <thomas.ilsche@tu-dresden.de>,
        Doug Smythies <dsmythies@telus.net>, Rik van Riel <riel@surriel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Mike Galbraith <mgalbraith@suse.de>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 10:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Thu, Mar 15, 2018 at 11:16:41PM +0100, Rafael J. Wysocki wrote:
>
>> --- linux-pm.orig/kernel/time/tick-sched.c
>> +++ linux-pm/kernel/time/tick-sched.c
>> @@ -1031,10 +1031,11 @@ void tick_nohz_irq_exit(void)
>>
>>  /**
>>   * tick_nohz_get_sleep_length - return the expected length of the current sleep
>> + * @cur_ret: pointer for returning the current time to the next event
>
> Both name and description are confusing, what it actually appears to
> return is the duration until the next event. Which would suggest a name
> like: delta_next or something along those lines.
>
> But 'cur' short for current, is very misleading.

OK, I'll change that.

Thanks!
