Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752989AbeDCTTM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 15:19:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:37188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751469AbeDCTTK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 15:19:10 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AEBC20CAA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 3 Apr 2018 16:19:07 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Du, Changbin" <changbin.du@intel.com>
Cc: jolsa@redhat.com, peterz@infradead.org, mingo@redhat.com,
        namhyung@kernel.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH] perf trace: remove redundant ')'
Message-ID: <20180403191907.GE23295@kernel.org>
References: <1520937601-24952-1-git-send-email-changbin.du@intel.com>
 <20180316075108.xwenvklz3a6scodh@intel.com>
 <20180316125045.GC10026@kernel.org>
 <20180328072631.gj72odnaimsohkmc@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180328072631.gj72odnaimsohkmc@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 28, 2018 at 03:26:31PM +0800, Du, Changbin escreveu:
> Hi Arnaldo,
> Just a kind reminder. Hope you didn't forget this.

Ok, applied.

- Arnaldo
 
> On Fri, Mar 16, 2018 at 09:50:45AM -0300, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Mar 16, 2018 at 03:51:09PM +0800, Du, Changbin escreveu:
> > > Hi Arnaldo, How about this simple one? Thanks.
> > > 
> > > On Tue, Mar 13, 2018 at 06:40:01PM +0800, changbin.du@intel.com wrote:
> > > > From: Changbin Du <changbin.du@intel.com>
> > > > 
> > > > There is a redundant ')' at the tail of each event. So remove it.
> > > > $ sudo perf trace --no-syscalls -e 'kmem:*' -a
> > > >    899.342 kmem:kfree:(vfs_writev+0xb9) call_site=ffffffff9c453979 ptr=(nil))
> > > >    899.344 kmem:kfree:(___sys_recvmsg+0x188) call_site=ffffffff9c9b8b88 ptr=(nil))
> > > > 
> > > > Signed-off-by: Changbin Du <changbin.du@intel.com>
> > > > ---
> > > >  tools/perf/builtin-trace.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
> > > > index e7f1b18..7273f5f 100644
> > > > --- a/tools/perf/builtin-trace.c
> > > > +++ b/tools/perf/builtin-trace.c
> > > > @@ -1959,7 +1959,7 @@ static int trace__event_handler(struct trace *trace, struct perf_evsel *evsel,
> > > >  				      trace->output);
> > > >  	}
> > > >  
> > > > -	fprintf(trace->output, ")\n");
> > > > +	fprintf(trace->output, "\n");
> > 
> > It looks simple on the surface, but I couldn't quickly recall why this
> > ')' was put there in the first place... So I left for later to do a 'git
> > blame' on this file, etc.
> > 
> > - Arnaldo
> > 
> > > >  	if (callchain_ret > 0)
> > > >  		trace__fprintf_callchain(trace, sample);
> > > > -- 
> > > > 2.7.4
> > > > 
> > > 
> > > -- 
> > > Thanks,
> > > Changbin Du
> 
> -- 
> Thanks,
> Changbin Du
