Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751893AbeCEPEO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 10:04:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59758 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751392AbeCEPEM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 10:04:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E2E206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 5 Mar 2018 12:04:09 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        linux-kernel@vger.kernel.org, namhyung@kernel.org, wangnan0@huawei.com,
        ak@linux.intel.com
Subject: Re: [PATCH 02/14] perf trace: Apply new perf_mmap__read_event()
 interface
Message-ID: <20180305150409.GA22849@kernel.org>
References: <1519945751-37786-1-git-send-email-kan.liang@linux.intel.com>
 <1519945751-37786-2-git-send-email-kan.liang@linux.intel.com>
 <20180302233022.GB8970@krava>
 <20180305130339.GE30054@kernel.org>
 <20180305134652.GF30054@kernel.org>
 <44636157-9aaf-4e50-c12a-a2e60e01e415@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44636157-9aaf-4e50-c12a-a2e60e01e415@linux.intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Mar 05, 2018 at 09:50:10AM -0500, Liang, Kan escreveu:
> 
> 
> On 3/5/2018 8:46 AM, Arnaldo Carvalho de Melo wrote:
> > Em Mon, Mar 05, 2018 at 10:03:39AM -0300, Arnaldo Carvalho de Melo escreveu:
> > > I'm doing this, the argument is 'bool', so the value should be false or
> > > true, even '0' being way shorter...

> > While doing that I wonder why is that we can't do it without those
> > explicit start/end variables in all the call sites and passing
> > overwrite, start and end as parameters...

> > Can't we just add 'overwrite, 'start' and 'end' to struct perf_mmap,
> > then have perf_mmap__read_init() with just 'md' and 'overwrite' as
> > parameters, initialize md->{start,end} and set md->overwrite to the
> > 'overwrite' parameter in 'perf_mmap__read_init()' and then use just
> > md as parameters for both perf_mmap__read_event() and
> > perf_mmap__consume()?
 
> I don't see any reason we cannot do this.
> I will do some test. If it works well, I will submit the follow-up patch to
> clean up the interface.

Thanks a lot! The less boilerplate we have in such functions, making
them easier to use for new people contributing to tools/perf/, the
better.

- Arnaldo
