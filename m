Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C32ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16585214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 12:33:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16585214C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbeIQSAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 14:00:44 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:35322 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728134AbeIQSAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 14:00:44 -0400
Received: by mail-ot1-f68.google.com with SMTP id j9-v6so11067204otl.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Sep 2018 05:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y5WQS/sTXMN9TisiTsd4I1nHFk7LAGf32Y4VNo8iLTk=;
        b=PudHBh/oC1wHTOKkyssrxB3xfILKnMXZslWozoLlKpk9pTxaO2Sce1KmdudzI9BIEr
         DF3eZvI3rZ9528DOLtlf+uFlLt/cimt631NAF6PoiModMSMxvtUew3vaLcwUoNpbsqOH
         cgeWspTTEmXfu4J8g54Yg7ThyANF3hvSiaN6e1p38WE3/tIepX9K+b4y9WvBBuL2c2V4
         Cwqqt8GjoED3GTAQjEdNzZzw4G7SKeUzEQhVAtE6faMpk3gsZ8ZMybm0WeFihOLtU7fn
         7Sk9EZGqEyfMDN+Y9pWcsEG7ZZiMjb6UBMP5e0dZJbWDPcuH5w5Q7vVmcjUWQj8vckg9
         2o8g==
X-Gm-Message-State: APzg51DHioqLcn23KWPgv3k7UUSk0TS+jJl/OIfucbZyuT/bs5IcW3Os
        0CYcdGD+bgs1PiZ9KCTJOouUuQBRp1HSMfF0YHz+OA==
X-Google-Smtp-Source: ANB0VdYVsTnM5zfo4Z6mLw2AYynJCWpfTwq5m33qxxssAU/y7UKpztIb0ogy7xfgXalqVXwjfMZblq+0YYotPqeBVq0=
X-Received: by 2002:a9d:2486:: with SMTP id z6-v6mr13298522ota.230.1537187616091;
 Mon, 17 Sep 2018 05:33:36 -0700 (PDT)
MIME-Version: 1.0
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
 <CALAqxLU7UyCqs9t8E+UV7BQvfYOSB6mdYB2f5RYmu_mb76i7VA@mail.gmail.com>
 <CAFqZXNsZSN=pVupOHZwam8k9V357sA7KPuK3EjtZ=hPRrr1ocA@mail.gmail.com> <20180913155418.regeoj6veiivpvlt@madcap2.tricolour.ca>
In-Reply-To: <20180913155418.regeoj6veiivpvlt@madcap2.tricolour.ca>
From:   Ondrej Mosnacek <omosnace@redhat.com>
Date:   Mon, 17 Sep 2018 14:33:24 +0200
Message-ID: <CAFqZXNt=5hFVG8+8OYvp1q9LEp_voCG1CzvxpdJCBdxMNovJGQ@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     John Stultz <john.stultz@linaro.org>,
        Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
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

