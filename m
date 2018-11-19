Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4855BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32F32086B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 01:14:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VewVnrcG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32F32086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbeKSLgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 06:36:25 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:34847 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeKSLgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 06:36:24 -0500
Received: by mail-vs1-f65.google.com with SMTP id e7so16836895vsc.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Nov 2018 17:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=pqdz3qt5+8c+QF9jBJATRrusibJ0aQtAU8JPX+VSrxk=;
        b=VewVnrcGBqgJqdsNOHS3WDia6h78KGCatzthPtfrklMtuSZ4hpLeWF6UcRaejV1e8k
         mvsrEYSYBtUwfmOqMxuC3idHH3s93Nf1UzscOWEZPsToQBuu/t0S3+xhEg4y4T+8qEF6
         kdGvSrQwOkDKpw1arNwTc8pQ9RsCs3HikduD12UoS4j9bCj4TWylR6vujJWZJc2XCxvu
         T8nS8n/hbrL0t76FyuhNIW/ge+SGaN0p8hyvKraQ0fAazWuTI6TnVp7BOmWdpMzNRxo8
         b7Vx1noOeu4aSYlOMqJ/EBsXml0yBZ3XNT+dGKUtjnkOxeCyup0BIYrXBsZrKLHw6Liq
         gE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=pqdz3qt5+8c+QF9jBJATRrusibJ0aQtAU8JPX+VSrxk=;
        b=WFwmZR5eNaW1LDZ4INX7zxgHJwcruCY0Q2+9sLxRzLeD/0f0WYr5DOPIelPts+iQOe
         wDhzBeiMuHCsbreMjDVjKz/Iid8V9uJSwV4WAzFijfMYg7VCsu+rP5AGAUbHnTyLV8o7
         M7g5W27HfE8YuIfVSkBlK+E3EekpUnX4qDbMxUrSdVTyzlMv7AG9EzoFzB0bCRfm1omp
         SgH8v5onDpN6dp3F9I9hqpkJGslen+oFuFTvyluTtIpYRyNyo9XmFs4890PaJyEta089
         Ya+TpA1ilhWUUrY4n6endBXIocKdqjwLegZSr96jEujEJM+YuHJUi7fsYv7CcHDL0iYv
         dpeA==
X-Gm-Message-State: AGRZ1gLs4cSfc8tGAPhrbStVDEvRfy+qNGiHnWu5cKuzLyVlLnQfro6A
        /w4UviwI/SgdThyFINDY6OvncOtaSCdKgNkGNDRDNA==
X-Google-Smtp-Source: AJdET5eSZlNqFWj+zWmJ9H1tmntL9TmgVmvnE67opBp5aLgxb7dvWsJJ1hdbEc8JM3OCuhV0RRJPQPqV8eriw8M9DJI=
X-Received: by 2002:a67:105:: with SMTP id 5mr8103366vsb.183.1542590067404;
 Sun, 18 Nov 2018 17:14:27 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Sun, 18 Nov 2018 17:14:25
 -0800 (PST)
In-Reply-To: <20181119000857.rnkuqdpmcutrwtem@yavin>
References: <20181118111751.6142-1-christian@brauner.io> <CAKOZuet3s0WxxPgrtrNkq8YiOWhYAiK6yEio6PKVV9J_H4_TSA@mail.gmail.com>
 <CALCETrUd2Y2MmO8Qx8aUvQDOTNiyj35Y7bctPBZe0p2i1EUiLw@mail.gmail.com>
 <20181118174148.nvkc4ox2uorfatbm@brauner.io> <CAKOZueto1CmUSWFKjOkazcDcZH6CiXXCr4U=ghewLh8GjE2-=A@mail.gmail.com>
 <20181119000857.rnkuqdpmcutrwtem@yavin>
From:   Daniel Colascione <dancol@google.com>
Date:   Sun, 18 Nov 2018 17:14:25 -0800
Message-ID: <CAKOZueuBwZyof72j4=L2_uwF+AWYWZOgCBz4DNq6z_rdAYybZg@mail.gmail.com>
Subject: Re: [PATCH] proc: allow killing processes via file descriptors
To:     Aleksa Sarai <cyphar@cyphar.com>
Cc:     Christian Brauner <christian@brauner.io>,
        Andy Lutomirski <luto@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Kees Cook <keescook@chromium.org>,
        David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 18, 2018 at 4:08 PM, Aleksa Sarai <cyphar@cyphar.com> wrote:
