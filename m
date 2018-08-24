Return-Path: <SRS0=6SfI=LH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49795C433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE00F21477
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Aug 2018 18:33:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Le18FBhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE00F21477
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbeHXWI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Aug 2018 18:08:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34234 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbeHXWI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Aug 2018 18:08:56 -0400
Received: by mail-wm0-f66.google.com with SMTP id m199-v6so4883236wma.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Aug 2018 11:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=68TodATwyQ8q+tJSMPrlzLpct6ImMwswJQejaPcpD3M=;
        b=Le18FBhJmadSC0YiUul6Ka+7nxVgHBuxrd0lGH7n4QouWWa2NAVTf4YLeh/Oy7UcSf
         2btoMV8/evRUI+Cu8THzo/73TEwPPbXQmPovC5VIaYqIRMDrv2Ks8WWKWVKn/vUlR7tn
         jIv4aXTaVIQm2VefK4nmvmJKfVX5e1Qo1bEek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=68TodATwyQ8q+tJSMPrlzLpct6ImMwswJQejaPcpD3M=;
        b=OIll0DfBWoz32lO0x1kRvo28SsiVj0NXUPOsXJ6vkM23UYUD2gLtfgqIe7/JIdoKHK
         VEMtmG3cSrkEqW4Ro/QiiHNrXON4Jiz8EicGrfNsSyO5IeELWlJ1P2HO4pBUGPi1bRv3
         qC43S4JiFOpjIA1oXPFifxl6ts4Bnm1IL8TXPtXTk59wu08gSXX2TuWiCvUeiZA536Xl
         culMd6sEbegERBTj5RXQ8sGD9Us+O+8+50nvJurJtKmNrFo1PZxdbdV9WL+5EtNxR1iN
         ydrgRgW2PhNnehq8TxY1NlZIC9aTVtvpdXiN/Pme6yJUHCXjPQryTHfdo1EtG6ITEnqv
         4Buw==
X-Gm-Message-State: APzg51ATotultiD/i8gQURJ2r8aX29MRBbtMXDwj/y5WLU9WbvbJfuRo
        JML7b/ItlgT4kwa3h07H7xUk7tZfXLPCHO5eKZgGHQ==
X-Google-Smtp-Source: ANB0VdZ3hWk9j57pZa5rlwZXSac6zYrixVyxt+AgPBgzfttTFz7TfpFgcU9v1ISN+yw3I9kKwpVnrSsgvsNFIJV5UBU=
X-Received: by 2002:a1c:1c92:: with SMTP id c140-v6mr1969147wmc.155.1535135587574;
 Fri, 24 Aug 2018 11:33:07 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a1c:c243:0:0:0:0:0 with HTTP; Fri, 24 Aug 2018 11:33:06
 -0700 (PDT)
