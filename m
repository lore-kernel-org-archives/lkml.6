Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2A8C468C6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 356BD2084C
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 14:29:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="vdZbSPIL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356BD2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731797AbeGSPMZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 11:12:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:33224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731750AbeGSPMY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 11:12:24 -0400
Received: from jouet.infradead.org (unknown [179.97.41.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03DEE2084E;
        Thu, 19 Jul 2018 14:28:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532010538;
        bh=Ey+fGETlEUf0o7vqKR9jts0A0czG5z9MjK09jf3IpDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vdZbSPILQVVZyFGSuksE7RQ0jKk1otkSI0LZRXZ3t+2A5brHdoDd/h47VUgYrR9ba
         hDZauEj2N39/IGLypuRFcjQxjFDqQ65x6bI99L/9IEo+R0BH8i5vQXqoErirgWiOuc
         Q8bJlllPGjKHCCMbd4xX4iKbQ6o4bYyNUWo2izn4=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id E425A14486C; Thu, 19 Jul 2018 11:28:54 -0300 (-03)
Date:   Thu, 19 Jul 2018 11:28:54 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephane Eranian <eranian@google.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH] perf tools: Synthesize GROUP_DESC feature in pipe mode
Message-ID: <20180719142854.GB4070@kernel.org>
References: <20180712135202.14774-1-jolsa@kernel.org>
 <CABPqkBQsecn6Tp3q5fG1KgqF49Js0cA7KPY=dRkWV37jsqDXmg@mail.gmail.com>
 <20180712164941.GA8420@krava>
 <CABPqkBRObtG6ODH4N9psNKsknGYAJxgEKXGU3h84qyUvOB5iWw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPqkBRObtG6ODH4N9psNKsknGYAJxgEKXGU3h84qyUvOB5iWw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, Jul 12, 2018 at 11:18:05PM -0700, Stephane Eranian escreveu:
> Hi Jiri,
> On Thu, Jul 12, 2018 at 9:49 AM Jiri Olsa <jolsa@redhat.com> wrote:
> >
> > On Thu, Jul 12, 2018 at 09:34:45AM -0700, Stephane Eranian wrote:
> > > Hi Jiri,
> > > On Thu, Jul 12, 2018 at 6:52 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > > >
> > > > Stephan reported, that pipe mode does not carry the group
> > > > information and thus the piped report won't display the
> > > > grouped output for following command:
> > > >
> > > Thanks for fixing this quickly.
> >
> > could I have your tested/acked by?

> Acked-by: Stephane Eranian <eranian@google.com>

Applying, Stephane, please consider providing a

  Tested-by: Stephane Eranian <eranian@google.com>

When you actually applied the patch, built and tested, so that we can
have this reflect better what actually was done.

Acked-by is more like hey, I briefly looked at the patch, looks good.
I.e. no actual test was performed, which I think wasn't the case here,
but will keep what you provided (Acked-by) as I'm not sure you actually
tested.

Thanks,

- Arnaldo
 
> > > I think we should have more testing on the pipe mode, in general.
> >
> > yea, we should
> >
> > jirka
> >
> > >
> > > >   # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf report
> > > >
> > > > It has no idea about the group setup, so it will display
> > > > events separately:
> > > >
> > > >   # Overhead  Command          Shared Object             ...
> > > >   # ........  ...............  .......................
> > > >   #
> > > >        6.71%  swapper          [kernel.kallsyms]
> > > >        2.28%  offlineimap      libpython2.7.so.1.0
> > > >        0.78%  perf             [kernel.kallsyms]
> > > >   ...
> > > >
> > > > Fixing GROUP_DESC feature record to be synthesized in pipe mode,
> > > > so the report output is grouped if there's group defined in record:
> > > >
> > > >   #                 Overhead  Command          Shared    ...
> > > >   # ........................  ...............  .......
> > > >   #
> > > >        7.57%   0.16%   0.30%  swapper          [kernel
> > > >        1.87%   3.15%   2.46%  offlineimap      libpyth
> > > >        1.33%   0.00%   0.00%  perf             [kernel
> > > >   ...
> > > >
> > > > Cc: David Carrillo-Cisneros <davidcc@google.com>
> > > > Reported-by: Stephane Eranian <eranian@google.com>
> > > > Link: http://lkml.kernel.org/n/tip-ybqyh8ac4g173iy3xt4pxnlo@git.kernel.org
> > > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > > ---
> > > >  tools/perf/util/header.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > > index 59fcc790c865..af9aaf28f976 100644
> > > > --- a/tools/perf/util/header.c
> > > > +++ b/tools/perf/util/header.c
> > > > @@ -2587,7 +2587,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
> > > >         FEAT_OPR(NUMA_TOPOLOGY, numa_topology,  true),
> > > >         FEAT_OPN(BRANCH_STACK,  branch_stack,   false),
> > > >         FEAT_OPR(PMU_MAPPINGS,  pmu_mappings,   false),
> > > > -       FEAT_OPN(GROUP_DESC,    group_desc,     false),
> > > > +       FEAT_OPR(GROUP_DESC,    group_desc,     false),
> > > >         FEAT_OPN(AUXTRACE,      auxtrace,       false),
> > > >         FEAT_OPN(STAT,          stat,           false),
> > > >         FEAT_OPN(CACHE,         cache,          true),
> > > > --
> > > > 2.17.1
> > > >
