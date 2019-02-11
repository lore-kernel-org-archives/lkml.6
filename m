Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB2DC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8F2186A
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 19:30:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MkSN3Yip"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388216AbfBKTaV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:30:21 -0500
Received: from mail-ua1-f66.google.com ([209.85.222.66]:34317 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbfBKTaU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 14:30:20 -0500
Received: by mail-ua1-f66.google.com with SMTP id x15so32013uaq.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 11:30:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XxJxqy0JVpfH4MMaRLx8EkJwpOL/lVshLgZXsB8rvVQ=;
        b=MkSN3Yip13MwZeTXwcPcT7re/hNwbn6Q453vFdNi/YC+/m9O+VQ/GRMqf+7rZt5UkL
         HJaCvV3478Ygw50nHVfkTdOajVmdBfDxQn20UetDMpQ2dBhcpkl6soxIqWL47su5sAQM
         D6Fo5iPu+K24rxLsTodm8ELzodQ2oCsCJOnBsGlb4xMt4M+jk6U/VmUa87RZ1o1XKg58
         vZcLAwUV8DwXP8XUGf5XHFmeQiJSzWxpgG6q6QxSpv1TJEzLIPIT7KMLiP1jZ+a6axR1
         FTOLUQXv7ZibW0JbIUQXBZLdwJ3ACNrNCUji7qDMWXgG8WWYfgSx/1tlNQIp/3pB3TPh
         tpbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XxJxqy0JVpfH4MMaRLx8EkJwpOL/lVshLgZXsB8rvVQ=;
        b=Dz+JjINUc/ufLS4WyAW6KXa9Th3yf3KYa5+gIqESAfNL5U3D9CzWd3BGtpNDdeQArn
         +1njr4ZGt0bQ826Gtpk0urSiJc1MX5X2CIXDM77VUPCk5fiHf1Zrr0VH1ytFN4o7pK/M
         U4SyKMNzzjT+6kuqli56kZsgyFbzQXEDjewK8HmH4R4OJf2WTfbzrBd/mO6IkJKnQiQ8
         uZ2N5/wI3ASxgyE0ixo+IjdQcJzbb5gqjh2coY8ywj/+sgVlH+VMaePx64Ps89KsBhwi
         fnbhGhwhM82pIQrmopdmpDRNrKEz90wfqLD03uOCKeVtRgf6rtvzjHcRRHgnd7UwQ7Uz
         eegg==
X-Gm-Message-State: AHQUAuaRiTlmp3CaORJ6FP0Wf963xwQj541d8FXh+dXJ+aM3szqgrH5S
        vunfRS/zBWpX8kAmII3iHiA3PqwzBNC08+Hobk+9Wg==
X-Google-Smtp-Source: AHgI3IYwqnsnm6YiHaI6YzcXCGowgb6ZK5KOjGt+XTBdoFzmLZ1i9GmWZMigXVBkh4sJfIPZrsLaLJ5vMFCHh2S/bMU=
X-Received: by 2002:ab0:5590:: with SMTP id v16mr14827577uaa.132.1549913419017;
 Mon, 11 Feb 2019 11:30:19 -0800 (PST)
MIME-Version: 1.0
References: <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava> <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org> <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava> <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava> <20190211101957.GB14253@krava>
 <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com> <20190211185510.GF3269@kernel.org>
In-Reply-To: <20190211185510.GF3269@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 11 Feb 2019 11:30:07 -0800
Message-ID: <CABPqkBTOM2gLvv89ywkpWDKniS2L37XhKPjNLtR8WCY3VuYXzw@mail.gmail.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in directory
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Song Liu <songliubraving@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,

On Mon, Feb 11, 2019 at 10:55 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Mon, Feb 11, 2019 at 10:34:16AM -0800, Stephane Eranian escreveu:
> > Jiri,
> >
> > On Mon, Feb 11, 2019 at 2:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Tue, Feb 05, 2019 at 02:37:27PM +0100, Jiri Olsa wrote:
> > > > On Mon, Feb 04, 2019 at 02:44:37PM -0800, Stephane Eranian wrote:
> > > > > Jiri,
> > > > >
> > > > > While you're looking at the output format, I think it would be good
> > > > > time to simplify the code handling perf.data file.
> > > > > Today, perf record can emit in two formats: file mode or pipe mode.
> > > > > This adds complexity in the code and
> > > > > is error prone as the file mode path is tested more than the pipe mode
> > > > > path. We have run into multiple issues with
> > > > > the pipe mode in recent years. There is no real reason why we need to
> > > > > maintain two formats. If I recall, the pipe format
> > > > > was introduced because on pipes you cannot lseek to update the headers
> > > > > and therefore some of the information present as tables
> > > > > updated on the fly needed to be generated as pseudo records by the
> > > > > tool. I believe that the pipe format covers all the needs and could
> > > > > supersede the file mode format. That would simplify code in perf
> > > > > record and eliminate the risk of errors when new headers
> > > > > are introduced.
> > > >
> > > > yep, I think we have almost all the features covered for pipe mode,
> > > > and we have all necessary events to describe events features
> > > >
> > > > so with some effort we could switch off the superfluos file header
> > > > and use only events to describe events ;-) make sense, I'll check
> > > > on it
> > >
> > > so following features are not synthesized:
> > >
> > >         FEAT_OPN(TRACING_DATA,  tracing_data,   false),
> > >         FEAT_OPN(BUILD_ID,      build_id,       false),
> > >         FEAT_OPN(BRANCH_STACK,  branch_stack,   false),
> > >         FEAT_OPN(AUXTRACE,      auxtrace,       false),
> > >         FEAT_OPN(STAT,          stat,           false),
> > >         FEAT_OPN(CACHE,         cache,          true),
> > >
> > What do you need for BRANCH_STACK?
> >
> > > I think all could be added and worked around with exception
> > > of BUILD_ID, which we store at the end (after processing
> > > all data) and we need it early in the report phase
> > >
> > Buildids are injected after the fact via perf inject when in pipe mode.
> >
> > > maybe it's time to re-think that buildid -> mmap event
> > > association again, because it's pain in current implementation
> > > as well
> > >
> > Sure, but what do you propose?
>
> this keeps resurfacing, the idea is to have the building go together
> with the PERF_RECORD_MMAP3 event, i.e. as part of setting up an
> executable mapping the loader would get the buildid and ask the kernel
> to keep it aroung, then when a PERF_RECORD_MMAP needs to be issued, it
> can include the build id, so tooling will not need to get it.
>
And how would the dynamic loader (ld.so) communicate the buildid to the kernel?
How would that work for statically linked binaries.
I think you're say the kernel would parse the ELF header looking for
that note section
and extract the buildid from there. Is that what you are proposing?

> Alternatively, we would have a separate thread to process
> PERF_RECORD_MMAP events, and as soon as it gets one from the kernel,
> augment it straight away with the build-id it reads from the ELF file,
> i.e. no need to have the kernel provide it, do it just like we do with
> PERF_RECORD_BPF_EVENT, which reminds me Song probably already posted
> thise bits...
>
But that would not work in pipe mode, wouldn't it?
Unless that thread intercepts everything pushed to the pipe looking
for MMAP records.

> > > looks like bpf code is actualy getting build ids and storing
> > > it for the callchains in kernel.. we can check if we can do
> > > something similar for mmap events
> > >
> > > jirka
>
> --
>
> - Arnaldo
