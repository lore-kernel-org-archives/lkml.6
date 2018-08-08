Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B59C46470
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64BD221A8E
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 21:48:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="juo1Bnqi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64BD221A8E
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbeHIAJc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 20:09:32 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40805 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727530AbeHIAJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 20:09:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id h15-v6so3290909wrs.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Aug 2018 14:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EYOhkqlMSqAMmDp3jViTrJi8ZBdYbjlxkmDTdzIuNbc=;
        b=juo1Bnqi6hF8QaHB4B150SMqRpXeJcJpx+Ty3ITNza/+6b9+E/tQ2KZSWUYvOMznrr
         ETXcF0Z3oorP1fqitumKeCoDKxFlbDzldClO/FxN0knFYEH8Sch3TzVGVDgX+3cePXJi
         uXOdNoHf+RqUnL9y3XLTRfp+FjBO7tJvrWdgVusWgZeIiRYNcJEqLvDSDJ1VKjGLWKRo
         MBg1ZmtlgEwxNkRLkEBWC/LHd4VQjZEheR2E4A/NqeMuEHxf89KyghCUp74dLEbhJGEb
         kz8yQ18gH5zF8HiqGL92CPkke9T/YohRNQDtO7vn3LibOoApj2cErsxzdG/Q8iGK5EkU
         /r8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EYOhkqlMSqAMmDp3jViTrJi8ZBdYbjlxkmDTdzIuNbc=;
        b=azNbuhFQbSRYLWMQc5dYceYKb48gorQbr5O9hqlou+o1BjUWkleTpDs4ZJtz/zyPP1
         RUbIqY6zvClX7J2cVaN8HyifKmQy+3sCoGXtV5P3eMjvGrKMWfb2ABV5bFU5FFkQ5vdM
         VTd4jr2Pw3Ic4o1IhV7YtztjU8gtrYX8Ha5NsQ+eIM4dm5148Rm3cTCwseETqrWH4pfb
         dQN/BfU56b5fFiPQPDk4TY3TDd+86XZUv/+Ypk0uBdMTcq9LZDqacACBf4oj66vu6eBD
         TxOQLYphXbkQSlpl11RkxVJQvpBmDhFX/PdWmmtJwv2LbldjLsuh6ik1F7EHBzclPQsY
         kJsw==
X-Gm-Message-State: AOUpUlFNIO+j+fc1PNDcRbMLG2MfPghG5f+7Sm6IihedO1V5+DV9bkT6
        4ZLJImYwxdmy48l5xoEAN+5JRY1xKU1nu9L80S6RxBZqwB4=
X-Google-Smtp-Source: AA+uWPz45IsrMJFXt7GQW8Y9Cpxdc36n6xoDxrZo7awgMsdeRD0Ivz27P4hhFpxS+LqW4WtxVccLgoI6RruaakJwX60=
X-Received: by 2002:adf:fdcd:: with SMTP id i13-v6mr2864838wrs.276.1533764875421;
 Wed, 08 Aug 2018 14:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <1533605015-19514-1-git-send-email-eranian@google.com>
 <20180807072029.GA7716@krava> <CABPqkBSyf0WMKmZAFGSyBvX=jn1zifbMPztt_053hvvDh6UsHw@mail.gmail.com>
 <20180807085010.GC7716@krava> <CABPqkBTvXSgJNPW=4MxFqDR_oeYHteuDoeavdFHKuXe+8Y=2DQ@mail.gmail.com>
 <20180808082347.GB20320@krava>
In-Reply-To: <20180808082347.GB20320@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Wed, 8 Aug 2018 14:47:42 -0700
Message-ID: <CABPqkBRwG_MzfJp1d7+4JKNemoD9cOWqJnXaBWQNR7buESKm2w@mail.gmail.com>
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

Hi,

Ok, I found the problem. It still exists upstream , just very tricky to trigger.
Took me lots of time with gdb + watchpoints to track this down, where
in fact it was just in front of me.

From the crashdump:
  Program received signal SIGSEGV, Segmentation fault.
  free_dup_event (oe=0x26a39a0, event=0xffffffff00000000)

I was puzzled by the 0xffffffff00000000. I tracked down where this
value was coming from using watchpoints.
In my case the memory was used before by elfutils to back the struct
Elf. The -1 in the upper bits came from:

file_read_elf () at third_party/elfutils/libelf/elf_begin.c:451
elf->state.elf64.scns.data[cnt].shndx_index = -1;

And yet the next access to that memory location was in the crash. That
meant the memory was released by
elfutils and reused by ordered_events, yet without any initialization.
But looking at alloc_event(), it was
not obvious to figure out how a new_event->event could be uninitialized.

