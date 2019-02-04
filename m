Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2F9C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:44:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8140F20821
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 22:44:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WQchJggI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728143AbfBDWov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:44:51 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37299 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725942AbfBDWou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 17:44:50 -0500
Received: by mail-vs1-f68.google.com with SMTP id n13so1034654vsk.4
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 14:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nm99aDROSsc8k+m+Nop8pHm6K1YhSGPlBQH3jrAOQkE=;
        b=WQchJggI68SAjCb96GjjE+9K6UT31IPh5/64uPYMioUFNi2m0wFaBh4fgg+4wCWOpR
         w7Nah6SvCGnXULJmWuxPJwPck531sq8z3pUOEMmkudG9kBCYXQqzmZUFTa/fHyGptza+
         fHJ4gwJ296HNGORky28FNK690JTSe1vMW5UkFYkyzthtIGWBg2Hq7nu0unmaqsOEzydm
         MlbOktLjHNhqtoMC0UnVSGft+D9Zx5w6uzBs6DcU0Pft8n6KRd3cZlOYXfGey6T9bkFl
         WeTHgBtvY4J9B6i3jG9ptY4VKQizUduSOLECVSIonA4p8BJMZN2TlFTxpXFBh8+Y4MEq
         3eBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nm99aDROSsc8k+m+Nop8pHm6K1YhSGPlBQH3jrAOQkE=;
        b=aZ4IaJ/PMbOE/XEq+Hoct7UXesbmmKR8hO2hiLVvnutbBL6CUVq7HfpcIWyC9PLqfi
         FvL6XUFuuVIjIMFsn1loE9ACLC2FdoEVssLCWOGzcB+K7GcIxTi3m5oZq2Z6OWBMLCxM
         Dk6PGRIQBKlOaF0KIFH/VCZ4ESaGG/Botr0VKs6Bn0uVBmmFR5ON1MWVe1copLaOCXAh
         9gGdi8CX8d2DO+vhm0ylKUIGt9+Jor9q49HBactAGdK0+5hxthlvMpmluepY9qv/x9jI
         XF9I5BptNy4RbdPWKaHkM0O1kmTkDI11BHxCMvLVnIXiZMxlM+MIkMnilmrMlqghw3ez
         TqjA==
X-Gm-Message-State: AHQUAuZNM2Fiv0eL4FhOqEwqQWKOYdO/2AVCEFXbftyeikhxEzWgcOTo
        1Kg20jYVvkGmbH0pd+WkVf6i9Dz9gI0ZNFcnwBlhrh+/
X-Google-Smtp-Source: AHgI3IYsxiuyGaFnIv8Da2gzR7ehGzCpztBmq+j3prTtT9vKKGn6jryGQpChFY3VgpTHJM7iNou5ITaq/Cwq4P1KGZk=
X-Received: by 2002:a67:e983:: with SMTP id b3mr741500vso.231.1549320288622;
 Mon, 04 Feb 2019 14:44:48 -0800 (PST)
MIME-Version: 1.0
References: <20190203153018.9650-1-jolsa@kernel.org> <8d8b3f0d-cea8-2daf-249f-29f485c49a46@linux.intel.com>
 <20190204103643.GA18141@krava> <6bf24b7d-2bd3-8091-cf49-363c91e4e864@linux.intel.com>
 <20190204114144.GC18141@krava> <CABPqkBQpQX67NOysim7s-R84nAYipXJ+DgR=xYPi6zWQWgq4Zg@mail.gmail.com>
 <20190204192721.GI5593@kernel.org> <CABPqkBTcxkKkxBwLfToenAk0ubp-o08xVq=XqpkfzYHTNqgBkQ@mail.gmail.com>
 <20190204202818.GC4794@krava>
In-Reply-To: <20190204202818.GC4794@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Mon, 4 Feb 2019 14:44:37 -0800
Message-ID: <CABPqkBQTpt0dhinJZc+mJ-JNvkU2M9DVx1G65ngWxZxk-eGBVA@mail.gmail.com>
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

While you're looking at the output format, I think it would be good
time to simplify the code handling perf.data file.
Today, perf record can emit in two formats: file mode or pipe mode.
This adds complexity in the code and
is error prone as the file mode path is tested more than the pipe mode
path. We have run into multiple issues with
the pipe mode in recent years. There is no real reason why we need to
maintain two formats. If I recall, the pipe format
was introduced because on pipes you cannot lseek to update the headers
and therefore some of the information present as tables
updated on the fly needed to be generated as pseudo records by the
tool. I believe that the pipe format covers all the needs and could
supersede the file mode format. That would simplify code in perf
record and eliminate the risk of errors when new headers
are introduced.

Related to your effort to make perf record multi-threaded, I was
wondering how this would impact pipe mode.
Could you explain?

Thanks.


On Mon, Feb 4, 2019 at 12:28 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Mon, Feb 04, 2019 at 12:05:38PM -0800, Stephane Eranian wrote:
>
> SNIP
>
> > > > > > >
> > > > > > > [jolsa@krava perf]$ ll result_1/
> > > > > > > total 348
> > > > > > > -rw-------. 1 jolsa jolsa 27624 Feb  4 11:35 data.0
> > > > > > > -rw-------. 1 jolsa jolsa 56672 Feb  4 11:35 data.1
> > > > > > > -rw-------. 1 jolsa jolsa 30824 Feb  4 11:35 data.2
> > > > > > > -rw-------. 1 jolsa jolsa 49136 Feb  4 11:35 data.3
> > > > > > > -rw-------. 1 jolsa jolsa 22712 Feb  4 11:35 data.4
> > > > > > > -rw-------. 1 jolsa jolsa 53392 Feb  4 11:35 data.5
> > > > > > > -rw-------. 1 jolsa jolsa 43352 Feb  4 11:35 data.6
> > > > > > > -rw-------. 1 jolsa jolsa 46688 Feb  4 11:35 data.7
> > > > > > > -rw-------. 1 jolsa jolsa  9068 Feb  4 11:35 header
> > > > > >
> > > > > > Awesome. What do you think about having it like this:
> > > > > >
> > > > > >   $ perf record --output result_1.data ... - writes data to a file
> > > > > >
> > > > > >   $ perf record --dir result_1 ... - or even
> > > > > >   $ perf record --output_dir result_1 ... - writes data into a directory
> > > > > >
> > > > > > IMHO, this interface is simpler for a user.
> > > > >
> > > > > yep, seems more convenient.. I'll add it
> > > > >
> > > > But what happens if you do: perf record -o foo --output_dir foo.d?
> > >
> > > Should fail, i.e. either you use single-file or directory output, I
> > > think.
> > >
> > Agreed
>
> ok, will do that
>
> thanks,
> jirka
