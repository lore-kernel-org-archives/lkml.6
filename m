Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752927AbeCPR54 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 13:57:56 -0400
Received: from merlin.infradead.org ([205.233.59.134]:55506 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752292AbeCPR5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 13:57:55 -0400
Date: Fri, 16 Mar 2018 18:57:45 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tipbuild@zytor.com,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [tip:perf/core 1/2] drivers//perf/qcom_l2_pmu.c:598:13: error:
 invalid storage class for function 'l2_cache_event_start'
Message-ID: <20180316175745.GC4043@hirez.programming.kicks-ass.net>
References: <201803170151.rTZuY1Yd%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201803170151.rTZuY1Yd%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 17, 2018 at 01:19:54AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
> head:   bbb68468641547d56c83012670bcaf77f3dacd64
> commit: 7eb709f29593aced51901cb53565477762800722 [1/2] perf: Fix sibling iteration

ARGH.. the below folded it makes it build again. But lets see if the
0day finds more fail.


diff --git a/drivers/perf/qcom_l2_pmu.c b/drivers/perf/qcom_l2_pmu.c
index 1a7889f63c9a..842135cf35a3 100644
--- a/drivers/perf/qcom_l2_pmu.c
+++ b/drivers/perf/qcom_l2_pmu.c
@@ -541,6 +541,7 @@ static int l2_cache_event_init(struct perf_event *event)
 				 "Can't create mixed PMU group\n");
 			return -EINVAL;
 		}
+	}
 
 	cluster = get_cluster_pmu(l2cache_pmu, event->cpu);
 	if (!cluster) {
