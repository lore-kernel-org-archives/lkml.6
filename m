Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92277C6786F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:10:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A31C20664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 23:10:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HxA8N5Z5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A31C20664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728647AbeJaIGT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 04:06:19 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:39043 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727430AbeJaIGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 04:06:18 -0400
Received: by mail-vs1-f65.google.com with SMTP id h78so7802542vsi.6
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 16:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=uyNmxWgVjtCDcTKlEYTWilkBglVV2Ve0yeaY0nXKyx0=;
        b=HxA8N5Z5b3dxflo9UiRMfqQ7f3t85wA1ta9xqNLLEU+PJrAh/RFqc8Vzx4DLig5fKL
         Etrxv/z8JASsncWUwrmJUDIg1a8wjZ0z/py8wtqsws4pNr+f2EqccClxb2+d5AG3wiAw
         0qk4v1Vi4bhgj2UFi8Ir/JTMxgAMjN7RkhUa7S1Iy7PeovVJaqtIerGZp2jB5dG91B5N
         XizrOUrfaX27gxfjeSuHVGMMNm7utP9YhcJItpezTFwfMoSs0rWdr6Eg4MhSZLdPxZkg
         T7BD/swMCFb0sy55QEdXgBc6t1wEZbJAlytmuzEKDEKmeNIzr/R50KfSxE6nt3Zu4atZ
         etZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=uyNmxWgVjtCDcTKlEYTWilkBglVV2Ve0yeaY0nXKyx0=;
        b=hvGDIkCNJxYUJ0oeJAI/Pqu+i0CikNeXWNpAO7B5fMDIrDE0KFT1zhfBL9F+N+qN2g
         vojmVYuhjep7zwYu9Ga8Gxfh+iwz7p/Ij5y8HNmtmyAyrGTDE+lQuGh/vjPR1aV7DZXp
         AlunEQbPRPwPGZTimcv8rdGqsmzNNr/S8zWK3iN9jogrrwhpDr7dc9y4OpaKauOht0L+
         mDPMqKOfT/JU4Mn08GEk9jCP6iVUv1vtSpj0ruO1Dk4MzGK8LlTRxBDf9pL6Jh7fJTdg
         mhQoJdxgLYnosuFVanjjGB0bgDIG2q+3IXLIorxoBZ0VZbi2KeiOR1NuS90HA2PlQEgp
         RhNw==
X-Gm-Message-State: AGRZ1gIwkEgEpBnVeips3utTppecejKGo/UajFBy8LuWrwGlpNzW9+JX
        I56/E9c5i2pber8tMmEvGVLnTBX6k1sGMZGwcRLgTQ==
X-Google-Smtp-Source: AJdET5c/gq3O/Z4W9yonwE50p0RiUoyqtX929aFTVImK5J2FGjTftI0CuqxExKaDAf9KVkPjhDVCMW9TMRQ0eDbWpDQ=
X-Received: by 2002:a67:6e87:: with SMTP id j129mr313033vsc.171.1540941048268;
 Tue, 30 Oct 2018 16:10:48 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 16:10:47
 -0700 (PDT)
