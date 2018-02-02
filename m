Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752819AbeBBVEj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 16:04:39 -0500
Received: from mail-io0-f193.google.com ([209.85.223.193]:44664 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751878AbeBBVEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 16:04:35 -0500
X-Google-Smtp-Source: AH8x227G3YO0FRC0w0fERv75gWasvfpvTU8ddDYiycY0pNkpiYnBroIODOy6CLOHMznuGRssg2wiL5asnSp/8WyXQBI=
MIME-Version: 1.0
In-Reply-To: <20180202204004.GB8297@kernel.org>
References: <20180201083812.11359-1-jolsa@kernel.org> <20180201083812.11359-2-jolsa@kernel.org>
 <CABPqkBSkbq9NnufY1k2de-Fa-Qb0vhN_MGu6mhqNOV-p3CaVLQ@mail.gmail.com>
 <20180202202849.GA8297@kernel.org> <20180202204004.GB8297@kernel.org>
From: Stephane Eranian <eranian@google.com>
Date: Fri, 2 Feb 2018 13:04:34 -0800
Message-ID: <CABPqkBQniVqi_7OuEmWQohWSsnp17BkDMRYgOE1RQYE00GpuVw@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf tools: Fix period/freq terms setup
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 12:40 PM, Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
> Em Fri, Feb 02, 2018 at 05:28:49PM -0300, Arnaldo Carvalho de Melo escreveu:
>> Em Fri, Feb 02, 2018 at 10:45:46AM -0800, Stephane Eranian escreveu:
>> > Otherwise, I tested what you have written so far and it works.
>
>> So I take that as a Tested-by: Stephane and will apply the patches, Jiri
>> can continue working on these other aspects, right?
>
> I also added this for the casual reader to get up to speed more quickly,
> please check that it makes sense.
>
>     Committer note:
>
>     When we use -c or a period=N term in the event definition, then we don't
>     need to ask the kernel, via perf_event_attr.sample_type |=
>     PERF_SAMPLE_PERIOD, to put the event period in each sample, as we know
>     it already, it is in perf_event_attr.sample_period.
>
Not quite. It depends on how each event is setup. I can mix & match period
and frequency. The PERF_SAMPLE_PERIOD can be dropped only if all the
events use a fixed period either via period=N or -c.

I hope that perf report can deal with config mixing period and fixed
mode correctly.
