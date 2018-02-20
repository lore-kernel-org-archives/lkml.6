Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeBTLQ4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 06:16:56 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:53728 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751570AbeBTLQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 06:16:55 -0500
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / wakeirq: Add wakeup name to dedicated wake irqs
Date: Tue, 20 Feb 2018 12:14:58 +0100
Message-ID: <16911769.8IEilD0BqZ@aspire.rjw.lan>
In-Reply-To: <CAHp75VdxsDiwi8uux3Q4vYhEO1P3w0sePVBcm38RvimKez8XAg@mail.gmail.com>
References: <20180209161456.18951-1-tony@atomide.com> <CAJZ5v0gowD179tVaAc_8Wy-pV=mAwsO1egs0DfCnA-eEWayJdw@mail.gmail.com> <CAHp75VdxsDiwi8uux3Q4vYhEO1P3w0sePVBcm38RvimKez8XAg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, February 16, 2018 3:52:22 PM CET Andy Shevchenko wrote:
> On Fri, Feb 16, 2018 at 12:54 PM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > On Fri, Feb 16, 2018 at 11:39 AM, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> >> On Fri, Feb 16, 2018 at 11:14 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >>> On Wed, Feb 14, 2018 at 12:23 PM, Andy Shevchenko
> >>> <andy.shevchenko@gmail.com> wrote:
> 
> >>> IMO it is somewhat excessive to put the entire sprintf() under a raw
> >>> spinlock and it's not even necessary.
> >>
> >> It's a copy'n'paste of from the rest of functions there.
> >
> > Fair enough. :-)
> 
> >>> The value can change any time after you've dropped the lock and in
> >>> particular before the function returns, so why bother with locking?
> >>> desc will not go away from under you at that point anyway.
> >>
> >> IIRC descriptor's content might be changed, or descriptor itself might
> >> be gone (potential crash).
> >
> > No, desc cannot go away at this point AFAICS due to the kernfs
> > refcounting.  And the lock is *inside* of the desc object anyway, so
> > it doesn't help really against that.
> 
> Oh, indeed.
> 
> > The contents may change, but so what?
> >
> > Effectively, you read an int and reading an int is atomic.  It may
> > change after that, but the lock doesn't prevent it from changing.  It
> > only prevents the change from being applied to it before you drop the
> > lock, but why do you care?
> 
> So, with explanations above, perhaps we can produce the patch to
> remove those locks from the rest?

Well, I guess so.

I'm not the maintainer of that code, however. :-)
