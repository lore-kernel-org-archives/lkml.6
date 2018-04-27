Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759454AbeD0WtV (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 18:49:21 -0400
Received: from mga07.intel.com ([134.134.136.100]:46130 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759215AbeD0WtT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 18:49:19 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,336,1520924400";
   d="gz'50?scan'50,208,50";a="36757988"
Date: Sat, 28 Apr 2018 06:49:06 +0800
From: kbuild test robot <lkp@intel.com>
To: Vincent Guittot <vincent.guittot@linaro.org>
Cc: kbuild-all@01.org, peterz@infradead.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] sched/fair: use RETRY_TASK in idle_balance
Message-ID: <201804280508.qS0p38MV%fengguang.wu@intel.com>
References: <1524739022-7788-1-git-send-email-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Disposition: inline
In-Reply-To: <1524739022-7788-1-git-send-email-vincent.guittot@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Vincent,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on v4.17-rc2 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Vincent-Guittot/sched-fair-use-RETRY_TASK-in-idle_balance/20180428-050824
config: x86_64-randconfig-x012-04271426 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'idle_balance':
>> kernel/sched/fair.c:9865:15: warning: assignment makes integer from pointer without a cast [-Wint-conversion]
      pulled_task = RETRY_TASK;
                  ^
   Cyclomatic Complexity 5 include/linux/compiler.h:__read_once_size
   Cyclomatic Complexity 5 include/linux/compiler.h:__write_once_size
   Cyclomatic Complexity 2 arch/x86/include/asm/bitops.h:clear_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:constant_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:variable_test_bit
   Cyclomatic Complexity 1 arch/x86/include/asm/bitops.h:fls
   Cyclomatic Complexity 1 arch/x86/include/asm/arch_hweight.h:__arch_hweight64
   Cyclomatic Complexity 2 include/linux/bitops.h:hweight_long
   Cyclomatic Complexity 1 include/linux/log2.h:__ilog2_u32
   Cyclomatic Complexity 1 arch/x86/include/asm/current.h:get_current
   Cyclomatic Complexity 1 include/linux/list.h:INIT_LIST_HEAD
   Cyclomatic Complexity 1 include/linux/list.h:__list_add_valid
   Cyclomatic Complexity 1 include/linux/list.h:__list_del_entry_valid
   Cyclomatic Complexity 2 include/linux/list.h:__list_add
   Cyclomatic Complexity 1 include/linux/list.h:list_add
   Cyclomatic Complexity 1 include/linux/list.h:__list_del
   Cyclomatic Complexity 2 include/linux/list.h:__list_del_entry
   Cyclomatic Complexity 1 include/linux/list.h:list_del_init
   Cyclomatic Complexity 1 include/linux/list.h:list_move
   Cyclomatic Complexity 1 include/linux/list.h:list_empty
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic.h:atomic_read
   Cyclomatic Complexity 1 arch/x86/include/asm/atomic64_64.h:atomic64_add
   Cyclomatic Complexity 1 include/linux/jump_label.h:static_key_count
   Cyclomatic Complexity 3 include/linux/string.h:memset
   Cyclomatic Complexity 3 include/linux/bitmap.h:bitmap_and
   Cyclomatic Complexity 3 include/linux/bitmap.h:bitmap_intersects
   Cyclomatic Complexity 3 include/linux/bitmap.h:bitmap_subset
   Cyclomatic Complexity 3 include/linux/bitmap.h:bitmap_weight
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_check
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_first
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_clear_cpu
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_test_cpu
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_and
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_intersects
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_subset
   Cyclomatic Complexity 1 include/linux/cpumask.h:cpumask_weight
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_restore
   Cyclomatic Complexity 1 arch/x86/include/asm/paravirt.h:arch_local_irq_enable
   Cyclomatic Complexity 1 include/linux/math64.h:div_u64_rem
   Cyclomatic Complexity 1 include/linux/math64.h:div_u64
   Cyclomatic Complexity 1 include/linux/math64.h:mul_u64_u32_shr
   Cyclomatic Complexity 2 include/linux/thread_info.h:test_ti_thread_flag
   Cyclomatic Complexity 1 include/linux/lockdep.h:lock_is_held
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_lock_acquire
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_lock_release
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_read_lock
   Cyclomatic Complexity 1 include/linux/rcupdate.h:rcu_read_unlock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_trylock
   Cyclomatic Complexity 1 include/linux/spinlock.h:spin_unlock
   Cyclomatic Complexity 1 include/linux/jiffies.h:_msecs_to_jiffies
   Cyclomatic Complexity 3 include/linux/jiffies.h:msecs_to_jiffies
   Cyclomatic Complexity 1 include/linux/rbtree.h:rb_link_node
   Cyclomatic Complexity 1 include/linux/sched.h:task_thread_info
   Cyclomatic Complexity 1 include/linux/sched.h:test_tsk_thread_flag
   Cyclomatic Complexity 1 include/linux/sched.h:test_tsk_need_resched
   Cyclomatic Complexity 1 include/linux/sched.h:task_cpu
   Cyclomatic Complexity 1 include/linux/sched/clock.h:local_clock
   Cyclomatic Complexity 1 include/linux/sched/cputime.h:get_running_cputimer
   Cyclomatic Complexity 2 include/linux/sched/cputime.h:account_group_exec_runtime
   Cyclomatic Complexity 1 include/linux/tick.h:tick_nohz_tick_stopped
   Cyclomatic Complexity 1 include/linux/sched/topology.h:sched_domain_span
   Cyclomatic Complexity 1 include/linux/cgroup.h:task_css_set
   Cyclomatic Complexity 1 include/linux/cgroup.h:task_dfl_cgroup
   Cyclomatic Complexity 3 include/linux/cgroup.h:cgroup_parent
   Cyclomatic Complexity 1 include/linux/cgroup.h:cpuacct_charge
   Cyclomatic Complexity 2 include/linux/cgroup.h:cgroup_account_cputime
   Cyclomatic Complexity 1 kernel/sched/sched.h:sched_asym_prefer
   Cyclomatic Complexity 1 kernel/sched/sched.h:cpu_of
   Cyclomatic Complexity 1 kernel/sched/sched.h:__rq_clock_broken
   Cyclomatic Complexity 4 kernel/sched/sched.h:assert_clock_updated
   Cyclomatic Complexity 4 kernel/sched/sched.h:rq_clock
   Cyclomatic Complexity 4 kernel/sched/sched.h:rq_clock_task
   Cyclomatic Complexity 5 kernel/sched/sched.h:rq_clock_skip_update
   Cyclomatic Complexity 1 kernel/sched/sched.h:rq_pin_lock
   Cyclomatic Complexity 2 kernel/sched/sched.h:rq_unpin_lock
   Cyclomatic Complexity 1 kernel/sched/sched.h:rq_repin_lock
   Cyclomatic Complexity 1 kernel/sched/sched.h:sched_group_span
   Cyclomatic Complexity 1 kernel/sched/sched.h:group_balance_mask
   Cyclomatic Complexity 1 kernel/sched/sched.h:task_group
   Cyclomatic Complexity 1 kernel/sched/sched.h:task_running
   Cyclomatic Complexity 1 kernel/sched/sched.h:task_on_rq_queued
   Cyclomatic Complexity 1 kernel/sched/sched.h:put_prev_task
   Cyclomatic Complexity 4 kernel/sched/sched.h:idle_get_state
   Cyclomatic Complexity 1 kernel/sched/sched.h:sched_update_tick_dependency
   Cyclomatic Complexity 4 kernel/sched/sched.h:add_nr_running
   Cyclomatic Complexity 1 kernel/sched/sched.h:sub_nr_running
   Cyclomatic Complexity 1 kernel/sched/sched.h:sched_avg_period
   Cyclomatic Complexity 1 kernel/sched/sched.h:hrtick_enabled
   Cyclomatic Complexity 1 kernel/sched/sched.h:arch_scale_freq_capacity
   Cyclomatic Complexity 4 kernel/sched/sched.h:arch_scale_cpu_capacity
   Cyclomatic Complexity 1 kernel/sched/sched.h:rq_lock_irqsave
   Cyclomatic Complexity 1 kernel/sched/sched.h:rq_lock_irq
   Cyclomatic Complexity 1 kernel/sched/sched.h:rq_lock
   Cyclomatic Complexity 1 kernel/sched/sched.h:rq_unlock_irqrestore
   Cyclomatic Complexity 1 kernel/sched/sched.h:rq_unlock
   Cyclomatic Complexity 1 kernel/sched/sched.h:cpufreq_update_util
   Cyclomatic Complexity 1 include/trace/events/sched.h:trace_sched_stat_runtime
   Cyclomatic Complexity 1 kernel/sched/fair.c:update_load_add

vim +9865 kernel/sched/fair.c

  9757	
  9758	/*
  9759	 * idle_balance is called by schedule() if this_cpu is about to become
  9760	 * idle. Attempts to pull tasks from other CPUs.
  9761	 */
  9762	static int idle_balance(struct rq *this_rq, struct rq_flags *rf)
  9763	{
  9764		unsigned long next_balance = jiffies + HZ;
  9765		int this_cpu = this_rq->cpu;
  9766		struct sched_domain *sd;
  9767		int pulled_task = 0;
  9768		u64 curr_cost = 0;
  9769	
  9770		/*
  9771		 * We must set idle_stamp _before_ calling idle_balance(), such that we
  9772		 * measure the duration of idle_balance() as idle time.
  9773		 */
  9774		this_rq->idle_stamp = rq_clock(this_rq);
  9775	
  9776		/*
  9777		 * Do not pull tasks towards !active CPUs...
  9778		 */
  9779		if (!cpu_active(this_cpu))
  9780			return 0;
  9781	
  9782		/*
  9783		 * This is OK, because current is on_cpu, which avoids it being picked
  9784		 * for load-balance and preemption/IRQs are still disabled avoiding
  9785		 * further scheduler activity on it and we're being very careful to
  9786		 * re-start the picking loop.
  9787		 */
  9788		rq_unpin_lock(this_rq, rf);
  9789	
  9790		if (this_rq->avg_idle < sysctl_sched_migration_cost ||
  9791		    !this_rq->rd->overload) {
  9792	
  9793			rcu_read_lock();
  9794			sd = rcu_dereference_check_sched_domain(this_rq->sd);
  9795			if (sd)
  9796				update_next_balance(sd, &next_balance);
  9797			rcu_read_unlock();
  9798	
  9799			nohz_newidle_balance(this_rq);
  9800	
  9801			goto out;
  9802		}
  9803	
  9804		raw_spin_unlock(&this_rq->lock);
  9805	
  9806		update_blocked_averages(this_cpu);
  9807		rcu_read_lock();
  9808		for_each_domain(this_cpu, sd) {
  9809			int continue_balancing = 1;
  9810			u64 t0, domain_cost;
  9811	
  9812			if (!(sd->flags & SD_LOAD_BALANCE))
  9813				continue;
  9814	
  9815			if (this_rq->avg_idle < curr_cost + sd->max_newidle_lb_cost) {
  9816				update_next_balance(sd, &next_balance);
  9817				break;
  9818			}
  9819	
  9820			if (sd->flags & SD_BALANCE_NEWIDLE) {
  9821				t0 = sched_clock_cpu(this_cpu);
  9822	
  9823				pulled_task = load_balance(this_cpu, this_rq,
  9824							   sd, CPU_NEWLY_IDLE,
  9825							   &continue_balancing);
  9826	
  9827				domain_cost = sched_clock_cpu(this_cpu) - t0;
  9828				if (domain_cost > sd->max_newidle_lb_cost)
  9829					sd->max_newidle_lb_cost = domain_cost;
  9830	
  9831				curr_cost += domain_cost;
  9832			}
  9833	
  9834			update_next_balance(sd, &next_balance);
  9835	
  9836			/*
  9837			 * Stop searching for tasks to pull if there are
  9838			 * now runnable tasks on this rq.
  9839			 */
  9840			if (pulled_task || this_rq->nr_running > 0)
  9841				break;
  9842		}
  9843		rcu_read_unlock();
  9844	
  9845		raw_spin_lock(&this_rq->lock);
  9846	
  9847		if (curr_cost > this_rq->max_idle_balance_cost)
  9848			this_rq->max_idle_balance_cost = curr_cost;
  9849	
  9850		/*
  9851		 * While browsing the domains, we released the rq lock, a task could
  9852		 * have been enqueued in the meantime. Since we're not going idle,
  9853		 * pretend we pulled a task.
  9854		 */
  9855		if (this_rq->cfs.h_nr_running && !pulled_task)
  9856			pulled_task = 1;
  9857	
  9858	out:
  9859		/* Move the next balance forward */
  9860		if (time_after(this_rq->next_balance, next_balance))
  9861			this_rq->next_balance = next_balance;
  9862	
  9863		/* Is there a task of a high priority class? */
  9864		if (this_rq->nr_running != this_rq->cfs.h_nr_running)
> 9865			pulled_task = RETRY_TASK;
  9866	
  9867		if (pulled_task)
  9868			this_rq->idle_stamp = 0;
  9869	
  9870		rq_repin_lock(this_rq, rf);
  9871	
  9872		return pulled_task;
  9873	}
  9874	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--LZvS9be/3tNcYl/X
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICCOV41oAAy5jb25maWcAlFxfc9u2sn/vp9CkL+c8tLWdxM2ZO34ASVBCRRIsAMqSXziu
rbSeOnauLZ+23/7uLkgRIJfK3M40CbELEFjsn98uQH3/3fcL8XZ4/nJ7eLi7fXz8Z/H7/mn/
cnvY3y8+Pzzu/2eR6UWl3UJmyv0IzMXD09vfP/396bK9/LD48OP55Y9nP7zcXS7W+5en/eMi
fX76/PD7Gwzw8Pz03fffpbrK1RJ4E+Wu/ukft9Q9eh4eVGWdaVKndNVmMtWZNANRN65uXJtr
Uwp39W7/+Pnyww8wmx8uP7zreYRJV9Az949X725f7v7AGf90R5N77Wbf3u8/+5Zjz0Kn60zW
rW3qWptgwtaJdO2MSOWUVpbN8EDvLktRt6bKWli0bUtVXV18OsUgtlfvL3iGVJe1cMNAM+NE
bDDc+WXPV0mZtVkpWmSFZTg5TJZodknkQlZLtxpoS1lJo9JWWYH0KSFplmxja2QhnNrIttaq
ctLYKdvqWqrlyo3FJnbtSmDHtM2zdKCaayvLdpuuliLLWlEstVFuVU7HTUWhEgNrhO0vxG40
/krYNq0bmuCWo4l0JdtCVbDJ6iaQE03KStfUbS0NjSGMFCNB9iRZJvCUK2Ndm66aaj3DV4ul
5Nn8jFQiTSXIDGptrUoKOWKxja0l7P4M+VpUrl018Ja6hH1ewZw5DhKeKIjTFcnAcqNBErD3
7y+Cbg34Aeo8mQuZhW117VQJ4svAkEGWqlrOcWYS1QXFIAqwvLF7aG1Zz3VtaqMTGWhWrrat
FKbYwXNbykA36qUTIBtQ8I0s7NWHvh3+8n5GhxqqzK/ttTbBZiSNKjJYkmzl1o9kI/N3K1AF
XGyu4Y/WCYudwfV9v1iSK31cvO4Pb18HZwhCca2sNrAmcDkgLBeYf2pgM8meFWzou3cwzHHC
1NY6ad3i4XXx9HzAkQPfJYoNmBsoDPZjmmH3nB6p9RqUTBbt8kbVPCUBygVPKm5CxxBStjdz
PWbeX9xgODiuNZhVuNQxneZ2igFneIq+vTndWzOCjmbctUG0EU0B1qatq0QJG/evp+en/b+P
22B3dqPqQMe7Bvw7dUW4drBmUOby10Y2knm9VxBQcW12rXAQmAJTbKwEDxiORgbLDEPCJ6Mi
DpwGWGGvuWAGi9e3317/eT3svwyaewwKYCVkgUy8AJJd6WueIvNcphQcRJ6Dw7frKR+6NPAa
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
VORG6xp6UEyM+f904Yf4flcBAA==

--LZvS9be/3tNcYl/X--
