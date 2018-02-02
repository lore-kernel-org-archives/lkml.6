Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752256AbeBBOIe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 09:08:34 -0500
Received: from merlin.infradead.org ([205.233.59.134]:34434 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751544AbeBBOI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 09:08:29 -0500
Date: Fri, 2 Feb 2018 15:08:17 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Mel Gorman <mgorman@techsingularity.net>,
        Mike Galbraith <efault@gmx.de>,
        Matt Fleming <matt@codeblueprint.co.uk>,
        LKML <linux-kernel@vger.kernel.org>,
        srinivas.pandruvada@linux.intel.com
Subject: Re: [PATCH 4/4] sched/fair: Use a recently used CPU as an idle
 candidate and the basis for SIS
Message-ID: <20180202140817.GP2295@hirez.programming.kicks-ass.net>
References: <20180130104555.4125-1-mgorman@techsingularity.net>
 <3838689.GpfBVtfPr0@aspire.rjw.lan>
 <20180201091104.GW2269@hirez.programming.kicks-ass.net>
 <8930678.7E2iWGoJnn@aspire.rjw.lan>
 <20180202124647.GK2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202124647.GK2269@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 01:46:47PM +0100, Peter Zijlstra wrote:

> +static void __intel_pstate_hwp_set_desired(int val)
> +{
> +	u64 value;
> +
> +	value = rdmsrl(MSR_HWP_REQUEST);
> +	value &= ~GENMASK_ULL(23, 16);
> +	value |= (val & 0xff) << 16;
> +	wrmsrl(MSR_HWP_REQUEST, val);
> +}

Also, if we keep a software shadow of that MSR, we can avoid the
rdmsr, which might also help.