Well, it turns out there is this little hack where the code
commandeers the first element in the oe->buffer to
use as a list_head for the oe->to_free freelist. The problem is that
this entry also gets freed, but its
event->event field is NEVER initialized. So depending on how the
memory was previously used, you
could get a on NULL value and crash in free_dup_event(). This is what
happened to me. I am glad
I pursued this further because the bug is still in the upstream
version. The patch is a one-liner fixing
the initialization of the event->event = NULL. For the other elements
in the list, the initialization is
already done at the end of alloc_event().

I will send the patch separately.



On Wed, Aug 8, 2018 at 1:23 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Aug 07, 2018 at 12:11:05PM -0700, Stephane Eranian wrote:
> > Jiri,
> > On Tue, Aug 7, 2018 at 1:50 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Aug 07, 2018 at 01:16:22AM -0700, Stephane Eranian wrote:
> > > > On Tue, Aug 7, 2018 at 12:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > > >
> > > > > On Mon, Aug 06, 2018 at 06:23:35PM -0700, Stephane Eranian wrote:
> > > > > > Depending on memory allocations, it was possible to get a SEGFAULT in
> > > > > > free_dup_event() because the event pointer was bogus:
> > > > > >
> > > > > > perf[1354]: segfault at ffffffff00000006 ip 00000000004b7fc7
> > > > >
> > > > > is there any reproducer?
> > > > >
> > > > The cmdline is simple:
> > > > $ perf record -e cycles:pp -o - -a sleep 1 | perf inject -b -i - >/dev/null
> > > > I was using v4.13 for my tests and it may be sensitive to compiler.
> > > > Was using LLVM.
> > >
> > > I can't make it fail even when I compile with clang 'make CC=clang'
> > >
> > I checked, my actual reproducer is:
> > $ perf record -o - -e cycles date |  perf inject -b -i - >/dev/null
> > Tue Aug  7 12:03:48 PDT 2018
> > [ perf record: Woken up 1 times to write data ]
> > [ perf record: Captured and wrote 0.000 MB - ]
> > Segmentation fault (core dumped)
> >
> > the crash is in perf inject.
> > So if I do:
> > $ perf record -o - -e cycles date >tt
> > $ gdb perf
> > (gdb) r inject -b -i - < tt  >/dev/null
> > Program received signal SIGSEGV, Segmentation fault.
> > free_dup_event (oe=0x26a39a0, event=0xffffffff00000000) at
> > util/ordered-events.c:85
> > 85 in util/ordered-events.c
> > (gdb) bt
> > #0  free_dup_event (oe=0x26a39a0, event=0xffffffff00000000) at
> > util/ordered-events.c:85
> > #1  ordered_events__free (oe=0x26a39a0) at util/ordered-events.c:310
> > #2  0x00000000004b5a56 in __perf_session__process_pipe_events
> > (session=<optimized out>) at util/session.c:1753
> > #3  perf_session__process_events (session=<optimized out>) at
> > util/session.c:1932
> > #4  0x000000000043a2eb in __cmd_inject (inject=<optimized out>) at
> > builtin-inject.c:750
> > #5  cmd_inject (argc=<optimized out>, argv=<optimized out>) at
> > builtin-inject.c:924
> > #6  0x000000000046b175 in run_builtin (p=0xabc640 <commands+576>,
> > argc=4, argv=0x7fffffffe560) at perf.c:297
> > #7  0x000000000046b062 in handle_internal_command (argc=4,
> > argv=0x7fffffffe560) at perf.c:349
> > #8  0x000000000046a5e8 in run_argv (argcp=<optimized out>,
> > argv=<optimized out>) at perf.c:393
> > #9  main (argc=4, argv=0x7fffffffe560) at perf.c:531
>
> nice
>
> >
> > Again, this is with an older version of perf compiled with LLVM.
>
> can you also reproduce it with latest code?
>
> > Notice the value of event passed to free_dup_event(): 0xffffffff00000000
> > And yes, I checked sizeof(union_perf_event) = 4168 which is the size of
> > the mmap2_event which is the largest.
> >
> > I also checked that you are freeing what you have actually allocated.
> > No double free.
> > If I add the padding or modifies the call to memdup() as in the patch,
> > then the problem
> > goes away.
> >
> > If you don't want to copy 4Kb each time, then you could also make the
> > event field
> > by a void *event and case whenever needed.
>
> not sure I understand this one.. could you please elaborate?
>
> >
> > I suspect the problem may come from a compiler optimization or assumption which
> > clashes with what you are optimizing here.
>
> I'll go throught the code and try to find somethign.. thanks a lot for the backtrace
>
> jirka
>
