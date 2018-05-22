Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbeEVVbP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 17:31:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:25131 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752960AbeEVVbO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 17:31:14 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,430,1520924400";
   d="scan'208";a="43113452"
Date: Wed, 23 May 2018 05:30:35 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH rcu] rcutorture: __pcpu_scope_rcu_torture_timer_rand can
 be static
Message-ID: <20180522213034.GA87654@lkp-sb04>
References: <201805230516.7z5kOC3u%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805230516.7z5kOC3u%fengguang.wu@intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 816e0790625a ("rcutorture: Use per-CPU random state for rcu_torture_timer()")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 rcutorture.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 5683bfb..a03313e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1142,7 +1142,7 @@ static bool rcu_torture_one_read(struct torture_random_state *trsp)
 	return true;
 }
 
-DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
+static DEFINE_TORTURE_RANDOM_PERCPU(rcu_torture_timer_rand);
 
 /*
  * RCU torture reader from timer handler.  Dereferences rcu_torture_current,
