Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751940AbeFEMSt (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:18:49 -0400
Received: from ozlabs.org ([203.11.71.1]:60453 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751742AbeFEMSr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:18:47 -0400
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gautham R Shenoy <ego@linux.vnet.ibm.com>
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Michael Neuling <mikey@neuling.org>,
        Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
        Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
        Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpuidle:powernv: Make the snooze timeout dynamic.
In-Reply-To: <20180605084529.GA5656@in.ibm.com>
References: <1527768909-32637-1-git-send-email-ego@linux.vnet.ibm.com> <87fu22bxlf.fsf@concordia.ellerman.id.au> <20180605084529.GA5656@in.ibm.com>
Date: Tue, 05 Jun 2018 22:18:40 +1000
Message-ID: <87zi09mnof.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gautham R Shenoy <ego@linux.vnet.ibm.com> writes:
> Hello Michael,
>
> On Mon, Jun 04, 2018 at 09:27:40PM +1000, Michael Ellerman wrote:
>> "Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:
>> 
>> > From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>> >
>> > The commit 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of
>> > snooze to deeper idle state") introduced a timeout for the snooze idle
>> > state so that it could be eventually be promoted to a deeper idle
>> > state. The snooze timeout value is static and set to the target
>> > residency of the next idle state, which would train the cpuidle
>> > governor to pick the next idle state eventually.
>> >
>> > The unfortunate side-effect of this is that if the next idle state(s)
>> > is disabled, the CPU will forever remain in snooze, despite the fact
>> > that the system is completely idle, and other deeper idle states are
>> > available.
>> 
>> That sounds like a bug, I'll add?
>
> Yes, this is a bug-fix for a customer scenario which we encountered
> recently.

OK, the change log could have used some more scary words to make that
clearer ;)

I changed the subject to:

  cpuidle: powernv: Fix promotion from snooze if next state disabled

Which hopefully makes sense.

>> Fixes: 78eaa10f027c ("cpuidle: powernv/pseries: Auto-promotion of snooze to deeper idle state")
>> Cc: stable@vger.kernel.org # v4.2+
>
> This patch applies cleanly from v4.13 onwards. Prior to that there are
> some (minor) conflicts.
>
> Should I spin a version separately for the prior stable versions ?

Yes please, that would be great.

You might want to avoid "=====" in the change log too, as patchwork and
possibly other tools will think it's part of the diff.

cheers
