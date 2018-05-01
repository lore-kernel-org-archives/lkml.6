Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755749AbeEAAaT (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 20:30:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:56527 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753530AbeEAAaS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 20:30:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,349,1520924400";
   d="scan'208";a="51292344"
Date: Tue, 1 May 2018 08:29:55 +0800
From: kbuild test robot <lkp@intel.com>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org,
        Cong Wang <xiyou.wangcong@gmail.com>, Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] sched/fair: make CFS bandwidth slice per cpu group
Message-ID: <201805010804.P1jvQYaP%fengguang.wu@intel.com>
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

Hi Cong,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on v4.17-rc3 next-20180430]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Cong-Wang/sched-fair-make-CFS-bandwidth-slice-per-cpu-group/20180501-064013
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   kernel/sched/core.c:509:9: sparse: incompatible types in comparison expression (different address spaces)
   kernel/sched/core.c:1614:17: sparse: incompatible types in comparison expression (different address spaces)
   kernel/sched/core.c:1802:27: sparse: incompatible types in comparison expression (different address spaces)
   kernel/sched/core.c:6541:11: sparse: symbol 'max_cfs_quota_period' was not declared. Should it be static?
   kernel/sched/core.c:6542:11: sparse: symbol 'min_cfs_quota_period' was not declared. Should it be static?
   kernel/sched/core.c:6622:5: sparse: symbol 'tg_set_cfs_quota' was not declared. Should it be static?
   kernel/sched/core.c:6635:6: sparse: symbol 'tg_get_cfs_quota' was not declared. Should it be static?
   kernel/sched/core.c:6648:5: sparse: symbol 'tg_set_cfs_period' was not declared. Should it be static?
   kernel/sched/core.c:6658:6: sparse: symbol 'tg_get_cfs_period' was not declared. Should it be static?
>> kernel/sched/core.c:6668:5: sparse: symbol 'tg_set_cfs_slice' was not declared. Should it be static?
>> kernel/sched/core.c:6686:6: sparse: symbol 'tg_get_cfs_slice' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
