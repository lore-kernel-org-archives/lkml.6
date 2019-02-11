Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3B0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:34:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91A61218A4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 18:34:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CE1tTZvh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732616AbfBKSef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 13:34:35 -0500
Received: from mail-ua1-f68.google.com ([209.85.222.68]:42089 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732388AbfBKSe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 13:34:29 -0500
Received: by mail-ua1-f68.google.com with SMTP id d21so3750086uap.9
        for <linux-kernel@vger.kernel.org>; Mon, 11 Feb 2019 10:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8v5rXm2mbK57fE9mGZjp881pWNsrUC5UsBR5Fm6c7Ks=;
        b=CE1tTZvhs5KOt+Wwzp3OUQeK1wDhENGndtldlTcgSt6BWVou+3afyDDvqlPv9cWlvC
         i3TpqYRyxxrPv9k/SaLPXDs4lq2+7JuJR4VRBxKh74VUgInn6dCHNOLmswU5+mLf8Fy3
         g6M9nMJWaec4+qhGzCdQ2NpvpQRPtDBWDTCNFlG8pLjDCNprId9mWT8Z70vVOQO4wBKj
         hvImSDjQM6DY2Jd6Y76Q1OTCcFGLaccVCfdqMqmovQuVkq1YeG0Anhiqy6zZDKY/AcE0
         iEh7vJUwfeGAlIWbXy3xP20QNg4aFJbWT6HkIV5eXUoY6W7VlnlcYd4/MutXpeMpIHdR
         csQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8v5rXm2mbK57fE9mGZjp881pWNsrUC5UsBR5Fm6c7Ks=;
        b=dY93nIJdBdEHb/TPhrmILkAFWr9EP68yuhHdKOUvIHtJRUqoQ5BxMHy7dL6M5vTax+
         FYze9oGdI4VmIXKWisXoWTD+TTduyG46eceaXuWfFHwgoOO4cWRCMBaAbeMsfSYdA4W6
         hafLVrceZXvmMmpdM7JhVIC7d0vfWIR0mQwrMlzteJgHI1RCZfBpeuzcdkwWgyaXCt2C
         QNgieHuGDmdX3erBUlUkhRRkC1OayfY9KofPSHWflsUafOGe8tEqlOHnCRfftk53pEUF
         rrDpG0e0WwEUGWFVVQpPmbLPmM20rvZ92jdVXFcPZw3Dcbv7FSDdvUjYR0lMXSgJbgGd
         IJzw==
X-Gm-Message-State: AHQUAuYFTGwu/g35gk0Jf69C3MMY7dCPtTdXlz1qqwfdnQSZg4I8NqZq
        e/2TYHDuhzZfRfDlKqAQK/lgFNPLWf5MzxbQf4pGSQ==
X-Google-Smtp-Source: AHgI3IamETjtIJq8zejbhs0qEZRHqpouYVxA/qWDVtomaSMN4i9+SxmSp/+69bLutAZHT8c2+DUuWYJmPYD7TRVQMRQ=
X-Received: by 2002:ab0:73c4:: with SMTP id m4mr15318574uaq.101.1549910068070;
 Mon, 11 Feb 2019 10:34:28 -0800 (PST)
MIME-Version: 1.0
References: <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
 <20190204103643.GA18141@krava> <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava> <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org> <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava> <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
 <20190205133727.GF4794@krava> <20190211101957.GB14253@krava>
In-Reply-To: <20190211101957.GB14253@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 11 Feb 2019 10:34:16 -0800
Message-ID: <CABPqkBSkyHRaXN-oVLuJJ=aPEBfqOAunRUReHsxESnC=KKQuPg@mail.gmail.com>
Subject: Re: [RFC/PATCH 00/14] perf record: Add support to store data in directory
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
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

Jiri,

On Mon, Feb 11, 2019 at 2:20 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Tue, Feb 05, 2019 at 02:37:27PM +0100, Jiri Olsa wrote:
> > On Mon, Feb 04, 2019 at 02:44:37PM -0800, Stephane Eranian wrote:
> > > Jiri,
> > >
> > > While you're looking at the output format, I think it would be good
> > > time to simplify the code handling perf.data file.
> > > Today, perf record can emit in two formats: file mode or pipe mode.
> > > This adds complexity in the code and
> > > is error prone as the file mode path is tested more than the pipe mode
> > > path. We have run into multiple issues with
> > > the pipe mode in recent years. There is no real reason why we need to
> > > maintain two formats. If I recall, the pipe format
> > > was introduced because on pipes you cannot lseek to update the headers
> > > and therefore some of the information present as tables
> > > updated on the fly needed to be generated as pseudo records by the
> > > tool. I believe that the pipe format covers all the needs and could
> > > supersede the file mode format. That would simplify code in perf
> > > record and eliminate the risk of errors when new headers
> > > are introduced.
> >
> > yep, I think we have almost all the features covered for pipe mode,
> > and we have all necessary events to describe events features
> >
> > so with some effort we could switch off the superfluos file header
> > and use only events to describe events ;-) make sense, I'll check
> > on it
>
> so following features are not synthesized:
>
>         FEAT_OPN(TRACING_DATA,  tracing_data,   false),
>         FEAT_OPN(BUILD_ID,      build_id,       false),
>         FEAT_OPN(BRANCH_STACK,  branch_stack,   false),
>         FEAT_OPN(AUXTRACE,      auxtrace,       false),
>         FEAT_OPN(STAT,          stat,           false),
>         FEAT_OPN(CACHE,         cache,          true),
>
What do you need for BRANCH_STACK?

> I think all could be added and worked around with exception
> of BUILD_ID, which we store at the end (after processing
> all data) and we need it early in the report phase
>
Buildids are injected after the fact via perf inject when in pipe mode.

> maybe it's time to re-think that buildid -> mmap event
> association again, because it's pain in current implementation
> as well
>
Sure, but what do you propose?

> looks like bpf code is actualy getting build ids and storing
> it for the callchains in kernel.. we can check if we can do
> something similar for mmap events
>
> jirka
