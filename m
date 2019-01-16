Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBFB4C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B93205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 16:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gl+h/5tb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405104AbfAPQFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 11:05:11 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42303 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727010AbfAPQFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 11:05:10 -0500
Received: by mail-pl1-f194.google.com with SMTP id y1so3209431plp.9;
        Wed, 16 Jan 2019 08:05:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IR8vtkw1HKxDpMsK1CFhi6axsJW9P48opoYslkIs5nI=;
        b=Gl+h/5tbOod0hKxistRYZsDyoiHHP9ItWzlWgiOMyN6zW+HmXqm/jwE+F4qDWjD6Wb
         eb4KGhKzQ0U1zcVmHMqT3Ez4nLHGvTusjGp5XPfY1zUZZfK3CmCFO4D3KHoK1siASuUI
         Z31J5DfD3igEdukqN5B2qGdeHHMULf8KC/AEb9rFR/hkZ4VmGXDsRTnNMj8ujV+ARWv8
         74rcuf934bX85UueV9ZBIfzl8/KbopH/iuixVIXrfKogSFPy7tz4olHIj2Vadoobsowu
         DQ8pGy9Ja846DcxWtUsbVFhx5DfGmWIk3tJKqRz6IBPL3D30/c6e9Vz5Z6zgGQkH2gXl
         RwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IR8vtkw1HKxDpMsK1CFhi6axsJW9P48opoYslkIs5nI=;
        b=HPPL7rcofBGKsL9cTKNA7jXQB1uvNjz0R9/wLvmVMVBbrDxyxSmG1BZ3tbuNZnuYmC
         euUJYArIukDZA/hzVBCczSxlP5rXbYbUTbfWeCm2SCWADcfmFhsVlr/EZRlBrqY1qOdo
         /Ll4GngS6MjMrWMzXGly5lqiO7lNkF5BzpjRvCrUIunJww7CH6JE0Tke3i4cT29ph5j9
         tGMBRRWZmO7zWrAQW8WYC+fUFizHt1CXGq86C5He2y5y7+1iZMkHIp713zEfLo5JIdoz
         +0Hb2YS4UR5qHoTAarIQqSR21yqSFbeG5+mopFl1RgYFb3FOIx8d2KUc7yvZ9fMtQl4W
         tMdQ==
X-Gm-Message-State: AJcUukcKZ29w0M1qtDzp5BRvrFyY+uyAtTnqvQa5V6FuOY60P2Ew5j/5
        zQri67gZCw0W6LFMNg6JOyg=
X-Google-Smtp-Source: ALg8bN7zQsW08c4/oRqqhJm0ejrf0Y6ceqMz0DVhjsAPleZ/lxmdzMzeXiA8MUxPh8VcYLddcA/fbA==
X-Received: by 2002:a17:902:bd0b:: with SMTP id p11mr10597529pls.259.1547654710139;
        Wed, 16 Jan 2019 08:05:10 -0800 (PST)
Received: from mail.google.com ([207.246.99.41])
        by smtp.gmail.com with ESMTPSA id d6sm7242239pgc.89.2019.01.16.08.04.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 16 Jan 2019 08:05:09 -0800 (PST)
Date:   Thu, 17 Jan 2019 00:04:45 +0800
From:   Changbin Du <changbin.du@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Changbin Du <changbin.du@gmail.com>, mingo@redhat.com,
        corbet@lwn.net, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] sched/tracing: Show stacktrace for wakeup tracers
Message-ID: <20190116160442.zlc6qopl6jyoyrjj@mail.google.com>
References: <20190101154614.8887-1-changbin.du@gmail.com>
 <20190101154614.8887-5-changbin.du@gmail.com>
 <20190115222500.6b1ca824@vmware.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190115222500.6b1ca824@vmware.local.home>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven, I just send v2 of this one that has applied your 2 suggestions.
Please check. Thanks!

On Tue, Jan 15, 2019 at 10:25:00PM -0500, Steven Rostedt wrote:
> On Tue,  1 Jan 2019 23:46:13 +0800
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > This align the behavior of wakeup tracers with irqsoff latency tracer
> > that we record stacktrace at the beginning and end of waking up. The
> > stacktrace shows us what is happening in the kernel.
> 
> OK, so I've applied (locally) all of the patches in this series except
> this one.
> 
> > 
> > Signed-off-by: Changbin Du <changbin.du@gmail.com>
> > ---
> >  kernel/trace/trace_sched_wakeup.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> > index da5b6e012840..0ec136d408ff 100644
> > --- a/kernel/trace/trace_sched_wakeup.c
> > +++ b/kernel/trace/trace_sched_wakeup.c
> > @@ -474,6 +474,8 @@ probe_wakeup_sched_switch(void *ignore, bool preempt,
> >  	data = per_cpu_ptr(wakeup_trace->trace_buffer.data, wakeup_cpu);
> >  
> >  	__trace_function(wakeup_trace, CALLER_ADDR0, CALLER_ADDR1, flags, pc);
> > +	/* Skip 2 functions to get to the task switch function */
> > +	__trace_stack(wakeup_trace, flags, 2, pc);
> 
> 1) Just put in zero for skip. I found that with all the new updates to
> the unwinders, you can never get this number right :-(, as well as with
> gcc playing games, and retpolines and all that jazz.
> 
> >  	tracing_sched_switch_trace(wakeup_trace, prev, next, flags, pc);
> 
> 2) Have the stack trace go after the sched_switch trace, otherwise it
> looks funny:
> 
>       285 us |   5)    <idle>-0    |  dN.2 |   1.632 us    |    }
>       286 us |   5)    <idle>-0    |  d..3 |   0.000 us    |  __schedule();
>   <idle>-0       5d..3  299us : <stack trace>
>  => schedule_idle
>  => do_idle
>  => cpu_startup_entry
>  => start_secondary
>  => secondary_startup_64
>       299 us |   5)    <idle>-0    |  d..3 |               |  /*      0:120:R ==> [005]   811: 98:R i915/signal:0 */
> 
> Note, I removed the skip and moved the trace and it looks like this:
> 
>       180 us |   3)    <idle>-0    |  dN.2 |   0.944 us    |    }
>       181 us |   3)    <idle>-0    |  d..3 |   0.000 us    |  __schedule();
>       181 us |   3)    <idle>-0    |  d..3 |               |  /*      0:120:R ==> [003]    25:  0:R migration/3 */
>   <idle>-0       3d..3  195us : <stack trace>
>  => probe_wakeup_sched_switch
>  => __schedule
>  => schedule_idle
>  => do_idle
>  => cpu_startup_entry
>  => start_secondary
>  => secondary_startup_64
> 
> Yeah, it shows the "probe_wakeup_sched" but its better to show too much
> than not enough. I've had a hard time debugging some kernels because
> the skip was too high.
> 
> Please resend this patch with the above updates. Just this patch.
> 
> Thanks!
> 
> -- Steve
> 
> >  
> >  	T0 = data->preempt_timestamp;
> > @@ -593,6 +595,8 @@ probe_wakeup(void *ignore, struct task_struct *p)
> >  	 * it should be safe to use it here.
> >  	 */
> >  	__trace_function(wakeup_trace, CALLER_ADDR1, CALLER_ADDR2, flags, pc);
> > +	/* Skip 2 functions to get to the task wakeup function */
> > +	__trace_stack(wakeup_trace, flags, 2, pc);
> >  
> >  out_locked:
> >  	arch_spin_unlock(&wakeup_lock);
> 

-- 
Cheers,
Changbin Du
