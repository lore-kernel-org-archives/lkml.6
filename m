Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752015AbeB0XF5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 18:05:57 -0500
Received: from mga02.intel.com ([134.134.136.20]:21305 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751800AbeB0XF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 18:05:56 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,403,1515484800";
   d="scan'208";a="20827546"
Date: Tue, 27 Feb 2018 15:05:39 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Agustin Vega-Frias <agustinv@codeaurora.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        timur@codeaurora.org
Subject: Re: [RFC 1/3] perf, tools: Support wildcards on pmu name in dynamic
 pmu events
Message-ID: <20180227230539.GF21543@tassilo.jf.intel.com>
References: <1519770848-26738-1-git-send-email-agustinv@codeaurora.org>
 <1519770848-26738-2-git-send-email-agustinv@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519770848-26738-2-git-send-email-agustinv@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 05:34:06PM -0500, Agustin Vega-Frias wrote:
> Starting on v4.12 event parsing code for dynamic pmu events already
> supports prefix-based matching of multiple pmus when creating dynamic
> events. E.g., in a system with the following dynamic pmus:
> 
>     mypmu_0
>     mypmu_1
>     mypmu_2
>     mypmu_4
> 
> passing mypmu/<config>/ as an event spec will result in the creation
> of the event in all of the pmus. This change expands this matching
> through the use of fnmatch so glob-like expressions can be used to
> create events in multiple pmus. E.g., in the system described above
> if a user only wants to create the event in mypmu_0 and mypmu_1,
> mypmu_[01]/<config>/ can be passed.

Missing documentation for the globbing.

The rest looked ok to me. 

Reviewed-by: Andi Kleen <ak@linux.intel.com>

-Andi
