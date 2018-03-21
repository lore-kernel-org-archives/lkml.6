Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbeCUQEt (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:04:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40674 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751662AbeCUQEs (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:04:48 -0400
Date: Wed, 21 Mar 2018 17:04:46 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: "Jin, Yao" <yao.jin@linux.intel.com>, jolsa@kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        ak@linux.intel.com, kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf util: Display warning when perf report/annotate is
 missing some libs
Message-ID: <20180321160446.GB2707@krava>
References: <1515668586-14327-1-git-send-email-yao.jin@linux.intel.com>
 <20180111153028.GB20406@krava>
 <ef52d9de-54b6-88a6-625d-bd048a098222@linux.intel.com>
 <42a90e87-f2fd-293d-bd25-591fcdff14e1@linux.intel.com>
 <20180321153807.GA2707@krava>
 <20180321154035.GC24312@kernel.org>
 <20180321154315.GD24312@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321154315.GD24312@kernel.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 12:43:15PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Wed, Mar 21, 2018 at 12:40:35PM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Wed, Mar 21, 2018 at 04:38:07PM +0100, Jiri Olsa escreveu:
> > > On Wed, Mar 21, 2018 at 10:11:10AM +0800, Jin, Yao wrote:
> > > > Hi Jiri,
> > > > 
> > > > I'm still thinking it's worth displaying the warning when perf missing some
> > > > libraries.
> > > > 
> > > > Somebody just told me that perf didn't work well. While after some
> > > > investigations, I found it's just missing some libraries when building the
> > > > perf.
> > > > 
> > > > But I have spent some time on getting the root cause. If with this patch, it
> > > > should be very easily to know that.
> > > 
> > > true.. Arnaldo, any feedback on this one?
> > 
> > Lemme re-read the thread...
> 
> Well, how about we make it harder to build without key libraries? I.e.
> if we detect that what we consider a core set of libraries isn't found
> in the system, then we stop the build, warn about it and ask the user to
> confirm that the build should proceed by passing some explicit
> -DI_KNOW_WHAT_I_AM_DOING___PROCEED=doit

hum, not sure we want to complicate the build even more than it
is now :-\ and IMO it still won't help much in Jin's problem,
if user forces the build anyway

jirka
