Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA32DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99B9C2082E
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 18:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5Y/e2Lk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729665AbfBDS4T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 13:56:19 -0500
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40535 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfBDS4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 13:56:19 -0500
Received: by mail-vs1-f67.google.com with SMTP id z3so599928vsf.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 10:56:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eB7rLJj0zWDFaY0IrsCoKrezlQtftgSE3U7E+p9MGD8=;
        b=r5Y/e2LkRULJwPfbVBFN1qItunDZE0FRQAguY3G3d01BR1vioKSDbkTxCHPCd5B2hc
         TsxTiA9rVTAr0Zp7Ft4GM1mYoq6TO1t1KM1COIyal04BZCdou3BJg+5w/vDUcis8t9YM
         noLXDfylylvFpaljwxlfG9qlsUpnqynN5Oj7L3FuNy4QrCaXwm6Jl2pt8yLMVmTsOMu5
         CALWPlNtfY3jbCfpL4ohsAMznKTtbEbJow68mDcnYbwYJUBA+lTvEg3+J2wFZvdZq98P
         ZrAEziBQhvGsyRd075+jGWvWxW8+O6qDRnZDwClH1kvmz5EkqhzvtC5UKUcPS6BlJDNQ
         1fvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eB7rLJj0zWDFaY0IrsCoKrezlQtftgSE3U7E+p9MGD8=;
        b=sif6Bpe/r3k5pZzuZQFtQRTzJj/FB7h6r3odpQwYjnjZ/m/0OgxlDrP1LYA5Jcd0h0
         A/r4IWYIs4D9LRgKykaGcuSnW7EdzTgx5nIrAxIp344LWHWxem+CV8TQwU7Ffwj0My6n
         506OHf8oN1llzcw9JwSZUtPrmf5Hk7SdE8u4srKLY1Gn4NrB8jX5Zy4snfyQz+qpolo2
         UxIp1LW7XTDtqt7QZkxAOK6CBEPBZvMINKpqMSz0eLFaJpY6GNiezOBZqDCb9dccPhx/
         XToJJDxjgcoN9K5VcTKYNZz79HPu36vZn6A1c0CNlhcj57owmdIXKEgvDKnU8pRbgmt7
         xehw==
X-Gm-Message-State: AHQUAubEta9xUpGkELB2lte6/p4jvfEhrhsdS88SlLwWwfdpEGXQS0ka
        l+btoKy9vXxlJJrs0AgAXEcJhjUiHTyTBe2pCtq1GA==
X-Google-Smtp-Source: AHgI3IZZQlK6jZh1Vu/o4svnGzEX8VzVmiI8mmJ6wJ+H80zDxvyGXwfR/tnkpIuXLV1UTkLzoVtlNlSmwPNVR3wqphU=
X-Received: by 2002:a67:74d1:: with SMTP id p200mr374906vsc.101.1549306577448;
 Mon, 04 Feb 2019 10:56:17 -0800 (PST)
MIME-Version: 1.0
References: <20190203153018.9650-1-jolsa@kernel.org> <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
 <20190204103643.GA18141@krava> <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava>
In-Reply-To: <20190204114144.GC18141@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 4 Feb 2019 10:56:05 -0800
Message-ID: <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 4, 2019 at 3:41 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Feb 04, 2019 at 02:29:56PM +0300, Alexey Budankov wrote:
> > On 04.02.2019 13:36, Jiri Olsa wrote:
> > > On Mon, Feb 04, 2019 at 01:12:11PM +0300, Alexey Budankov wrote:
> > >>
> > >> Hi,
> > >>
> > >> On 03.02.2019 18:30, Jiri Olsa wrote:
> > >>> hi,
> > >>> this patchset adds the --dir option to record command (and all
> > >>> the other record command that overload cmd_record) that allows
> > >>> the data to be stored in directory with multiple data files.
> > >>>
> > >>> It's next step for multiple threads implementation in record.
> > >>> It's now possible to make directory data via --dir option, like:
> > >>>
> > >>>   $ perf record --dir perf bench sched messaging
> > >>
> > >> Is it possible to name data directory differently from perf.data
> > >> e.g. using --output option, like this?
> > >>
> > >>   $ perf record --output result_1 --dir perf bench sched messaging
> > >
> > >
> > > yep, it's taken into account:
> > >
> > > [jolsa@krava perf]$ ./perf record --output result_1 --dir ./perf bench sched messaging
> > > Couldn't synthesize bpf events.
> > > # Running 'sched/messaging' benchmark:
> > > # 20 sender and receiver processes per group
> > > # 10 groups == 400 processes run
> > >
> > >      Total time: 0.177 [sec]
> > > [ perf record: Woken up 1 times to write data ]
> > > [ perf record: Captured and wrote 0.316 MB result_1 (7225 samples) ]
> > >
> > > [jolsa@krava perf]$ ll result_1/
> > > total 348
> > > -rw-------. 1 jolsa jolsa 27624 Feb  4 11:35 data.0
> > > -rw-------. 1 jolsa jolsa 56672 Feb  4 11:35 data.1
> > > -rw-------. 1 jolsa jolsa 30824 Feb  4 11:35 data.2
> > > -rw-------. 1 jolsa jolsa 49136 Feb  4 11:35 data.3
> > > -rw-------. 1 jolsa jolsa 22712 Feb  4 11:35 data.4
> > > -rw-------. 1 jolsa jolsa 53392 Feb  4 11:35 data.5
> > > -rw-------. 1 jolsa jolsa 43352 Feb  4 11:35 data.6
> > > -rw-------. 1 jolsa jolsa 46688 Feb  4 11:35 data.7
> > > -rw-------. 1 jolsa jolsa  9068 Feb  4 11:35 header
> >
> > Awesome. What do you think about having it like this:
> >
> >   $ perf record --output result_1.data ... - writes data to a file
> >
> >   $ perf record --dir result_1 ... - or even
> >   $ perf record --output_dir result_1 ... - writes data into a directory
> >
> > IMHO, this interface is simpler for a user.
>
> yep, seems more convenient.. I'll add it
>
But what happens if you do: perf record -o foo --output_dir foo.d?

> thanks,
> jirka
