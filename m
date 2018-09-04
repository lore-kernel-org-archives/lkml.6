Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C073C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:50:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E617C20843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jxoFJWgB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E617C20843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727447AbeIDUQD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:16:03 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:44821 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeIDUQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:16:03 -0400
Received: by mail-wr1-f51.google.com with SMTP id v16-v6so4465486wro.11
        for <linux-kernel@vger.kernel.org>; Tue, 04 Sep 2018 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ca72OBszcaAcTZ51it0B5lmImDUrEqCwJXodEBD/g5o=;
        b=jxoFJWgBhROd6LZNBxeedTRAZkPAs6BomeK3x8kWAo5gbnHhm0ambOaXIjwprruCas
         nXQH2MuMwgY6KzjuxVZop2Do9VpBvbpH5ELAGVRnhz0V3cof6WQqHSjnIiVVoC2b4si3
         1uX3EejranzfymssOZNNUvTn5PoYxlTfGWjBohGxpHfIdhDqeHj3ZinSJ7TAVLratur5
         XV47KTZdIm2bZy4F+DRhpfHBaGzqYFWLBufBHIGrL3+SqJ9zn6igJEuAp2REN+RaCVxw
         CvULn+Yuzy4l4XY+Trs87ucgOrZPAbWlFwjR3bmSxYmuUu75okqZMbU0AeUg+u0j9idS
         CsQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ca72OBszcaAcTZ51it0B5lmImDUrEqCwJXodEBD/g5o=;
        b=i+xjHlLnysm9FgnR6MWCYZe8YzhNz0U5sKzFh/i/CzYUf0N/zaicSzXnXWFTsfiwQK
         yA/NqfzCFlEE1+QG437vnM82PnJiSUxZG3/qtIxs1hwBKCSzPDM/49pVuRMuV3I25b9t
         vla1KdzTkEmpXWnfXjb6czRF6zY/96SX+2YcrXo4GFA7TKhG+YbUYL23RQVItSblLn6F
         Z8A7CxJHjOu66qwkncdtke72XuA7kKuUeLuG7brUugeSGihgXn/80kO2Wvf6jIO3BZU9
         v2MoQ8UKxNCcVLuPWpyajBXW7p7TAzAxvT24R7Rt59QZLalSt6Fbehi4JrI7PCt5ifg8
         SP9g==
X-Gm-Message-State: APzg51BCSke0x5pzg/u91abs+qGttGazqLw/P9zk3ELtYxntN7nsndJz
        PCQWC9uBlG9Z3VOvtNw+MIg2YTDpFziAYkAzGr05ug==
X-Google-Smtp-Source: ANB0VdaCrvFJT9ueP17t65pGdlo8WyQja7nULIVQpF3t2ia4K5OnYB/0Et1NxujeQ9yDaM771/1qehrvmPKcbj8wWOI=
X-Received: by 2002:adf:c454:: with SMTP id a20-v6mr22803218wrg.20.1536076219852;
 Tue, 04 Sep 2018 08:50:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABPqkBT0kEMOnTw1-E1kezCvtWNSws7dp2qzCWKVmjGPOEga8Q@mail.gmail.com>
 <20180904071049.GY24124@hirez.programming.kicks-ass.net> <20180904134218.GA5364@kernel.org>
In-Reply-To: <20180904134218.GA5364@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Tue, 4 Sep 2018 08:50:07 -0700
Message-ID: <CABPqkBSm9xgqiPx1hUY2njn3SsPGhxjqK02HbM5Qar8di-q97w@mail.gmail.com>
Subject: Re: [RFC] perf tool improvement requests
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaldo,

On Tue, Sep 4, 2018 at 6:42 AM Arnaldo Carvalho de Melo <acme@kernel.org> w=
rote:
>
> Em Tue, Sep 04, 2018 at 09:10:49AM +0200, Peter Zijlstra escreveu:
> > On Mon, Sep 03, 2018 at 07:45:48PM -0700, Stephane Eranian wrote:
> > > A few weeks ago, you had asked if I had more requests for the perf to=
ol.
>
> > I have one long standing one; that is IP based data structure
> > annotation.
>
> > When we get an exact IP (using PEBS) and were sampling a data related
> > event (say L1 misses), we can get the data type from the instruction
> > itself; that is, through DWARF. We _know_ what type (structure::member)
> > is read/written to.
>
I have been asking this from the compiler people for a long time!
I don't think it is there. I'd like each load/store to be annotated
with a data type + offset
within the type. It would allow data type profiling. This would not be
bulletproof though
because of the accessor function problem:
  void incr(int *v) { (*v)++; }
  struct foo { int a, int b } bar;
  incr(&bar.a);

Here the load/store in incr() would see an int pointer, not an int
inside struct foo at offset 0 which
is what we want. There are concern with the volume of data that this
would generate. But my argument
is that this is just debug binaries, does not make the stripped binary
any bigger.