In-Reply-To: <20181030223343.GB105735@joelaf.mtv.corp.google.com>
References: <20181029221037.87724-1-dancol@google.com> <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin> <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin> <20181030223343.GB105735@joelaf.mtv.corp.google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Tue, 30 Oct 2018 23:10:47 +0000
Message-ID: <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com>
Subject: Re: [RFC PATCH] Implement /proc/pid/kill
To:     Joel Fernandes <joel@joelfernandes.org>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Tim Murray <timmurray@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 30, 2018 at 10:33 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Wed, Oct 31, 2018 at 09:23:39AM +1100, Aleksa Sarai wrote:
>> On 2018-10-30, Joel Fernandes <joel@joelfernandes.org> wrote:
>> > On Wed, Oct 31, 2018 at 07:45:01AM +1100, Aleksa Sarai wrote:
>> > [...]
>> > > > > (Unfortunately
>> > > > > there are lots of things that make it a bit difficult to use /proc/$pid
>> > > > > exclusively for introspection of a process -- especially in the context
>> > > > > of containers.)
>> > > >
>> > > > Tons of things already break without a working /proc. What do you have in mind?
>> > >
>> > > Heh, if only that was the only blocker. :P
>> > >
>> > > The basic problem is that currently container runtimes either depend on
>> > > some non-transient on-disk state (which becomes invalid on machine
>> > > reboots or dead processes and so on), or on long-running processes that
>> > > keep file descriptors required for administration of a container alive
>> > > (think O_PATH to /dev/pts/ptmx to avoid malicious container filesystem
>> > > attacks). Usually both.
>> > >
>> > > What would be really useful would be having some way of "hiding away" a
>> > > mount namespace (of the pid1 of the container) that has all of the
>> > > information and bind-mounts-to-file-descriptors that are necessary for
>> > > administration. If the container's pid1 dies all of the transient state
>> > > has disappeared automatically -- because the stashed mount namespace has
>> > > died. In addition, if this was done the way I'm thinking with (and this
>> > > is the contentious bit) hierarchical mount namespaces you could make it
>> > > so that the pid1 could not manipulate its current mount namespace to
>> > > confuse the administrative process. You would also then create an
>> > > intermediate user namespace to help with several race conditions (that
>> > > have caused security bugs like CVE-2016-9962) we've seen when joining
>> > > containers.
>> > >
>> > > Unfortunately this all depends on hierarchical mount namespaces (and
>> > > note that this would just be that NS_GET_PARENT gives you the mount
>> > > namespace that it was created in -- I'm not suggesting we redesign peers
>> > > or anything like that). This makes it basically a non-starter.
>> > >
>> > > But if, on top of this ground-work, we then referenced containers
>> > > entirely via an fd to /proc/$pid then you could also avoid PID reuse
>> > > races (as well as being able to find out implicitly whether a container
>> > > has died thanks to the error semantics of /proc/$pid). And that's the
>> > > way I would suggest doing it (if we had these other things in place).
>> >
>> > I didn't fully follow exactly what you mean. If you can explain for the
>> > layman who doesn't know much experience with containers..
>> >
>> > Are you saying that keeping open a /proc/$pid directory handle is not
>> > sufficient to prevent PID reuse while the proc entries under /proc/$pid are
>> > being looked into? If its not sufficient, then isn't that a bug? If it is
>> > sufficient, then can we not just keep the handle open while we do whatever we
>> > want under /proc/$pid ?
>>
>> Sorry, I went on a bit of a tangent about various internals of container
>> runtimes. My main point is that I would love to use /proc/$pid because
>> it makes reuse handling very trivial and is always correct, but that
>> there are things which stop us from being able to use it for everything
>> (which is what my incoherent rambling was on about).
>
> Ok thanks. So I am guessing if the following sequence works, then Dan's patch is not
> needed.
>
> 1. open /proc/<pid> directory
> 2. inspect /proc/<pid> or do whatever with <pid>
> 3. Issue the kill on <pid>
> 4. Close the /proc/<pid> directory opened in step 1.
>
> So unless I missed something, the above sequence will not cause any PID reuse
> races.

Keeping a /proc/$PID directory file descriptor open does not prevent
$PID being used to name some other process. If it could, you could
pretty quickly fill a whole system's process table. See the program
below, which demonstrates the PID collision.

I think Aleksa's larger point is that it's useful to treat processes
as other file-descriptor-named, poll-able, wait-able resources.
Consistency is important. A process is just another system resource,
and like any other system resource, you should be open to hold a file
descriptor to it and do things to that process via that file
descriptor. The precise form of this process-handle FD is up for
debate. The existing /proc/$PID directory FD is a good candidate for a
process handle FD, since it does almost all of what's needed. But
regardless of what form a process handle FD takes, we need it. I don't
see a case for continuing to treat processes in a non-unixy,
non-file-descriptor-based manner.

#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int
main()
{
    int child_pid = fork();
    if (child_pid < 0)
        abort();

    char buf[64];
    int child_procfs_fd;

    if (child_pid == 0) {
        for (;;)
            pause();
        abort();
    }

    printf("child PID is %d\n", child_pid);
    sprintf(buf, "/proc/%d", child_pid);
    child_procfs_fd = open(buf, O_DIRECTORY | O_RDONLY);
    if (child_procfs_fd < 0)
        abort();
    printf("FD# of open /proc/%d is %d\n",
           child_pid,
           child_procfs_fd);
    printf("killing child with SIGKILL\n");
    kill(child_pid, SIGKILL);
    if (wait(NULL) != child_pid)
        abort();
    printf("child is now dead. PROCFS FD STILL OPEN\n");
    for (;;) {
        int new_child_pid = fork();
        if (new_child_pid < 0)
            abort();
        if (new_child_pid == 0)
            _exit(0);
        // printf("new child PID: %d\n", new_child_pid);
        if (wait(NULL) != new_child_pid)
            abort();
        if (new_child_pid == child_pid) {
            printf("FOUND PID COLLISION %d\n", child_pid);
            printf("old child had pid %d. new, "
                   "different child has pid %d. "
                   "procfs directory for old child still open!\n",
                   child_pid, child_pid);
            break;
        }
    }

    return 0;
}
