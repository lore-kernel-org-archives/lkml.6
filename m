Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904CCC4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A7B223B5
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 08:21:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fk3ox4uT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41A7B223B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbeHJKuV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 06:50:21 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39619 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbeHJKuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 06:50:20 -0400
Received: by mail-wr1-f66.google.com with SMTP id h10-v6so7503053wre.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Aug 2018 01:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cO4PA/1+z2tQO0z/RG+l0qNJjq3sAN2geBDB5jiMFMc=;
        b=Fk3ox4uTLbCn1iN0ReYGQQUDlEzhvJYAquvN2hS/iew9REIRUEuFhTGkA6u02iuRTI
         iiTo+d+dXK/d/X0FhBNb6j+7GpE8334vFNXnHncbT5CzU6tZSRlyHR/d+QD4xvlkNx0n
         Y5BMhImHgRxsG3zSowOm0CMEj7EdsypUvxk+j8tHnhRwRj9WZ/VcTqXc/+KYyforyaeU
         6VL5LNGxvhCiZ7GQMvw9e1QHDzNs28mrQ4J533fNZVrgHHQuC0qI63pd8IK20NRbT+fD
         gFSg6yP6j6fx1NtUBkfCfnPXYPovS9nXDtMA3pMlK2yr5pLqcCdlVdwp3hoD4D5x28my
         6r1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cO4PA/1+z2tQO0z/RG+l0qNJjq3sAN2geBDB5jiMFMc=;
        b=FBo/CVuCoov7DcxfE/Dsr05Ndq7wpqEp+xaZfDCLNLZdUbaq7/atitwIn29og6HTAn
         cxSvs9+asG631vc7bmtnx3ZLGYkjAYNN3YDH3LhPnW4SYPfBYOZejDNdckWocySPNg0/
         AI+roVx1bRRUvqbU88R/DEqMAZrz7j75tPpElgX3V7IFq8y4KQR3M6IhSXqn3kjpEbpT
         p1f0hLgdv9P5RKBPsxjOHAzW3OntRT4JzA64sfwGf78eY7P4DhvzdfQC/d0LVwGLfra/
         SryvANk7/nDEth3C2CqPLdVNxs6TyVkFXplhnb/eQgYarUmUlBbs6zH3dOlE+imC608u
         297g==
X-Gm-Message-State: AOUpUlEg0FQojg3fdlaIj8JUoXja+MvXa5TeQmN94gGk43ZPDlpaK1N0
        BUdjol9oHOYWFYRRmPWNWmPComO92j3LD3hEzJQfIQ==
X-Google-Smtp-Source: AA+uWPzJKUY9vRybPxTquRZc9+sbrpjSs28L4BXTRBeBpnEIVZ6kTT9mN5Gapk7uhzkgRGAMxU4xt9wJD9dOyiLBz80=
X-Received: by 2002:adf:fc45:: with SMTP id e5-v6mr3543287wrs.157.1533889290104;
 Fri, 10 Aug 2018 01:21:30 -0700 (PDT)
MIME-Version: 1.0
References: <1533767600-7794-1-git-send-email-eranian@google.com> <20180809080721.GB19243@krava>
In-Reply-To: <20180809080721.GB19243@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Fri, 10 Aug 2018 01:21:18 -0700
Message-ID: <CABPqkBQEfoMDEqot1VbgExg1fU3+EEunzZqDFKSGmLKBhxNkwA@mail.gmail.com>
Subject: Re: [PATCH v2] perf ordered_events: fix crash in free_dup_event()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, mingo@elte.hu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 9, 2018 at 1:07 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Aug 08, 2018 at 03:33:20PM -0700, Stephane Eranian wrote:
> > This patch fixes a bug in ordered_event.c:alloc_event().
> > An ordered_event struct was not initialized properly potentially
> > causing crashes later on in free_dup_event() depending on the
> > content of the memory. If it was NULL, then it would work fine,
> > otherwise, it could cause crashes such as:
>
> I'm now little puzzled what do we use this first event for..
> I can't see anything special about it, other than it's added
> on the list uninitialized ;-)
>
> it seems to work properly when we ditch it.. might be some
> prehistoric leftover or I'm terribly missing something
>
You need to keep track of the buffers to free. You do not free the
ordered_event structs
individually. For each oe->buffer, you need one free(). Each buffer is
put in the to_free
list. But to link it into the list it needs a list_head. This is what
buffer[0] is used for.
But the logic is broken in  ordered_events__free(). It does not free individual
ordered_event structs, but a buffer with many. Yet, it is missing
freeing all of the duped
events.

 void ordered_events__free(struct ordered_events *oe)
{
        while (!list_empty(&oe->to_free)) {
                struct ordered_event *buffer;

                buffer = list_entry(oe->to_free.next, struct
ordered_event, list);
                list_del(&buffer->list);
---->         free_dup_event(oe, event->event);
                free(buffer);
        }
}
This only frees the dup_event of buffer[0] which we know is NULL (well, now).
It needs to walk all the entries in buffer[] to free buffer[x].event.

I think the goal was likely to avoid adding another list_head field to
each ordered_event
and instead use one per allocated buffer.
This is very convoluted and prone to errors and we are seeing right
now. This should
be cleaned. So either you add a list_head to ordered_event or you
would buffer[x] in
ordered_events_free().

At this point, this is my understanding.
Do you agree?


>
> thanks,
> jirka
>
>
> ---
> diff --cc tools/perf/util/ordered-events.c
> index bad9e0296e9a,0e837b0b8582..000000000000
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@@ -119,12 -119,8 +119,9 @@@ static struct ordered_event *alloc_even
>                 pr("alloc size %" PRIu64 "B (+%zu), max %" PRIu64 "B\n",
>                    oe->cur_alloc_size, size, oe->max_alloc_size);
>
>  +              oe->cur_alloc_size += size;
> -               list_add(&oe->buffer->list, &oe->to_free);
> -
> -               /* First entry is abused to maintain the to_free list. */
> -               oe->buffer_idx = 2;
> -               new = oe->buffer + 1;
> +               oe->buffer_idx = 1;
> +               new = oe->buffer;
>         } else {
>                 pr("allocation limit reached %" PRIu64 "B\n", oe->max_alloc_size);
>         }
