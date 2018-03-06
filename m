Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753891AbeCFRaK (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:30:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34940 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752784AbeCFRaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:30:09 -0500
Date: Tue, 6 Mar 2018 14:30:06 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Andi Kleen <ak@linux.intel.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
        Jiri Olsa <jolsa@redhat.com>, Ilya Pronin <ipronin@twitter.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
Message-ID: <20180306173006.GB2213@redhat.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306170011.GD25017@tassilo.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306170011.GD25017@tassilo.jf.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 06, 2018 at 09:00:11AM -0800, Andi Kleen escreveu:
> On Mon, Mar 05, 2018 at 10:43:53PM -0800, Cong Wang wrote:
> > From: Ilya Pronin <ipronin@twitter.com>
> > 
> > When printing stats in CSV mode, perf stat appends extra CSV
> > separators when counter is not supported:
> > 
> > <not supported>,,L1-dcache-store-misses,mesos/bd442f34-2b4a-47df-b966-9b281f9f56fc,0,100.00,,,,
> > 
> > which causes a failure of parsing fields. The numbers of separators
> 
> Causes failure in what?
> 
> > is fixed for each line, no matter supported or not supported.
> 
> I don't think they're extra fields, there are cases where they can be filled out

My understanding was that at some place there is a if/else

	if (supported counters)
		fprintf_something with N fields, all filled in
        else
		fprintf_empty_fields with != N fields

So I think this is not about using things like 'a,b,,,,,,' but about
using different number of commas (fields) for supported/unsupported
counters, no?

- Arnaldo

> for variance, metricvalue, unit. And other code in perf too uses empty
> fields when something is not available.
> 
>         - optional usec time stamp in fractions of second (with -I xxx)
>         - optional CPU, core, or socket identifier
>         - optional number of logical CPUs aggregated
>         - counter value
>         - unit of the counter value or empty
>         - event name
>         - run time of counter
>         - percentage of measurement time the counter was running
>         - optional variance if multiple values are collected with -r  
>         - optional metric value
>         - optional unit of metric
> 
> 
> -Andi
