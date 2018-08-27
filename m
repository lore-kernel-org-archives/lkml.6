Return-Path: <SRS0=ekB2=LK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30DD5C433F4
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7822208B8
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Aug 2018 15:25:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RIljxpAa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7822208B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727086AbeH0TMP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Aug 2018 15:12:15 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33778 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbeH0TMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Aug 2018 15:12:15 -0400
Received: by mail-wr1-f65.google.com with SMTP id v90-v6so14033307wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Aug 2018 08:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CVonuTD2+P1mRuQBu21JEK1VihPWQbfsCqWhCd49sr4=;
        b=RIljxpAaXZGrvTN4sX7Oax4MqLjtztsT4pcJ3DRgT5FBWmFcaI4NH6VpsZKMNbryh4
         qpkY2TuEFQUsR7NOOGiRbxxrbcWBFdEvdklhtXHs4fCheZcrLden7f9yhhZhXW6xk2vf
         2oVkzYyZWxWo89nYcS7Y1hpzRAtnTYVJYDUtj5Vmodror2e80dfpqvFlwfonLKsOY3WX
         W09Aovvs7LKXiVvWGOwu7kS+rmzBDzUYg0MdGeEJf/yb4Hi05YkkAk9Ra/HdgQtPeo/v
         bWJ9CkvfVKzINcNSmbPlJTQeeDRMYBc5hFBIC3GQ1V4WrZM5kvbQeLiD2DHxw63pZwD+
         EK7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CVonuTD2+P1mRuQBu21JEK1VihPWQbfsCqWhCd49sr4=;
        b=RMQZWLGmeptIEjnrskGUT2TsAnTG/+nbviZBovfF4nKEQiQMPMAvdwv0Yfwg8wlhtS
         j8YWpX60w7daD6r3iIGT4hT8wi1+i4RzfPmVOqX7rK045Wp4eXiVwcPW/m/iRqgOabDq
         aQy9gJRcgc7b8/mdYcAKI7x1dHG1tyHb1qptF/Ks/0Rawex+W3XwB36hADasSMDhT3Gv
         mgHpBXywNQkzdgVRG+9tT2QDW3pq/vJpGtafq+mmjiDHmMvA2/D8ZlSj50ZvMXxjkSs0
         1xTbLgQz11PnUKBPg/kCAaREwoLANeruIobeLSaeoP1Dj0F4444jj4vDcKPBQPbRREH7
         yaUw==
X-Gm-Message-State: APzg51A6atIIPZcFcNvTTlGqVQ5v+02XFApwu2rUDEhFR54dnf7x2EKJ
        fDac9wF4vNKKf7kq7EmytmsisHRfCu3IbaAE0sYuFA==
X-Google-Smtp-Source: ANB0VdZ4VsshJ+/UyJ4OOY7SmCf7OrkHAbLhnhPDXVuR7dhb15SYpeHjnDNV1Q017KN7K9zFh5KJ2Wxq4ikB5xSKHnU=
X-Received: by 2002:adf:fa4d:: with SMTP id y13-v6mr9506846wrr.155.1535383508187;
 Mon, 27 Aug 2018 08:25:08 -0700 (PDT)
MIME-Version: 1.0
References: <1533767600-7794-1-git-send-email-eranian@google.com>
 <20180809080721.GB19243@krava> <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
 <20180810115431.GA4162@krava> <20180813130446.GA8685@krava>
 <CABPqkBSgYEFFAkddBqZbYXe9tjUY7RbMBjQsZht8ki1iOR6unw@mail.gmail.com>
 <20180815084825.GD3180@krava> <20180827092818.GA3725@krava>
In-Reply-To: <20180827092818.GA3725@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 27 Aug 2018 08:24:56 -0700
Message-ID: <CABPqkBQS+QG1jjzMU=wpuOJXD5A8iiPj3fNZoHSsPep7rfEQow@mail.gmail.com>
Subject: Re: [PATCHv2] perf tools: Add struct ordered_events_buffer layer
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri,


