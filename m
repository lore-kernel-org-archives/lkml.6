Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27CA8C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:28:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD8B7208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 08:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD8B7208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbeH0MOS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 08:14:18 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:40082 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726802AbeH0MOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 08:14:18 -0400
Received: by mail-oi0-f66.google.com with SMTP id l202-v6so18937845oig.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 01:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ONNzXop+iXz4kxRxZhE5SwuP7zkcGvl71ot5B8fA+KA=;
        b=RJogWZJH5Hj4q+qjLplAdYrYHMZX7kL6A2JAaDrerSbZzC9nQWbfzacPPNPdvmishA
         HYecFm1FVu6inWdIu4TAhMQ5zk7Dyhh7c0ZrepOXwCl2uyAvF2J4uC3KJGH45ELivIR6
         /o7TK2ENTiujRxQYGS/2hSVyT9NVqOUBMgk2MesywHYOzs95XZt3qIQGA5i9eRtKXL9s
         j7juhdJ5D27T4K+rSCUSfiRL7rC2s6qAOuiOFMh5MB5vS2w58n4BwkvuixGUNVVopnHC
         97QE0FC9IU8CssE9tIvu4NzB0cq0PYsyn1S6W4jI7uM9Chgtlm2Tkw1cj9orHOA7dzKt
         UQRw==
X-Gm-Message-State: APzg51BhbDsFJ3ASwGWx9qayh9IcWuXKmpenRe+L0JSZLT3tkW4pWkfZ
        RuFcFdVrKlY5EwVjquGFkZUbIoOYzXJinZLWN4pAeA==
X-Google-Smtp-Source: ANB0VdaXXOJyiz7z6cUd/kuK4ZWZmxDGosIuxz3t8WNifFbgFYRGFigX2Dvr4yLJRJ/EWGFVOxG+cuACPQIkrUTXxKY=
X-Received: by 2002:aca:3f55:: with SMTP id m82-v6mr12293330oia.237.1535358519321;
 Mon, 27 Aug 2018 01:28:39 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
 <CALAqxLU7UyCqs9t8E+UV7BQvfYOSB6mdYB2f5RYmu_mb76i7VA@mail.gmail.com>
