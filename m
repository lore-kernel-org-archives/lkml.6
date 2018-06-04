Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751354AbeFDSKG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 14:10:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:56464 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750999AbeFDSKF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 14:10:05 -0400
Date: Mon, 4 Jun 2018 14:10:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nick Desaulniers <nick.desaulniers@gmail.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ebiggers@google.com
Subject: Re: [PATCH] tracing: prefer strlcpy to strncpy
Message-ID: <20180604141003.3b3d507b@gandalf.local.home>
In-Reply-To: <CAH7mPvh_T1YzfGBR+mzcwQ5r6bhz2NxrvY5r7sSY=wMeh-GK+w@mail.gmail.com>
References: <1527573818-29712-1-git-send-email-nick.desaulniers@gmail.com>
        <CAH7mPvh_T1YzfGBR+mzcwQ5r6bhz2NxrvY5r7sSY=wMeh-GK+w@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 May 2018 18:55:23 -0700
Nick Desaulniers <nick.desaulniers@gmail.com> wrote:

> On Mon, May 28, 2018 at 11:03 PM, Nick Desaulniers
> <nick.desaulniers@gmail.com> wrote:
> > Fixes a stringop-truncation warning from gcc-8.
> >
> > Signed-off-by: Nick Desaulniers <nick.desaulniers@gmail.com>
> > ---
> >  kernel/trace/trace_events_hist.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index b9061ed..b53a6c0 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -393,7 +393,7 @@ static void hist_err_event(char *str, char *system, char *event, char *var)
> >         else if (system)
> >                 snprintf(err, MAX_FILTER_STR_VAL, "%s.%s", system, event);
> >         else
> > -               strncpy(err, var, MAX_FILTER_STR_VAL);
> > +               strlcpy(err, var, MAX_FILTER_STR_VAL);
> >
> >         hist_err(str, err);
> >  }
> > --
> > 2.7.4
> >  
> 
> Eric points out this wont initialize the rest of err with zeros.

And why do we care?

-- Steve
