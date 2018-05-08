Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932337AbeEHOD5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:03:57 -0400
Received: from gum.cmpxchg.org ([85.214.110.215]:49796 "EHLO gum.cmpxchg.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932079AbeEHODz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:03:55 -0400
Date: Tue, 8 May 2018 10:05:33 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: kbuild test robot <lkp@intel.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-block@vger.kernel.org, cgroups@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linuxfoundation.org>, Tejun Heo <tj@kernel.org>,
        Balbir Singh <bsingharora@gmail.com>, Mike Galbraith <efault@gmx.de>,
        Oliver Yang <yangoliver@me.com>, Shakeel Butt <shakeelb@google.com>,
        xxx xxx <x.qendo@gmail.com>, Taras Kondratiuk <takondra@cisco.com>,
        Daniel Walker <danielwa@cisco.com>,
        Vinayak Menon <vinmenon@codeaurora.org>,
        Ruslan Ruslichenko <rruslich@cisco.com>, kernel-team@fb.com
Subject: Re: [PATCH 6/7] psi: pressure stall information for CPU, memory, and
 IO
Message-ID: <20180508140533.GA2900@cmpxchg.org>
References: <20180507210135.1823-7-hannes@cmpxchg.org>
 <201805080952.2yQWmzU2%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201805080952.2yQWmzU2%fengguang.wu@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 11:04:09AM +0800, kbuild test robot wrote:
>    118	#else /* CONFIG_PSI */
>    119	static inline void psi_enqueue(struct task_struct *p, u64 now)
>    120	{
>    121	}
>    122	static inline void psi_dequeue(struct task_struct *p, u64 now)
>    123	{
>    124	}
>    125	static inline void psi_ttwu_dequeue(struct task_struct *p) {}
>  > 126	{
>    127	}

Stupid last-minute cleanup reshuffling. v2 will have:

diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index cb4a68bcf37a..ff6256b3d216 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -122,7 +122,7 @@ static inline void psi_enqueue(struct task_struct *p, u64 now)
 static inline void psi_dequeue(struct task_struct *p, u64 now)
 {
 }
-static inline void psi_ttwu_dequeue(struct task_struct *p) {}
+static inline void psi_ttwu_dequeue(struct task_struct *p)
 {
 }
 #endif /* CONFIG_PSI */