On Mon, Aug 27, 2018 at 2:28 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Aug 15, 2018 at 10:48:25AM +0200, Jiri Olsa wrote:
> > On Tue, Aug 14, 2018 at 12:14:19AM -0700, Stephane Eranian wrote:
> >
> > SNIP
> >
> > > > @@ -104,11 +110,12 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
> > > >                 new = list_entry(cache->next, struct ordered_event, list);
> > > >                 list_del(&new->list);
> > > >         } else if (oe->buffer) {
> > > > -               new = oe->buffer + oe->buffer_idx;
> > > > +               new = &oe->buffer->event[oe->buffer_idx];
> > > >                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
> > > >                         oe->buffer = NULL;
> > > >         } else if (oe->cur_alloc_size < oe->max_alloc_size) {
> > > > -               size_t size = MAX_SAMPLE_BUFFER * sizeof(*new);
> > > > +               size_t size = sizeof(*oe->buffer) +
> > > > +                             MAX_SAMPLE_BUFFER * sizeof(*new);
> > > >
> > > >                 oe->buffer = malloc(size);
> > > >                 if (!oe->buffer) {
> > > > @@ -122,9 +129,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
> > > >                 oe->cur_alloc_size += size;
> > > >                 list_add(&oe->buffer->list, &oe->to_free);
> > > >
> > > > -               /* First entry is abused to maintain the to_free list. */
> > > > -               oe->buffer_idx = 2;
> > > > -               new = oe->buffer + 1;
> > > > +               oe->buffer_idx = 1;
> > > > +               new = &oe->buffer->event[0];
> > >
> > > Ok, but I think this section between the malloc() and the line above
> > > needs some comments to clarify what is going on.
> > > It is still hard to read.
> >
> > ok, I put some bigger comment at the top, but I'm not too happy
> > feel free to suggest different one ;-)
> >
> > >
> > > >         } else {
> > > >                 pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
> > > >         }
> > > > @@ -300,15 +306,27 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
> > > >         oe->deliver        = deliver;
> > > >  }
> > > >
> > > > +static void
> > > > +ordered_events_buffer__free(struct ordered_events_buffer *buffer,
> > > > +                           struct ordered_events *oe)
> > > > +{
> > > > +       if (oe->copy_on_queue) {
> > > > +               unsigned int i;
> > > > +
> > > > +               for (i = 0; i < MAX_SAMPLE_BUFFER; i++)
> > > > +                       __free_dup_event(oe, buffer->event[i].event);
> > > > +       }
> > > > +
> > > I have a problem with this one, given that the buffer->event[] is
> > > never actually zeroed.
> > > So what happens if you do not use all the entries by the time you have to free?
> > > I think one way to avoid this is by iterating only all the way to
> > > oe->buffer_idx.
> >
> > right, please check attached patch
>
> any comments? attaching v2
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
>  tools/perf/util/ordered-events.c | 82 +++++++++++++++++++++++++++-----
>  tools/perf/util/ordered-events.h | 37 +++++++-------
>  2 files changed, 90 insertions(+), 29 deletions(-)
>
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index bad9e0296e9a..3672060508a7 100644
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
> @@ -100,15 +106,43 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>         if (!new_event)
>                 return NULL;
>
> +       /*
> +        * We maintain following scheme of buffers for ordered
> +        * event allocation:
> +        *
> +        *   to_free list -> buffer1 (64K)
> +        *                   buffer2 (64K)
> +        *                   ...
> +        *
> +        * Each buffer keeps an array of ordered events objects:
> +        *    buffer -> event[0]
> +        *              event[1]
> +        *              ...
> +        *
> +        * Each allocated ordered event is linked to one of
> +        * following lists:
> +        *   - time ordered list 'events'
> +        *   - list of currently removed events 'cache'
> +        *
> +        * Allocation of the ordered event uses following order
> +        * to get the memory:
> +        *   - use recently removed object from 'cache' list
> +        *   - use available object in current allocation buffer
> +        *   - allocate new buffer if the current buffer is full
> +        *
> +        * Removal of ordered event object moves it from events to
> +        * the cache list.
> +        */
>         if (!list_empty(cache)) {
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
> @@ -122,9 +156,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>                 oe->cur_alloc_size += size;
>                 list_add(&oe->buffer->list, &oe->to_free);
>
> -               /* First entry is abused to maintain the to_free list. */
> -               oe->buffer_idx = 2;
> -               new = oe->buffer + 1;
> +               oe->buffer_idx = 1;
> +               new = &oe->buffer->event[0];
>         } else {
>                 pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);


I am wondering about the usefulness of returning a new_event with
new_event->event = NULL
in this case. Don't you need new_event->event? If so, then you need return NULL.

>         }
> @@ -300,15 +333,38 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
>         oe->deliver        = deliver;
>  }
>
> +static void
> +ordered_events_buffer__free(struct ordered_events_buffer *buffer,
> +                           unsigned int max, struct ordered_events *oe)
> +{
> +       if (oe->copy_on_queue) {
> +               unsigned int i;
> +
> +               for (i = 0; i < max; i++)
> +                       __free_dup_event(oe, buffer->event[i].event);
> +       }
> +
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
> +       if (list_empty(&oe->to_free))
> +               return;
> +
> +       /*
> +        * Current buffer might not have all the events allocated
> +        * yet, we need to free only allocated ones ...
> +        */
> +       list_del(&oe->buffer->list);
> +       ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
> +
> +       /* ... and continue with the rest */
> +       list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
> +               list_del(&buffer->list);
> +               ordered_events_buffer__free(buffer, MAX_SAMPLE_BUFFER, oe);


Here you are saying that if it is on the to_free list and not the
current buffer, then necessarily
all the entries have been used and it is safe to use
MAX_SAMPLE_BUFFER. Is that right?

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
