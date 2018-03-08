Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755693AbeCHK71 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 05:59:27 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47146 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751971AbeCHK70 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 05:59:26 -0500
Date: Thu, 8 Mar 2018 11:59:23 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        David Ahern <dsahern@gmail.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH 05/19] perf tools: Add refcnt into struct mem_info
Message-ID: <20180308105923.GA13693@krava>
References: <20180307155020.32613-1-jolsa@kernel.org>
 <20180307155020.32613-6-jolsa@kernel.org>
 <20180307185659.GP3701@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307185659.GP3701@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 07, 2018 at 03:56:59PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 07, 2018 at 04:50:06PM +0100, Jiri Olsa escreveu:
> > It's passed along several hists entries in --hierarchy mode,
> > so it's better we keep track of it.
> 
> I like this, but you called it...
>  
> > +
> > +struct mem_info *mem_info__aloc(void)
> > +{
> > +	struct mem_info *mi = zalloc(sizeof(*mi));
> > +
> > +	if (mi)
> > +		refcount_set(&mi->refcnt, 1);
> > +	return mi;
> 
> "aloc" with just one 'l', so I have to fix the typo, while at it I'll
> use what is used elsewhere for this operation, i.e.
> 
> struct mem_info *mem_info__new(void);

ok, thanks

jirka
