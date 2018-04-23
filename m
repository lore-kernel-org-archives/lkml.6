Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755352AbeDWNsX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:48:23 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:34363 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755215AbeDWNsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:48:18 -0400
X-Google-Smtp-Source: AIpwx4+IbDHbyVe3CZlHNJQMIR4kAu4woNFdmuUChQP7AHb/j+ypY/dx73YcRzW3kcWvzkGy+RoX5vwCZhOcHynRA/Y=
MIME-Version: 1.0
In-Reply-To: <20180423124552.GY4064@hirez.programming.kicks-ass.net>
References: <20180419051510.GA21898@mwanda> <20180420120044.GN4064@hirez.programming.kicks-ass.net>
 <fb72fc65-085b-65dc-c965-492d6d0902ea@embeddedor.com> <20180423124552.GY4064@hirez.programming.kicks-ass.net>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 23 Apr 2018 06:48:17 -0700
Message-ID: <CAPcyv4gLKYiCtXsKFX2FY+rW93aRtQt9zB8hU1hMsj770m8gxQ@mail.gmail.com>
Subject: Re: Smatch check for Spectre stuff
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 5:45 AM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Apr 23, 2018 at 07:31:03AM -0500, Gustavo A. R. Silva wrote:
>> Hi Peter,
>>
>> On 04/20/2018 07:00 AM, Peter Zijlstra wrote:
>> >
>> > Hi Dan,
>> >
>> > awesome stuff...
>> >
>> > So I fear that many are actually things we want to fix. Our policy was
>> > to kill the speculation on the first load and not worry if it can be
>> > completed with a dependent load/store.
>> >
>> I wonder if there is any thread where I can read the discussion about that
>> policy that you mention.
>>
>> Could you share it here, please?
>
> I think it was somewhere in the many spectre variant1 threads when Linus
> Alexei and Dan W were hashing out the mitigation thing. I cannot quickly
> find the specific email.
>
> Clarifying that position was one reason for the patches I did, Linus and
> Dan W are on Cc and I figure that if they all agree we should maybe add
> a little something to Documentation/speculation.txt.

Yes, given that speculation windows are large if an attacker can
trigger one out of bounds read it is difficult to identify that all of
possible speculation from that point is safe, or that future code
changes will not introduce a data ex-filtration sequence relative to
that first out of bounds access. This is also the reason we protect
all get_user() and __get_user() instances.
