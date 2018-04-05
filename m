Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751516AbeDENwB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 09:52:01 -0400
Received: from mail-ot0-f177.google.com ([74.125.82.177]:33379 "EHLO
        mail-ot0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDENv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 09:51:58 -0400
X-Google-Smtp-Source: AIpwx4+EgF345LNz9wzOzMqmeb3hHhISVwtr2OaxM5AgElEfbyUBbOhjp89d5NUtZinGqwE+tOKJus4uTGDDjl4585o=
MIME-Version: 1.0
In-Reply-To: <20180405122758.GO4082@hirez.programming.kicks-ass.net>
References: <1736751.LdhZHb50jq@aspire.rjw.lan> <5752796.zf5UeYB95r@aspire.rjw.lan>
 <20180405122758.GO4082@hirez.programming.kicks-ass.net>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 5 Apr 2018 15:51:57 +0200
X-Google-Sender-Auth: WgBaIdiZeKg78h84MEgloXyBY9U
Message-ID: <CAJZ5v0i0Ou2=_7RDPDcaQVhYf22UNbfj4g9xBR8_cEP8whWnJA@mail.gmail.com>
Subject: Re: [PATCH v9 09/10] cpuidle: menu: Refine idle state selection for
 running tick
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
        LKML <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 5, 2018 at 2:27 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, Apr 04, 2018 at 10:49:34AM +0200, Rafael J. Wysocki wrote:
>> -static inline ktime_t tick_nohz_get_sleep_length(void)
>> +static inline ktime_t tick_nohz_get_sleep_length(ktime_t *delta_next)
>>  {
>> -     return NSEC_PER_SEC / HZ;
>> +     *delta_next = NSEC_PER_SEC / HZ;
>> +     return *delta_next;
>
> Shouldn't that be TICK_NSEC ?

Yes, it should.
