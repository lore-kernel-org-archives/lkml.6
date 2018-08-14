Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4CE0C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46C12218DE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 07:14:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="c4k6ib2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46C12218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731796AbeHNKA0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 06:00:26 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55973 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731125AbeHNKA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 06:00:26 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so11185598wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 00:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FCX3lVNqpRwuOxWkQeYgf99tLfJAEJvTdPI7YEbJnC0=;
        b=c4k6ib2x9G1sTtrlu1oR0HaEqdOzgBcuFB66WzErJfBbBAM/j+oHP6NhtgAj8myCoW
         AjwPjprdYZPf7HqWppdkPx0lxmBjuvbLzDeFV2V4wxcwW2edr0HkLA0la3mF6hoQbVJd
         MJjGfuHX2zq6Q86HQjAHojX8QpikNPSvumxUU77dHaSHlWw6b+gLnkjbnhoqpDMgEcZH
         HbCo7sd8805yPI6iBpbj/74euzQ8T9rD03uXx/o/uR67bVtcLjehwIgQ7aX4YgqS0Vos
         RbuXd/eC8zlcKxma+kzWaY7GtAo8HiSfFBUi2Rpl27dkTRHgTuQRdr4xFiXsX6ftRkNE
         b6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FCX3lVNqpRwuOxWkQeYgf99tLfJAEJvTdPI7YEbJnC0=;
        b=o7XNpWOGXJ9OZJj1V0bes7+Y5/U5/ulbE/PBCksrKeZ8AXsqZonTxxQyA+c5OEznF3
         aJUGTAxJeBKL+0beWI99jyOcGRlE78GOekwmUcKu9BOq5SIiF2gxXXUtYTPILq4GFRzi
         fDP7RasT1yGi0ZZwJNvn2Ah4wxpXbZAYNCXZwMjXpSAuHIJYhH9/ZB8nYTqmmIrKyZOt
         v/xwfYWt0cWEssbqUCks85vhuz2iMbUi4seFypBxils+zxXP0Y5DR/LhYylU1XzEuwhM
         8aQsDNueZUcdP0/dSNND7zx5bapBXwHFhov8naw8GImzNfMGhBf9RSKnwuF/nDAKx8I4
         6nDg==
X-Gm-Message-State: AOUpUlGjmfqvvWtpAkRGVUOmEWYRTamf4FTiGWlxtUZANRQSgU5ZOFxm
        IcpoW98wg0OOsfwrjf5y5w58CambopzQxIQQhf2vMQ==
X-Google-Smtp-Source: AA+uWPwaI3kJgi4C4i69PbH4YreznTuJDhKT3/4dN0zn0w/o2FzPCm27+fANhLxgPRFe+K1FBaIBCtgo9cGxobfHveE=
X-Received: by 2002:a1c:8dd1:: with SMTP id p200-v6mr9251145wmd.145.1534230871351;
 Tue, 14 Aug 2018 00:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <1533767600-7794-1-git-send-email-eranian@google.com>
 <20180809080721.GB19243@krava> <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
 <20180810115431.GA4162@krava> <20180813130446.GA8685@krava>
