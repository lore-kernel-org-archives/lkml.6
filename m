Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74217C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A76E2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 15:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nhom19JB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A76E2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731856AbeGSQAz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 12:00:55 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:32943 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730053AbeGSQAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 12:00:55 -0400
Received: by mail-wr1-f65.google.com with SMTP id g6-v6so8471558wrp.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jul 2018 08:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FAWcGE+cm8MlJtzO/unBmWmSa7BHhnLc9eU3mRhdmaI=;
        b=Nhom19JB7uEyDCNSSM7HSlSJ44iHP2jatzM4ixR25H3wCGmZ8z7eYUARqpj0sdHZvI
         fvGYTdH6EKfwc6i3UgHsEmGYMpRDD050Cq9nuyYxkSId41df8JquUrxXnrtR39Tbwlgn
         mFOXtK+mKYlxR8FZjMM0LETlJAzydlf3GXr+gR7Iufi2VncHzTiQr2nSqW701qrkZQrg
         aBgAMi4Ep0Zqtp35+B6rwebhXlx6vfRAlN1GD8tjEHHJALCqHvskEBNwu/9jpBkqgMJU
         3yjyrcdi1tv4AhBELuchZ+wu03WeuD43l4Oki5qTtV0Cfk8pW5Eg39MKI1PV6bP9oFgf
         H9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FAWcGE+cm8MlJtzO/unBmWmSa7BHhnLc9eU3mRhdmaI=;
        b=o4Adl9HBZrQr8xEebcMDMrazqtZgJAXdVtIdBykSppuWm+iUcP8oHaeV35W7aFX5Pm
         wesDZNbiCSoz7URyHyvo7V3sBrYOQf0zbfQWE1KEHPDQF+iHt9Xpe2sbBborZNawU/hn
         QI9afZauQ71e5/a4ssH6Y6t4Elu1O2o76W17aMH7tGrBCS3U5pxQiQpDiMZzUM+KA6Fa
         ltmdcJKk5TItYGWnaCptD5WkU15u6WyuZ8rxzku+/HArl6rtpoNkpznbW4oyDaFrLQNx
         FteIybAk8J/I8JyGVhSWVuF1UdpA3xwro3cWNS4gavuFpwZ8nWO0leAj75rQtaYXYo2k
         HeqQ==
X-Gm-Message-State: AOUpUlGeYGJVfuTLU4ohAih2A1d31x36ispRN7kP9HG5sdCN917nBKbY
        gXTNKBX19obUBslQkDqBcuk28wHB+KiJDjfuqPJBlA==
X-Google-Smtp-Source: AAOMgpdSco4FZF2ZLILFQqHlkx7mK4uznodurOcEqDKn/qDihJBCvjc9au8yT5XZsm65lAGVfdlX24UCmV16XZR4teQ=
X-Received: by 2002:adf:c612:: with SMTP id n18-v6mr7626672wrg.177.1532013435424;
 Thu, 19 Jul 2018 08:17:15 -0700 (PDT)
MIME-Version: 1.0
References: <20180712135202.14774-1-jolsa@kernel.org> <CABPqkBQsecn6Tp3q5fG1KgqF49Js0cA7KPY=dRkWV37jsqDXmg@mail.gmail.com>
 <20180712164941.GA8420@krava> <CABPqkBRObtG6ODH4N9psNKsknGYAJxgEKXGU3h84qyUvOB5iWw@mail.gmail.com>
 <20180719142854.GB4070@kernel.org>
In-Reply-To: <20180719142854.GB4070@kernel.org>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 19 Jul 2018 08:17:03 -0700
Message-ID: <CABPqkBR7Ot+XS1v5vPNXha=Z98FQ5cKFMg9aqND2Q+ZagnU0_w@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Synthesize GROUP_DESC feature in pipe mode
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,
On Thu, Jul 19, 2018 at 7:29 AM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> Em Thu, Jul 12, 2018 at 11:18:05PM -0700, Stephane Eranian escreveu:
> > Hi Jiri,
> > On Thu, Jul 12, 2018 at 9:49 AM Jiri Olsa <jolsa@redhat.com> wrote:
> > >
> > > On Thu, Jul 12, 2018 at 09:34:45AM -0700, Stephane Eranian wrote:
> > > > Hi Jiri,
> > > > On Thu, Jul 12, 2018 at 6:52 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > > >
> > > > > Stephan reported, that pipe mode does not carry the group
> > > > > information and thus the piped report won't display the
> > > > > grouped output for following command:
> > > > >
> > > > Thanks for fixing this quickly.
> > >
> > > could I have your tested/acked by?
>
> > Acked-by: Stephane Eranian <eranian@google.com>
>
> Applying, Stephane, please consider providing a
>
Sorry about that.

Tested-by: Stephane Eranian <eranian@google.com>

>
> When you actually applied the patch, built and tested, so that we can
> have this reflect better what actually was done.
>
> Acked-by is more like hey, I briefly looked at the patch, looks good.
> I.e. no actual test was performed, which I think wasn't the case here,
> but will keep what you provided (Acked-by) as I'm not sure you actually
> tested.
>
> Thanks,
>
> - Arnaldo
>
> > > > I think we should have more testing on the pipe mode, in general.
> > >
> > > yea, we should
> > >
> > > jirka
> > >
> > > >
> > > > >   # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf report
> > > > >
> > > > > It has no idea about the group setup, so it will display
> > > > > events separately:
> > > > >
> > > > >   # Overhead  Command          Shared Object             ...
> > > > >   # ........  ...............  .......................
> > > > >   #
> > > > >        6.71%  swapper          [kernel.kallsyms]
> > > > >        2.28%  offlineimap      libpython2.7.so.1.0
> > > > >        0.78%  perf             [kernel.kallsyms]
> > > > >   ...
> > > > >
> > > > > Fixing GROUP_DESC feature record to be synthesized in pipe mode,
> > > > > so the report output is grouped if there's group defined in record:
> > > > >
> > > > >   #                 Overhead  Command          Shared    ...
> > > > >   # ........................  ...............  .......
> > > > >   #
> > > > >        7.57%   0.16%   0.30%  swapper          [kernel
> > > > >        1.87%   3.15%   2.46%  offlineimap      libpyth
> > > > >        1.33%   0.00%   0.00%  perf             [kernel
> > > > >   ...
> > > > >
> > > > > Cc: David Carrillo-Cisneros <davidcc@google.com>
> > > > > Reported-by: Stephane Eranian <eranian@google.com>
> > > > > Link: http://lkml.kernel.org/n/tip-ybqyh8ac4g173iy3xt4pxnlo@git.kernel.org
> > > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > > ---
> > > > >  tools/perf/util/header.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > > index 59fcc790c865..af9aaf28f976 100644
> > > > > --- a/tools/perf/util/header.c
> > > > > +++ b/tools/perf/util/header.c
> > > > > @@ -2587,7 +2587,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
> > > > >         FEAT_OPR(NUMA_TOPOLOGY, numa_topology,  true),
> > > > >         FEAT_OPN(BRANCH_STACK,  branch_stack,   false),
> > > > >         FEAT_OPR(PMU_MAPPINGS,  pmu_mappings,   false),
> > > > > -       FEAT_OPN(GROUP_DESC,    group_desc,     false),
> > > > > +       FEAT_OPR(GROUP_DESC,    group_desc,     false),
> > > > >         FEAT_OPN(AUXTRACE,      auxtrace,       false),
> > > > >         FEAT_OPN(STAT,          stat,           false),
> > > > >         FEAT_OPN(CACHE,         cache,          true),
> > > > > --
> > > > > 2.17.1
> > > > >
