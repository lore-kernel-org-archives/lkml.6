Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751384AbeBTSeJ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 13:34:09 -0500
Received: from mga03.intel.com ([134.134.136.65]:55476 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750732AbeBTSeI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 13:34:08 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,540,1511856000";
   d="gz'50?scan'50,208,50";a="205615303"
Date: Wed, 21 Feb 2018 02:33:47 +0800
From: kbuild test robot <lkp@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?=
        <ckoenig.leichtzumerken@gmail.com>
Cc: kbuild-all@01.org, peterz@infradead.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] locking/ww_mutex: add ww_mutex_is_owned_by function v4
Message-ID: <201802210231.IRtd7Bkg%fengguang.wu@intel.com>
References: <20180220144946.2510-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180220144946.2510-1-christian.koenig@amd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Christian,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.16-rc2 next-20180220]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Christian-K-nig/locking-ww_mutex-add-ww_mutex_is_owned_by-function-v4/20180221-021317
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-1) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All error/warnings (new ones prefixed by >>):

   In file included from kernel/locking/mutex.c:21:0:
   include/linux/ww_mutex.h: In function 'ww_mutex_is_owned_by':
>> include/linux/ww_mutex.h:380:0: error: unterminated argument list invoking macro "likely"
    #endif
    
>> include/linux/ww_mutex.h:377:3: error: 'likely' undeclared (first use in this function)
      likely(READ_ONCE(lock->ctx) == NULL;
      ^~~~~~
   include/linux/ww_mutex.h:377:3: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/thread_info.h:13:0,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
>> include/linux/restart_block.h:11:1: error: expected ';' before 'struct'
    struct timespec;
    ^~~~~~
>> include/linux/restart_block.h:12:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    struct compat_timespec;
    ^~~~~~
   In file included from include/linux/thread_info.h:38:0,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
>> arch/x86/include/asm/thread_info.h:170:19: error: invalid storage class for function 'arch_within_stack_frames'
    static inline int arch_within_stack_frames(const void * const stack,
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/preempt.h:7:0,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
>> include/linux/thread_info.h:57:20: error: invalid storage class for function 'set_ti_thread_flag'
    static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
                       ^~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:62:20: error: invalid storage class for function 'clear_ti_thread_flag'
    static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
                       ^~~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:67:19: error: invalid storage class for function 'test_and_set_ti_thread_flag'
    static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:72:19: error: invalid storage class for function 'test_and_clear_ti_thread_flag'
    static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:77:19: error: invalid storage class for function 'test_ti_thread_flag'
    static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:115:20: error: invalid storage class for function 'check_object_size'
    static inline void check_object_size(const void *ptr, unsigned long n,
                       ^~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:125:20: error: invalid storage class for function 'copy_overflow'
    static inline void copy_overflow(int size, unsigned long count)
                       ^~~~~~~~~~~~~
>> include/linux/thread_info.h:131:1: error: invalid storage class for function 'check_copy_size'
    check_copy_size(const void *addr, size_t bytes, bool is_source)
    ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7:0,
                    from arch/x86/include/asm/percpu.h:543,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/mutex.h:14,
                    from kernel/locking/mutex.c:20:
>> arch/x86/include/asm/preempt.h:9:22: error: section attribute cannot be specified for local variables
    DECLARE_PER_CPU(int, __preempt_count);
                         ^
   include/linux/percpu-defs.h:101:44: note: in definition of macro 'DECLARE_PER_CPU_SECTION'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
                                               ^~~~
>> arch/x86/include/asm/preempt.h:9:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(int, __preempt_count);
    ^~~~~~~~~~~~~~~
   In file included from include/linux/preempt.h:81:0,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel/locking/mutex.c:22:
>> arch/x86/include/asm/preempt.h:21:28: error: invalid storage class for function 'preempt_count'
    static __always_inline int preempt_count(void)
                               ^~~~~~~~~~~~~
>> arch/x86/include/asm/preempt.h:26:29: error: invalid storage class for function 'preempt_count_set'
    static __always_inline void preempt_count_set(int pc)
                                ^~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/preempt.h:55:29: error: invalid storage class for function 'set_preempt_need_resched'
    static __always_inline void set_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/preempt.h:60:29: error: invalid storage class for function 'clear_preempt_need_resched'
    static __always_inline void clear_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/preempt.h:65:29: error: invalid storage class for function 'test_preempt_need_resched'
    static __always_inline bool test_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~
--
   In file included from kernel//locking/mutex.c:21:0:
   include/linux/ww_mutex.h: In function 'ww_mutex_is_owned_by':
>> include/linux/ww_mutex.h:380:0: error: unterminated argument list invoking macro "likely"
    #endif
    
>> include/linux/ww_mutex.h:377:3: error: 'likely' undeclared (first use in this function)
      likely(READ_ONCE(lock->ctx) == NULL;
      ^~~~~~
   include/linux/ww_mutex.h:377:3: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/thread_info.h:13:0,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel//locking/mutex.c:22:
>> include/linux/restart_block.h:11:1: error: expected ';' before 'struct'
    struct timespec;
    ^~~~~~
>> include/linux/restart_block.h:12:1: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
    struct compat_timespec;
    ^~~~~~
   In file included from include/linux/thread_info.h:38:0,
                    from arch/x86/include/asm/preempt.h:7,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel//locking/mutex.c:22:
>> arch/x86/include/asm/thread_info.h:170:19: error: invalid storage class for function 'arch_within_stack_frames'
    static inline int arch_within_stack_frames(const void * const stack,
                      ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from arch/x86/include/asm/preempt.h:7:0,
                    from include/linux/preempt.h:81,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel//locking/mutex.c:22:
>> include/linux/thread_info.h:57:20: error: invalid storage class for function 'set_ti_thread_flag'
    static inline void set_ti_thread_flag(struct thread_info *ti, int flag)
                       ^~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:62:20: error: invalid storage class for function 'clear_ti_thread_flag'
    static inline void clear_ti_thread_flag(struct thread_info *ti, int flag)
                       ^~~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:67:19: error: invalid storage class for function 'test_and_set_ti_thread_flag'
    static inline int test_and_set_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:72:19: error: invalid storage class for function 'test_and_clear_ti_thread_flag'
    static inline int test_and_clear_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:77:19: error: invalid storage class for function 'test_ti_thread_flag'
    static inline int test_ti_thread_flag(struct thread_info *ti, int flag)
                      ^~~~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:115:20: error: invalid storage class for function 'check_object_size'
    static inline void check_object_size(const void *ptr, unsigned long n,
                       ^~~~~~~~~~~~~~~~~
>> include/linux/thread_info.h:125:20: error: invalid storage class for function 'copy_overflow'
    static inline void copy_overflow(int size, unsigned long count)
                       ^~~~~~~~~~~~~
>> include/linux/thread_info.h:131:1: error: invalid storage class for function 'check_copy_size'
    check_copy_size(const void *addr, size_t bytes, bool is_source)
    ^~~~~~~~~~~~~~~
   In file included from include/asm-generic/percpu.h:7:0,
                    from arch/x86/include/asm/percpu.h:543,
                    from arch/x86/include/asm/current.h:6,
                    from include/linux/mutex.h:14,
                    from kernel//locking/mutex.c:20:
>> arch/x86/include/asm/preempt.h:9:22: error: section attribute cannot be specified for local variables
    DECLARE_PER_CPU(int, __preempt_count);
                         ^
   include/linux/percpu-defs.h:101:44: note: in definition of macro 'DECLARE_PER_CPU_SECTION'
     extern __PCPU_ATTRS(sec) __typeof__(type) name
                                               ^~~~
>> arch/x86/include/asm/preempt.h:9:1: note: in expansion of macro 'DECLARE_PER_CPU'
    DECLARE_PER_CPU(int, __preempt_count);
    ^~~~~~~~~~~~~~~
   In file included from include/linux/preempt.h:81:0,
                    from include/linux/rcupdate.h:40,
                    from include/linux/rculist.h:11,
                    from include/linux/sched/signal.h:5,
                    from kernel//locking/mutex.c:22:
>> arch/x86/include/asm/preempt.h:21:28: error: invalid storage class for function 'preempt_count'
    static __always_inline int preempt_count(void)
                               ^~~~~~~~~~~~~
>> arch/x86/include/asm/preempt.h:26:29: error: invalid storage class for function 'preempt_count_set'
    static __always_inline void preempt_count_set(int pc)
                                ^~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/preempt.h:55:29: error: invalid storage class for function 'set_preempt_need_resched'
    static __always_inline void set_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/preempt.h:60:29: error: invalid storage class for function 'clear_preempt_need_resched'
    static __always_inline void clear_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/x86/include/asm/preempt.h:65:29: error: invalid storage class for function 'test_preempt_need_resched'
    static __always_inline bool test_preempt_need_resched(void)
                                ^~~~~~~~~~~~~~~~~~~~~~~~~

vim +/likely +380 include/linux/ww_mutex.h

1b375dc3 Maarten Lankhorst 2013-07-05  360  
6cb2b111 Christian König   2018-02-20  361  /**
6cb2b111 Christian König   2018-02-20  362   * ww_mutex_is_owned_by - is the w/w mutex locked by this task in that context
6cb2b111 Christian König   2018-02-20  363   * @lock: the mutex to be queried
6cb2b111 Christian König   2018-02-20  364   * @ctx: the w/w acquire context to test
6cb2b111 Christian König   2018-02-20  365   *
6cb2b111 Christian König   2018-02-20  366   * If @ctx is not NULL test if the mutex is owned by this context.
6cb2b111 Christian König   2018-02-20  367   * If @ctx is NULL test if the mutex is owned by the current thread and not
6cb2b111 Christian König   2018-02-20  368   * locked in any context.
6cb2b111 Christian König   2018-02-20  369   */
6cb2b111 Christian König   2018-02-20  370  static inline bool ww_mutex_is_owned_by(struct ww_mutex *lock,
6cb2b111 Christian König   2018-02-20  371  					struct ww_acquire_ctx *ctx)
6cb2b111 Christian König   2018-02-20  372  {
6cb2b111 Christian König   2018-02-20  373  	if (ctx)
6cb2b111 Christian König   2018-02-20  374  		return likely(READ_ONCE(lock->ctx) == ctx);
6cb2b111 Christian König   2018-02-20  375  
6cb2b111 Christian König   2018-02-20  376  	return likely(__mutex_owner(&lock->base) == current) &&
6cb2b111 Christian König   2018-02-20 @377  		likely(READ_ONCE(lock->ctx) == NULL;
6cb2b111 Christian König   2018-02-20  378  }
6cb2b111 Christian König   2018-02-20  379  
1b375dc3 Maarten Lankhorst 2013-07-05 @380  #endif

:::::: The code at line 380 was first introduced by commit
:::::: 1b375dc30710180c4b88cc59caba6e3481ec5c8b mutex: Move ww_mutex definitions to ww_mutex.h

:::::: TO: Maarten Lankhorst <maarten.lankhorst@canonical.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--FCuugMFkClbJLl1L
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
7Facn3/TNfrWrmAAAA==

--FCuugMFkClbJLl1L--
