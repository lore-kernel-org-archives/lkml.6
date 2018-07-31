Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E35C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3921720894
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 19:07:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3921720894
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732187AbeGaUs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 16:48:57 -0400
Received: from mga02.intel.com ([134.134.136.20]:1917 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732006AbeGaUs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 16:48:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 31 Jul 2018 12:07:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,428,1526367600"; 
   d="scan'208";a="61313240"
Received: from spandruv-mobl.amr.corp.intel.com ([10.254.15.88])
  by orsmga008.jf.intel.com with ESMTP; 31 Jul 2018 12:07:08 -0700
Message-ID: <41b51613acbdaf59294f436af057753978908470.camel@linux.intel.com>
Subject: Re: [PATCH 4/4] cpufreq: intel_pstate: enable boost for Skylake Xeon
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eero Tamminen <eero.t.tamminen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Francisco Jerez <currojerez@riseup.net>, lenb@kernel.org,
        rjw@rjwysocki.net, ggherdovich@suse.cz, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, juri.lelli@redhat.com,
        viresh.kumar@linaro.org, Chris Wilson <chris@chris-wilson.co.uk>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Date:   Tue, 31 Jul 2018 12:07:08 -0700
In-Reply-To: <20180731150438.GE2458@hirez.programming.kicks-ass.net>
References: <20180605214242.62156-1-srinivas.pandruvada@linux.intel.com>
         <20180605214242.62156-5-srinivas.pandruvada@linux.intel.com>
         <87bmarhqk4.fsf@riseup.net>
         <20180728123639.7ckv3ljnei3urn6m@techsingularity.net>
         <e7388bf4-deb1-34b6-97d7-89ced8e78ef1@intel.com>
         <605cfcb3f315917c5970f452fab988ae1dc946ff.camel@linux.intel.com>
         <20180731150438.GE2458@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.3 (3.28.3-1.fc28) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-07-31 at 17:04 +0200, Peter Zijlstra wrote:
> On Mon, Jul 30, 2018 at 07:06:21AM -0700, Srinivas Pandruvada wrote:
> > On Mon, 2018-07-30 at 14:16 +0300, Eero Tamminen wrote:
> > > Questions:
> > > 
> > > * Does currently kernel CPU freq management have any idea which
> > > IO
> > >    devices share TDP with the CPU cores?
> > No. The requests we do to hardware is just indication only (HW can
> > ignore it). The HW has a bias register to adjust and distribute
> > power
> > among users.
> > We can have several other active device on servers beside CPU which
> > when runs need extra power. So the HW arbitrates power.
> 
> That's not entirely accurate AFAIK. "No" is accurate for Intel, but
> the
> ARM people have their IPA thing (not a beer):
We also have that for using space programs (E.g. KBL-G).

Thanks,
Srinivas

> 
>   https://developer.arm.com/open-source/intelligent-power-allocation
> 
>   drivers/thermal/power_allocator.c
> 
> which IIUC interacts with their cpufreq driver to disallow certain
> OPP
> states.
> 
> And note that I discourage intel_pstate active mode.
