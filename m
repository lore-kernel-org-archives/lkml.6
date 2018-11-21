Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110BAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF337206B2
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 22:40:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uqsfKe5r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF337206B2
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390240AbeKVJRG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 04:17:06 -0500
Received: from mail-vk1-f194.google.com ([209.85.221.194]:42712 "EHLO
        mail-vk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390227AbeKVJRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 04:17:05 -0500
Received: by mail-vk1-f194.google.com with SMTP id y14so1595509vky.9
        for <linux-kernel@vger.kernel.org>; Wed, 21 Nov 2018 14:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M9tjA2lexfD1mUkUX1Fi8axcHOA8khiAorvZefsr+Tc=;
        b=uqsfKe5rzzL+6gPwo7cGlTd5Xx09B/Myn22adVg6PEaMepPKfFOCFWojESzUMBW3SU
         /932QBoqHLtPy+kDFg1kwKrLLtysnqw8BG5Xk5BR+AsEk2hgU95C/GjLadLOjR7b/N/o
         aConQjXLLUfKug2PXGlqbh4pp8ebE7hBEwWO4ou+vZmq2r6yEDEpYrN6PpkK0jGbCoJb
         snx2U9Kcfn4YwUBKWVqWjFZtb7UApu0BX99Ao0wpX6lW2QoUhYpfrcp1ds5k+pxsn/LU
         hBxp46Je3Q8g6x6iWAYmwDtWMGg3UDWnJzH36XYgXX6FuxfaifY0GH/Com+IjzKz539a
         jsDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M9tjA2lexfD1mUkUX1Fi8axcHOA8khiAorvZefsr+Tc=;
        b=D3OOYMd6gSpjX1+dTTEYlXgTHR5QwlpdJZBjT1Z1zZMGwrpHWD9CJohIloDkIzLRYG
         e7IPIzBGsLCLZWgeyPG3BmP5O+ssvvq4vZ+feM9fkf8PyaU3iDEaWMmZAm53r/SuSsfK
         p2/DAjp7oLsMPwVWCM4ReLz7EdMviIc7c0vWA1A2tBArUtKVyFJriRLJrvhFJXboQT7g
         dBjVPPHncrBJiQT4sghVqFZpf1ZPfvzfaufBDZ7gKIfoPSLimH1rXVdexMuHfAllS2nd
         OajEGQ7oB6xniINcXkkwRI0vbPYfh+vZsCZq/RtAkSt4QGv+pVp8IAZ8TocaN5RtU1q4
         WqHg==
X-Gm-Message-State: AA+aEWav6ZPgN6MFCJFqszEgm0Pwk4NaVkBVxxTyps4K9HZzOHJ6+V6O
        k9ulos3bkVgLu7sLduUTWZ86p94kAXyjbLCzyzjUiA==
X-Google-Smtp-Source: AFSGD/XH5l7580bYLiOc11AS6/k9kpzLgMYMGaVKygtKnxG1pw58HUw0AsNmAaWOumbp/c22tmBfe8yHVM+738jKxEA=
X-Received: by 2002:a1f:7cca:: with SMTP id x193mr3620786vkc.89.1542840040673;
 Wed, 21 Nov 2018 14:40:40 -0800 (PST)
MIME-Version: 1.0
References: <20181121201452.77173-1-dancol@google.com> <20181121205428.165205-1-dancol@google.com>
 <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
In-Reply-To: <20181121141220.0e533c1dcb4792480efbf3ff@linux-foundation.org>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 21 Nov 2018 14:40:28 -0800
Message-ID: <CAKOZuetW6WMNFdL5_2=UbrEf8mjxYTdz1+4BiRLSgdoKh8FsqQ@mail.gmail.com>
Subject: Re: [PATCH v2] Add /proc/pid_gen
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Primiano Tucci <primiano@google.com>,
        Joel Fernandes <joelaf@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Prashant Dhamdhere <pdhamdhe@redhat.com>,
        "Dennis Zhou (Facebook)" <dennisszhou@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>, rostedt@goodmis.org,
        tglx@linutronix.de, mingo@kernel.org, linux@dominikbrodowski.net,
        jpoimboe@redhat.com, ard.biesheuvel@linaro.org,
        Michal Hocko <mhocko@suse.com>, sfr@canb.auug.org.au,
        ktsanaktsidis@zendesk.com, David Howells <dhowells@redhat.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2018 at 2:12 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 21 Nov 2018 12:54:20 -0800 Daniel Colascione <dancol@google.com> wrote:
>
> > Trace analysis code needs a coherent picture of the set of processes
> > and threads running on a system. While it's possible to enumerate all
> > tasks via /proc, this enumeration is not atomic. If PID numbering
> > rolls over during snapshot collection, the resulting snapshot of the
> > process and thread state of the system may be incoherent, confusing
> > trace analysis tools. The fundamental problem is that if a PID is
> > reused during a userspace scan of /proc, it's impossible to tell, in
> > post-processing, whether a fact that the userspace /proc scanner
> > reports regarding a given PID refers to the old or new task named by
> > that PID, as the scan of that PID may or may not have occurred before
> > the PID reuse, and there's no way to "stamp" a fact read from the
> > kernel with a trace timestamp.
> >
> > This change adds a per-pid-namespace 64-bit generation number,
> > incremented on PID rollover, and exposes it via a new proc file
> > /proc/pid_gen. By examining this file before and after /proc
> > enumeration, user code can detect the potential reuse of a PID and
> > restart the task enumeration process, repeating until it gets a
> > coherent snapshot.
> >
> > PID rollover ought to be rare, so in practice, scan repetitions will
> > be rare.
>
> In general, tracing is a rather specialized thing.  Why is this very
> occasional confusion a sufficiently serious problem to warrant addition
> of this code?

I wouldn't call tracing a specialized thing: it's important enough to
justify its own summit and a whole ecosystem of trace collection and
analysis tools. We use it in every day in Android. It's tremendously
helpful for understanding system behavior, especially in cases where
multiple components interact in ways that we can't readily predict or
replicate. Reliability and precision in this area are essential:
retrospective analysis of difficult-to-reproduce problems involves
puzzling over trace files and testing hypothesis, and when the trace
system itself is occasionally unreliable, the set of hypothesis to
consider grows. I've tried to keep the amount of kernel infrastructure
needed to support this precision and reliability to a minimum, pushing
most of the complexity to userspace. But we do need, from the kernel,
reliable process disambiguation.

Besides: things like checkpoint and restart are also non-core
features, but the kernel has plenty of infrastructure to support them.
We're talking about a very lightweight feature in this thread.

> Which userspace tools will be using pid_gen?  Are the developers of
> those tools signed up to use pid_gen?

I'll be changing Android tracing tools to capture process snapshots
using pid_gen, using the algorithm in the commit message.

> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -112,6 +112,7 @@ extern struct pid *find_ge_pid(int nr, struct pid_namespace *);
> >  int next_pidmap(struct pid_namespace *pid_ns, unsigned int last);
> >
> >  extern struct pid *alloc_pid(struct pid_namespace *ns);
> > +extern u64 read_pid_generation(struct pid_namespace *ns);
>
> pig_generation_read() would be a better (and more idiomatic) name.

Thanks. I'll change it.

>
> >  extern void free_pid(struct pid *pid);
> >  extern void disable_pid_allocation(struct pid_namespace *ns);
> >
> > ...
> >
> > +u64 read_pid_generation(struct pid_namespace *ns)
> > +{
> > +     u64 generation;
> > +
> > +
> > +     spin_lock_irq(&pidmap_lock);
> > +     generation = ns->generation;
> > +     spin_unlock_irq(&pidmap_lock);
> > +     return generation;
> > +}
>
> What is the spinlocking in here for?  afaict the only purpose it serves
> is to make the 64-bit read atomic, so it isn't needed on 32-bit?

ITYM the spinlock is necessary *only* on 32-bit, since 64-bit
architectures have atomic 64-bit reads, and 64-bit reads on 32-bit
architectures can tear. This function isn't a particularly hot path,
so I thought consistency across architectures would be more valuable
than avoiding the lock on some systems.

> >  void disable_pid_allocation(struct pid_namespace *ns)
> >  {
> >       spin_lock_irq(&pidmap_lock);
> > @@ -449,6 +463,17 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
> >       return idr_get_next(&ns->idr, &nr);
> >  }
> >
> > +#ifdef CONFIG_PROC_FS
> > +static int pid_generation_show(struct seq_file *m, void *v)
> > +{
> > +     u64 generation =
> > +             read_pid_generation(proc_pid_ns(file_inode(m->file)));
>
>         u64 generation;
>
>         generation = read_pid_generation(proc_pid_ns(file_inode(m->file)));
>
> is a nicer way of avoiding column wrap.

Sure.

> > +     seq_printf(m, "%llu\n", generation);
> > +     return 0;
> > +
> > +};
> > +#endif
> > +
> >  void __init pid_idr_init(void)
> >  {
> >       /* Verify no one has done anything silly: */
> > @@ -465,4 +490,13 @@ void __init pid_idr_init(void)
> >
> >       init_pid_ns.pid_cachep = KMEM_CACHE(pid,
> >                       SLAB_HWCACHE_ALIGN | SLAB_PANIC | SLAB_ACCOUNT);
> > +
> > +}
> > +
> > +void __init pid_proc_init(void)
> > +{
> > +     /* pid_idr_init is too early, so get a separate init function. */
>
> s/get a/use a/

Will change.

> > +#ifdef CONFIG_PROC_FS
> > +     WARN_ON(!proc_create_single("pid_gen", 0, NULL, pid_generation_show));
> > +#endif
> >  }
>
> This whole function could vanish if !CONFIG_PROC_FS.  Doesn't matter
> much with __init code though.

I wanted to keep the ifdefed region as small as possible. I wonder
whether LTO is good enough to make the function and its call site
disappear entirely in configurations where it has an empty body.
