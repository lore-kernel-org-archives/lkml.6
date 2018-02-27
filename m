Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753467AbeB0Ohq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 09:37:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43206 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753172AbeB0Oho (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 09:37:44 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03E1B21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Tue, 27 Feb 2018 11:37:40 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Jin, Yao" <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, jolsa@kernel.org, peterz@infradead.org,
        mingo@redhat.com, alexander.shishkin@linux.intel.com,
        Linux-kernel@vger.kernel.org, ak@linux.intel.com, kan.liang@intel.com,
        yao.jin@intel.com
Subject: Re: [PATCH] perf stat: Ignore error thread when enabling system-wide
 --per-thread
Message-ID: <20180227143740.GA20235@kernel.org>
References: <1516117388-10120-1-git-send-email-yao.jin@linux.intel.com>
 <20180116125132.GD26643@krava>
 <1189ec53-0d3b-c59c-63f0-4c4ad0d72405@linux.intel.com>
 <20180116131743.GA17752@krava>
 <a1ee430a-34ab-345d-71c5-c03862092aa8@linux.intel.com>
 <20180123141945.GC15155@krava>
 <d8184ad9-8426-595f-76c2-0c5a6826a493@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d8184ad9-8426-595f-76c2-0c5a6826a493@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Feb 27, 2018 at 08:53:13AM +0800, Jin, Yao escreveu:
> 
> 
> On 1/23/2018 10:19 PM, Jiri Olsa wrote:
> > On Mon, Jan 22, 2018 at 01:10:31PM +0800, Jin, Yao wrote:
> > > 
> > > 
> > > On 1/16/2018 9:17 PM, Jiri Olsa wrote:
> > > > On Tue, Jan 16, 2018 at 09:06:09PM +0800, Jin, Yao wrote:
> > > > > Just tested. But looks it's not OK for '--per-thread' case.
> > > > 
> > > > yea, I haven't tested much.. might need soem tweaking,
> > > > but my point was that it could be doable on one place
> > > > instead of introducing another if possible
> > > > 
> > > > jirka
> > > > 
> > > 
> > > Hi Jiri,
> > > 
> > > I ever considered to move the operation of removing error thread to
> > > perf_evsel__fallback(). The perf_evsel__fallback() is common code and it's
> > > shared by perf report, perf stat and perf top.
> > > 
> > > While finally I think it'd better let the caller decide to remove error
> > > thread and try again, or just return the warning message.
> > > perf_evsel__fallback() probably doesn't know what the caller want to do.
> > > 
> > > That's my current thinking. Maybe there will be a better fix...
> > 
> > ok, can't think of better fix atm.. looks good ;-)
> > 
> > Acked-by: Jiri Olsa <jolsa@kernel.org>
> > 
> > thanks,
> > jirka
> > 
> 
> Hi Arnaldo,
> 
> Could this fix be accepted?

yeah, its just strange that that err_thread is not used, applied.

- Arnaldo
