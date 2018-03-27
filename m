Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751980AbeC0L1W (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 07:27:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:11487 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbeC0L1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 07:27:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,367,1517904000";
   d="scan'208";a="211660688"
Date: Tue, 27 Mar 2018 04:27:02 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Kim Phillips <kim.phillips@arm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH] perf tools: Add a dso_size option to perf report --sort
Message-ID: <20180327112702.GQ13724@tassilo.jf.intel.com>
References: <20180327060956.1c01ebe67a2a941bb4468c6f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180327060956.1c01ebe67a2a941bb4468c6f@arm.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 06:09:56AM -0500, Kim Phillips wrote:
> Add DSO size to perf report/top sort output list.
> 
> This includes adding a map__size fn to map.h, which is
> approximately equal to the DSO data file_size:

What's the point of knowing the size?  

Most of the DSO may not be faulted in. If anything the working
set would be more interesting. This would need more changes
though.

-Andi
