Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751117AbeBIMhM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 07:37:12 -0500
Received: from bombadil.infradead.org ([65.50.211.133]:52833 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeBIMhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 07:37:11 -0500
Date: Fri, 9 Feb 2018 13:37:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Joel Fernandes <joelaf@google.com>
Cc: Rohit Jain <rohit.k.jain@oracle.com>, Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        "Cc: EAS Dev" <eas-dev@lists.linaro.org>
Subject: Re: [RESEND PATCH] sched/fair: consider RT/IRQ pressure in
 select_idle_sibling
Message-ID: <20180209123704.GN25201@hirez.programming.kicks-ass.net>
References: <1517268429-933-1-git-send-email-rohit.k.jain@oracle.com>
 <CAJWu+opnNgfVxhgHwLft_qcLMeikEAbNY0zci0WtgQiFkVVjhg@mail.gmail.com>
 <6967b972-129a-a7f0-06ab-c48dc9709726@oracle.com>
 <CAJWu+orYPDy3H2TCtB_FZWrMx18F_ePnD=Gdfj=pKg4HVaLjTQ@mail.gmail.com>
 <c78b1dab-95fb-ed88-30de-b4d489a5fc17@oracle.com>
 <CAJWu+opnwHQm8p6LnFRpfmQ+rkPgeGUWkV_imemvMqzg2WGB_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJWu+opnwHQm8p6LnFRpfmQ+rkPgeGUWkV_imemvMqzg2WGB_Q@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 10:50:41PM -0800, Joel Fernandes wrote:

> That's Ok with me. Just that I remember Peter messing with this path
> and that it was expensive to scan too much for some systems. The other
> thing is you're really doing to do a "fail safe" as you call it search
> here with SIS_PROP set. Do you see a difference in perf when doing the
> same approach as you took in select_idle_core?
> 
> Peter, are you with the approach Rohit has adopted to pick best
> capacity idle CPU in select_idle_cpu? I guess nr--; will bail out
> early if we have SIS_PROP set, incase the scan cost gets too much but
> then again we might end scanning too few CPUs.

_IF_ you want to consider capacity, I don't think there's much else you
can do. And yes, nr-- might have to save the day more often.
