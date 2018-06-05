Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751871AbeFERny (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 13:43:54 -0400
Received: from foss.arm.com ([217.140.101.70]:59546 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751788AbeFERnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 13:43:53 -0400
Subject: Re: How to print stack uses of IRQ in ARM64
To: Vishnu Motghare <vishnumotghare@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "linux-arm-kernel@lists.infradead.org"
        <linux-arm-kernel@lists.infradead.org>
References: <CADSz7_cqdKnmOm07Ykv5L9d2qscfKNmf7Vz=yW2Nf8PWsnsJaA@mail.gmail.com>
 <CAHp75VcTvMKy8h_2gztav2FOUvE1QG01FByTNmc=x0bdyRx5Dg@mail.gmail.com>
From: James Morse <james.morse@arm.com>
Message-ID: <9686668a-2739-309d-fb02-55c8fd2b802d@arm.com>
Date: Tue, 5 Jun 2018 18:40:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VcTvMKy8h_2gztav2FOUvE1QG01FByTNmc=x0bdyRx5Dg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vishun,

(CC: +linux-arm-kernel list)

On 05/06/18 14:12, Andy Shevchenko wrote:
> On Thu, May 31, 2018 at 1:01 PM, Vishnu Motghare
> <vishnumotghare@gmail.com> wrote:
>> My understanding is each CPU  getting its own IRQ stack. So is it
>> possible to print the stack uses of each IRQ handler?

The stacks are per-cpu not per-handler, so you would get a jumble of different
interrupt-handlers, mixed up with softirq that runs on the same stack.


>> like, How much stack is used & how much left free ?

What would you do with the information?


>> like in process context we have API like stack_not_used(struct
>> task_struct *p) to get the unused stack  of processes.

Isn't this only printed when the process exits?
When would you print it for an irqstack?

To get this information you would need to mask interrupts, then search backwards
on the irq-stack to find the 'last' value. I think it would always be more
useful to take interrupts in that time...


>> So, is it possible to get the similar result for IRQ?

Probably, but I don't think its useful.
If you're debugging a stack-overflow, its much better to use vmap stacks, which
will give you the function and stack trace that triggered the overflow.


Thanks,

James
