Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA16C46470
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:16:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6467215F9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 08:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aHO9s9RB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6467215F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbeHGK3r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 06:29:47 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:52027 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726286AbeHGK3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 06:29:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id y2-v6so16441599wma.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Aug 2018 01:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qt42W0B059LUO1C3lTHe3dnox4h7YF5q2lNhh+Y5CIM=;
        b=aHO9s9RBg2uclKggRsS0eiqs4RLFLkQkDCSH9L2O5OLqFQnbLdx04CGaNdafTUTKDJ
         egZIKlnA/A0ogyUR+iGbyaZE12NRJi8GWBNmQVQDTsGf8lEOZokx6RohrqyZNiq6JQ3o
         745KNhBLJ2AgZUDjLFaeEAchhyzGFLB/0Ss5rPbcvkIpR58bMTUC9zOJkkX3cTvS/71v
         JD24qhwhD/7syNjyBeAWp/Jt4JnuxgZqbVnJFvw21t1KLzZ4rpZkqbH5A3iWQBU1wcbn
         CAsPoM9qZtJrZ6XqBI+dv2sKfxuUp/HySSw738rDYwPWmi+4P6uO5aJ1WsF0ohwskoyY
         J7hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qt42W0B059LUO1C3lTHe3dnox4h7YF5q2lNhh+Y5CIM=;
        b=IRJWWHZSrOsrLY/FgoRMerBqxNXio+dp27HAjiNudqg3X4iqsYrPMlhN6h9idjUsVd
         T2W0xJHE3TFpy5B7umbTtAu63CPYLbTwXp0W7B3AERorNb4OSkOV8rCy0jFLBVdfVNTh
         vYJoASNZYlGo4R+C/OTHm9r3uuptzQfv3U3uZOSH+8l9eHYkB4hEOUdUuNRU/YQr+Fdv
         ffAmJojhQ82zHJsTbcW75FDNOaJkuRe4tUkhsYopYW+skswRGpunz16aKVCNIS0tHm/k
         lav7km8sBZgUQh7i4LqP0kMosW7hxmSZX+TKGx6GywYq8XlWIZC50Yd1frjUK5OtqyAl
         dNKQ==
X-Gm-Message-State: AOUpUlHZjPlcRCpFLOIjcLJQXWS7dtV1A2ziEA9qiOGzxGCNje1rVpuZ
        0bg06jTWOdHltSqFCvNxtuEoa6D/VfsVx3MXfHVBwdXcfoI=
X-Google-Smtp-Source: AA+uWPyjh+c+GZYFFHrXZzMBWbpbBkDqPwQ67UZ2Ftau8PdYWWnauqrWvGgZvKqBgSZHS4Kq/V9NfTaPB+gvrHcdQKk=
X-Received: by 2002:a1c:9d02:: with SMTP id g2-v6mr896590wme.122.1533629794155;
 Tue, 07 Aug 2018 01:16:34 -0700 (PDT)
MIME-Version: 1.0
References: <1533605015-19514-1-git-send-email-eranian@google.com> <20180807072029.GA7716@krava>
In-Reply-To: <20180807072029.GA7716@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 7 Aug 2018 01:16:22 -0700
Message-ID: <CABPqkBSyf0WMKmZAFGSyBvX=jn1zifbMPztt_053hvvDh6UsHw@mail.gmail.com>
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

On Tue, Aug 7, 2018 at 12:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Aug 06, 2018 at 06:23:35PM -0700, Stephane Eranian wrote:
> > Depending on memory allocations, it was possible to get a SEGFAULT in
> > free_dup_event() because the event pointer was bogus:
> >
> > perf[1354]: segfault at ffffffff00000006 ip 00000000004b7fc7
>
> is there any reproducer?
>
The cmdline is simple:
$ perf record -e cycles:pp -o - -a sleep 1 | perf inject -b -i - >/dev/null
I was using v4.13 for my tests and it may be sensitive to compiler.
Was using LLVM.

It may be a compiler related issue. You do not allocate the whole struct.
If the compiler was to do a memcpy() behind your back, you'd be in
troubles.

Adding extra padding before *event was also avoiding the problem.
struct ordered_event {
        u64                     timestamp;
        u64                     file_offset;
        char                   pad[32];   <----- extra padding for debugging
        union perf_event        *event;
        struct list_head        list;
};

> >
> > Initially, I thought it was some double free. But it turns out
> > it looked more like a buffer overrun. Adding padding before
> > the union perf_event field in struct ordered_event avoided the
> > problem. But it was not obvious where this could be coming from
> > given the accesses to the struct, i.e.,  no internal array.
> >
> > Then, it struck me that the following was bogus in __dup_event():
> >
> >  __dup_event(struct ordered_events *oe, union perf_event *event)
> > {
> >    ...
> >    union perf_event *new_event;
> >    new_event = memdup(event, event->header.size);
> >    ...
> > }
> >
> > The problem here is that header.size <= sizeof(*new_event). The code
> > was trying to copy only what was necessary, but then, the allocation
>
> hum, and I think we should continue to do so.. we can't allocate ~4000
> bytes space for 30 bytes sample
>
I understand that but it seems the event field gets overwritten under some
conditions.

> > was also only partial. In other words if the event was not the largest
> > possible for the union, it would not be fully backed by memory, likely
> > causing troubles.
>
> how? using that event allocated space for another type of event?
>
> >
> > This patch fixes the problem by passing the size of the union and not
> > that of the actual event.
>
> I think that's just bypassing the real issue, please share more details
> on how to reproduce this
>
> thanks,
> jirka
>
> >
> > Signed-off-by: Stephane Eranian <eranian@google.com>
> >
> > ---
> >  tools/perf/util/ordered-events.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> > index bad9e0296e9a..a90dbe5df019 100644
> > --- a/tools/perf/util/ordered-events.c
> > +++ b/tools/perf/util/ordered-events.c
> > @@ -66,9 +66,9 @@ static union perf_event *__dup_event(struct ordered_events *oe,
> >       union perf_event *new_event = NULL;
> >
> >       if (oe->cur_alloc_size < oe->max_alloc_size) {
> > -             new_event = memdup(event, event->header.size);
> > +             new_event = memdup(event, sizeof(*event));
> >               if (new_event)
> > -                     oe->cur_alloc_size += event->header.size;
> > +                     oe->cur_alloc_size += sizeof(*event);
> >       }
> >
> >       return new_event;
> > --
> > 2.18.0.597.ga71716f1ad-goog
> >