In-Reply-To: <CALAqxLU7UyCqs9t8E+UV7BQvfYOSB6mdYB2f5RYmu_mb76i7VA@mail.gmail.com>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 27 Aug 2018 10:28:27 +0200
Message-ID: <CAFqZXNsZSN=pVupOHZwam8k9V357sA7KPuK3EjtZ=hPRrr1ocA@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     John Stultz <john.stultz@linaro.org>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 8:33 PM John Stultz <john.stultz@linaro.org> wrote:
> On Fri, Aug 24, 2018 at 5:00 AM, Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > This patch adds two auxiliary record types that will be used to annotate
> > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > been changed.
> >
> > Next, it adds two functions to the audit interface:
> >  - audit_tk_injoffset(), which will be called whenever a timekeeping
> >    offset is injected by a syscall from userspace,
> >  - audit_ntp_adjust(), which will be called whenever an NTP internal
> >    variable is changed by a syscall from userspace.
> >
> > Quick reference for the fields of the new records:
> >     AUDIT_TIME_INJOFFSET
> >         sec - the 'seconds' part of the offset
> >         nsec - the 'nanoseconds' part of the offset
> >     AUDIT_TIME_ADJNTPVAL
> >         op - which value was adjusted:
> >             offset - corresponding to the time_offset variable
> >             freq   - corresponding to the time_freq variable
> >             status - corresponding to the time_status variable
> >             adjust - corresponding to the time_adjust variable
> >             tick   - corresponding to the tick_usec variable
> >             tai    - corresponding to the timekeeping's TAI offset
> >         old - the old value
> >         new - the new value
> >
> > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > ---
> >  include/linux/audit.h      | 21 +++++++++++++++++++++
> >  include/uapi/linux/audit.h |  2 ++
> >  kernel/auditsc.c           | 15 +++++++++++++++
> >  3 files changed, 38 insertions(+)
> >
> > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > index 9334fbef7bae..0d084d4b4042 100644
> > --- a/include/linux/audit.h
> > +++ b/include/linux/audit.h
> > @@ -26,6 +26,7 @@
> >  #include <linux/sched.h>
> >  #include <linux/ptrace.h>
> >  #include <uapi/linux/audit.h>
> > +#include <uapi/linux/timex.h>
> >
> >  #define AUDIT_INO_UNSET ((unsigned long)-1)
> >  #define AUDIT_DEV_UNSET ((dev_t)-1)
> > @@ -356,6 +357,8 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
> >  extern void __audit_mmap_fd(int fd, int flags);
> >  extern void __audit_log_kern_module(char *name);
> >  extern void __audit_fanotify(unsigned int response);
> > +extern void __audit_tk_injoffset(struct timespec64 offset);
> > +extern void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval);
> >
> >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> >  {
> > @@ -458,6 +461,18 @@ static inline void audit_fanotify(unsigned int response)
> >                 __audit_fanotify(response);
> >  }
> >
> > +static inline void audit_tk_injoffset(struct timespec64 offset)
> > +{
> > +       if (!audit_dummy_context())
> > +               __audit_tk_injoffset(offset);
> > +}
> > +
> > +static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > +{
> > +       if (!audit_dummy_context())
> > +               __audit_ntp_adjust(type, oldval, newval);
> > +}
> > +
> >  extern int audit_n_rules;
> >  extern int audit_signals;
> >  #else /* CONFIG_AUDITSYSCALL */
> > @@ -584,6 +599,12 @@ static inline void audit_log_kern_module(char *name)
> >  static inline void audit_fanotify(unsigned int response)
> >  { }
> >
> > +static inline void audit_tk_injoffset(struct timespec64 offset)
> > +{ }
> > +
> > +static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > +{ }
> > +
> >  static inline void audit_ptrace(struct task_struct *t)
> >  { }
> >  #define audit_n_rules 0
> > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > index 4e3eaba84175..242ce562b41a 100644
> > --- a/include/uapi/linux/audit.h
> > +++ b/include/uapi/linux/audit.h
> > @@ -114,6 +114,8 @@
> >  #define AUDIT_REPLACE          1329    /* Replace auditd if this packet unanswerd */
> >  #define AUDIT_KERN_MODULE      1330    /* Kernel Module events */
> >  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
> > +#define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
> > +#define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> >
> >  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant */
> >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > index fb207466e99b..d355d32d9765 100644
> > --- a/kernel/auditsc.c
> > +++ b/kernel/auditsc.c
> > @@ -2422,6 +2422,21 @@ void __audit_fanotify(unsigned int response)
> >                 AUDIT_FANOTIFY, "resp=%u", response);
> >  }
> >
> > +/* We need to allocate with GFP_ATOMIC here, since these two functions will be
> > + * called while holding the timekeeping lock: */
> > +void __audit_tk_injoffset(struct timespec64 offset)
> > +{
> > +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
> > +                 "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
> > +}
> > +
> > +void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > +{
> > +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_ADJNTPVAL,
> > +                 "op=%s old=%lli new=%lli", type,
> > +                 (long long)oldval, (long long)newval);
> > +}
>
> So it looks like you've been careful here, but just want to make sure,
> nothing in the audit_log path calls anything that might possibly call
> back into timekeeping code? We've had a number of issues over time
> where debug calls out to other subsystems end up getting tweaked to
> add some timestamping and we deadlock.  :)

Hm, that's a good point... AFAIK, the only place where audit_log()
might call into timekeeping is when it captures the timestamp for the
record (via ktime_get_coarse_real_ts64()), but this is only called
when the functions are called outside of a syscall and that should
never happen here. I'm thinking I could harden this more by returning
early from these functions if WARN_ON_ONCE(!audit_context() ||
!audit_context()->in_syscall)... It is not a perfect solution, but at
least there will be something in the code reminding us about this
issue.

>
> One approach we've done to make sure we don't create a trap for future
> changes in other subsystems, is avoid calling into other subsystems
> until later when we've dropped the locks, (see clock_was_set).  Its a
> little rough for some of the things done deep in the ntp code, but
> might be an extra cautious approach to try.

I'm afraid that delaying the audit_* calls would complicate things too
much here... Paul/Richard, any thoughts?

--
Ondrej Mosnacek <omosnace at redhat dot com>
Associate Software Engineer, Security Technologies
Red Hat, Inc.