In-Reply-To: <20180824120001.20771-2-omosnace@redhat.com>
References: <20180824120001.20771-1-omosnace@redhat.com> <20180824120001.20771-2-omosnace@redhat.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Fri, 24 Aug 2018 11:33:06 -0700
Message-ID: <CALAqxLU7UyCqs9t8E+UV7BQvfYOSB6mdYB2f5RYmu_mb76i7VA@mail.gmail.com>
Subject: Re: [PATCH ghak10 v5 1/2] audit: Add functions to log time adjustments
To:     Ondrej Mosnacek <omosnace@redhat.com>
Cc:     linux-audit@redhat.com, Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 24, 2018 at 5:00 AM, Ondrej Mosnacek <omosnace@redhat.com> wrote:
> This patch adds two auxiliary record types that will be used to annotate
> the adjtimex SYSCALL records with the NTP/timekeeping values that have
> been changed.
>
> Next, it adds two functions to the audit interface:
>  - audit_tk_injoffset(), which will be called whenever a timekeeping
>    offset is injected by a syscall from userspace,
>  - audit_ntp_adjust(), which will be called whenever an NTP internal
>    variable is changed by a syscall from userspace.
>
> Quick reference for the fields of the new records:
>     AUDIT_TIME_INJOFFSET
>         sec - the 'seconds' part of the offset
>         nsec - the 'nanoseconds' part of the offset
>     AUDIT_TIME_ADJNTPVAL
>         op - which value was adjusted:
>             offset - corresponding to the time_offset variable
>             freq   - corresponding to the time_freq variable
>             status - corresponding to the time_status variable
>             adjust - corresponding to the time_adjust variable
>             tick   - corresponding to the tick_usec variable
>             tai    - corresponding to the timekeeping's TAI offset
>         old - the old value
>         new - the new value
>
> Signed-off-by: Ondrej Mosnacek <omosnace@redhat.com>
> ---
>  include/linux/audit.h      | 21 +++++++++++++++++++++
>  include/uapi/linux/audit.h |  2 ++
>  kernel/auditsc.c           | 15 +++++++++++++++
>  3 files changed, 38 insertions(+)
>
> diff --git a/include/linux/audit.h b/include/linux/audit.h
> index 9334fbef7bae..0d084d4b4042 100644
> --- a/include/linux/audit.h
> +++ b/include/linux/audit.h
> @@ -26,6 +26,7 @@
>  #include <linux/sched.h>
>  #include <linux/ptrace.h>
>  #include <uapi/linux/audit.h>
> +#include <uapi/linux/timex.h>
>
>  #define AUDIT_INO_UNSET ((unsigned long)-1)
>  #define AUDIT_DEV_UNSET ((dev_t)-1)
> @@ -356,6 +357,8 @@ extern void __audit_log_capset(const struct cred *new, const struct cred *old);
>  extern void __audit_mmap_fd(int fd, int flags);
>  extern void __audit_log_kern_module(char *name);
>  extern void __audit_fanotify(unsigned int response);
> +extern void __audit_tk_injoffset(struct timespec64 offset);
> +extern void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval);
>
>  static inline void audit_ipc_obj(struct kern_ipc_perm *ipcp)
>  {
> @@ -458,6 +461,18 @@ static inline void audit_fanotify(unsigned int response)
>                 __audit_fanotify(response);
>  }
>
> +static inline void audit_tk_injoffset(struct timespec64 offset)
> +{
> +       if (!audit_dummy_context())
> +               __audit_tk_injoffset(offset);
> +}
> +
> +static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> +{
> +       if (!audit_dummy_context())
> +               __audit_ntp_adjust(type, oldval, newval);
> +}
> +
>  extern int audit_n_rules;
>  extern int audit_signals;
>  #else /* CONFIG_AUDITSYSCALL */
> @@ -584,6 +599,12 @@ static inline void audit_log_kern_module(char *name)
>  static inline void audit_fanotify(unsigned int response)
>  { }
>
> +static inline void audit_tk_injoffset(struct timespec64 offset)
> +{ }
> +
> +static inline void audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> +{ }
> +
>  static inline void audit_ptrace(struct task_struct *t)
>  { }
>  #define audit_n_rules 0
> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
> index 4e3eaba84175..242ce562b41a 100644
> --- a/include/uapi/linux/audit.h
> +++ b/include/uapi/linux/audit.h
> @@ -114,6 +114,8 @@
>  #define AUDIT_REPLACE          1329    /* Replace auditd if this packet unanswerd */
>  #define AUDIT_KERN_MODULE      1330    /* Kernel Module events */
>  #define AUDIT_FANOTIFY         1331    /* Fanotify access decision */
> +#define AUDIT_TIME_INJOFFSET   1332    /* Timekeeping offset injected */
> +#define AUDIT_TIME_ADJNTPVAL   1333    /* NTP value adjustment */
>
>  #define AUDIT_AVC              1400    /* SE Linux avc denial or grant */
>  #define AUDIT_SELINUX_ERR      1401    /* Internal SE Linux Errors */
> diff --git a/kernel/auditsc.c b/kernel/auditsc.c
> index fb207466e99b..d355d32d9765 100644
> --- a/kernel/auditsc.c
> +++ b/kernel/auditsc.c
> @@ -2422,6 +2422,21 @@ void __audit_fanotify(unsigned int response)
>                 AUDIT_FANOTIFY, "resp=%u", response);
>  }
>
> +/* We need to allocate with GFP_ATOMIC here, since these two functions will be
> + * called while holding the timekeeping lock: */
> +void __audit_tk_injoffset(struct timespec64 offset)
> +{
> +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_INJOFFSET,
> +                 "sec=%lli nsec=%li", (long long)offset.tv_sec, offset.tv_nsec);
> +}
> +
> +void __audit_ntp_adjust(const char *type, s64 oldval, s64 newval)
> +{
> +       audit_log(audit_context(), GFP_ATOMIC, AUDIT_TIME_ADJNTPVAL,
> +                 "op=%s old=%lli new=%lli", type,
> +                 (long long)oldval, (long long)newval);
> +}

So it looks like you've been careful here, but just want to make sure,
nothing in the audit_log path calls anything that might possibly call
back into timekeeping code? We've had a number of issues over time
where debug calls out to other subsystems end up getting tweaked to
add some timestamping and we deadlock.  :)

One approach we've done to make sure we don't create a trap for future
changes in other subsystems, is avoid calling into other subsystems
until later when we've dropped the locks, (see clock_was_set).  Its a
little rough for some of the things done deep in the ntp code, but
might be an extra cautious approach to try.

thanks
-john