On Thu, Sep 13, 2018 at 5:59 PM Richard Guy Briggs <rgb@redhat.com> wrote:
> On 2018-08-27 10:28, Ondrej Mosnacek wrote:
> > On Fri, Aug 24, 2018 at 8:33 PM John Stultz <john.stultz@linaro.org> wrote:
> > > On Fri, Aug 24, 2018 at 5:00 AM, Ondrej Mosnacek <omosnace@redhat.com> wrote:
> > > > This patch adds two auxiliary record types that will be used to annotate
> > > > the adjtimex SYSCALL records with the NTP/timekeeping values that have
> > > > been changed.
> > > >
> > > > Next, it adds two functions to the audit interface:
> > > >  - audit_tk_injoffset(), which will be called whenever a timekeeping
> > > >    offset is injected by a syscall from userspace,
> > > >  - audit_ntp_adjust(), which will be called whenever an NTP internal
> > > >    variable is changed by a syscall from userspace.
> > > >
> > > > Quick reference for the fields of the new records:
> > > >     AUDIT_TIME_INJOFFSET
> > > >         sec - the 'seconds' part of the offset
> > > >         nsec - the 'nanoseconds' part of the offset
> > > >     AUDIT_TIME_ADJNTPVAL
> > > >         op - which value was adjusted:
> > > >             offset - corresponding to the time_offset variable
> > > >             freq   - corresponding to the time_freq variable
> > > >             status - corresponding to the time_status variable
> > > >             adjust - corresponding to the time_adjust variable
> > > >             tick   - corresponding to the tick_usec variable
> > > >             tai    - corresponding to the timekeeping's TAI offset
> > > >         old - the old value
> > > >         new - the new value
> > > >
> > > > Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> > > > ---
> > > >  include/linux/audit.h      | 21 +++++++++++++++++++++
> > > >  include/uapi/linux/audit.h |  2 ++
> > > >  kernel/auditsc.c           | 15 +++++++++++++++
> > > >  3 files changed, 38 insertions(+)
> > > >
> > > > diff --git a/include/linux/audit.h b/include/linux/audit.h
> > > > index 9334fbef7bae..0d084d4b4042 100644
> > > > --- a/include/linux/audit.h
> > > > +++ b/include/linux/audit.h
> > > > @@ -26,6 +26,7 @@
> > > >  #include <linux/sched.h>
> > > >  #include <linux/ptrace.h>
> > > >  #include <uapi/linux/audit.h>
> > > > +#include <uapi/linux/timex.h>
> > > >
> > > >  #define AUDIT_INO_UNSET ((unsigned long)-1)
> > > >  #define AUDIT_DEV_UNSET ((dev_t)-1)
> > > > @@ -356,6 +357,8 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
> > > >  extern void __audit_mmap_fd(int fd, int flags);
> > > >  extern void __audit_log_kern_module(char *name);
> > > >  extern void __audit_fanotify(unsigned int response);
> > > > +extern void __audit_tk_injoffset(struct timespec64 offset);
> > > > +extern void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval);
> > > >
> > > >  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
> > > >  {
> > > > @@ -458,6 +461,18 @@ static inline void audit_fanotify(unsigned int response)
> > > >                 __audit_fanotify(response);
> > > >  }
> > > >
> > > > +static inline void audit_tk_injoffset(struct timespec64 offset)
> > > > +{
> > > > +       if (!audit_dummy_context())
> > > > +               __audit_tk_injoffset(offset);
> > > > +}
> > > > +
> > > > +static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > > > +{
> > > > +       if (!audit_dummy_context())
> > > > +               __audit_ntp_adjust(type, oldval, newval);
> > > > +}
> > > > +
> > > >  extern int audit_n_rules;
> > > >  extern int audit_signals;
> > > >  #else /* CONFIG_AUDITSYSCALL */
> > > > @@ -584,6 +599,12 @@ static inline void audit_log_kern_module(char *name)
> > > >  static inline void audit_fanotify(unsigned int response)
> > > >  { }
> > > >
> > > > +static inline void audit_tk_injoffset(struct timespec64 offset)
> > > > +{ }
> > > > +
> > > > +static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > > > +{ }
> > > > +
> > > >  static inline void audit_ptrace(struct task_struct *t)
> > > >  { }
> > > >  #define audit_n_rules 0
> > > > diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> > > > index 4e3eaba84175..242ce562b41a 100644
> > > > --- a/include/uapi/linux/audit.h
> > > > +++ b/include/uapi/linux/audit.h
> > > > @@ -114,6 +114,8 @@
> > > >  #define AUDIT_REPLACE          1329    /* Replace auditd if this packet unanswerd */
> > > >  #define AUDIT_KERN_MODULE      1330    /* Kernel Module events */
> > > >  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
> > > > +#define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
> > > > +#define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
> > > >
> > > >  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant */
> > > >  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> > > > diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> > > > index fb207466e99b..d355d32d9765 100644
> > > > --- a/kernel/auditsc.c
> > > > +++ b/kernel/auditsc.c
> > > > @@ -2422,6 +2422,21 @@ void __audit_fanotify(unsigned int response)
> > > >                 AUDIT_FANOTIFY, "resp=%u", response);
> > > >  }
> > > >
> > > > +/* We need to allocate with GFP_ATOMIC here, since these two functions will be
> > > > + * called while holding the timekeeping lock: */
> > > > +void __audit_tk_injoffset(struct timespec64 offset)
> > > > +{
> > > > +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
> > > > +                 "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
> > > > +}
> > > > +
> > > > +void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> > > > +{
> > > > +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_ADJNTPVAL,
> > > > +                 "op=%s old=%lli new=%lli", type,
> > > > +                 (long long)oldval, (long long)newval);
> > > > +}
> > >
> > > So it looks like you've been careful here, but just want to make sure,
> > > nothing in the audit_log path calls anything that might possibly call
> > > back into timekeeping code? We've had a number of issues over time
> > > where debug calls out to other subsystems end up getting tweaked to
> > > add some timestamping and we deadlock.  :)
> >
> > Hm, that's a good point... AFAIK, the only place where audit_log()
> > might call into timekeeping is when it captures the timestamp for the
> > record (via ktime_get_coarse_real_ts64()), but this is only called
> > when the functions are called outside of a syscall and that should
> > never happen here. I'm thinking I could harden this more by returning
> > early from these functions if WARN_ON_ONCE(!audit_context() ||
> > !audit_context()->in_syscall)... It is not a perfect solution, but at
> > least there will be something in the code reminding us about this
> > issue.
>
> It looks like this should be safe already since if there is no context,
> it won't call into the real audit logging function and as you point out,
> this should never happen outside of a syscall.
>
> > > One approach we've done to make sure we don't create a trap for future
> > > changes in other subsystems, is avoid calling into other subsystems
> > > until later when we've dropped the locks, (see clock_was_set).  Its a
> > > little rough for some of the things done deep in the ntp code, but
> > > might be an extra cautious approach to try.
> >
> > I'm afraid that delaying the audit_* calls would complicate things too
> > much here... Paul/Richard, any thoughts?
>
> The other way to address this would be to have your timekeeping audit
> logging functions save the parameters you want to log somewhere in the
> struct audit_context union and have it print the record on syscall exit
> based on the presence of this type and applicable filters.

Yes, I thought about that, but it doesn't seem to be worth the hassle.
I think I'll just add the paranoid WARN_ON_ONCE(...) unless there are
strong objections to that.

>
> > Ondrej Mosnacek <omosnace at redhat dot com>
>
> - RGB
>
> --
> Richard Guy Briggs <rgb@redhat.com>
> Sr. S/W Engineer, Kernel Security, Base Operating Systems
> Remote, Ottawa, Red Hat Canada
> IRC: rgb, SunRaycer
> Voice: +1.647.777.2635, Internal: (81) 32635

--
Ondrej Mosnacek <omosnace at redhat dot com>Associate Software
Engineer, Security Technologies
Red Hat, Inc.
