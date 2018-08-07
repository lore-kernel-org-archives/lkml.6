Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B65C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:11:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6984021731
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 19:11:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WNHmLB4M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6984021731
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390020AbeHGV1H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 17:27:07 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33556 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389073AbeHGV1G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 17:27:06 -0400
Received: by mail-wm0-f65.google.com with SMTP id r24-v6so15138823wmh.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 12:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsvBhI8WfMhdEP61XONYzmkwOka+jmTuWQfVXM0QqAo=;
        b=WNHmLB4Mjdd2YFAVcTzD2IdueOCM4bk+FtNCtQD5UdYQ2oqKS+2O7nZKtUNYEoBxBn
         dRhX5jlf+7ZyvCAM4vuEk/GqJcUCZrlnZjL9wXhveIrRQG+akjEXuA7rP+Xvm8WzIx2n
         OGX6es+9kTOEflGRDJgEzd78jkOesf1S0cJXUkGJjowep0swB/3R1s1TAcWwrq1tTmWR
         Joe8u5LyAg6QPRcmuiuVBDFh1RWJLRM2q3jYUwzr9rhsOowaAdPv7SjIXum6fdm3uKd4
         g8egIh1hOzwW1J649Ft4eiw8czmefZrQJDMLRmWcH7h5z30+sG1YZIBQGkw5QZv1FE67
         daEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsvBhI8WfMhdEP61XONYzmkwOka+jmTuWQfVXM0QqAo=;
        b=qFDkoM5LC6OYipSlzIcYhNYZcvU+9tRlyuFbN2IVGCHfjO0o7zbm8YcJvR4ojppKrH
         aMxSUO3PLIMStvZdHLBvt0CNcbk8LbLRkpcn6yqYTiFI9GGQhE+VrZCU0eEc31hJHzJ+
         /+kMHY09455Scj3Lrq/FF6ALbaKU4z4GvI9n8tQf6QvByf0ywLwk/CERKDPf77ZifXm6
         YLGrzJKO+WQkN0bbzgOYXynZaIrJW1H49kZP6ntz++ZiKqEkzwaeGC0QUGp/eT3X55ej
         7DbLETXQ6k/5/ND7O0NfY0gwHWAoIi3njPU5o7yUFEqRq3s/h9XkQ+i5W4CapToucPmu
         fErQ==
X-Gm-Message-State: AOUpUlFNj/N1N+ENFhAuWgPdPnisI8JYxKdQBXo3f0oeDsPp8vZRbmj6
        fsiTiXbfsRSj5zFI1vvU85Xdln//08GkOHUHpoMfZg==
X-Google-Smtp-Source: AA+uWPxS0UZlq/5a52Ll7pVVZZfxEjAhOc9m+YdhhhJHNej54AJhuRzcn04D2Q/dPIXL1/3TRWm+QRtpe9OIrH1AcVY=
X-Received: by 2002:a1c:9d02:: with SMTP id g2-v6mr2333950wme.122.1533669077271;
 Tue, 07 Aug 2018 12:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <1533605015-19514-1-git-send-email-eranian@google.com>
 <20180807072029.GA7716@krava> <CABPqkBSyf0WMKmZAFGSyBvX=jn1zifbMPztt_053hvvDh6UsHw@mail.gmail.com>
 <20180807085010.GC7716@krava>
In-Reply-To: <20180807085010.GC7716@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 7 Aug 2018 12:11:05 -0700
Message-ID: <CABPqkBTvXSgJNPW=4MxFqDR_oeYHteuDoeavdFHKuXe+8Y=2DQ@mail.gmail.com>
Subject: Re: [PATCH] perf ordered_events: fix crash in free_dup_event()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri,
On Tue, Aug 7, 2018 at 1:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Aug 07, 2018 at 01:16:22AM -0700, Stephane Eranian wrote:
> > On Tue, Aug 7, 2018 at 12:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Mon, Aug 06, 2018 at 06:23:35PM -0700, Stephane Eranian wrote:
> > > > Depending on memory allocations, it was possible to get a SEGFAULT in
> > > > free_dup_event() because the event pointer was bogus:
> > > >
> > > > perf[1354]: segfault at ffffffff00000006 ip 00000000004b7fc7
> > >
> > > is there any reproducer?
> > >
> > The cmdline is simple:
> > $ perf record -e cycles:pp -o - -a sleep 1 | perf inject -b -i - >/dev/null
> > I was using v4.13 for my tests and it may be sensitive to compiler.
> > Was using LLVM.
>
> I can't make it fail even when I compile with clang 'make CC=clang'
>
I checked, my actual reproducer is:
$ perf record -o - -e cycles date |  perf inject -b -i - >/dev/null
Tue Aug  7 12:03:48 PDT 2018
[ perf record: Woken up 1 times to write data ]
[ perf record: Captured and wrote 0.000 MB - ]
Segmentation fault (core dumped)

the crash is in perf inject.
So if I do:
$ perf record -o - -e cycles date >tt
$ gdb perf
(gdb) r inject -b -i - < tt  >/dev/null
Program received signal SIGSEGV, Segmentation fault.
free_dup_event (oe=0x26a39a0, event=0xffffffff00000000) at
util/ordered-events.c:85
85 in util/ordered-events.c
(gdb) bt
#0  free_dup_event (oe=0x26a39a0, event=0xffffffff00000000) at
util/ordered-events.c:85
#1  ordered_events__free (oe=0x26a39a0) at util/ordered-events.c:310
#2  0x00000000004b5a56 in __perf_session__process_pipe_events
(session=<optimized out>) at util/session.c:1753
#3  perf_session__process_events (session=<optimized out>) at
util/session.c:1932
#4  0x000000000043a2eb in __cmd_inject (inject=<optimized out>) at
builtin-inject.c:750
#5  cmd_inject (argc=<optimized out>, argv=<optimized out>) at
builtin-inject.c:924
#6  0x000000000046b175 in run_builtin (p=0xabc640 <commands+576>,
argc=4, argv=0x7fffffffe560) at perf.c:297
#7  0x000000000046b062 in handle_internal_command (argc=4,
argv=0x7fffffffe560) at perf.c:349
#8  0x000000000046a5e8 in run_argv (argcp=<optimized out>,
argv=<optimized out>) at perf.c:393
#9  main (argc=4, argv=0x7fffffffe560) at perf.c:531

Again, this is with an older version of perf compiled with LLVM.
Notice the value of event passed to free_dup_event(): 0xffffffff00000000
And yes, I checked sizeof(union_perf_event) = 4168 which is the size of
the mmap2_event which is the largest.

I also checked that you are freeing what you have actually allocated.
No double free.
If I add the padding or modifies the call to memdup() as in the patch,
then the problem
goes away.

If you don't want to copy 4Kb each time, then you could also make the
event field
by a void *event and case whenever needed.

I suspect the problem may come from a compiler optimization or assumption which
clashes with what you are optimizing here.


>   [jolsa@krava perf]$ clang --version
>   clang version 6.0.1 (tags/RELEASE_601/final)
>
> I'm on v4.17, but I dont think kernel version is related to this issue
>
> >
> > It may be a compiler related issue. You do not allocate the whole struct.
> > If the compiler was to do a memcpy() behind your back, you'd be in
> > troubles.
> >
> > Adding extra padding before *event was also avoiding the problem.
> > struct ordered_event {
> >         u64                     timestamp;
> >         u64                     file_offset;
> >         char                   pad[32];   <----- extra padding for debugging
> >         union perf_event        *event;
> >         struct list_head        list;
> > };
>
> might be some issue in the struct ordered_event allocation,
> which is little convoluted
>
> jirka
