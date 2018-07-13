Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB00ECDFB1
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:18:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AE020843
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 06:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KK53kii+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6AE020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729485AbeGMGbY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 02:31:24 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:52450 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726655AbeGMGbY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 02:31:24 -0400
Received: by mail-wm0-f66.google.com with SMTP id o11-v6so1723550wmh.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jul 2018 23:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/CS0Fkk/noTpzGPwzbGyBpdxWu8D/VK+euQ9/V0rAKs=;
        b=KK53kii+QzV/yf3/xsMcpc26i+CYUSrQ2lwoRQQK3Zan72A8eKk6uatVfOeOCGDTJt
         jig9qt/A6Rh8e/LTsZNLE0rZwlrT1K7naGEHDAPbJL7IpzpJ0t84jHJhXKsEN5e/2H3j
         Iwv2kxz7+X/XoXlqPULrvciyCWimC5vLwzxsgmlvN4vgHI2DBsnxvKualtaJlrgNtLq0
         IdT0E+mRFvOSbKWqH6oRgjSd24u3n6Gx5rGb6FJgSJze4E+l+/FEtwRMR7gpqERcHyq+
         5LfqecEiWGH2boRkZT4JJqw3fgMCi7I1XH0tOWgcb/aGjtHjbOG0fmM5IJdvtxjJn5tx
         LnTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/CS0Fkk/noTpzGPwzbGyBpdxWu8D/VK+euQ9/V0rAKs=;
        b=IdJzBGi6a4NN+/uwQp/aLy/2mfWep1TxcXj8hVes3r2/Zj1UQAbKqKuvjy2cI7ZHZK
         e47Y2PS1afdz8N6aA4lPwYswkp8WxHqwFQWbh8y9BsuDLSpCUdGOl7SFZb4Wt0ZIysEg
         fjej5HY/lT+I18FuiF/CyttcD0LMLP99np2rVlULdPLOPorl+9uCd1vcBtbpvpEwc0Ga
         F7kZ31aHsjFkgUkureHmky0mkfcc4kqOVOei3CKyod2ywBGW5BZypZXcbL5KBsQpmx9s
         yJXf4f7aA6i3/9GC8UZsftT28N1nUo/stdEEZLiO4aVLgk2kTefb8n8JqgZEpsCcRI0N
         oF3Q==
X-Gm-Message-State: AOUpUlE8EsaGKIxmCDmGsZecNdPitnyfrJdNhCwPiYdAHXjSpQX1H5Ju
        kjitZZRK6HgHrKWweKrYKcVANPQRw0jspsd5Ss0YUg==
X-Google-Smtp-Source: AAOMgpcdSPEBcCmh/UpUzoacDlxx1gIaDnWeOICdIh/H1/nOseLyvvWhUr3JkyBinOqSIKWvCD8hG/NdcXAd14LyreI=
X-Received: by 2002:a1c:6c14:: with SMTP id h20-v6mr3199195wmc.138.1531462696498;
 Thu, 12 Jul 2018 23:18:16 -0700 (PDT)
MIME-Version: 1.0
References: <20180712135202.14774-1-jolsa@kernel.org> <CABPqkBQsecn6Tp3q5fG1KgqF49Js0cA7KPY=dRkWV37jsqDXmg@mail.gmail.com>
 <20180712164941.GA8420@krava>
In-Reply-To: <20180712164941.GA8420@krava>
From:   Stephane Eranian <eranian@google.com>
Date:   Thu, 12 Jul 2018 23:18:05 -0700
Message-ID: <CABPqkBRObtG6ODH4N9psNKsknGYAJxgEKXGU3h84qyUvOB5iWw@mail.gmail.com>
Subject: Re: [PATCH] perf tools: Synthesize GROUP_DESC feature in pipe mode
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
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

Hi Jiri,
On Thu, Jul 12, 2018 at 9:49 AM Jiri Olsa <jolsa@redhat.com> wrote:
>
> On Thu, Jul 12, 2018 at 09:34:45AM -0700, Stephane Eranian wrote:
> > Hi Jiri,
> > On Thu, Jul 12, 2018 at 6:52 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Stephan reported, that pipe mode does not carry the group
> > > information and thus the piped report won't display the
> > > grouped output for following command:
> > >
> > Thanks for fixing this quickly.
>
> could I have your tested/acked by?
>
Acked-by: Stephane Eranian <eranian@google.com>

> > I think we should have more testing on the pipe mode, in general.
>
> yea, we should
>
> jirka
>
> >
> > >   # perf record -e '{cycles,instructions,branches}' -a sleep 4 | perf report
> > >
> > > It has no idea about the group setup, so it will display
> > > events separately:
> > >
> > >   # Overhead  Command          Shared Object             ...
> > >   # ........  ...............  .......................
> > >   #
> > >        6.71%  swapper          [kernel.kallsyms]
> > >        2.28%  offlineimap      libpython2.7.so.1.0
> > >        0.78%  perf             [kernel.kallsyms]
> > >   ...
> > >
> > > Fixing GROUP_DESC feature record to be synthesized in pipe mode,
> > > so the report output is grouped if there's group defined in record:
> > >
> > >   #                 Overhead  Command          Shared    ...
> > >   # ........................  ...............  .......
> > >   #
> > >        7.57%   0.16%   0.30%  swapper          [kernel
> > >        1.87%   3.15%   2.46%  offlineimap      libpyth
> > >        1.33%   0.00%   0.00%  perf             [kernel
> > >   ...
> > >
> > > Cc: David Carrillo-Cisneros <davidcc@google.com>
> > > Reported-by: Stephane Eranian <eranian@google.com>
> > > Link: http://lkml.kernel.org/n/tip-ybqyh8ac4g173iy3xt4pxnlo@git.kernel.org
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  tools/perf/util/header.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
> > > index 59fcc790c865..af9aaf28f976 100644
> > > --- a/tools/perf/util/header.c
> > > +++ b/tools/perf/util/header.c
> > > @@ -2587,7 +2587,7 @@ static const struct feature_ops feat_ops[HEADER_LAST_FEATURE] = {
> > >         FEAT_OPR(NUMA_TOPOLOGY, numa_topology,  true),
> > >         FEAT_OPN(BRANCH_STACK,  branch_stack,   false),
> > >         FEAT_OPR(PMU_MAPPINGS,  pmu_mappings,   false),
> > > -       FEAT_OPN(GROUP_DESC,    group_desc,     false),
> > > +       FEAT_OPR(GROUP_DESC,    group_desc,     false),
> > >         FEAT_OPN(AUXTRACE,      auxtrace,       false),
> > >         FEAT_OPN(STAT,          stat,           false),
> > >         FEAT_OPN(CACHE,         cache,          true),
> > > --
> > > 2.17.1
> > >
