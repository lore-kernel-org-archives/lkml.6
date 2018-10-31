Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A0D5C6786F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD20120664
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 01:57:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aIDyzfRt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD20120664
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbeJaKwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 06:52:53 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:36012 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728561AbeJaKwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 06:52:53 -0400
Received: by mail-vk1-f196.google.com with SMTP id u62so862974vkb.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Oct 2018 18:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gIedtFsau99dkfG9iitWwXQFeF8PwLH20DgCwdJwnQA=;
        b=aIDyzfRtxplweUamZKyra9pbDi4xcOoP3OjVeRHs5afbTYPs87LW7U2f1BQJMba2IP
         D27B0//gN3J1q71yLHxf4P1wGAY354CiDu43ZDzK/eiphLflsXR+ZKx2V1Mq5Gg9OeyV
         8RSyghGi4faLt/E9EBgUewrkVTn0yM7muz5L294RDpQQLhWE3I32yGvE8oICt2+tpwTC
         yOzUb/EGX7xx9dXqM2ofbAviqAnn6V062wrqfuYkbOfROx4FBUJHaQD5VsQ7H+NSqwRt
         P3lFZ6ccmc5Th/6oGS3LmxLXIY6lcJqOSTSF7ZgS1R2dEh03CibI9jAz4p+zM2Tmxohk
         KdiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gIedtFsau99dkfG9iitWwXQFeF8PwLH20DgCwdJwnQA=;
        b=iCuhTCcDcK3Na2S+Tg09G/dHfynG8uW8mzqKh1RhhIAGpkuDi0wtsAlHoEom0rVlIr
         sEOEE6wh8QpI2JfBfNKRCuzYA2JVlzcwef4aTebj+C0Pw7K8WbOdzuuhZ+7mu40tzRJt
         B58QqvWNBO6MVGhiekdvraWs37dYpAcD1/ewNsqWEn/IUmBd26T0P1vayqILc6oHQHJd
         hrhPP5EYw/xzF+uBzRq1Zw6dBfOWiQ6Hv6gBnRVDRIeQx7Yqn+Q8723TtQWAWNM5tKxi
         GrslQPuf9XZm3j8wE1+jhyURG6N4S9x4qBpZUiznB94MXh4b7fWavYMECJaY1ZLYnWj/
         KBhQ==
X-Gm-Message-State: AGRZ1gKzYPhssfnxF42ofWhlJLQ49+IDhr/zZuG7kF9QMpocRdY4fZ/Z
        aABKn/lvKaNkZMpuHok5xXQAq+vl1v1Aartc3UeU8Q==
X-Google-Smtp-Source: AJdET5fLHlDBwhTbGi1rX5a3RqaspuUbxkr98GfDLzD9eI+V6pD0FpTpEWLQOSOTOHMYLWo3F8rMX2lBFiQHA5W5X00=
X-Received: by 2002:a1f:d43:: with SMTP id 64-v6mr474699vkn.51.1540951017108;
 Tue, 30 Oct 2018 18:56:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:f48d:0:0:0:0:0 with HTTP; Tue, 30 Oct 2018 18:56:55
 -0700 (PDT)
In-Reply-To: <20181031005723.GD224709@google.com>
References: <20181029221037.87724-1-dancol@google.com> <20181030050012.u43lcvydy6nom3ul@yavin>
 <CAKOZuesKVic-5epRj8XcFNR_63SgvaPcbjDQuSLxNrEfS=O=Jg@mail.gmail.com>
 <20181030204501.jnbe7dyqui47hd2x@yavin> <20181030214243.GB32621@google.com>
 <20181030222339.ud4wfp75tidowuo4@yavin> <20181030223343.GB105735@joelaf.mtv.corp.google.com>
 <CAKOZueuBdY_b=CVk29pzn0NAt9sJtzr6yqx9Y00WCppCm1JFWQ@mail.gmail.com> <20181031005723.GD224709@google.com>
From:   Daniel Colascione <dancol@google.com>
Date:   Wed, 31 Oct 2018 01:56:55 +0000
Message-ID: <CAKOZuesgmHcSET23K5fWmE1pBcy9cSi=ysQ-dxLVq+R3km6Rxg@mail.gmail.com>
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

