Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753172AbeBZN5V (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 08:57:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:50048 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752471AbeBZN5U (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 08:57:20 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 94B5C206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 26 Feb 2018 10:57:16 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>, jolsa@kernel.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf annotate: Support to display the LBR data in tui
 mode
Message-ID: <20180226135716.GA29523@kernel.org>
References: <1519396558-23397-1-git-send-email-yao.jin@linux.intel.com>
 <20180223082500.GT25181@hirez.programming.kicks-ass.net>
 <20180223152906.GA8805@kernel.org>
 <2a73ede7-a033-c601-3717-287ed5496c45@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a73ede7-a033-c601-3717-287ed5496c45@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Feb 24, 2018 at 09:40:02AM +0800, Jin, Yao escreveu:
> 
> 
> On 2/23/2018 11:29 PM, Arnaldo Carvalho de Melo wrote:
> > Em Fri, Feb 23, 2018 at 09:25:00AM +0100, Peter Zijlstra escreveu:
> > > On Fri, Feb 23, 2018 at 10:35:58PM +0800, Jin Yao wrote:
> > > > Unlike the perf report interactive annotate mode, the perf annotate
> > > > doesn't display the LBR data.
> > 
> > > > perf record -b ...
> > > > perf annotate function
> > 
> > > > It should show IPC/cycle, but it doesn't.
> > 
> > > There is far more than IPC/cycle for the LBR data, so this Changelog is
> > > misleading.
> > 
> > > Also, I think that this patch goes the wrong way, we should reduce the
> > > divergence of the various modes, not make it worse.
> > 
> > Right, Peter, what would you think if I made --stdio use the same
> > routines used to format the TUI, i.e. stdio would be equal to the TUI
> > modulo de navigation/jump arrows, etc.
> > 
> > We would have switches to provide the TUI output options that make sense
> > for non-interactive mode, like:
> > 
> >    J   Toggle showing number of jump sources on targets
> >    o   Toggle disassembler output/simplified view
> >    s   Toggle source code view
> >    t   Circulate percent, total period, samples view
> >    k   Toggle line numbers
> > 
> 
> Hi Arnaldo, looks your idea is very similar as my idea. In my understanding,
> for example, we may provide switch to tui routine like
> annotate_browser__write() and use fprintf() to replace
> ui_browser__printf()/ui_browser_write__xxx() if switch is on for stdio.
> 
> Is that your idea?

Yes, right now the TUI simply uses foo__scnprintf() routines to then
pass formatted buffers to the TUI routines, we would then just pass them
to plain fprintf(sdtout).
 
> For this approach, I think, the benefit is we can reuse most of existing
> code but the disadvantage is we have to mix tui and stdio up.

- Arnaldo
