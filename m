Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48AD6C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0713620652
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 21:54:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZODnnXre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731410AbfAPVyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 16:54:09 -0500
Received: from mail-qt1-f175.google.com ([209.85.160.175]:44922 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731095AbfAPVyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 16:54:08 -0500
Received: by mail-qt1-f175.google.com with SMTP id n32so9045761qte.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 13:54:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NSenx1DO0yjoW9T/uFtKqZ0r4srEmOF5tK7bZenMyTk=;
        b=ZODnnXreaNPYbGP9cbElIubbM90xWE0GnPkjUvNDaB2aVNV8tstGGE6CxcC68Coxd2
         kSA7PerID0u5eyt/pPtRPYXbO1A2+boxQ3rXJmyRwP6qpw3ONH/kE2fF75lZBmP2frJm
         LuBp07r5XPqbFRYv8ak6lnNHr/7tcmSRxaJiiSMYhXLnYqqMzURi6s+/9rO3bjZ924uX
         9LEB4sffb0nzqE55BeJRFsc4MXFiJUhOqZFfA39pf+NdXhWWV4ubxy6YXdgkZ4fN11Eg
         WiSG65PTT0pk9XtqEe84dszTfQ9jRUaXta5ijTJTv1RYHFeVjCB5Icirax69jFZK2/mv
         OfDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NSenx1DO0yjoW9T/uFtKqZ0r4srEmOF5tK7bZenMyTk=;
        b=pbra+wrKIeT3OR8CWhE9EEuNgWEmhiHjEDRZSgWPT3p339ZLB7OuDyn/Cm19Qo8E8L
         lk4aYKp1IvEgyTZmgvWBt0bqdDuf+r0hw8TfW9Gal7dnBziZbOBjeH3PYDobZt9NCFSM
         ZWKcvAjkDD8EM97D5wtt/LaAbvRIpFpH8ztrX8uWX7JkDbH51LSV57ppWfk1ibVvsvyf
         Oqsdn27rwkMzS3EcjaFcAT/Wi9u0mI/7jShJytrk0ETSzPGLRTQO+cyA9YLMsTCUxhJi
         H+fI4k5C7wNgsM2RkYrqn26TjjROmKsGj27C+lCavIwX1SS27dhaIR6qU2yjrmI55jLD
         fE0g==
X-Gm-Message-State: AJcUukfmNzqxV5q8g6MQstOjthWsPLdCEOwO54Gad78emOwKCfPL3lRm
        h7Dw+j+0t2Ah8pz0lenSaxkm8dQ3yVhmf9Dyor0ZjMpI
X-Google-Smtp-Source: ALg8bN4z5lva4wQcd9MWQNUgVk+McmxndaSkUmACaINGXQBH9/Q1ex4umi3YClN/WFa5bBx3xvzNOnbf4uqncAhrXwI=
X-Received: by 2002:ac8:1889:: with SMTP id s9mr8755413qtj.268.1547675647603;
 Wed, 16 Jan 2019 13:54:07 -0800 (PST)
MIME-Version: 1.0
References: <CAPhsuW4EiGUo=p=KYsu+kGWVFRoxEjF3Bq_32QvakQjCsAAjFQ@mail.gmail.com>
 <20190116213425.GA16366@krava>
In-Reply-To: <20190116213425.GA16366@krava>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 16 Jan 2019 13:53:55 -0800
Message-ID: <CAPhsuW6g9FOXvWA=9_Ab7Qo2B=DHraTPCT_ekmywF8soZz90=A@mail.gmail.com>
Subject: Re: perf segfault in in ordered_events__free()
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>, acme@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Jiri!

On Wed, Jan 16, 2019 at 1:34 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Wed, Jan 16, 2019 at 10:57:49AM -0800, Song Liu wrote:
> > Hi,
> >
> > We are debugging a segfault of perf in ordered_events__free().
>
> hi,
> any backtrace or info on how to reproduce it?

Here is the backtrace:

#0  0x0000000000500055 in ordered_events(float, long double,...)(...) ()
#1  0x0000000000500196 in ordered_events.reinit ()
#2  0x00000000004fe413 in perf_session.process_events ()
#3  0x0000000000440431 in cmd_record ()
#4  0x00000000004a439f in run_builtin ()
#5  0x000000000042b3e5 in main ()"

>
> > Disassemble shows the segfault was caused by oe->buff == NULL
> > in the following line:
> >
> >         /*
> >          * Current buffer might not have all the events allocated
> >          * yet, we need to free only allocated ones ...
> >          */
> >         list_del(&oe->buffer->list);
> >
> > After poking around the code, I suspect it is caused by the following
> > condition in alloc_event():
> >
> >         } else if (oe->buffer) {
> >                 new = &oe->buffer->event[oe->buffer_idx];
> >                 if (++oe->buffer_idx == MAX_SAMPLE_BUFFER)
> >                         oe->buffer = NULL;
>
>
> argh.. yea, we need to check oe->buffer in ordered_events__free
>
> would attached change fix it for you?

Let me try roll a fixed version to confirm.

Thanks again!
Song

>
> thanks,
> jirka
>
>
> ---
> diff --git a/tools/perf/util/ordered-events.c b/tools/perf/util/ordered-events.c
> index 897589507d97..ea523d3b248f 100644
> --- a/tools/perf/util/ordered-events.c
> +++ b/tools/perf/util/ordered-events.c
> @@ -391,8 +391,10 @@ void ordered_events__free(struct ordered_events *oe)
>          * Current buffer might not have all the events allocated
>          * yet, we need to free only allocated ones ...
>          */
> -       list_del(&oe->buffer->list);
> -       ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
> +       if (oe->buffer) {
> +               list_del(&oe->buffer->list);
> +               ordered_events_buffer__free(oe->buffer, oe->buffer_idx, oe);
> +       }
>
>         /* ... and continue with the rest */
>         list_for_each_entry_safe(buffer, tmp, &oe->to_free, list) {
