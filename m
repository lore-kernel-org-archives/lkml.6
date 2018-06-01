Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751200AbeFAGCt (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 02:02:49 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:42919 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750821AbeFAGCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 02:02:47 -0400
X-Google-Smtp-Source: ADUXVKKG9sxgLCQqu1Q8jTF8ZjscrIUGHuj1Hnveo5G44BwBtXJjsgz8IDnofK+dM2vodOuCLZlJ4w==
Date: Thu, 31 May 2018 23:02:43 -0700
From: Joel Fernandes <joel@joelfernandes.org>
To: Byungchul Park <byungchul.park@lge.com>
Cc: Peter Zijlstra <peterz@infradead.org>, mingo@kernel.org,
        rostedt@goodmis.org, tglx@linutronix.de, raistlin@linux.it,
        linux-kernel@vger.kernel.org, juri.lelli@gmail.com, bristot@redhat.com,
        kernel-team@lge.com
Subject: Re: [RESEND PATCH v3 1/2] sched/deadline: Add cpudl_maximum_dl() for
 clean-up
Message-ID: <20180601060243.GA184458@joelaf.mtv.corp.google.com>
References: <1515392081-32320-1-git-send-email-byungchul.park@lge.com>
 <20180111090716.GV6176@hirez.programming.kicks-ass.net>
 <20180509063322.GA29160@X58A-UD3R>
 <536cd801-03e5-a1de-605b-a6ed0f95b4a9@lge.com>
 <6617f569-6c2f-509c-328e-fad3db73f5df@lge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6617f569-6c2f-509c-328e-fad3db73f5df@lge.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 01, 2018 at 12:07:48PM +0900, Byungchul Park wrote:
> 
> 
> On 2018-05-25 14:13, Byungchul Park wrote:
> > 
> > 
> > On 2018-05-09 15:33, Byungchul Park wrote:
> > > On Thu, Jan 11, 2018 at 10:07:16AM +0100, Peter Zijlstra wrote:
> > > > 
> > > > 
> > > > Sorry for the huge delay on this, but I'll have to postpone further.
> > > > Still busy with meltdown/spectre stuff.
> > > 
> > > Please consider this. Even though it's not a big bug, anyway leading
> > > mis-behavior in certain situaions.
> > 
> > Could you see this patches, it's been too long since the start tho?
> 
> Please, any opinion.

Just my opinion: this patch [1] is just a cosmetic change. I would argue that
there's no readability improvement by wrapping up elements[0].dl. Infact I
even feel that the elements[0].cpu should directly be accessed since both
.cpu and .dl for the 0th element are directly accessed only from one place
(cpudl_find) and only one time, and explicitly accessing index 0 makes it
more clear that this is the root of the max-heap.

IOW I don't see any benefit in hiding it behind a wrapper which hides the
fact that we're accessing the root of the max heap, but I don't terribly hate
this patch and I'm Ok if maintainers and other reviewers think its worth it.

thanks,

 - Joel

[1] https://patchwork.kernel.org/patch/10149099/
