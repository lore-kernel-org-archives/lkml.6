Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088CDC169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:03:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19F021916
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 09:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cHYUDXs0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfBHJDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 04:03:04 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45588 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfBHJDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 04:03:03 -0500
Received: by mail-pf1-f195.google.com with SMTP id j3so1362553pfi.12;
        Fri, 08 Feb 2019 01:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XO2QqIzd/2wsZWXY5lU5a7LjREkFwpyihI12GITFRaE=;
        b=cHYUDXs0ksagr3AbAAYZEjCZBjLKWgwPfUhdltVMvSvfaYJDKCMe/c/lFrsVzcSicD
         xMQyb+Odr4rS0c87VhL6//2HCqJSVJdmLa2LnxS7BVzuDztZazXy0dxIyt++uY36R8hY
         oTOmARw99ziclhaTWmCGrE9+ORTiBy2GxV/nue1HaQs8IUbFbRa7F9ZLWKDDQW+6JaYt
         i1/KiPlqZtwLXQiQRVGS8HNJmx+XdSG4XXQJXgMvKrWZbNy+3EvOecpidhiqoJpoO5KC
         Z6ZCb6GvcazS1ISYhbnIF48CN4w2080D8tVmbWVr341rU9tENkX1tJxRm9ocKWA7rS1s
         Tc6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XO2QqIzd/2wsZWXY5lU5a7LjREkFwpyihI12GITFRaE=;
        b=prIKqQi12GA4QEQCKEEzuZY62PBaY5RLkvV4avnPqyJF0P1qVRDqTQ8MKFH6Mnk2dr
         39QCbgGwj/BLfkX9PiyCSIo7ml+QwYCymenDQR5gqUtiuQ4XgE3VdPZ+FGfY4wDN/FeF
         KfGnwSLJC8jriJib2ULz3Q6pXx/DAoOel7dP1XYo5cswIH8R+DMGMESn453kITo11N5G
         yg48+Rvru3PsFP8Pms2uqhSFyz4/wEMHtDIayu0kDommzE953A+HHEH7XJpCRf+mgQFf
         AKMDmDKmyDL+cc8UPacG2vJW9xPtbO6YKAvT2NKds9Sz7iwbfGj/JzoOdvC8Yylua7aO
         ORwA==
X-Gm-Message-State: AHQUAuazXb001ZxwuI9akCEaPClP/AvY6d5/NEA/rQDdix2H09WkuBwv
        hfJz1b1eBKYmQPOfk3x03m4=
X-Google-Smtp-Source: AHgI3Ia09PqPeAhEw0y8LFAPCPs8SijrsKIym2xq6OgKnZvnMGNyMYSVcJZNuhAciqStHUSIL2FTkQ==
X-Received: by 2002:a62:9111:: with SMTP id l17mr21020002pfe.200.1549616582151;
        Fri, 08 Feb 2019 01:03:02 -0800 (PST)
Received: from gmail.com (c-73-140-212-29.hsd1.wa.comcast.net. [73.140.212.29])
        by smtp.gmail.com with ESMTPSA id h129sm4224899pfb.110.2019.02.08.01.03.00
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 08 Feb 2019 01:03:01 -0800 (PST)
Date:   Fri, 8 Feb 2019 01:02:59 -0800
From:   Andrei Vagin <avagin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Dmitry Safonov <dima@arista.com>, linux-kernel@vger.kernel.org,
        Andrei Vagin <avagin@openvz.org>,
        Adrian Reber <adrian@lisas.de>,
        Andy Lutomirski <luto@kernel.org>,
        Andy Tucker <agtucker@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Cyrill Gorcunov <gorcunov@openvz.org>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jeff Dike <jdike@addtoit.com>, Oleg Nesterov <oleg@redhat.com>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Shuah Khan <shuah@kernel.org>,
        containers@lists.linux-foundation.org, criu@openvz.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 03/32] timens: Introduce CLOCK_MONOTONIC offsets
Message-ID: <20190208090258.GA31765@gmail.com>
References: <20190206001107.16488-1-dima@arista.com>
 <20190206001107.16488-4-dima@arista.com>
 <alpine.DEB.2.21.1902072225420.1645@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1902072225420.1645@nanos.tec.linutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2019 at 10:40:55PM +0100, Thomas Gleixner wrote:
> On Wed, 6 Feb 2019, Dmitry Safonov wrote:
> >  #include "timekeeping.h"
> >  #include "posix-timers.h"
> > @@ -1041,6 +1042,9 @@ SYSCALL_DEFINE2(clock_gettime, const clockid_t, which_clock,
> >  
> >  	error = kc->clock_get(which_clock, &kernel_tp);
> >  
> > +	if (!error && kc->clock_timens_adjust)
> > +		timens_clock_from_host(which_clock, &kernel_tp);
> 
> Why are you adding this conditional instead of sticking the offset
> magic into the affected ->clock_get() implementations?
> 
> That spares you the switch() and the !offsets conditional.
> 
> > +static void clock_timens_fixup(int clockid, struct timespec64 *val, bool to_ns)
> > +{
> > +	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
> > +	struct timespec64 *offsets = NULL;
> > +
> > +	if (!ns_offsets)
> > +		return;
> > +
> > +	if (val->tv_sec == 0 && val->tv_nsec == 0)
> > +		return;
> 
> I have no idea why 0/0 is special.

Initially this function was introduced to apply timens offsets in
do_timer_settime and there it is special and means that the timer should
be disarmed.

Now this functions is used in many other places and this check defenetly
sould not be here.


> 
> > +
> > +	switch (clockid) {
> > +	case CLOCK_MONOTONIC:
> > +	case CLOCK_MONOTONIC_RAW:
> > +	case CLOCK_MONOTONIC_COARSE:
> > +		offsets = &ns_offsets->monotonic_time_offset;
> > +		break;
> > +	}
> > +
> > +	if (!offsets)
> > +		return;
> > +
> > +	if (to_ns)
> > +		*val = timespec64_add(*val, *offsets);
> > +	else
> > +		*val = timespec64_sub(*val, *offsets);
> > +}
> > +
> > +void timens_clock_to_host(int clockid, struct timespec64 *val)
> 
> Does this really need to be an out of line call?

The idea was to collect all the logic about timens offsets in one place.

clock_timens_fixup() is used in all places where we need apply timens
offsets (clock_gettim, posix timers, clock_nanosleep, timerfd, uptime_proc_show).


> If you stick this into the
> clock_get() implementations then it boils down to:

clock_get() is called from clock_gettime and from common_timer_get(). In
common_timer_get(), we expect to get time in the root time namespace.

but I think we can handle this. For example, we can introduce a new flag
CLOCL_TIMENS and

kc->clock_get(which_clock | CLOCK_TIMENS, &tp) will return time in a
current time namespace.

kc->clock_get(which_clock, &tp) will return time in the root time
namespace.

> 
> static inline void timens_add_monotonic(struct timespec64 *ts)
> {
> 	struct timens_offsets *ns_offsets = current->nsproxy->time_ns->offsets;
> 
> 	if (ns_offsets)
> 		*ts = timespec64_add(*ts, ns_offsets->monotonic_time_offset);
> }
> 
> and
> 
> static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
> {
>         ktime_get_ts64(tp);
> 	timens_add_monotonic(tp);
>         return 0;
> }
> 
> Hmm?

Yes, we can do this. I like this idea. This will allow us to remove
timens_clock_to_host(), but I am not sure that we will be able to do
something similar with timens_clock_from_host, which is used to apply
offsets for timers. I need to look at the timer code again.


Thanks,
Andrei

> 
> Thanks,
> 
> 	tglx
> 