> On 2018-11-18, Daniel Colascione <dancol@google.com> wrote:
>> > The gist is to have file descriptors for processes which is obviously not a new
>> > idea. This has been done before in other OSes and it has been tried before in
>> > Linux [2], [3] (Thanks to Kees for pointing out these patches.). So I want to
>> > make it very clear that I'm not laying claim to this being my or even a novel
>> > idea in any way. However, I want to diverge from previous approaches with my
>> > suggestion. (Though I can't be sure that there's not something similar in other
>> > OSes already.)
>>
>> Windows works basically as you describe. You can create a process is
>> suspended state, configure it however you want, then let it run.
>> CreateProcess (and even moreso, NtCreateProcess) also provide a rich
>> (and *extensible*) interface for pre-creation process configuration.
>>
>> >> One of the main motivations for having procfds is to have a race-free way of
>> > configuring, starting, polling, and killing a process. Basically, a process
>> > lifecycle api if you want to think about it that way. The api should also be
>> > easily extendable in the future to avoid running into the limitations we
>> > currently see with the clone*() syscall(s) again.
>> >
>> > One of the crucial points of the api is to *separate the configuration
>> > of a process through a procfd from actually creating the process*.
>> > This is a crucial property expressed in the open*() system calls. First, get a
>> > stable handle on an object then allow for ways to configure it. As such the
>> > procfd api shares the same insight with Al's and David's new mount api.
>> > (Fwiw, Andy also pointed out similarities with posix_spawn().)
>> > What I envisioned was to have the following syscalls (multiple name suggestions):
>> >
>> > 1. int process_open / proc_open / procopen
>> > 2. int process_config / proc_config / procconfig or ioctl()-based
>> > 3. int process_info / proc_info / procinfo or ioctl()-based
>> > 4. int process_manage / proc_manage / procmanage or ioctl()-based
>>
>> The API you've proposed seems fine to me, although I'd either 1)
>> consolidate operations further into one system call, or 2) separate
>> the different management operations into more and different system
>> calls that can be audited independently. The grouping you've proposed
>> seems to have the worst aspects of API splitting and API multiplexing.
>> But I have no objection to it in spirit.
>
> I think combining it all into one API is going to be a soft re-invention
> of ioctls, but specifically for procfds. This would be an improvement
> over just ioctls (since the current ioctl namespacing is based on
> well-behaved drivers and hoping we never have more than 256 ioctl
> drivers), but I'm not sure it would help make the API nicer than having
> separate syscalls (we'd have to do something similar to bpf(2) which I'm
> not a huge fan of).

Right. Multiplexers are nothing new, and I'm not a huge fan of them.
From an API design perspective, having a bunch of different system
calls is probably best.

 (I do wonder what happens to system call cache behavior once the
top-level system call table becomes huge though.)

>> That said, while I do want to fix process configuration and startup
>> generally, I want to fix specific holes in the existing API surface
>> first. The two patches I've already sent do that, and this work
>> shouldn't wait on an ideal larger process-API overhaul that may or may
>> not arrive. Based on previous history, I suspect that an API of the
>> scope you're proposing would take years to overcome all LKML
>> objections and land. I don't want to wait that long when we can make
>> smaller fixes that would not conflict with the general architecture.
>
> I believe this is precisely what Christian is trying to do with this
> patch (and you say as much later in your mail).
>
> I think that adding all of {sighand,sighand_exitcode,kill,...} would not
> help the path of landing a much larger API change. We should instead
> think about the API we want at the end of the day, and then land smaller
> changes which are long-term compatible (and won't just become deprecated
> APIs -- there's far too many of them, let's not add more needlessly).

I don't think we need to reach consensus on some long-term design to
address specific problems that we know today. The changes we're
talking about here *are* long-term compatible with a bigger process
API overhaul. They may or may not be *part* of that solution, but I
don't see them making that solution harder either. And the proposals
so far all seem to go in the right direction.

>> Next, I want to merge my exithand proposal, or something like it. It's
>> likewise a simple change that, in a minimal way, addresses a
>> longstanding API deficiency. I'm very strongly against the
>> POLLERR-on-directory variant of the idea.
>
> I agree with you on this need. I will admit I do somewhat like the EOF
> solution (mainly because it seamlessly deals with the multi-reader case)
> but I'm still not sure I like /proc/$pid/exit_sighand. As mentioned in
> the other discussion, ideally we would be only ever operating with the

This sentence got cut off.

> An ugly strawman of an alternative would be an interface that gave you
> an fd that you could similarly wait-until-EOF on, but that's probably
> not a major API improvement unless we also make said API provide exit
> status information in a way that works with the
> multiple-readers-with-different-creds usecase.

What about something like this then?

#define PROCESS_EXIT_HANDLE_CLOEXEC (1<<0)
#define PROCESS_EXIT_HANDLE_NONBLOCK (1<<1)
#define PROCESS_EXIT_HANDLE_WANT_STATUS (1<<2)

/* Open an "status handle" for the process identified by PROCFS_DFD,
 * which must be an open descriptor to a /proc/pid directory. FLAGS is
 * a combination of zero or more of the
 * PROCESS_EXIT_HANDLE_* constants.
 *
 * Return -1 on error. On success, return a descriptor for a process
 * status handle. Before the process identified by PROCFS_DFD exits,
 * reads from the status handle block. After exit, reads from the
 * status handle yield either EOF (if PROCESS_EXIT_HANDLE_WANT_STATUS
 * is not specified) or a siginfo_t describing how the process exited
 * (if PROCESS_EXIT_HANDLE_WANT_STATUS is specified), as from
 * waitid(2).
 *
 * The returned file descriptor also supports poll(2) and other
 * notification APIs.
 *
 * Any process may call process_get_statusfd from any PROCFS_DFD
 * without PROCESS_EXIT_HANDLE_WANT_STATUS.
 * If PROCESS_EXIT_HANDLE_WANT_STATUS is specified, PROCFS_DFD must
 * refer either to the calling process (or one of its threads), a
 * child of the current process, or a process for which the current
 * process would be able to successfully call ptrace(2).
 *
 * The PROCESS_EXIT_HANDLE_WANT_STATUS permission check happens only
 * at open time, not at read time, and the process handle can be
transferred like any other FD.
 */
int process_get_statusfd(int procfs_dfd, int flags);

> One other thing I think we should eventually consider is to provide an
> API which pings a listener whenever a process does an execve() (and
> possibly fork()).

I thought about providing this facility too, but it's not immediately
apparent to me who would use it. ISTM that most callers that would
want this would be happy grabbing the process with ptrace or passively
monitoring it with ftrace or the process connector.
