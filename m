Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F97C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8ADE2086A
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 02:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u1zgXjUb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8ADE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726047AbeIDHBE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 03:01:04 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55976 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725837AbeIDHBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 03:01:04 -0400
Received: by mail-wm0-f65.google.com with SMTP id f21-v6so2705996wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 03 Sep 2018 19:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pYtqK5PkNu+1njshomHfJClDnLZjip+jdNiVPgQvCwc=;
        b=u1zgXjUbdRHtrXahnPCdpcqSJCGdmltG+NNxEvEHeA38p5Z8hj1sfXCjMjP2ensVYS
         kkj++crdgS6NQaVfXJqxNgaGDCx40EEtVHJ/XtPQdNTkgOSAmMVcJCR8bex6yPx8G44i
         YWm3rUWvD2EgvKhknVVAGzGr91LflDanFgj4o+x93aumYiJukYn2UzlmEf/SGVKBHEOj
         FL8HsorM0flMF9f/jePEWg+yyaFOtgfpRltymn+4tAbz/jv46bN/c6kT7bgpBLrtWjZ/
         BY5QjE7Rr3uMvd738JteUyHKn2DOQ3Ozc2Vn7QaN36KdQrTd1JIFd4yUuAuWWyih+3fe
         fSmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pYtqK5PkNu+1njshomHfJClDnLZjip+jdNiVPgQvCwc=;
        b=n9QsmvborJQUmKp0LCHVqd5wi1qfYhIf1JJkaX+KYZWFoT+d6EVhqbrto09nEwwdNg
         4iES+qeCcRhmIk8Tdy7EyVss9jkLbOgn6s4BGEQOnnHLLNiHa7FC0SRQze6NVi8I3iB1
         TX4ymvBSSQlkTZrhAbqlp+wTrgK2R9TlxdGKcLHov9iwsUrtIBLIfZ2Ww7BZddoDSU+2
         2z2A2pbgdeYeiCg1GhOWYB3auvPXIwV9oyDdtOrkfXJ79wAATX6HNwibmV0A8oBXRCPI
         k2MgZB6ArFxmiw+K9UdyYB6bjmpBPpFnvpNJAWgHklThZ1dJKnVdenfRCGBTT7hJ3cUc
         ZBaw==
X-Gm-Message-State: APzg51Au+xoACbEzP46IZj06LznTFQxChfXcozHxa3db4NS9ZO8aU42f
        M312/2lDOR/zCEWOui7gx4j17TnRXCHv/khbMOcH/Q==
X-Google-Smtp-Source: ANB0VdZP0+UB42pmEpx1kC6oN4fU4lbiuLZBz1KRnO1Vdxh+SCAPEWHsn756BdUgJw1i+ID24bzXCcfDT1dNyurY65c=
X-Received: by 2002:a1c:5411:: with SMTP id i17-v6mr6577301wmb.53.1536028688529;
 Mon, 03 Sep 2018 19:38:08 -0700 (PDT)
MIME-Version: 1.0
References: <1533767600-7794-1-git-send-email-eranian@google.com>
 <20180809080721.GB19243@krava> <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
 <20180810115431.GA4162@krava> <20180813130446.GA8685@krava>
 <CABPqkBSgYEFFAkddBqZbYXe9tjUY7RbMBjQsZht8ki1iOR6unw@mail.gmail.com>
 <20180815084825.GD3180@krava> <20180827092818.GA3725@krava>
 <CABPqkBQS+QG1jjzMU=wpuOJXD5A8iiPj3fNZoHSsPep7rfEQow@mail.gmail.com>
 <20180827170543.GA31347@krava> <20180902144738.GA28012@krava>
In-Reply-To: <20180902144738.GA28012@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 3 Sep 2018 19:37:56 -0700
Message-ID: <CABPqkBTiDYm_pbFdbQCiNTpECVpWyOb16vBFC7AZ=vzqcR=2ig@mail.gmail.com>
Subject: Re: [PATCHv3] perf tools: Add struct ordered_events_buffer layer
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

