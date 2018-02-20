Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752239AbeBTTPO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 14:15:14 -0500
Received: from mga18.intel.com ([134.134.136.126]:19685 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751813AbeBTTPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 14:15:13 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="gz'50?scan'50,208,50";a="32842104"
Date: Wed, 21 Feb 2018 03:15:07 +0800
From: kbuild test robot <lkp@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: kbuild-all@01.org, peterz@infradead.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/ww_mutex: add ww_mutex_is_owned_by function v4
Message-ID: <201802210334.ThGIktKN%fengguang.wu@intel.com>
References: <20180220144946.2510-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="9amGYk9869ThD9tj"
Content-Disposition: inline
In-Reply-To: <20180220144946.2510-1-christian.koenig@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--9amGYk9869ThD9tj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Christian,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc2 next-20180220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christian-K-nig/locking-ww_mutex-add-ww_mutex_is_owned_by-function-v4/20180221-021317
config: microblaze-mmu_defconfig (attached as .config)
compiler: microblaze-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=microblaze 

All error/warnings (new ones prefixed by >>):

   In file included from kernel/locking/mutex.c:21:0:
   include/linux/ww_mutex.h: In function 'ww_mutex_is_owned_by':
   include/linux/ww_mutex.h:380:0: error: unterminated argument list invoking macro "likely"
    #endif
    
   include/linux/ww_mutex.h:377:3: error: 'likely' undeclared (first use in this function)
      likely(READ_ONCE(lock->ctx) == NULL;
      ^~~~~~
   include/linux/ww_mutex.h:377:3: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/thread_info.h:13:0,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/microblaze/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
   include/linux/restart_block.h:11:1: error: expected ';' before 'struct'
    struct timespec;
    ^~~~~~
   include/linux/restart_block.h:12:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    struct compat_timespec;
    ^~~~~~
   In file included from include/linux/thread_info.h:38:0,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/microblaze/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
>> arch/microblaze/include/asm/thread_info.h:90:35: error: invalid storage class for function 'current_thread_info'
    static inline struct thread_info *current_thread_info(void)
                                      ^~~~~~~~~~~~~~~~~~~
   In file included from include/asm-generic/preempt.h:5:0,
                    from ./arch/microblaze/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
   include/linux/thread_info.h:57:20: error: invalid storage class for function 'set_ti_thread_flag'
    static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
                       ^~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:62:20: error: invalid storage class for function 'clear_ti_thread_flag'
    static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:67:19: error: invalid storage class for function 'test_and_set_ti_thread_flag'
    static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:72:19: error: invalid storage class for function 'test_and_clear_ti_thread_flag'
    static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:77:19: error: invalid storage class for function 'test_ti_thread_flag'
    static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:96:19: error: invalid storage class for function 'arch_within_stack_frames'
    static inline int arch_within_stack_frames(const void * const stack,
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:115:20: error: invalid storage class for function 'check_object_size'
    static inline void check_object_size(const void *ptr, unsigned long n,
                       ^~~~~~~~~~~~~~~~~
   include/linux/thread_info.h:125:20: error: invalid storage class for function 'copy_overflow'
    static inline void copy_overflow(int size, unsigned long count)
                       ^~~~~~~~~~~~~
   include/linux/thread_info.h:131:1: error: invalid storage class for function 'check_copy_size'
    check_copy_size(const void *addr, size_t bytes, bool is_source)
    ^~~~~~~~~~~~~~~
   include/linux/thread_info.h:148:20: error: invalid storage class for function 'arch_setup_new_exec'
    static inline void arch_setup_new_exec(void) { }
                       ^~~~~~~~~~~~~~~~~~~
   In file included from ./arch/microblaze/include/generated/asm/preempt.h:1:0,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
   include/asm-generic/preempt.h:9:28: error: invalid storage class for function 'preempt_count'
    static __always_inline int preempt_count(void)
                               ^~~~~~~~~~~~~
   include/asm-generic/preempt.h:14:38: error: invalid storage class for function 'preempt_count_ptr'
    static __always_inline volatile int *preempt_count_ptr(void)
                                         ^~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:19:29: error: invalid storage class for function 'preempt_count_set'
    static __always_inline void preempt_count_set(int pc)
                                ^~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:35:29: error: invalid storage class for function 'set_preempt_need_resched'
    static __always_inline void set_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:39:29: error: invalid storage class for function 'clear_preempt_need_resched'
    static __always_inline void clear_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:43:29: error: invalid storage class for function 'test_preempt_need_resched'
    static __always_inline bool test_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:52:29: error: invalid storage class for function '__preempt_count_add'
    static __always_inline void __preempt_count_add(int val)
                                ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:57:29: error: invalid storage class for function '__preempt_count_sub'
    static __always_inline void __preempt_count_sub(int val)
                                ^~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:62:29: error: invalid storage class for function '__preempt_count_dec_and_test'
    static __always_inline bool __preempt_count_dec_and_test(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/asm-generic/preempt.h:75:29: error: invalid storage class for function 'should_resched'
    static __always_inline bool should_resched(int preempt_offset)
                                ^~~~~~~~~~~~~~
   In file included from include/linux/rcupdate.h:41:0,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
   include/linux/bottom_half.h:10:29: error: invalid storage class for function '__local_bh_disable_ip'
    static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
                                ^~~~~~~~~~~~~~~~~~~~~
   include/linux/bottom_half.h:17:20: error: invalid storage class for function 'local_bh_disable'
    static inline void local_bh_disable(void)
                       ^~~~~~~~~~~~~~~~
   include/linux/bottom_half.h:25:20: error: invalid storage class for function 'local_bh_enable_ip'
    static inline void local_bh_enable_ip(unsigned long ip)
                       ^~~~~~~~~~~~~~~~~~
   include/linux/bottom_half.h:30:20: error: invalid storage class for function 'local_bh_enable'
    static inline void local_bh_enable(void)
                       ^~~~~~~~~~~~~~~
   In file included from include/linux/bitmap.h:9:0,
                    from include/linux/cpumask.h:12,
                    from include/linux/rcupdate.h:44,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
   include/linux/string.h:71:34: error: invalid storage class for function 'strstrip'
    static inline __must_check char *strstrip(char *str)
                                     ^~~~~~~~
--
                      ^~~~~~~~~~~~~
   include/linux/cpumask.h:637:19: error: invalid storage class for function 'cpulist_parse'
    static inline int cpulist_parse(const char *buf, struct cpumask *dstp)
                      ^~~~~~~~~~~~~
   include/linux/cpumask.h:645:28: error: invalid storage class for function 'cpumask_size'
    static inline unsigned int cpumask_size(void)
                               ^~~~~~~~~~~~
   include/linux/cpumask.h:715:20: error: invalid storage class for function 'alloc_cpumask_var'
    static inline bool alloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
                       ^~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:720:20: error: invalid storage class for function 'alloc_cpumask_var_node'
    static inline bool alloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
                       ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:726:20: error: invalid storage class for function 'zalloc_cpumask_var'
    static inline bool zalloc_cpumask_var(cpumask_var_t *mask, gfp_t flags)
                       ^~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:732:20: error: invalid storage class for function 'zalloc_cpumask_var_node'
    static inline bool zalloc_cpumask_var_node(cpumask_var_t *mask, gfp_t flags,
                       ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:739:20: error: invalid storage class for function 'alloc_bootmem_cpumask_var'
    static inline void alloc_bootmem_cpumask_var(cpumask_var_t *mask)
                       ^~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:743:20: error: invalid storage class for function 'free_cpumask_var'
    static inline void free_cpumask_var(cpumask_var_t mask)
                       ^~~~~~~~~~~~~~~~
   include/linux/cpumask.h:747:20: error: invalid storage class for function 'free_bootmem_cpumask_var'
    static inline void free_bootmem_cpumask_var(cpumask_var_t mask)
                       ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:751:20: error: invalid storage class for function 'cpumask_available'
    static inline bool cpumask_available(cpumask_var_t mask)
                       ^~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:774:20: error: invalid storage class for function 'reset_cpu_possible_mask'
    static inline void reset_cpu_possible_mask(void)
                       ^~~~~~~~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:780:1: error: invalid storage class for function 'set_cpu_possible'
    set_cpu_possible(unsigned int cpu, bool possible)
    ^~~~~~~~~~~~~~~~
   include/linux/cpumask.h:789:1: error: invalid storage class for function 'set_cpu_present'
    set_cpu_present(unsigned int cpu, bool present)
    ^~~~~~~~~~~~~~~
   include/linux/cpumask.h:798:1: error: invalid storage class for function 'set_cpu_online'
    set_cpu_online(unsigned int cpu, bool online)
    ^~~~~~~~~~~~~~
   include/linux/cpumask.h:807:1: error: invalid storage class for function 'set_cpu_active'
    set_cpu_active(unsigned int cpu, bool active)
    ^~~~~~~~~~~~~~
   include/linux/cpumask.h:830:19: error: invalid storage class for function '__check_is_bitmap'
    static inline int __check_is_bitmap(const unsigned long *bitmap)
                      ^~~~~~~~~~~~~~~~~
   include/linux/cpumask.h:845:37: error: invalid storage class for function 'get_cpu_mask'
    static inline const struct cpumask *get_cpu_mask(unsigned int cpu)
                                        ^~~~~~~~~~~~
   include/linux/cpumask.h:880:1: error: invalid storage class for function 'cpumap_print_to_pagebuf'
    cpumap_print_to_pagebuf(bool list, char *buf, const struct cpumask *mask)
    ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/rculist.h:11:0,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
   include/linux/rcupdate.h:80:20: error: invalid storage class for function '__rcu_read_lock'
    static inline void __rcu_read_lock(void)
                       ^~~~~~~~~~~~~~~
   include/linux/rcupdate.h:86:20: error: invalid storage class for function '__rcu_read_unlock'
    static inline void __rcu_read_unlock(void)
                       ^~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:92:20: error: invalid storage class for function 'synchronize_rcu'
    static inline void synchronize_rcu(void)
                       ^~~~~~~~~~~~~~~
   include/linux/rcupdate.h:97:19: error: invalid storage class for function 'rcu_preempt_depth'
    static inline int rcu_preempt_depth(void)
                      ^~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:118:20: error: invalid storage class for function 'rcu_sysrq_start'
    static inline void rcu_sysrq_start(void) { }
                       ^~~~~~~~~~~~~~~
   include/linux/rcupdate.h:119:20: error: invalid storage class for function 'rcu_sysrq_end'
    static inline void rcu_sysrq_end(void) { }
                       ^~~~~~~~~~~~~
   include/linux/rcupdate.h:126:20: error: invalid storage class for function 'rcu_user_enter'
    static inline void rcu_user_enter(void) { }
                       ^~~~~~~~~~~~~~
   include/linux/rcupdate.h:127:20: error: invalid storage class for function 'rcu_user_exit'
    static inline void rcu_user_exit(void) { }
                       ^~~~~~~~~~~~~
   include/linux/rcupdate.h:133:20: error: invalid storage class for function 'rcu_init_nohz'
    static inline void rcu_init_nohz(void) { }
                       ^~~~~~~~~~~~~
   include/linux/rcupdate.h:186:20: error: invalid storage class for function 'exit_tasks_rcu_start'
    static inline void exit_tasks_rcu_start(void) { }
                       ^~~~~~~~~~~~~~~~~~~~
   include/linux/rcupdate.h:187:20: error: invalid storage class for function 'exit_tasks_rcu_finish'
    static inline void exit_tasks_rcu_finish(void) { }
                       ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/spinlock.h:90:0,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/ktime.h:24,
                    from include/linux/rcutiny.h:28,
                    from include/linux/rcupdate.h:211,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
>> include/linux/spinlock_up.h:29:20: error: invalid storage class for function 'arch_spin_lock'
    static inline void arch_spin_lock(arch_spinlock_t *lock)
                       ^~~~~~~~~~~~~~
>> include/linux/spinlock_up.h:35:19: error: invalid storage class for function 'arch_spin_trylock'
    static inline int arch_spin_trylock(arch_spinlock_t *lock)
                      ^~~~~~~~~~~~~~~~~
>> include/linux/spinlock_up.h:45:20: error: invalid storage class for function 'arch_spin_unlock'
    static inline void arch_spin_unlock(arch_spinlock_t *lock)
                       ^~~~~~~~~~~~~~~~
   In file included from include/linux/spinlock.h:288:0,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/ktime.h:24,
                    from include/linux/rcutiny.h:28,
                    from include/linux/rcupdate.h:211,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
>> include/linux/spinlock_api_smp.h:86:19: error: invalid storage class for function '__raw_spin_trylock'
    static inline int __raw_spin_trylock(raw_spinlock_t *lock)
                      ^~~~~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:104:29: error: invalid storage class for function '__raw_spin_lock_irqsave'
    static inline unsigned long __raw_spin_lock_irqsave(raw_spinlock_t *lock)
                                ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:124:20: error: invalid storage class for function '__raw_spin_lock_irq'
    static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
                       ^~~~~~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:132:20: error: invalid storage class for function '__raw_spin_lock_bh'
    static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
                       ^~~~~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:139:20: error: invalid storage class for function '__raw_spin_lock'
    static inline void __raw_spin_lock(raw_spinlock_t *lock)
                       ^~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:148:20: error: invalid storage class for function '__raw_spin_unlock'
    static inline void __raw_spin_unlock(raw_spinlock_t *lock)
                       ^~~~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:155:20: error: invalid storage class for function '__raw_spin_unlock_irqrestore'
    static inline void __raw_spin_unlock_irqrestore(raw_spinlock_t *lock,
                       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:164:20: error: invalid storage class for function '__raw_spin_unlock_irq'
    static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
                       ^~~~~~~~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:172:20: error: invalid storage class for function '__raw_spin_unlock_bh'
    static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
                       ^~~~~~~~~~~~~~~~~~~~
>> include/linux/spinlock_api_smp.h:179:19: error: invalid storage class for function '__raw_spin_trylock_bh'
    static inline int __raw_spin_trylock_bh(raw_spinlock_t *lock)
                      ^~~~~~~~~~~~~~~~~~~~~
   In file included from include/linux/spinlock_api_smp.h:190:0,
                    from include/linux/spinlock.h:288,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/ktime.h:24,
                    from include/linux/rcutiny.h:28,
                    from include/linux/rcupdate.h:211,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
>> include/linux/rwlock_api_smp.h:117:19: error: invalid storage class for function '__raw_read_trylock'
    static inline int __raw_read_trylock(rwlock_t *lock)
                      ^~~~~~~~~~~~~~~~~~
>> include/linux/rwlock_api_smp.h:128:19: error: invalid storage class for function '__raw_write_trylock'
    static inline int __raw_write_trylock(rwlock_t *lock)
                      ^~~~~~~~~~~~~~~~~~~
>> include/linux/rwlock_api_smp.h:146:20: error: invalid storage class for function '__raw_read_lock'
    static inline void __raw_read_lock(rwlock_t *lock)
                       ^~~~~~~~~~~~~~~
>> include/linux/rwlock_api_smp.h:153:29: error: invalid storage class for function '__raw_read_lock_irqsave'
    static inline unsigned long __raw_read_lock_irqsave(rwlock_t *lock)
                                ^~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/rwlock_api_smp.h:165:20: error: invalid storage class for function '__raw_read_lock_irq'
    static inline void __raw_read_lock_irq(rwlock_t *lock)
                       ^~~~~~~~~~~~~~~~~~~
>> include/linux/rwlock_api_smp.h:173:20: error: invalid storage class for function '__raw_read_lock_bh'
    static inline void __raw_read_lock_bh(rwlock_t *lock)
                       ^~~~~~~~~~~~~~~~~~
..

vim +/current_thread_info +90 arch/microblaze/include/asm/thread_info.h

4684dade Michal Simek 2009-03-27  88  
4684dade Michal Simek 2009-03-27  89  /* how to get the thread information struct from C */
4684dade Michal Simek 2009-03-27 @90  static inline struct thread_info *current_thread_info(void)
4684dade Michal Simek 2009-03-27  91  {
4684dade Michal Simek 2009-03-27  92  	register unsigned long sp asm("r1");
4684dade Michal Simek 2009-03-27  93  
4684dade Michal Simek 2009-03-27  94  	return (struct thread_info *)(sp & ~(THREAD_SIZE-1));
4684dade Michal Simek 2009-03-27  95  }
4684dade Michal Simek 2009-03-27  96  

:::::: The code at line 90 was first introduced by commit
:::::: 4684dadec6ca3f310b0d9ff1860ca6b6f11ffd2d microblaze_v8: string.h thread_info.h

:::::: TO: Michal Simek <monstr@monstr.eu>
:::::: CC: Michal Simek <monstr@monstr.eu>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--9amGYk9869ThD9tj
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
EgNMleDGQObXP7KMI14izwAA

--9amGYk9869ThD9tj--
