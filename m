Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752177AbeEPPpk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 11:45:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:33880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751096AbeEPPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 11:45:38 -0400
Date: Wed, 16 May 2018 11:45:35 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Carsten Emde <C.Emde@osadl.org>,
        John Kacur <jkacur@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Julia Cartwright <julia@ni.com>,
        Daniel Wagner <daniel.wagner@siemens.com>, tom.zanussi@linux.intel.com
Subject: Re: [PATCH RT 3/5] tracing: Restore proper field flag printing when
 displaying triggers
Message-ID: <20180516114535.6c3dbd1b@gandalf.local.home>
In-Reply-To: <20180516153213.mh5zgxzd2hwnkvuh@linutronix.de>
References: <20180516133642.521479369@goodmis.org>
        <20180516133836.518686476@goodmis.org>
        <20180516153213.mh5zgxzd2hwnkvuh@linutronix.de>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018 17:32:14 +0200
Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> On 2018-05-16 09:36:45 [-0400], Steven Rostedt wrote:
> > diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
> > index 9dac8bae4f34..4745ed588607 100644
> > --- a/kernel/trace/trace_events_hist.c
> > +++ b/kernel/trace/trace_events_hist.c
> > @@ -4916,6 +4916,16 @@ static void hist_field_print(struct seq_file *m, struct hist_field *hist_field)
> >  		seq_printf(m, "%s", field_name);
> >  	} else if (hist_field->flags & HIST_FIELD_FL_TIMESTAMP)
> >  		seq_puts(m, "common_timestamp");
> > +
> > +	if (hist_field->flags) {
> > +		if (!(hist_field->flags & HIST_FIELD_FL_VAR_REF) &&
> > +		    !(hist_field->flags & HIST_FIELD_FL_EXPR)) {
> > +			const char *flags = get_hist_field_flags(hist_field);
> > +
> > +			if (flags)
> > +				seq_printf(m, ".%s", flags);
> > +		}
> > +	}
> >  }
> >  
> >  static int event_hist_trigger_print(struct seq_file *m,  
> 
> For v4.16 I needed commit 0ae7961e75c3 ("tracing: Fix display of hist
> trigger expressions containing timestamps") in order to get this one

Yes, I assumed you had it as you pulled it into 4.14-rt. I was just
looking at what 4.14-rt has. Anything you added there you should add to
4.16-rt as well.

> cleanly applied. Comparing with -rc3 it looks like commit 5e4cf2bf6d1c
> ("tracing: Fix a potential NULL dereference") would be great addition.

Good catch, yeah, I should pull that in too.

> 
> Safe to take them, right?

Yep.

-- Steve
