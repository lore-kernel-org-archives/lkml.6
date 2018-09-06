Return-Path: <SRS0=QnR0=LU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28399C43334
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCFB32075B
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Sep 2018 15:03:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vWfzLnhJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCFB32075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbeIFTjb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Sep 2018 15:39:31 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:51942 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbeIFTja (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Sep 2018 15:39:30 -0400
Received: by mail-wm0-f67.google.com with SMTP id y2-v6so11748459wma.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Sep 2018 08:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vDgs0JSFi3+yNN105xhhVZSUB5brvMtE41ecnMoS628=;
        b=vWfzLnhJW0TlH3Jhg9urQ4OdUOIGQEop+hlH8c+kru3kRkAf6eQ1sHHhDe+T+AvHVp
         e0iWCAQDW0v64PlOPhu3NIHfZiB5Fz6IiKCMRou+yPa7AtrLMpIYRY0DknpzpWhYfWzy
         yLXV1ZavyFJRTGq/Q2hEE84ObRr1WDihERcEqgMXLSeHrErikcb/+Yf9NEdNb/f1iZ0q
         DNeiaMUQL9qyFWhwk4jw2pzEB1WVvhOBVJGz2J9Orvlb0/eiiAq8SSvqmt6ldYkZS5HP
         qOchJWVNT/rmT/7MCXiGC6sTa2U9jG/QKPjlyCx/GslZj6qU4ZwkwKZ6+/cs3nKy0uNa
         RwKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vDgs0JSFi3+yNN105xhhVZSUB5brvMtE41ecnMoS628=;
        b=ngAI38d/8lg4ROf2S9pvl5Wf2V3fzjkz/ftPefLQnaJDjTqtkt5EMkyuSTtjJsS7CW
         dfYtCGEEPFpwH3jzUY0U17kw+KPAgyFUnV47JLj9PMnccYlu1eDY6zkHMdDf34JUBI5P
         rd+HkL1dyc+b1fafRl9Brmo3E5Nmd5ULnauKVsciUAM1ZS2bqtI5+52FzLn5ryrkuNhN
         jyEjXTXylc6DtqJxGJHrYKXTEd+CLxZfYL9F7JPBdO+t4HG5PmMmkLBiIt68v07FIR1J
         DwVoaD+k7UGoPJfRHQp1vht0nYJ1ocOgkZRaUgcHXRD8YL+l6fTP6HFa8Of9kXIWCoRA
         AFzg==
X-Gm-Message-State: APzg51CKjNnR6XmAxWxbqj8vcHaI3AObMluBtnes7Lhx8LxZxYe2rQSd
        KHP20MGlYX3SLCd6BMaNF9ThixnkXUU83YGvee05tw==
X-Google-Smtp-Source: ANB0VdZ442klrifclm6KDhx2KLXSdptr9k4CxtVIpuRYPgElBeDpfNgZDkbDjTbeKmav8JfPKUs1OLNW8eDXLWdwNlY=
X-Received: by 2002:a1c:9d02:: with SMTP id g2-v6mr2228025wme.122.1536246211708;
 Thu, 06 Sep 2018 08:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
 <20180810115431.GA4162@krava> <20180813130446.GA8685@krava>
 <CABPqkBSgYEFFAkddBqZbYXe9tjUY7RbMBjQsZht8ki1iOR6unw@mail.gmail.com>
 <20180815084825.GD3180@krava> <20180827092818.GA3725@krava>
 <CABPqkBQS+QG1jjzMU=wpuOJXD5A8iiPj3fNZoHSsPep7rfEQow@mail.gmail.com>
 <20180827170543.GA31347@krava> <20180902144738.GA28012@krava>
 <CABPqkBTiDYm_pbFdbQCiNTpECVpWyOb16vBFC7AZ=vzqcR=2ig@mail.gmail.com> <20180906132859.GA9577@krava>
In-Reply-To: <20180906132859.GA9577@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 6 Sep 2018 08:04:02 -0700
Message-ID: <CABPqkBQkzyATS_W31-ND6tgB3QBoro-G9rGCSgOJAfBKifdRHQ@mail.gmail.com>
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

On Thu, Sep 6, 2018 at 6:29 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Sep 03, 2018 at 07:37:56PM -0700, Stephane Eranian wrote:
>
> SNIP
>
> >
> > I think the code is correct now for the issue related to uninitialized pointer.
> > But there is still one problem I found stressing the code with max_alloc_size.
> > The way the following is written:
> >
> >        if (!list_empty(cache)) {
> >                 new = list_entry(cache->next, struct ordered_event, list);
> >                 list_del(&new->list);
> >         } else if (oe->buffer) {
> >                 new = oe->buffer + oe->buffer_idx;
> >                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
> >                         oe->buffer = NULL;
> >         } else if (oe->cur_alloc_size < oe->max_alloc_size) {
> >                 size_t size = sizeof(*oe->buffer) MAX_SAMPLE_BUFFER *
> > sizeof(*new);
> >
> >                 oe->buffer = malloc(size);
> >                 if (!oe->buffer) {
> >                         free_dup_event(oe, new_event);
> >                         return NULL;
> >                 }
> >
> >                 pr("alloc size %" PRIu64 "B (+%zu), max %" PRIu64 "B\n",
> >                    oe->cur_alloc_size, size, oe->max_alloc_size);
> >
> >                 oe->cur_alloc_size += size;
> >
> > You can end up with oe->cur_alloc_size > oe->max_alloc_size in case
> > the max limit is
> > really low (< size_t size = sizeof (*oe->buffer) + MAX_SAMPLE_BUFFER *
> > sizeof(*new);
> > So I think to make sure you can never allocate more than the max, you
> > have to do:
> >
> >       size_t size = sizeof(*oe->buffer) MAX_SAMPLE_BUFFER * sizeof(*new);
> >        if (!list_empty(cache)) {
> >                 new = list_entry(cache->next, struct ordered_event, list);
> >                 list_del(&new->list);
> >         } else if (oe->buffer) {
> >                 new = oe->buffer + oe->buffer_idx;
> >                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
> >                         oe->buffer = NULL;
> >         } else if ((oe->cur_alloc_size + size) < oe->max_alloc_size) {
> >
> > Then you will never allocate more than the max.
> > I think with this change, we are okay.
> > Tested-by: Stephane Eranian <eranian@google.com>
>
> yep, makes sense.. something like below then
> I'll post it on top of the previous patch
>
Yes. This works.
Thanks.


> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index 87171e8fd70d..2d1d0f3c8f77 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -101,6 +101,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>         struct list_head *cache = &oe->cache;
>         struct ordered_event *new = NULL;
>         union perf_event *new_event;
> +       size_t size;
>
>         new_event = dup_event(oe, event);
>         if (!new_event)
> @@ -133,6 +134,8 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>          * Removal of ordered event object moves it from events to
>          * the cache list.
>          */
> +       size = sizeof(*oe->buffer) + MAX_SAMPLE_BUFFER * sizeof(*new);
> +
>         if (!list_empty(cache)) {
>                 new = list_entry(cache->next, struct ordered_event, list);
>                 list_del(&new->list);
> @@ -140,10 +143,7 @@ static struct ordered_event *alloc_event(struct ordered_events *oe,
>                 new = &oe->buffer->event[oe->buffer_idx];
>                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
>                         oe->buffer = NULL;
> -       } else if (oe->cur_alloc_size < oe->max_alloc_size) {
> -               size_t size = sizeof(*oe->buffer) +
> -                             MAX_SAMPLE_BUFFER * sizeof(*new);
> -
> +       } else if ((oe->cur_alloc_size + size) < oe->max_alloc_size) {
>                 oe->buffer = malloc(size);
>                 if (!oe->buffer) {
>                         free_dup_event(oe, new_event);
