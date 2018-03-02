Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936219AbeCBLjF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 06:39:05 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40934 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S936005AbeCBLis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 06:38:48 -0500
Date: Fri, 2 Mar 2018 12:38:45 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: acme@kernel.org, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RESEND PATCH] perf sched map: re-annotate shortname if thread
 comm changed
Message-ID: <20180302113845.GC16348@krava>
References: <1519386040-25874-1-git-send-email-changbin.du@intel.com>
 <20180302105254.234axj7b3nixakav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180302105254.234axj7b3nixakav@intel.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 02, 2018 at 06:52:54PM +0800, Du, Changbin wrote:
> Hello, any comment?

sry, overlooked this one

SNIP

> > diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
> > index 68b65b1..c660fe6 100644
> > --- a/tools/perf/util/thread.c
> > +++ b/tools/perf/util/thread.c
> > @@ -212,6 +212,7 @@ static int ____thread__set_comm(struct thread *thread, const char *str,
> >  			unwind__flush_access(thread);
> >  	}
> >  
> > +	thread->comm_changed = true;
> >  	thread->comm_set = true;
> >  
> >  	return 0;
> > diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
> > index 40cfa36..b9a328b 100644
> > --- a/tools/perf/util/thread.h
> > +++ b/tools/perf/util/thread.h
> > @@ -27,6 +27,7 @@ struct thread {
> >  	int			cpu;
> >  	refcount_t		refcnt;
> >  	char			shortname[3];
> > +	bool			comm_changed;

I don't like that it's in struct thread and set by generic function,
and just one command (sched) checks/sets it back.. I'd rather see it
in thread::priv area..  on the other hand it's simple enough and looks
like generic solution would be more tricky

Acked-by: Jiri Olsa <jolsa@kernel.org>

jirka