In-Reply-To: <20180813130446.GA8685@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 14 Aug 2018 00:14:19 -0700
Message-ID: <CABPqkBSgYEFFAkddBqZbYXe9tjUY7RbMBjQsZht8ki1iOR6unw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Add struct ordered_events_buffer layer
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
On Mon, Aug 13, 2018 at 6:04 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Fri, Aug 10, 2018 at 01:54:31PM +0200, Jiri Olsa wrote:
> > On Fri, Aug 10, 2018 at 01:21:18AM -0700, Stephane Eranian wrote:
> > > On Thu, Aug 9, 2018 at 1:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > > >
> > > > On Wed, Aug 08, 2018 at 03:33:20PM -0700, Stephane Eranian wrote:
> > > > > This patch fixes a bug in ordered_event.c:alloc_event().
> > > > > An ordered_event struct was not initialized properly potentially
> > > > > causing crashes later on in free_dup_event() depending on the
> > > > > content of the memory. If it was NULL, then it would work fine,
> > > > > otherwise, it could cause crashes such as:
> > > >
> > > > I'm now little puzzled what do we use this first event for..
> > > > I can't see anything special about it, other than it's added
> > > > on the list uninitialized ;-)
> > > >
> > > > it seems to work properly when we ditch it.. might be some
> > > > prehistoric leftover or I'm terribly missing something
> > > >
> > > You need to keep track of the buffers to free. You do not free the
> > > ordered_event structs
> > > individually. For each oe->buffer, you need one free(). Each buffer is
> > > put in the to_free
> > > list. But to link it into the list it needs a list_head. This is what
> > > buffer[0] is used for.
> > > But the logic is broken in  ordered_events__free(). It does not free individual
> > > ordered_event structs, but a buffer with many. Yet, it is missing
> > > freeing all of the duped
> > > events.
> > >
> > >  void ordered_events__free(struct ordered_events *oe)
> > > {
> > >         while (!list_empty(&oe->to_free)) {
> > >                 struct ordered_event *buffer;
> > >
> > >                 buffer = list_entry(oe->to_free.next, struct
> > > ordered_event, list);
> > >                 list_del(&buffer->list);
> > > ---->         free_dup_event(oe, event->event);
> > >                 free(buffer);
> > >         }
> > > }
> > > This only frees the dup_event of buffer[0] which we know is NULL (well, now).
> > > It needs to walk all the entries in buffer[] to free buffer[x].event.
> >
> > yes.. if there's copy_on_queue set, we need to do that,
> > otherwise we're leaking all the events
> >
> > >
> > > I think the goal was likely to avoid adding another list_head field to
> > > each ordered_event
> > > and instead use one per allocated buffer.
> > > This is very convoluted and prone to errors and we are seeing right
> > > now. This should
> > > be cleaned. So either you add a list_head to ordered_event or you
> > > would buffer[x] in
> > > ordered_events_free().
> > >
> > > At this point, this is my understanding.
> > > Do you agree?
> >
> > yea, I see it now.. thanks for pointing this out
> >
> > how about something like below? haven't tested properly yet
>
> attaching full patch
>
> thanks,
> jirka
>
>
> ---
> When ordering events, we use preallocated buffers to store separated
> events. Those buffers currently don't have their own struct, but since
> they are basically array of 'struct ordered_event' objects, we use the
> first event to hold buffers data - list head, that holds all buffers
> together:
>
>    struct ordered_events {
>      ...
>      struct ordered_event *buffer;
>      ...
>    };
>
>    struct ordered_event {
>      u64               timestamp;
>      u64               file_offset;
>      union perf_event  *event;
>      struct list_head  list;
>    };
>
> This is quite convoluted and error prone as demonstrated by
> free-ing issue discovered and fixed by Stephane in here [1].
>
> This patch adds the 'struct ordered_events_buffer' object,
> that holds the buffer data and frees it up properly.
>
> [1] - https://marc.info/?l=linux-kernel&m=153376761329335&w=2
>
> Reported-by: Stephane Eranian <eranian@google.com>
> Link: http://lkml.kernel.org/n/tip-qrkcqm5m1sugy4q83pfn5a1r@git.kernel.org
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/ordered-events.c | 44 ++++++++++++++++++++++----------
>  tools/perf/util/ordered-events.h | 37 +++++++++++++++------------
>  2 files changed, 52 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index bad9e0296e9a..038515a52e2c 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -80,14 +80,20 @@ static union perf_event *dup_event(struct ordered_events *oe,
>         return oe->copy_on_queue ? __dup_event(oe, event) : event;
>  }
>
> -static void free_dup_event(struct ordered_events *oe, union perf_event *event)
> +static void __free_dup_event(struct ordered_events *oe, union perf_event *event)
>  {
> -       if (event && oe->copy_on_queue) {
> +       if (event) {
>                 oe->cur_alloc_size -= event->header.size;
>                 free(event);
>         }
>  }
>
> +static void free_dup_event(struct ordered_events *oe, union perf_event *event)
> +{
> +       if (oe->copy_on_queue)
> +               __free_dup_event(oe, event);
> +}
> +
>  #define MAX_SAMPLE_BUFFER      (64 * 1024 / sizeof(struct ordered_event))
>  static struct ordered_event *alloc_event(struct ordered_events *oe,
>                                          union perf_event *event)
> @@ -104,11 +110,12 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>                 new = list_entry(cache->next, struct ordered_event, list);
>                 list_del(&new->list);
>         } else if (oe->buffer) {
> -               new = oe->buffer + oe->buffer_idx;
> +               new = &oe->buffer->event[oe->buffer_idx];
>                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
>                         oe->buffer = NULL;
>         } else if (oe->cur_alloc_size < oe->max_alloc_size) {
> -               size_t size = MAX_SAMPLE_BUFFER * sizeof(*new);
> +               size_t size = sizeof(*oe->buffer) +
> +                             MAX_SAMPLE_BUFFER * sizeof(*new);
>
>                 oe->buffer = malloc(size);
>                 if (!oe->buffer) {
> @@ -122,9 +129,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>                 oe->cur_alloc_size += size;
>                 list_add(&oe->buffer->list, &oe->to_free);
>
> -               /* First entry is abused to maintain the to_free list. */
> -               oe->buffer_idx = 2;
> -               new = oe->buffer + 1;
> +               oe->buffer_idx = 1;
> +               new = &oe->buffer->event[0];

Ok, but I think this section between the malloc() and the line above
needs some comments to clarify what is going on.
It is still hard to read.

>         } else {
>                 pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
>         }
> @@ -300,15 +306,27 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
>         oe->deliver        = deliver;
>  }
>
> +static void
> +ordered_events_buffer__free(struct ordered_events_buffer *buffer,
> +                           struct ordered_events *oe)
> +{
> +       if (oe->copy_on_queue) {
> +               unsigned int i;
> +
> +               for (i = 0; i < MAX_SAMPLE_BUFFER; i++)
> +                       __free_dup_event(oe, buffer->event[i].event);
> +       }
> +
I have a problem with this one, given that the buffer->event[] is
never actually zeroed.
So what happens if you do not use all the entries by the time you have to free?
I think one way to avoid this is by iterating only all the way to
oe->buffer_idx.

> +       free(buffer);
> +}
> +
>  void ordered_events__free(struct ordered_events *oe)
>  {
> -       while (!list_empty(&oe->to_free)) {
> -               struct ordered_event *event;
> +       struct ordered_events_buffer *buffer, *tmp;
>
> -               event = list_entry(oe->to_free.next, struct ordered_event, list);
> -               list_del(&event->list);
> -               free_dup_event(oe, event->event);
> -               free(event);
> +       list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
> +               list_del(&buffer->list);
> +               ordered_events_buffer__free(buffer, oe);
>         }
>  }
>
> diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
> index 8c7a2948593e..1338d5c345dc 100644
> --- a/tools/perf/util/ordered-events.h
> +++ b/tools/perf/util/ordered-events.h
> @@ -25,23 +25,28 @@ struct ordered_events;
>  typedef int (*ordered_events__deliver_t)(struct ordered_events *oe,
>                                          struct ordered_event *event);
>
> +struct ordered_events_buffer {
> +       struct list_head        list;
> +       struct ordered_event    event[0];
> +};
> +
>  struct ordered_events {
> -       u64                     last_flush;
> -       u64                     next_flush;
> -       u64                     max_timestamp;
> -       u64                     max_alloc_size;
> -       u64                     cur_alloc_size;
> -       struct list_head        events;
> -       struct list_head        cache;
> -       struct list_head        to_free;
> -       struct ordered_event    *buffer;
> -       struct ordered_event    *last;
> -       ordered_events__deliver_t deliver;
> -       int                     buffer_idx;
> -       unsigned int            nr_events;
> -       enum oe_flush           last_flush_type;
> -       u32                     nr_unordered_events;
> -       bool                    copy_on_queue;
> +       u64                              last_flush;
> +       u64                              next_flush;
> +       u64                              max_timestamp;
> +       u64                              max_alloc_size;
> +       u64                              cur_alloc_size;
> +       struct list_head                 events;
> +       struct list_head                 cache;
> +       struct list_head                 to_free;
> +       struct ordered_events_buffer    *buffer;
> +       struct ordered_event            *last;
> +       ordered_events__deliver_t        deliver;
> +       int                              buffer_idx;
> +       unsigned int                     nr_events;
> +       enum oe_flush                    last_flush_type;
> +       u32                              nr_unordered_events;
> +       bool                             copy_on_queue;
>  };
>
>  int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
> --
> 2.17.1
>
