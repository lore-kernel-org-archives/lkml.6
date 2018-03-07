Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754512AbeCGNgg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:36:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:59596 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754302AbeCGNgf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:36:35 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B823920685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 10:36:30 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Jiri Olsa <jolsa@redhat.com>, Andi Kleen <andi@firstfloor.org>
Cc: Agustin Vega-Frias <agustinv@codeaurora.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>, timur@codeaurora.org
Subject: Re: [RFC V3 0/3] perf stat: improvements for handling of multiple
 PMUs
Message-ID: <20180307133630.GD3701@kernel.org>
References: <1520345084-42646-1-git-send-email-agustinv@codeaurora.org>
 <20180307100408.GA22848@krava>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307100408.GA22848@krava>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 11:04:08AM +0100, Jiri Olsa escreveu:
> On Tue, Mar 06, 2018 at 09:04:41AM -0500, Agustin Vega-Frias wrote:
> > This series of patches adds some simple improvements to the way perf stat
> > handles PMUs that have multiple instances by:
> > 
> > 1. Adding glob-like matching in addition to the prefix-based matching
> >    introduced previously (patch 1).
> > 2. Adding the ability to recover the PMU names when printing the events
> >    separately with the --no-merge option (patch 2).
> > 3. Restoring auto-merge for events created by prefix or glob-like match
> >    (patch 3). Note that this still keeps the behavior that disables
> >    auto-merging of legacy symbolic events (e.g. cycles).
> > 
> > V3:
> > 
> > - Consolidated prefix and glob matching into a single glob match with a
> >   trailing * to maintain prefix matching and have more consistent behavior.
> >   E.g., all of these match all the uncore_imc PMUs: imc, imc*, *imc, *imc*
> 
> Acked-by: Jiri Olsa <jolsa@kernel.org>

Thanks, applied.

I guess Andi had Acked or Reviewed this, no?

- Arnaldo
