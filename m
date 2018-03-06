Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753720AbeCFNy5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 08:54:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34658 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750838AbeCFNy4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 08:54:56 -0500
Date: Tue, 6 Mar 2018 10:54:54 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Jiri Olsa <jolsa@redhat.com>
Cc: Cong Wang <xiyou.wangcong@gmail.com>, linux-kernel@vger.kernel.org,
        Andi Kleen <ak@linux.intel.com>, Ilya Pronin <ipronin@twitter.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
Message-ID: <20180306135454.GD2257@redhat.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
 <20180306075846.GB19895@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306075846.GB19895@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 06, 2018 at 08:58:46AM +0100, Jiri Olsa escreveu:
> On Mon, Mar 05, 2018 at 10:43:53PM -0800, Cong Wang wrote:
> > From: Ilya Pronin <ipronin@twitter.com>
> > 
> > When printing stats in CSV mode, perf stat appends extra CSV
> > separators when counter is not supported:
> > 
> > <not supported>,,L1-dcache-store-misses,mesos/bd442f34-2b4a-47df-b966-9b281f9f56fc,0,100.00,,,,
> > 
> > which causes a failure of parsing fields. The numbers of separators
> > is fixed for each line, no matter supported or not supported.
> > 
> > Fixes: 92a61f6412d3 ("perf stat: Implement CSV metrics output")
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > Cc: Jiri Olsa <jolsa@redhat.com>
> > Signed-off-by: Ilya Pronin <ipronin@twitter.com>
> > Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> > ---
> >  tools/perf/builtin-stat.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
> > index 98bf9d32f222..54a4c152edb3 100644
> > --- a/tools/perf/builtin-stat.c
> > +++ b/tools/perf/builtin-stat.c
> > @@ -917,7 +917,7 @@ static void print_metric_csv(void *ctx,
> >  	char buf[64], *vals, *ends;
> >  
> >  	if (unit == NULL || fmt == NULL) {
> > -		fprintf(out, "%s%s%s%s", csv_sep, csv_sep, csv_sep, csv_sep);
> > +		fprintf(out, "%s%s", csv_sep, csv_sep);
> >  		return;
> >  	}
> 
> right, the non else legs prints just 2 values:
>   fprintf(out, "%s%s%s%s", csv_sep, vals, csv_sep, unit);
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> 

Thanks, applied to perf/urgent.

- Arnaldo