On Wed, Oct 31, 2018 at 12:57 AM, Joel Fernandes <joel@joelfernandes.org> wrote:
> On Tue, Oct 30, 2018 at 11:10:47PM +0000, Daniel Colascione wrote:
>> On Tue, Oct 30, 2018 at 10:33 PM, Joel Fernandes <joel@joelfernandes.org> wrote:
>> > On Wed, Oct 31, 2018 at 09:23:39AM +1100, Aleksa Sarai wrote:
>> >> On 2018-10-30, Joel Fernandes <joel@joelfernandes.org> wrote:
>> >> > On Wed, Oct 31, 2018 at 07:45:01AM +1100, Aleksa Sarai wrote:
>> >> > [...]
>> >> > > > > (Unfortunately
>> >> > > > > there are lots of things that make it a bit difficult to use /proc/$pid
>> >> > > > > exclusively for introspection of a process -- especially in the context
>> >> > > > > of containers.)
>> >> > > >
>> >> > > > Tons of things already break without a working /proc. What do you have in mind?
>> >> > >
>> >> > > Heh, if only that was the only blocker. :P
>> >> > >
>> >> > > The basic problem is that currently container runtimes either depend on
>> >> > > some non-transient on-disk state (which becomes invalid on machine
>> >> > > reboots or dead processes and so on), or on long-running processes that
>> >> > > keep file descriptors required for administration of a container alive
>> >> > > (think O_PATH to /dev/pts/ptmx to avoid malicious container filesystem
>> >> > > attacks). Usually both.
>> >> > >
>> >> > > What would be really useful would be having some way of "hiding away" a
>> >> > > mount namespace (of the pid1 of the container) that has all of the
>> >> > > information and bind-mounts-to-file-descriptors that are necessary for
>> >> > > administration. If the container's pid1 dies all of the transient state
>> >> > > has disappeared automatically -- because the stashed mount namespace has
>> >> > > died. In addition, if this was done the way I'm thinking with (and this
>> >> > > is the contentious bit) hierarchical mount namespaces you could make it
>> >> > > so that the pid1 could not manipulate its current mount namespace to
>> >> > > confuse the administrative process. You would also then create an
>> >> > > intermediate user namespace to help with several race conditions (that
>> >> > > have caused security bugs like CVE-2016-9962) we've seen when joining
>> >> > > containers.
>> >> > >
>> >> > > Unfortunately this all depends on hierarchical mount namespaces (and
>> >> > > note that this would just be that NS_GET_PARENT gives you the mount
>> >> > > namespace that it was created in -- I'm not suggesting we redesign peers
>> >> > > or anything like that). This makes it basically a non-starter.
>> >> > >
>> >> > > But if, on top of this ground-work, we then referenced containers
>> >> > > entirely via an fd to /proc/$pid then you could also avoid PID reuse
>> >> > > races (as well as being able to find out implicitly whether a container
>> >> > > has died thanks to the error semantics of /proc/$pid). And that's the
>> >> > > way I would suggest doing it (if we had these other things in place).
>> >> >
>> >> > I didn't fully follow exactly what you mean. If you can explain for the
>> >> > layman who doesn't know much experience with containers..
>> >> >
>> >> > Are you saying that keeping open a /proc/$pid directory handle is not
>> >> > sufficient to prevent PID reuse while the proc entries under /proc/$pid are
>> >> > being looked into? If its not sufficient, then isn't that a bug? If it is
>> >> > sufficient, then can we not just keep the handle open while we do whatever we
>> >> > want under /proc/$pid ?
>> >>
>> >> Sorry, I went on a bit of a tangent about various internals of container
>> >> runtimes. My main point is that I would love to use /proc/$pid because
>> >> it makes reuse handling very trivial and is always correct, but that
>> >> there are things which stop us from being able to use it for everything
>> >> (which is what my incoherent rambling was on about).
>> >
>> > Ok thanks. So I am guessing if the following sequence works, then Dan's patch is not
>> > needed.
>> >
>> > 1. open /proc/<pid> directory
>> > 2. inspect /proc/<pid> or do whatever with <pid>
>> > 3. Issue the kill on <pid>
>> > 4. Close the /proc/<pid> directory opened in step 1.
>> >
>> > So unless I missed something, the above sequence will not cause any PID reuse
>> > races.
>>
>> Keeping a /proc/$PID directory file descriptor open does not prevent
>> $PID being used to name some other process. If it could, you could
>> pretty quickly fill a whole system's process table. See the program
>> below, which demonstrates the PID collision.
>
> I know. We both were not sure about that earlier, that's why I requested you
> to write the program when we were privately chatting. Now I'm sure because
> Aleska answered that and the you program you wrote showed that too.

I don't think that this behavior was ever in doubt from my side.

> I wonder if this cannot be plumbed by just making the /proc/$PID directory
> opens hold a reference to task_struct (and a reference to whatever else is
> supposed to prevent the PID from getting reused), instead of introducing a
> brand new API.

That *is* a brand-new API ---- just spelled the same as an old API.
Besides, the PID-preserving handle approach has a problem with
rlimits. In particular, a user that is otherwise limited by
RLIMIT_NPROC could squat on far more entries in the process table than
he could otherwise. (And the whole point of RLIMIT_NPROC is to limit
process table squatting.) You can't just make procfs directory FDs
count against RLIMIT_NPROC, because that'd break existing user code
that assumes that procfs FDs *don't* count against the user process
limit.

>> I think Aleksa's larger point is that it's useful to treat processes
>> as other file-descriptor-named, poll-able, wait-able resources.
>> Consistency is important. A process is just another system resource,
>> and like any other system resource, you should be open to hold a file
>> descriptor to it and do things to that process via that file
>> descriptor. The precise form of this process-handle FD is up for
>> debate. The existing /proc/$PID directory FD is a good candidate for a
>> process handle FD, since it does almost all of what's needed. But
>> regardless of what form a process handle FD takes, we need it. I don't
>> see a case for continuing to treat processes in a non-unixy,
>> non-file-descriptor-based manner.
>
> So wait, how is that supposed to address what you're now saying above
> "quickly fill a whole process table"? You either want this, or you don't :)

I don't understand what you're getting at.
