Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751540AbeBWRC0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 12:02:26 -0500
Received: from mga14.intel.com ([192.55.52.115]:64772 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751351AbeBWRCZ (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 12:02:25 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,383,1515484800";
   d="scan'208";a="32299303"
Date: Fri, 23 Feb 2018 09:02:10 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>, jolsa@kernel.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, Linux-kernel@vger.kernel.org,
        kan.liang@intel.com, yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Support to display the LBR data in tui
 mode
Message-ID: <20180223170210.GC7045@tassilo.jf.intel.com>
References: <1519396558-23397-1-git-send-email-yao.jin@linux.intel.com>
 <20180223082500.GT25181@hirez.programming.kicks-ass.net>
 <20180223152906.GA8805@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223152906.GA8805@kernel.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 12:29:06PM -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 23, 2018 at 09:25:00AM +0100, Peter Zijlstra escreveu:
> > On Fri, Feb 23, 2018 at 10:35:58PM +0800, Jin Yao wrote:
> > > Unlike the perf report interactive annotate mode, the perf annotate
> > > doesn't display the LBR data.
> 
> > > perf record -b ...
> > > perf annotate function
> 
> > > It should show IPC/cycle, but it doesn't.
> 
> > There is far more than IPC/cycle for the LBR data, so this Changelog is
> > misleading.
> 
> > Also, I think that this patch goes the wrong way, we should reduce the
> > divergence of the various modes, not make it worse.
> 
> Right, Peter, what would you think if I made --stdio use the same
> routines used to format the TUI, i.e. stdio would be equal to the TUI
> modulo de navigation/jump arrows, etc.

With the unification Jin Yao's patch would be the right thing anyways
-- it would magically work for stdio mode too. So it seems to me
merging the patch would be the right thing to do.

-Andi