On Sun, Sep 2, 2018 at 7:47 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Aug 27, 2018 at 07:05:43PM +0200, Jiri Olsa wrote:
> > On Mon, Aug 27, 2018 at 08:24:56AM -0700, Stephane Eranian wrote:
> >
> > SNIP
> >
> > > > -               /* First entry is abused to maintain the to_free list. */
> > > > -               oe->buffer_idx = 2;
> > > > -               new = oe->buffer + 1;
> > > > +               oe->buffer_idx = 1;
> > > > +               new = &oe->buffer->event[0];
> > > >         } else {
> > > >                 pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
> > >
> > >
> > > I am wondering about the usefulness of returning a new_event with
> > > new_event->event = NULL
> > > in this case. Don't you need new_event->event? If so, then you need return NULL.
> >
> > yep, that's a bug.. with new being NULL in here,
> > we'd get a crash anyway.. so 'return NULL;' it is
> >
> > SNIP
> >
> > > > +        * yet, we need to free only allocated ones ...
> > > > +        */
> > > > +       list_del(&oe->buffer->list);
> > > > +       ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
> > > > +
> > > > +       /* ... and continue with the rest */
> > > > +       list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
> > > > +               list_del(&buffer->list);
> > > > +               ordered_events_buffer__free(buffer, MAX_SAMPLE_BUFFER, oe);
> > >
> > >
> > > Here you are saying that if it is on the to_free list and not the
> > > current buffer, then necessarily
> > > all the entries have been used and it is safe to use
> > > MAX_SAMPLE_BUFFER. Is that right?
> >
> > yes, at this point they either holds an event or NULL
> > so it's free to call __free_dup_event on it
> >
> > thanks, v3 attached
> >
> > added also Namhyung's ack, as the 'return NULL' change wasn't
> > related to the v2 changes
> >

I think the code is correct now for the issue related to uninitialized pointer.
But there is still one problem I found stressing the code with max_alloc_size.
The way the following is written:

       if (!list_empty(cache)) {
                new = list_entry(cache->next, struct ordered_event, list);
                list_del(&new->list);
        } else if (oe->buffer) {
                new = oe->buffer + oe->buffer_idx;
                if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
                        oe->buffer = NULL;
        } else if (oe->cur_alloc_size < oe->max_alloc_size) {
                size_t size = sizeof(*oe->buffer) MAX_SAMPLE_BUFFER *
sizeof(*new);

                oe->buffer = malloc(size);
                if (!oe->buffer) {
                        free_dup_event(oe, new_event);
                        return NULL;
                }

                pr("alloc size %" PRIu64 "B (+%zu), max %" PRIu64 "B\n",
                   oe->cur_alloc_size, size, oe->max_alloc_size);

                oe->cur_alloc_size += size;

You can end up with oe->cur_alloc_size > oe->max_alloc_size in case
the max limit is
really low (< size_t size = sizeof (*oe->buffer) + MAX_SAMPLE_BUFFER *
sizeof(*new);
So I think to make sure you can never allocate more than the max, you
have to do:

      size_t size = sizeof(*oe->buffer) MAX_SAMPLE_BUFFER * sizeof(*new);
       if (!list_empty(cache)) {
                new = list_entry(cache->next, struct ordered_event, list);
                list_del(&new->list);
        } else if (oe->buffer) {
                new = oe->buffer + oe->buffer_idx;
                if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
                        oe->buffer = NULL;
        } else if ((oe->cur_alloc_size + size) < oe->max_alloc_size) {

Then you will never allocate more than the max.
I think with this change, we are okay.
Tested-by: Stephane Eranian <eranian@google.com>

 > jirka
>
> Stephane,
> any comments to v3 version?
>
> thanks,
> jirka
>
> >
> >
> > ---
> > When ordering events, we use preallocated buffers to store separated
> > events. Those buffers currently don't have their own struct, but since
> > they are basically array of 'struct ordered_event' objects, we use the
> > first event to hold buffers data - list head, that holds all buffers
> > together:
> >
> >    struct ordered_events {
> >      ...
> >      struct ordered_event *buffer;
> >      ...
> >    };
> >
> >    struct ordered_event {
> >      u64               timestamp;
> >      u64               file_offset;
> >      union perf_event  *event;
> >      struct list_head  list;
> >    };
> >
> > This is quite convoluted and error prone as demonstrated by
> > free-ing issue discovered and fixed by Stephane in here [1].
> >
> > This patch adds the 'struct ordered_events_buffer' object,
> > that holds the buffer data and frees it up properly.
> >
> > [1] - https://marc.info/?l=linux-kernel&m=153376761329335&w=2
> >
> > Reported-by: Stephane Eranian <eranian@google.com>
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> > Link: http://lkml.kernel.org/n/tip-qrkcqm5m1sugy4q83pfn5a1r@git.kernel.org
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  tools/perf/util/ordered-events.c | 83 +++++++++++++++++++++++++++-----
> >  tools/perf/util/ordered-events.h | 37 ++++++++------
> >  2 files changed, 91 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> > index bad9e0296e9a..87171e8fd70d 100644
> > --- a/tools/perf/util/ordered-events.c
> > +++ b/tools/perf/util/ordered-events.c
> > @@ -80,14 +80,20 @@ static union perf_event *dup_event(struct ordered_events *oe,
> >       return oe->copy_on_queue ? __dup_event(oe, event) : event;
> >  }
> >
> > -static void free_dup_event(struct ordered_events *oe, union perf_event *event)
> > +static void __free_dup_event(struct ordered_events *oe, union perf_event *event)
> >  {
> > -     if (event && oe->copy_on_queue) {
> > +     if (event) {
> >               oe->cur_alloc_size -= event->header.size;
> >               free(event);
> >       }
> >  }
> >
> > +static void free_dup_event(struct ordered_events *oe, union perf_event *event)
> > +{
> > +     if (oe->copy_on_queue)
> > +             __free_dup_event(oe, event);
> > +}
> > +
> >  #define MAX_SAMPLE_BUFFER    (64 * 1024 / sizeof(struct ordered_event))
> >  static struct ordered_event *alloc_event(struct ordered_events *oe,
> >                                        union perf_event *event)
> > @@ -100,15 +106,43 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
> >       if (!new_event)
> >               return NULL;
> >
> > +     /*
> > +      * We maintain following scheme of buffers for ordered
> > +      * event allocation:
> > +      *
> > +      *   to_free list -> buffer1 (64K)
> > +      *                   buffer2 (64K)
> > +      *                   ...
> > +      *
> > +      * Each buffer keeps an array of ordered events objects:
> > +      *    buffer -> event[0]
> > +      *              event[1]
> > +      *              ...
> > +      *
> > +      * Each allocated ordered event is linked to one of
> > +      * following lists:
> > +      *   - time ordered list 'events'
> > +      *   - list of currently removed events 'cache'
> > +      *
> > +      * Allocation of the ordered event uses following order
> > +      * to get the memory:
> > +      *   - use recently removed object from 'cache' list
> > +      *   - use available object in current allocation buffer
> > +      *   - allocate new buffer if the current buffer is full
> > +      *
> > +      * Removal of ordered event object moves it from events to
> > +      * the cache list.
> > +      */
> >       if (!list_empty(cache)) {
> >               new = list_entry(cache->next, struct ordered_event, list);
> >               list_del(&new->list);
> >       } else if (oe->buffer) {
> > -             new = oe->buffer + oe->buffer_idx;
> > +             new = &oe->buffer->event[oe->buffer_idx];
> >               if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
> >                       oe->buffer = NULL;
> >       } else if (oe->cur_alloc_size < oe->max_alloc_size) {
> > -             size_t size = MAX_SAMPLE_BUFFER * sizeof(*new);
> > +             size_t size = sizeof(*oe->buffer) +
> > +                           MAX_SAMPLE_BUFFER * sizeof(*new);
> >
> >               oe->buffer = malloc(size);
> >               if (!oe->buffer) {
> > @@ -122,11 +156,11 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
> >               oe->cur_alloc_size += size;
> >               list_add(&oe->buffer->list, &oe->to_free);
> >
> > -             /* First entry is abused to maintain the to_free list. */
> > -             oe->buffer_idx = 2;
> > -             new = oe->buffer + 1;
> > +             oe->buffer_idx = 1;
> > +             new = &oe->buffer->event[0];
> >       } else {
> >               pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
> > +             return NULL;
> >       }
> >
> >       new->event = new_event;
> > @@ -300,15 +334,38 @@ void ordered_events__init(struct ordered_events *oe, ordered_events__deliver_t d
> >       oe->deliver        = deliver;
> >  }
> >
> > +static void
> > +ordered_events_buffer__free(struct ordered_events_buffer *buffer,
> > +                         unsigned int max, struct ordered_events *oe)
> > +{
> > +     if (oe->copy_on_queue) {
> > +             unsigned int i;
> > +
> > +             for (i = 0; i < max; i++)
> > +                     __free_dup_event(oe, buffer->event[i].event);
> > +     }
> > +
> > +     free(buffer);
> > +}
> > +
> >  void ordered_events__free(struct ordered_events *oe)
> >  {
> > -     while (!list_empty(&oe->to_free)) {
> > -             struct ordered_event *event;
> > +     struct ordered_events_buffer *buffer, *tmp;
> >
> > -             event = list_entry(oe->to_free.next, struct ordered_event, list);
> > -             list_del(&event->list);
> > -             free_dup_event(oe, event->event);
> > -             free(event);
> > +     if (list_empty(&oe->to_free))
> > +             return;
> > +
> > +     /*
> > +      * Current buffer might not have all the events allocated
> > +      * yet, we need to free only allocated ones ...
> > +      */
> > +     list_del(&oe->buffer->list);
> > +     ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
> > +
> > +     /* ... and continue with the rest */
> > +     list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
> > +             list_del(&buffer->list);
> > +             ordered_events_buffer__free(buffer, MAX_SAMPLE_BUFFER, oe);
> >       }
> >  }
> >
> > diff --git a/tools/perf/util/ordered-events.h b/tools/perf/util/ordered-events.h
> > index 8c7a2948593e..1338d5c345dc 100644
> > --- a/tools/perf/util/ordered-events.h
> > +++ b/tools/perf/util/ordered-events.h
> > @@ -25,23 +25,28 @@ struct ordered_events;
> >  typedef int (*ordered_events__deliver_t)(struct ordered_events *oe,
> >                                        struct ordered_event *event);
> >
> > +struct ordered_events_buffer {
> > +     struct list_head        list;
> > +     struct ordered_event    event[0];
> > +};
> > +
> >  struct ordered_events {
> > -     u64                     last_flush;
> > -     u64                     next_flush;
> > -     u64                     max_timestamp;
> > -     u64                     max_alloc_size;
> > -     u64                     cur_alloc_size;
> > -     struct list_head        events;
> > -     struct list_head        cache;
> > -     struct list_head        to_free;
> > -     struct ordered_event    *buffer;
> > -     struct ordered_event    *last;
> > -     ordered_events__deliver_t deliver;
> > -     int                     buffer_idx;
> > -     unsigned int            nr_events;
> > -     enum oe_flush           last_flush_type;
> > -     u32                     nr_unordered_events;
> > -     bool                    copy_on_queue;
> > +     u64                              last_flush;
> > +     u64                              next_flush;
> > +     u64                              max_timestamp;
> > +     u64                              max_alloc_size;
> > +     u64                              cur_alloc_size;
> > +     struct list_head                 events;
> > +     struct list_head                 cache;
> > +     struct list_head                 to_free;
> > +     struct ordered_events_buffer    *buffer;
> > +     struct ordered_event            *last;
> > +     ordered_events__deliver_t        deliver;
> > +     int                              buffer_idx;
> > +     unsigned int                     nr_events;
> > +     enum oe_flush                    last_flush_type;
> > +     u32                              nr_unordered_events;
> > +     bool                             copy_on_queue;
> >  };
> >
> >  int ordered_events__queue(struct ordered_events *oe, union perf_event *event,
> > --
> > 2.17.1
