Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753821AbeBPHxL (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Feb 2018 02:53:11 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753806AbeBPHxK (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 16 Feb 2018 02:53:10 -0500
Date: Fri, 16 Feb 2018 08:53:04 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: acme@kernel.org, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf report: Fix a memory corrupton issue when enabling
 --branch-history
Message-ID: <20180216075303.GD14831@krava>
References: <1518511468-32737-1-git-send-email-yao.jin@linux.intel.com>
 <20180213094551.GA26936@krava>
 <2bfe35a5-f671-90dc-4753-75c8b2215f30@linux.intel.com>
 <9b3483ae-a612-9d69-9671-4ddfea2c440e@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b3483ae-a612-9d69-9671-4ddfea2c440e@linux.intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 10:25:31AM +0800, Jin, Yao wrote:

SNIP

> >  From my opinion, the option '--max-stack' in perf report looks not very
> > necessary. While it's just my personal opinion, need to hear from more
> > people. :)
> > 
> > Thanks
> > Jin Yao
> > 
> > > thanks,
> > > jirka
> > > 
> > > 
> > > ---
> > > diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
> > > index b6140950301e..b50b7b70dcca 100644
> > > --- a/tools/perf/util/hist.c
> > > +++ b/tools/perf/util/hist.c
> > > @@ -879,7 +879,7 @@ iter_prepare_cumulative_entry(struct
> > > hist_entry_iter *iter,
> > >        * cumulated only one time to prevent entries more than 100%
> > >        * overhead.
> > >        */
> > > -    he_cache = malloc(sizeof(*he_cache) * (iter->max_stack + 1));
> > > +    he_cache = malloc(sizeof(*he_cache) * (callchain_cursor.nr + 1));
> > >       if (he_cache == NULL)
> > >           return -ENOMEM;
> > > 
> 
> Hi Jiri,
> 
> I guess you will post this patch, right?

yep, later today

jirka