> > I would love to get that in a pahole style output.
>
Yes, me too!

> > Better yet, when you measure both hits and misses, you can get a
> > structure usage overview, and see what lines are used lots and what
> > members inside that line are rarely used. Ideal information for data
> > structure layout optimization.
>
> > 1000x more useful than that c2c crap.
>

c2c is about something else: more about NUMA issues and false sharing.

> > Can we please get that?
>
> So, use 'c2c record' to get the samples:
>
> [root@jouet ~]# perf c2c record
> ^C[ perf record: Woken up 1 times to write data ]
> [ perf record: Captured and wrote 5.152 MB perf.data (4555 samples) ]
>
> Events collected:
>
> [root@jouet ~]# perf evlist -v
> cpu/mem-loads,ldlat=3D30/P: type: 4, size: 112, config: 0x1cd, { sample_p=
eriod, sample_freq }: 4000, sample_type: IP|TID|TIME|ADDR|ID|CPU|PERIOD|DAT=
A_SRC|WEIGHT|PHYS_ADDR, read_format: ID, disabled: 1, inherit: 1, mmap: 1, =
comm: 1, freq: 1, task: 1, precise_ip: 3, mmap_data: 1, sample_id_all: 1, m=
map2: 1, comm_exec: 1, { bp_addr, config1 }: 0x1f
> cpu/mem-stores/P: type: 4, size: 112, config: 0x82d0, { sample_period, sa=
mple_freq }: 4000, sample_type: IP|TID|TIME|ADDR|ID|CPU|PERIOD|DATA_SRC|WEI=
GHT|PHYS_ADDR, read_format: ID, disabled: 1, inherit: 1, freq: 1, precise_i=
p: 3, sample_id_all: 1
>
>         Then we'll get a 'annotate --hits' option (just cooked up, will
> polish) that will show the name of the function, info about it globally,
> i.e.  what annotate already produced, we may get this in CSV for better
> post processing consumption:
>
> [root@jouet ~]# perf annotate --hits kmem_cache_alloc
> Samples: 20  of event 'cpu/mem-loads,ldlat=3D30/P', 4000 Hz, Event count =
(approx.): 875, [percent: local period]
> kmem_cache_alloc() /usr/lib/debug/lib/modules/4.17.17-100.fc27.x86_64/vml=
inux
>   4.91   15:   mov    gfp_allowed_mask,%ebx
>   2.51   51:   mov    (%r15),%r8
>  17.14   54:   mov    %gs:0x8(%r8),%rdx
>   6.51   61:   cmpq   $0x0,0x10(%r8)
>  17.14   66:   mov    (%r8),%r14
>   6.29   78:   mov    0x20(%r15),%ebx
>   5.71   7c:   mov    (%r15),%rdi
>  29.49   85:   xor    0x138(%r15),%rbx
>   2.86   9d:   lea    (%rdi),%rsi
>   3.43   d7:   pop    %rbx
>   2.29   dc:   pop    %r12
>   1.71   ed:   testb  $0x4,0xb(%rbp)
> [root@jouet ~]#
>
How does this related to what Peter was asking? It has nothing about data t=
ypes.

What I'd like is a true data type profiler showing you the most
accesses data types.
and then an annotate-mode showing you which fields inside the types are mos=
tly
read or written with their sizes and alignment. Goal is to improve
layout based on
accesses to minimize the number of cachelines moved.
You need DLA sampling on all loads and stores and then type annotation.
As I said, I have prototyped this for self-sampling programs but not
in the perf tool.
It is harder there because you need type information and heap information.
I think DWARF is one way to go assuming it is extended to support the right=
 kind
of load/store annotations. Another way is to track allocations and
correlate to data
types.



>         Then I need to get the DW_AT_location stuff parsed in pahole, so
> that with those offsets (second column, ending with :) with hits (first
> column, there its local period, but we can ask for some specific metric
> [1]), I'll be able to figure out what DW_TAG_variable or
> DW_TAG_formal_parameter is living there at that time, get the offset
> from the decoded instruction, say that xor, 0x138 offset from the type
> for %r15 at that offset (85) from kmem_cache_alloc, right?
>
> In a first milestone we'd have something like:
>
>         perf annotate --hits function | pahole --annotate -C task_struct
>
>         perf annotate --hits | pahole --annotate
>
I don't want to combine tools. I'd like this to be built into perf.

> Would show all structs with hits, for all functions with hits.
>
> Other options would show which struct has more hits, etc.
>
> - Arnaldo
>
> [1]
>
> [root@jouet ~]# perf annotate -h local
>
>  Usage: perf annotate [<options>]
>
>         --percent-type <local-period>
>                           Set percent type local/global-period/hits
>
> [root@jouet ~]#
>
> - Arnaldo
