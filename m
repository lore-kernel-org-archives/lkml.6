Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755482AbeDWOCQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 10:02:16 -0400
Received: from mail-yw0-f171.google.com ([209.85.161.171]:41166 "EHLO
        mail-yw0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755384AbeDWOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 10:02:15 -0400
X-Google-Smtp-Source: AIpwx4+YBbwnIokyIWaVGAGRUYji3qDRM9/OcuKpmPklpV0PjXocGgdxvRJ8wYNfP2gKU11mD0e0LKS7EFo9qOBaBY4=
MIME-Version: 1.0
In-Reply-To: <20180423140052.GO4129@hirez.programming.kicks-ass.net>
References: <CA+ToGPE59B0EKYkRbMcoddEtWwe50nXNu-91UMdjamz+s8nKfg@mail.gmail.com>
 <20180423091633.GU4064@hirez.programming.kicks-ass.net> <CA+ToGPEaHb1ueDRGuzCzm_HxketqxW8j1gawEsCCp2QGLCA=xg@mail.gmail.com>
 <20180423114850.GK4082@hirez.programming.kicks-ass.net> <CA+ToGPHA+Y=0PtiXF7fTSqSgwtzsJy3Z=U1i3xiW9jkzQGsXWQ@mail.gmail.com>
 <20180423123847.GL4082@hirez.programming.kicks-ass.net> <20180423140052.GO4129@hirez.programming.kicks-ass.net>
From: Diego Viola <diego.viola@gmail.com>
Date: Mon, 23 Apr 2018 11:02:12 -0300
Message-ID: <CA+ToGPEwvkn9URS+E_vEPrSjKXbtq2KLwt04z2uxVWcTTs=oSw@mail.gmail.com>
Subject: Re: Experiencing freezes with kernel 4.16.3 on a desktop with E5500
 CPU (bisect included)
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, tglx@linutronix.de, len.brown@intel.com,
        rui.zhang@intel.com, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 11:00 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Apr 23, 2018 at 02:38:47PM +0200, Peter Zijlstra wrote:
>> @@ -834,8 +857,12 @@ static int clocksource_unbind(struct clocksource *cs)
>>               if (curr_clocksource == cs)
>>                       return -EBUSY;
>>       }
>> +
>> +     clocksource_watchdog_lock(&flags);
>>       clocksource_dequeue_watchdog(cs);
>>       list_del_init(&cs->list);
>> +     clocksource_watchdog_lock(&flags);
>
> It works a lot better when this is _unlock();
>
>> +
>>       return 0;
>>  }
>>
>
> With that, and intel_idle.c modified to always issue the "halts in
> idle" thing, my IVB comes up in hpet mode. Let me dig up a Core2 era
> machine and see if that works too.

OK, thanks.
