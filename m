Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753366AbeBERuv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 12:50:51 -0500
Received: from outbound-smtp12.blacknight.com ([46.22.139.17]:44665 "EHLO
        outbound-smtp12.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752722AbeBERuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 12:50:44 -0500
Date: Mon, 5 Feb 2018 17:50:42 +0000
From: Mel Gorman <mgorman@techsingularity.net>
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180205175042.w4unfg3b2fppo4vq@techsingularity.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <20180201091104.GW2269@hirez.programming.kicks-ass.net>
 <1517491092.18051.52.camel@linux.intel.com>
 <2447536.u3g27UoP4q@aspire.rjw.lan>
 <1517583264.18051.60.camel@linux.intel.com>
 <20180202194801.mhvuwzbz6pauf63f@techsingularity.net>
 <1517601697.83171.361.camel@linux.intel.com>
 <20180205111018.pwm7nlt6rgulyfbt@techsingularity.net>
 <1517850265.2754.1.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <1517850265.2754.1.camel@linux.intel.com>
User-Agent: NeoMutt/20170912 (1.9.0)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 05, 2018 at 09:04:25AM -0800, Srinivas Pandruvada wrote:
> > I know EPP is a range, default from bios usually appear to be 6 or 7
> > but
> > I didn't do much experiementation to see if there is another value
> > that
> > works better. Even if there is, the default may need to change as not
> > many
> > people even know what EPP is or how it should be tuned.
> I think you are talking about EPB not EPP because of ranges you
> mentioned here. EPP is a value from 0 to 255. EPP is part of
> HWP_REQUEST MSR.
> EPB with HWP is used only in Broadwell server. I think you are using
> Skylake here.
> 

You're right in that I mixed up EPB (0-15 IIRC) and EPP which has a
different range whose exact meaning and semantics are not super-clear to
me. The machine in question is Skylake but for the purposes of the current
discussion, the issue is the same. There appears to be a lack of giving
decent hints to the hardware based on knowledge of migrations or short
periods of idleness that the processor may be very busy for very short
bursts that are important even if overall utilisation is low.

-- 
Mel Gorman
SUSE Labs
