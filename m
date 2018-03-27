Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753153AbeC0OFO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:05:14 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56788 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751136AbeC0OFK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:05:10 -0400
Date: Tue, 27 Mar 2018 09:05:07 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Andi Kleen <ak@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Milian Wolff <milian.wolff@kdab.com>
Subject: Re: [PATCH] perf tools: Add a dso_size option to perf report --sort
Message-Id: <20180327090507.622cba7cac16a7e812170067@arm.com>
In-Reply-To: <20180327112702.GQ13724@tassilo.jf.intel.com>
References: <20180327060956.1c01ebe67a2a941bb4468c6f@arm.com>
        <20180327112702.GQ13724@tassilo.jf.intel.com>
Organization: Arm
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018 04:27:02 -0700
Andi Kleen <ak@linux.intel.com> wrote:

> On Tue, Mar 27, 2018 at 06:09:56AM -0500, Kim Phillips wrote:
> > Add DSO size to perf report/top sort output list.
> > 
> > This includes adding a map__size fn to map.h, which is
> > approximately equal to the DSO data file_size:
> 
> What's the point of knowing the size?  

I think it's just an extra convenience over symbol_size (added in
commit 7768f8dada66d6  "perf tools: Allow sorting by symbol size") for
tools developers' aggregation statistics.

> Most of the DSO may not be faulted in. If anything the working
> set would be more interesting. This would need more changes
> though.

Indeed.  Maxim?

Kim
