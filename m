Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753962AbeCFRA2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 12:00:28 -0500
Received: from mga14.intel.com ([192.55.52.115]:15616 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752055AbeCFRA1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 12:00:27 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,432,1515484800";
   d="scan'208";a="35940661"
Date: Tue, 6 Mar 2018 09:00:11 -0800
From: Andi Kleen <ak@linux.intel.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ilya Pronin <ipronin@twitter.com>
Subject: Re: [PATCH] perf stat: fix cvs output format
Message-ID: <20180306170011.GD25017@tassilo.jf.intel.com>
References: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306064353.31930-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 10:43:53PM -0800, Cong Wang wrote:
> From: Ilya Pronin <ipronin@twitter.com>
> 
> When printing stats in CSV mode, perf stat appends extra CSV
> separators when counter is not supported:
> 
> <not supported>,,L1-dcache-store-misses,mesos/bd442f34-2b4a-47df-b966-9b281f9f56fc,0,100.00,,,,
> 
> which causes a failure of parsing fields. The numbers of separators

Causes failure in what?

> is fixed for each line, no matter supported or not supported.

I don't think they're extra fields, there are cases where they can be filled out
for variance, metricvalue, unit. And other code in perf too uses empty
fields when something is not available.

        - optional usec time stamp in fractions of second (with -I xxx)
        - optional CPU, core, or socket identifier
        - optional number of logical CPUs aggregated
        - counter value
        - unit of the counter value or empty
        - event name
        - run time of counter
        - percentage of measurement time the counter was running
        - optional variance if multiple values are collected with -r  
        - optional metric value
        - optional unit of metric


-Andi
