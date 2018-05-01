Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755804AbeEAAaV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 20:30:21 -0400
Received: from mga05.intel.com ([192.55.52.43]:51444 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753744AbeEAAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 20:30:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,349,1520924400";
   d="scan'208";a="54924061"
Date: Tue, 1 May 2018 08:29:56 +0800
From: kbuild test robot <lkp@intel.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: [RFC PATCH] sched/fair: tg_set_cfs_slice() can be static
Message-ID: <20180501002956.GA22627@lkp-ne02>
References: <20180430192925.12589-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430192925.12589-1-xiyou.wangcong@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 601aedfafd22 ("sched/fair: make CFS bandwidth slice per cpu group")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index abc48d9..daa1843 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6665,7 +6665,7 @@ long tg_get_cfs_period(struct task_group *tg)
 	return cfs_period_us;
 }
 
-int tg_set_cfs_slice(struct task_group *tg, long cfs_slice_us)
+static int tg_set_cfs_slice(struct task_group *tg, long cfs_slice_us)
 {
 	u64 quota, slice;
 
@@ -6683,7 +6683,7 @@ int tg_set_cfs_slice(struct task_group *tg, long cfs_slice_us)
 	return 0;
 }
 
-long tg_get_cfs_slice(struct task_group *tg)
+static long tg_get_cfs_slice(struct task_group *tg)
 {
 	u64 slice_us;
 
