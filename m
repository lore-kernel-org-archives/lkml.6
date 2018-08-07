Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF648C46471
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:34:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3A1E215F1
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Aug 2018 18:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A1E215F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389429AbeHGUuf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Aug 2018 16:50:35 -0400
Received: from mga01.intel.com ([192.55.52.88]:15422 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388778AbeHGUuf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Aug 2018 16:50:35 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Aug 2018 11:34:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,456,1526367600"; 
   d="gz'50?scan'50,208,50";a="252760827"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 07 Aug 2018 11:34:49 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fn6oR-000AkN-A8; Wed, 08 Aug 2018 02:34:31 +0800
Date:   Wed, 8 Aug 2018 02:34:05 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mao Wenan <maowenan@huawei.com>
Cc:     kbuild-all@01.org, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will.deacon@arm.com>,
        Mao Wenan <maowenan@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtmutex: Drop pointless static qualifier in
 rt_mutex_adjust_prio_chain()
Message-ID: <201808080245.7gKqyfV1%fengguang.wu@intel.com>
References: <1533632163-93769-1-git-send-email-maowenan@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="azLHFNyN32YCQGCU"
Content-Disposition: inline
In-Reply-To: <1533632163-93769-1-git-send-email-maowenan@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--azLHFNyN32YCQGCU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Mao,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on v4.18-rc8 next-20180807]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mao-Wenan/rtmutex-Drop-pointless-static-qualifier-in-rt_mutex_adjust_prio_chain/20180808-013010
config: x86_64-randconfig-x010-201831 (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: it may well be a FALSE warning. FWIW you are at least aware of it now.
http://gcc.gnu.org/wiki/Better_Uninitialized_Warnings

All warnings (new ones prefixed by >>):

   kernel/locking/rtmutex.c: In function 'rt_mutex_adjust_prio_chain':
>> kernel/locking/rtmutex.c:481:6: warning: 'prev_max' may be used uninitialized in this function [-Wmaybe-uninitialized]
      if (prev_max != max_lock_depth) {
         ^

vim +/prev_max +481 kernel/locking/rtmutex.c

820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  384  
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  385  /*
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  386   * Adjust the priority chain. Also used for deadlock detection.
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  387   * Decreases task's usage by one - may thus free the task.
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  388   *
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  389   * @task:	the task owning the mutex (owner) for which a chain walk is
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  390   *		probably needed
e6beaa363 kernel/locking/rtmutex.c Tom(JeHyeon  Yeon 2015-03-18  391)  * @chwalk:	do we have to carry out deadlock detection?
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  392   * @orig_lock:	the mutex (can be NULL if we are walking the chain to recheck
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  393   *		things for a task that has just got its priority adjusted, and
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  394   *		is waiting on a mutex)
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  395   * @next_lock:	the mutex on which the owner of @orig_lock was blocked before
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  396   *		we dropped its pi_lock. Is never dereferenced, only used for
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  397   *		comparison to detect lock chain changes.
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  398   * @orig_waiter: rt_mutex_waiter struct for the task that has just donated
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  399   *		its priority to the mutex owner (can be NULL in the case
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  400   *		depicted above or if the top waiter is gone away and we are
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  401   *		actually deboosting the owner)
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  402   * @top_task:	the current top waiter
0c1061733 kernel/rtmutex.c         Juri Lelli        2013-05-15  403   *
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  404   * Returns 0 or -EDEADLK.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  405   *
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  406   * Chain walk basics and protection scope
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  407   *
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  408   * [R] refcount on task
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  409   * [P] task->pi_lock held
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  410   * [L] rtmutex->wait_lock held
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  411   *
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  412   * Step	Description				Protected by
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  413   *	function arguments:
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  414   *	@task					[R]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  415   *	@orig_lock if != NULL			@top_task is blocked on it
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  416   *	@next_lock				Unprotected. Cannot be
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  417   *						dereferenced. Only used for
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  418   *						comparison.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  419   *	@orig_waiter if != NULL			@top_task is blocked on it
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  420   *	@top_task				current, or in case of proxy
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  421   *						locking protected by calling
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  422   *						code
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  423   *	again:
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  424   *	  loop_sanity_check();
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  425   *	retry:
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  426   * [1]	  lock(task->pi_lock);			[R] acquire [P]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  427   * [2]	  waiter = task->pi_blocked_on;		[P]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  428   * [3]	  check_exit_conditions_1();		[P]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  429   * [4]	  lock = waiter->lock;			[P]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  430   * [5]	  if (!try_lock(lock->wait_lock)) {	[P] try to acquire [L]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  431   *	    unlock(task->pi_lock);		release [P]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  432   *	    goto retry;
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  433   *	  }
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  434   * [6]	  check_exit_conditions_2();		[P] + [L]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  435   * [7]	  requeue_lock_waiter(lock, waiter);	[P] + [L]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  436   * [8]	  unlock(task->pi_lock);		release [P]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  437   *	  put_task_struct(task);		release [R]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  438   * [9]	  check_exit_conditions_3();		[L]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  439   * [10]	  task = owner(lock);			[L]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  440   *	  get_task_struct(task);		[L] acquire [R]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  441   *	  lock(task->pi_lock);			[L] acquire [P]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  442   * [11]	  requeue_pi_waiter(tsk, waiters(lock));[P] + [L]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  443   * [12]	  check_exit_conditions_4();		[P] + [L]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  444   * [13]	  unlock(task->pi_lock);		release [P]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  445   *	  unlock(lock->wait_lock);		release [L]
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  446   *	  goto again;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  447   */
bd197234b kernel/rtmutex.c         Thomas Gleixner   2007-06-17  448  static int rt_mutex_adjust_prio_chain(struct task_struct *task,
8930ed80f kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  449  				      enum rtmutex_chainwalk chwalk,
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  450  				      struct rt_mutex *orig_lock,
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  451  				      struct rt_mutex *next_lock,
95e02ca9b kernel/rtmutex.c         Thomas Gleixner   2006-06-27  452  				      struct rt_mutex_waiter *orig_waiter,
9a11b49a8 kernel/rtmutex.c         Ingo Molnar       2006-07-03  453  				      struct task_struct *top_task)
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  454  {
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  455  	struct rt_mutex_waiter *waiter, *top_waiter = orig_waiter;
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  456  	struct rt_mutex_waiter *prerequeue_top_waiter;
8930ed80f kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  457  	int ret = 0, depth = 0;
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  458  	struct rt_mutex *lock;
8930ed80f kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  459  	bool detect_deadlock;
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  460  	bool requeue = true;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  461  
8930ed80f kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  462  	detect_deadlock = rt_mutex_cond_detect_deadlock(orig_waiter, chwalk);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  463  
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  464  	/*
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  465  	 * The (de)boosting is a step by step approach with a lot of
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  466  	 * pitfalls. We want this to be preemptible and we want hold a
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  467  	 * maximum of two locks per step. So we have to check
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  468  	 * carefully whether things change under us.
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  469  	 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  470   again:
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  471  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  472  	 * We limit the lock chain length for each invocation.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  473  	 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  474  	if (++depth > max_lock_depth) {
3ac304ec5 kernel/locking/rtmutex.c Mao Wenan         2018-08-07  475  		int prev_max;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  476  
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  477  		/*
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  478  		 * Print this only once. If the admin changes the limit,
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  479  		 * print a new message when reaching the limit again.
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  480  		 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27 @481  		if (prev_max != max_lock_depth) {
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  482  			prev_max = max_lock_depth;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  483  			printk(KERN_WARNING "Maximum lock depth %d reached "
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  484  			       "task: %s (%d)\n", max_lock_depth,
ba25f9dcc kernel/rtmutex.c         Pavel Emelyanov   2007-10-18  485  			       top_task->comm, task_pid_nr(top_task));
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  486  		}
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  487  		put_task_struct(task);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  488  
3d5c9340d kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  489  		return -EDEADLK;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  490  	}
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  491  
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  492  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  493  	 * We are fully preemptible here and only hold the refcount on
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  494  	 * @task. So everything can have changed under us since the
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  495  	 * caller or our own code below (goto retry/again) dropped all
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  496  	 * locks.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  497  	 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  498   retry:
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  499  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  500  	 * [1] Task cannot go away as we did a get_task() before !
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  501  	 */
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  502  	raw_spin_lock_irq(&task->pi_lock);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  503  
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  504  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  505  	 * [2] Get the waiter on which @task is blocked on.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  506  	 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  507  	waiter = task->pi_blocked_on;
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  508  
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  509  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  510  	 * [3] check_exit_conditions_1() protected by task->pi_lock.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  511  	 */
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  512  
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  513  	/*
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  514  	 * Check whether the end of the boosting chain has been
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  515  	 * reached or the state of the chain has changed while we
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  516  	 * dropped the locks.
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  517  	 */
8161239a8 kernel/rtmutex.c         Lai Jiangshan     2011-01-14  518  	if (!waiter)
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  519  		goto out_unlock_pi;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  520  
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  521  	/*
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  522  	 * Check the orig_waiter state. After we dropped the locks,
8161239a8 kernel/rtmutex.c         Lai Jiangshan     2011-01-14  523  	 * the previous owner of the lock might have released the lock.
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  524  	 */
8161239a8 kernel/rtmutex.c         Lai Jiangshan     2011-01-14  525  	if (orig_waiter && !rt_mutex_owner(orig_lock))
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  526  		goto out_unlock_pi;
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  527  
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  528  	/*
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  529  	 * We dropped all locks after taking a refcount on @task, so
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  530  	 * the task might have moved on in the lock chain or even left
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  531  	 * the chain completely and blocks now on an unrelated lock or
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  532  	 * on @orig_lock.
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  533  	 *
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  534  	 * We stored the lock on which @task was blocked in @next_lock,
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  535  	 * so we can detect the chain change.
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  536  	 */
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  537  	if (next_lock != waiter->lock)
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  538  		goto out_unlock_pi;
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  539  
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  540  	/*
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  541  	 * Drop out, when the task has no waiters. Note,
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  542  	 * top_waiter can be NULL, when we are in the deboosting
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  543  	 * mode!
1a539a872 kernel/rtmutex.c         Thomas Gleixner   2007-06-08  544  	 */
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  545  	if (top_waiter) {
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  546  		if (!task_has_pi_waiters(task))
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  547  			goto out_unlock_pi;
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  548  		/*
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  549  		 * If deadlock detection is off, we stop here if we
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  550  		 * are not the top pi waiter of the task. If deadlock
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  551  		 * detection is enabled we continue, but stop the
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  552  		 * requeueing in the chain walk.
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  553  		 */
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  554  		if (top_waiter != task_top_pi_waiter(task)) {
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  555  			if (!detect_deadlock)
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  556  				goto out_unlock_pi;
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  557  			else
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  558  				requeue = false;
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  559  		}
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  560  	}
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  561  
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  562  	/*
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  563  	 * If the waiter priority is the same as the task priority
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  564  	 * then there is no further priority adjustment necessary.  If
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  565  	 * deadlock detection is off, we stop the chain walk. If its
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  566  	 * enabled we continue, but stop the requeueing in the chain
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  567  	 * walk.
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  568  	 */
19830e552 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  569  	if (rt_mutex_waiter_equal(waiter, task_to_waiter(task))) {
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  570  		if (!detect_deadlock)
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  571  			goto out_unlock_pi;
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  572  		else
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  573  			requeue = false;
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  574  	}
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  575  
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  576  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  577  	 * [4] Get the next lock
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  578  	 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  579  	lock = waiter->lock;
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  580  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  581  	 * [5] We need to trylock here as we are holding task->pi_lock,
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  582  	 * which is the reverse lock order versus the other rtmutex
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  583  	 * operations.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  584  	 */
d209d74d5 kernel/rtmutex.c         Thomas Gleixner   2009-11-17  585  	if (!raw_spin_trylock(&lock->wait_lock)) {
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  586  		raw_spin_unlock_irq(&task->pi_lock);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  587  		cpu_relax();
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  588  		goto retry;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  589  	}
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  590  
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  591  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  592  	 * [6] check_exit_conditions_2() protected by task->pi_lock and
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  593  	 * lock->wait_lock.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  594  	 *
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  595  	 * Deadlock detection. If the lock is the same as the original
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  596  	 * lock which caused us to walk the lock chain or if the
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  597  	 * current lock is owned by the task which initiated the chain
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  598  	 * walk, we detected a deadlock.
397335f00 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  599  	 */
95e02ca9b kernel/rtmutex.c         Thomas Gleixner   2006-06-27  600  	if (lock == orig_lock || rt_mutex_owner(lock) == top_task) {
8930ed80f kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  601  		debug_rt_mutex_deadlock(chwalk, orig_waiter, lock);
d209d74d5 kernel/rtmutex.c         Thomas Gleixner   2009-11-17  602  		raw_spin_unlock(&lock->wait_lock);
3d5c9340d kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  603  		ret = -EDEADLK;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  604  		goto out_unlock_pi;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  605  	}
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  606  
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  607  	/*
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  608  	 * If we just follow the lock chain for deadlock detection, no
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  609  	 * need to do all the requeue operations. To avoid a truckload
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  610  	 * of conditionals around the various places below, just do the
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  611  	 * minimum chain walk checks.
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  612  	 */
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  613  	if (!requeue) {
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  614  		/*
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  615  		 * No requeue[7] here. Just release @task [8]
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  616  		 */
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  617  		raw_spin_unlock(&task->pi_lock);
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  618  		put_task_struct(task);
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  619  
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  620  		/*
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  621  		 * [9] check_exit_conditions_3 protected by lock->wait_lock.
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  622  		 * If there is no owner of the lock, end of chain.
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  623  		 */
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  624  		if (!rt_mutex_owner(lock)) {
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  625  			raw_spin_unlock_irq(&lock->wait_lock);
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  626  			return 0;
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  627  		}
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  628  
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  629  		/* [10] Grab the next task, i.e. owner of @lock */
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  630  		task = rt_mutex_owner(lock);
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  631  		get_task_struct(task);
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  632  		raw_spin_lock(&task->pi_lock);
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  633  
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  634  		/*
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  635  		 * No requeue [11] here. We just do deadlock detection.
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  636  		 *
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  637  		 * [12] Store whether owner is blocked
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  638  		 * itself. Decision is made after dropping the locks
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  639  		 */
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  640  		next_lock = task_blocked_on_lock(task);
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  641  		/*
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  642  		 * Get the top waiter for the next iteration
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  643  		 */
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  644  		top_waiter = rt_mutex_top_waiter(lock);
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  645  
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  646  		/* [13] Drop locks */
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  647  		raw_spin_unlock(&task->pi_lock);
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  648  		raw_spin_unlock_irq(&lock->wait_lock);
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  649  
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  650  		/* If owner is not blocked, end of chain. */
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  651  		if (!next_lock)
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  652  			goto out_put_task;
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  653  		goto again;
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  654  	}
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  655  
67792e2ca kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  656  	/*
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  657  	 * Store the current top waiter before doing the requeue
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  658  	 * operation on @lock. We need it for the boost/deboost
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  659  	 * decision below.
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  660  	 */
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  661  	prerequeue_top_waiter = rt_mutex_top_waiter(lock);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  662  
9f40a51a3 kernel/locking/rtmutex.c Davidlohr Bueso   2015-05-19  663  	/* [7] Requeue the waiter in the lock waiter tree. */
fb00aca47 kernel/locking/rtmutex.c Peter Zijlstra    2013-11-07  664  	rt_mutex_dequeue(lock, waiter);
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  665  
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  666  	/*
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  667  	 * Update the waiter prio fields now that we're dequeued.
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  668  	 *
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  669  	 * These values can have changed through either:
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  670  	 *
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  671  	 *   sys_sched_set_scheduler() / sys_sched_setattr()
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  672  	 *
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  673  	 * or
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  674  	 *
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  675  	 *   DL CBS enforcement advancing the effective deadline.
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  676  	 *
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  677  	 * Even though pi_waiters also uses these fields, and that tree is only
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  678  	 * updated in [11], we can do this here, since we hold [L], which
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  679  	 * serializes all pi_waiters access and rb_erase() does not care about
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  680  	 * the values of the node being removed.
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  681  	 */
2d3d891d3 kernel/locking/rtmutex.c Dario Faggioli    2013-11-07  682  	waiter->prio = task->prio;
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  683  	waiter->deadline = task->dl.deadline;
e0aad5b44 kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  684  
fb00aca47 kernel/locking/rtmutex.c Peter Zijlstra    2013-11-07  685  	rt_mutex_enqueue(lock, waiter);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  686  
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  687  	/* [8] Release the task */
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  688  	raw_spin_unlock(&task->pi_lock);
2ffa5a5cd kernel/locking/rtmutex.c Thomas Gleixner   2014-06-07  689  	put_task_struct(task);
2ffa5a5cd kernel/locking/rtmutex.c Thomas Gleixner   2014-06-07  690  
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  691  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  692  	 * [9] check_exit_conditions_3 protected by lock->wait_lock.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  693  	 *
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  694  	 * We must abort the chain walk if there is no lock owner even
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  695  	 * in the dead lock detection case, as we have nothing to
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  696  	 * follow here. This is the end of the chain we are walking.
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  697  	 */
8161239a8 kernel/rtmutex.c         Lai Jiangshan     2011-01-14  698  	if (!rt_mutex_owner(lock)) {
8161239a8 kernel/rtmutex.c         Lai Jiangshan     2011-01-14  699  		/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  700  		 * If the requeue [7] above changed the top waiter,
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  701  		 * then we need to wake the new top waiter up to try
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  702  		 * to get the lock.
8161239a8 kernel/rtmutex.c         Lai Jiangshan     2011-01-14  703  		 */
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  704  		if (prerequeue_top_waiter != rt_mutex_top_waiter(lock))
8161239a8 kernel/rtmutex.c         Lai Jiangshan     2011-01-14  705  			wake_up_process(rt_mutex_top_waiter(lock)->task);
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  706  		raw_spin_unlock_irq(&lock->wait_lock);
2ffa5a5cd kernel/locking/rtmutex.c Thomas Gleixner   2014-06-07  707  		return 0;
8161239a8 kernel/rtmutex.c         Lai Jiangshan     2011-01-14  708  	}
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  709  
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  710  	/* [10] Grab the next task, i.e. the owner of @lock */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  711  	task = rt_mutex_owner(lock);
db630637b kernel/rtmutex.c         Steven Rostedt    2006-09-29  712  	get_task_struct(task);
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  713  	raw_spin_lock(&task->pi_lock);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  714  
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  715  	/* [11] requeue the pi waiters if necessary */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  716  	if (waiter == rt_mutex_top_waiter(lock)) {
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  717  		/*
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  718  		 * The waiter became the new top (highest priority)
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  719  		 * waiter on the lock. Replace the previous top waiter
9f40a51a3 kernel/locking/rtmutex.c Davidlohr Bueso   2015-05-19  720  		 * in the owner tasks pi waiters tree with this waiter
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  721  		 * and adjust the priority of the owner.
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  722  		 */
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  723  		rt_mutex_dequeue_pi(task, prerequeue_top_waiter);
fb00aca47 kernel/locking/rtmutex.c Peter Zijlstra    2013-11-07  724  		rt_mutex_enqueue_pi(task, waiter);
acd58620e kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  725  		rt_mutex_adjust_prio(task);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  726  
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  727  	} else if (prerequeue_top_waiter == waiter) {
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  728  		/*
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  729  		 * The waiter was the top waiter on the lock, but is
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  730  		 * no longer the top prority waiter. Replace waiter in
9f40a51a3 kernel/locking/rtmutex.c Davidlohr Bueso   2015-05-19  731  		 * the owner tasks pi waiters tree with the new top
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  732  		 * (highest priority) waiter and adjust the priority
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  733  		 * of the owner.
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  734  		 * The new top waiter is stored in @waiter so that
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  735  		 * @waiter == @top_waiter evaluates to true below and
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  736  		 * we continue to deboost the rest of the chain.
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  737  		 */
fb00aca47 kernel/locking/rtmutex.c Peter Zijlstra    2013-11-07  738  		rt_mutex_dequeue_pi(task, waiter);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  739  		waiter = rt_mutex_top_waiter(lock);
fb00aca47 kernel/locking/rtmutex.c Peter Zijlstra    2013-11-07  740  		rt_mutex_enqueue_pi(task, waiter);
acd58620e kernel/locking/rtmutex.c Peter Zijlstra    2017-03-23  741  		rt_mutex_adjust_prio(task);
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  742  	} else {
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  743  		/*
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  744  		 * Nothing changed. No need to do any priority
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  745  		 * adjustment.
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  746  		 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  747  	}
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  748  
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  749  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  750  	 * [12] check_exit_conditions_4() protected by task->pi_lock
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  751  	 * and lock->wait_lock. The actual decisions are made after we
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  752  	 * dropped the locks.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  753  	 *
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  754  	 * Check whether the task which owns the current lock is pi
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  755  	 * blocked itself. If yes we store a pointer to the lock for
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  756  	 * the lock chain change detection above. After we dropped
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  757  	 * task->pi_lock next_lock cannot be dereferenced anymore.
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  758  	 */
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  759  	next_lock = task_blocked_on_lock(task);
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  760  	/*
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  761  	 * Store the top waiter of @lock for the end of chain walk
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  762  	 * decision below.
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  763  	 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  764  	top_waiter = rt_mutex_top_waiter(lock);
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  765  
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  766  	/* [13] Drop the locks */
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  767  	raw_spin_unlock(&task->pi_lock);
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  768  	raw_spin_unlock_irq(&lock->wait_lock);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  769  
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  770  	/*
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  771  	 * Make the actual exit decisions [12], based on the stored
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  772  	 * values.
3eb65aead kernel/locking/rtmutex.c Thomas Gleixner   2014-06-09  773  	 *
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  774  	 * We reached the end of the lock chain. Stop right here. No
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  775  	 * point to go back just to figure that out.
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  776  	 */
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  777  	if (!next_lock)
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  778  		goto out_put_task;
820849843 kernel/locking/rtmutex.c Thomas Gleixner   2014-06-05  779  
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  780  	/*
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  781  	 * If the current waiter is not the top waiter on the lock,
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  782  	 * then we can stop the chain walk here if we are not in full
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  783  	 * deadlock detection mode.
a57594a13 kernel/locking/rtmutex.c Thomas Gleixner   2014-05-22  784  	 */
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  785  	if (!detect_deadlock && waiter != top_waiter)
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  786  		goto out_put_task;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  787  
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  788  	goto again;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  789  
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  790   out_unlock_pi:
b4abf9104 kernel/locking/rtmutex.c Thomas Gleixner   2016-01-13  791  	raw_spin_unlock_irq(&task->pi_lock);
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  792   out_put_task:
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  793  	put_task_struct(task);
36c8b5868 kernel/rtmutex.c         Ingo Molnar       2006-07-03  794  
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  795  	return ret;
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  796  }
23f78d4a0 kernel/rtmutex.c         Ingo Molnar       2006-06-27  797  

:::::: The code at line 481 was first introduced by commit
:::::: 23f78d4a03c53cbd75d87a795378ea540aa08c86 [PATCH] pi-futex: rt mutex core

:::::: TO: Ingo Molnar <mingo@elte.hu>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--azLHFNyN32YCQGCU
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICA3faVsAAy5jb25maWcAlFzbc9w2r3/vX7HjvrTzTVrbSZP0nPEDJVG77OrCitTamxeN
a29STxM7n+206X9/AFAXkoK2PZ1OmyXAOwH8cFG+/ebblfjy/PDp+vnu5vrjx79XHw73h8fr
58Pt6v3dx8P/rrJ6VdV2JTNlfwDm4u7+y9cfv7593b1+tXr1w9nbH05fPN78tNoeHu8PH1fp
w/37uw9fYIC7h/tvvv0G/v0WGj99hrEe/2f14ebmxZvVd9nht7vr+9WbH15C77PX37s/AW9a
V7law9CJshd/Dz+vaLbg9/RDVcY2bWpVXXWZTOtMNhOxbq1ubZfXTSnsxcnh4/vXr17A4l+8
fnUy8Igm3UDP3P28OLl+vPkdN/jjDe3lqd9sd3t471rGnkWdbjOpO9NqXTfego0V6dY2IpVz
Wlm20w+auyyF7poq62DTpitVdXH+9hiDuLp4ec4zpHWphZ0GWhgnYIPhzl4PfGtZyUalXdKu
p1V6jV0jC2HVTna6VpWVjZmzbS6lWm+8LTeXRpbdVbpZiyzrRLGuG2U35bxnKgqVNMJKuI9C
7KNz2gjTpbqlJVxxNJFuZFeoCk5dvZMMR64KWHKn17qpvfVtBOzHSNvqTgMZ5xCNFBNDJWU2
kmSZwK9cNcZ26aattgt8Wqwlz+bWoxLZVILera6NUUkRL9m0Rku4rgXypahst2lhFl1mndnA
mjkOOlxREKctkonlXQ0nlZXi5bnXrQU5p86ztdA7Nl2trSrheDOQPDhrVa2XODOJDwaPQRQg
KrE8d6bUS11buKBEem8rV1edFE2xh99dKb23k+0rUcLb0Zu9UfCA4EEb76z12go4uq6QO1mY
i1dDe5p2ynTr1FsW/Oh28KLhRi7enL48PR15C1GtR9LUXPeqp/alQDW/dpd14y0haVWRwaHJ
Tl65xZhAI9gNPDY8zryG/3TWrZ8055qU8cfV0+H5y+dJP8Kx205WOzg10EJwHRY1AijaYWGl
VjCNlcau7p5W9w/POIKntkQx7ObkhGuGd2DrSEC28Fxl0a3fKc1TEqCc86TiXSl4ytW7pR4L
8xfv0BKMe/VW5W81ptPajjHgCo/Rr94xJxmsdT7iK6YLGBrRFiC3tbHwcOXFyXf3D/eH70+m
/mZvdkqn7GpAFYAklL+2spUsQ9qAskAJqZt9JywYog3L1xoJupZZIGmA6OhJOIkAa4NXUkQK
g28F9WMDPUKNtpFyeN4gK6unL789/f30fPg0Pe/BHKAokSKYWwokmU19yVNknsuUrJTI80gh
DHyoWUF5IT8/SKnWDalnnpxufDnAlqwuhaq4NlD2oILhEPcLUwnbwLWSmhSgTniuRhrZ7JzF
KAHnhDMBxklBKTtlEmhlo0Vj5PJGSU/nngpLEdiYuoUB3R1mdazkfZZMWMF33oE9z9CcFwKt
4D4tmKskzbibPaERE+B4oLwry0ANj9glTS2yFCY6zgawqBPZLy3LV9Zoe3DJwxO1d58Oj0/c
K7Uq3XZgQuEZ+vLyDgGAqjOV+jqhqpGisoKXWkfO26JgJJKI3gwArvAt0MGR5XEgW7c/2uun
P1bPsOLV9f3t6un5+vlpdX1z8/Dl/vnu/kO0dII5aVq3lXXPZVzNTjU2IuMRMUvD50P3Fww0
2D2TofimEhQS0O0ypdu99MwhiCsAaP+6sclBwmggIlwxbapml4SbUqYuBrmmk2vSdmXm96tB
UZXadkD2Dwd+gh2HO+ZMq3HMw0pghLgJN9cFTTgg7Lco0G6XvrpBCkFKI9dpUij/yRKoAARf
nXsIRm17J2bWQsc9NRc1jpCDClW5vTg/9dvxjMAp8Ohn59OZAOjfdkbkMhrj7GVgMVqARg7q
ACbPnAAugb2qLUWXCABZ6RxNEoRNUAnBMG2FHgyA2C4vWrMIUWGNZ+dvA/ELpmAuLl03dau9
J0fonR4Q+ZPjSGBZ0zVveWkIt+FjDFplZnEFXZMRUoo75fCU3slmud+E7qeuGoy8PTJXJncq
lcxs0BNl6uguZJMvj5zonBmWDA0nNTWqo57HGZPp5gAjgQEDVcGuxj0vRKvUnefZmxy9ERBo
sK4Ll4NO5Z5ZW1Kg5tkR5G4yP+wAv0UJAztb5wHpJhtA8jR6dgSBAnERfQItRJ5hr5pZMRG8
aAl4NYPPhiCBbg7jIVV09REbutDcXYGdtj7SqwCNqArgiCc8TgWo7MyL07iOoDpTqQnCUHwk
6qNTo7ewRFDQuEZP3dGD6n849esvnuZiVlsC1FYgBYEIG5AUxIRdjzn4XeLNjpjEf0u4i+We
+UZUmQ9zHGIfbXWgSOPfXVUqX8V7ylAWOagj38Ofn9W4ykQA3ltAE3lrpRc9oZ+gk7yZdO3j
MKPWlShy7+nTXvwGQlZ+g9kELrpQni8nsp2C1fUn6B0JdElE06jwskC+0y3FmhDzADbmHuUW
R9qX3mBDSxdgyqk1ARAAO0dhAGXHcNARDsGu4B1yzwKfGPl1eca5VEP8adoiDFKl0YUCSPcQ
uouehG0UespkFksNTN7FEFmnZ6evBojTR2f14fH9w+On6/ubw0r+ebgHeCgAKKYIEAHletgn
GHHcZh/RQSLsuNuV5LGw6mlXuv6DDeXV9xCIbLacEBYisGemaBNewRf1EkEkcOjNWg5+9zIb
WliEWF0DAlyXzHoAQuWqCCAK6TB6nd7J145RXnyaphja+kMhvaQLecVMQ1c6jjEbFXWEE0Hv
1cbhsl/aUoPTlchQeQGqBi9nK/eg20ChLMSHwAzE483icbRIcLNVqnA/LagI0BNoilNE9REy
w8eCgBXAOGD/S+E5zttGzmcDaQLZs21TgfNjVa78zdLUCiQHsSATyJ0dhmtl5ulPmm/vhwEP
r8s5U5W3lUs6yKYBc6mqX2QaRguILdDoUzCFRtzU9TYiAvrDuKJV67ZuGYfXwL2iF9n7+dE5
U4wbILDK9wMsmTMAJuzjQ+zCXDDSBTa7y42yMnQ8RlRuxtAreVyuRzRkI9egbKvMZUT6x9EJ
HZ9JqOaoKS3is9lcgqKQwlmDiFaqK3h8E9nQ1DEi+ed35Sk+5uo2osnQkyEsayVGfqkHNwgz
/6A4m/44sraMQ6l0uoH0BscEDqFzq3IXRQvv1j03552lpcaES3yortXFehdoWd0u5Bp6ba10
2rmQ0hBEZnjrIvP4uV0amSJDn5TxwMNCuy7aNYbSamPT9OLkw3/+cxIMiuF7xxPYLK95SdnS
baAmoRsNkDMJTECGl1MFwDkkL83hTkbZDWzB3X7eoGsTXwLIvryypB+2gakh8kJkJlaOx6Iy
gQ6qMDYo+zQSurz/lq/TbYxC3CPEdBTgAvZdmzq3XQZbiDVPWWc9h5YpiKX3XoDUFqCG0YQg
BkZIxmxXXimLqpriwni8jOKj7mTcg+zgtL4gzxrbOpyAVbphryl1y4zr5V2XBvFZmKF6MrEj
RJ2/H70fdLgtYqp7eH1UNhBcZQRY6Eg1owwD/O/TkF6Irl9FTxeR3eupL88TPDJ4h9xZ4xuJ
b4prm8yWBftnh+RKc+n5MEdIcXf3nNjuHGns3mB9QOubnaGF/KwBZ6/Tevfit+unw+3qDwe5
Pz8+vL/7GERfkalfLDMTUQesF7kZMY1RNsTi6h26V90bb72IOkG3+E+GnByDKP7iLBI4f9r+
ZCjDAKZD8BGUnqutjnH0FoP3BvoRTJOOachwjzNOxYfiejI+RHAa+cng0ktYLOiVrNuiy8eF
D3rlQ4HcAtBaG0R1EsQCrKPgIscDxvCF3VRnHtCtKIcOG9FgFvDklqOkwtaItZrSy3nRhbrO
cFj1ZeXbS1d1sUDEmZZoI2SnLGNGbJTUmViWKXHn5pLvOmufJHXwjLtE5vg/RExhvsvjJVe8
u2yE1pIx3aJizDuJqn58uDk8PT08rp7//uwSJu8P189fHg+eHzyUSHjKwodsWMiQSwGAUrpA
pf86kHh1Dgo1ZZ4IEktNKMoD+aBQc+XHtdFpqfGF+ANj3Q2ouYzz3XBcwA+grrEShQkNIcMO
NsHKBBKHRSwyuOlLxcv4xFHoBclDFlFOy+vj0Cyvqk3elYk6EvwFsbAOTA01SRwG28Pz2CkD
+G3dSt+fgTsQCKv8Qxra5hHrOcsoA/xe2bTZdleOy5jKBnZlH2DJ+bHGKSNsx2mggXVIvIyD
/CJUsalRQGkBfLoxqWvrIniTSt2+5VWtNnwAqEQR5gPeJeoyznYNaVg/Ijc8qAZjzH2Nl0s5
vfZZirNlmjVR8VHv6kQ1hZj+3YUtpapU2ZYEuXPwdYv9xetXPgNdWGqL0gRRyz65iWF0WciU
O2YcEpS7ExZPcfXNICDzxhQguGh9n1VLGweDqE2WbYGJ98Z6W8/IoZ3QhIAHouqybPnYnCiA
Y3+EoxRXkSYZnhBVwBlE22tU42usaeSJoKkufjqbEftwnXfaPQVbIgVgSjYVS7TS2/7QgsH2
OrytwV5XvBYaGHZ1ASIHh7Js9D3F0neKcCM9VnS/EWtH7xKz1josHMDmRjY1BqsxLZM09VZW
JKHo7Cxr2DLUqM7mefHfTw/3d88PjwEy9aMfTom3VZR0mHGA5S2O0VOMOgb2y+chO1Bfsjob
d3H2elYJLI3O1VUsu0MBSf/yQ+fmbaACAUaBeII2WT47s7QeeIIq8wO72PgTFRf+Q+AfXnra
7P0HgnsPCeOoEakTrpop2XNx7Bh5QUcuOIo58HDysKWvyhSpVhGFsntYRgRQ0W5k00XpPsqu
S7+uue8RquLew0fM4/YmmJLXkTxogIhO6nSob0NU6D0+VRRyDYLVwwB0dFt5cfr19nB9e+r9
M0Wajgw2raQUVSs4irdfrNIYgvrx8bgQh5sE/RHpqwPvPK7AzfCd5Ym0g//ghcZHNnFQIqZz
q9WdrdcSLyoIU8WjLUWqMEkVOiJBM+2um0d4BuO9buOq3kyBZDYZM3B/KH5Fjl9ogbRNbTF6
xyl4XQDw05YWRabhVTCtO6yBDfWMDWenOEUUu2CK/vzBxvAXw4cFyJ3Isqaz8QcMDrXVGGHx
pipbJgq9NX5tc18sSpfvCtey5uLV6c+vfT92Hp1b0g4ubG83uuuTMJOxL6SoCEBxUCUqSQFp
XyrlGGlBPSE0YkG9uXgzOla6rgvQo8PPxA8nvnuZgxPiUY1LNE4tQ1U3nIuOitcGZsp2HQGZ
VE0+5JGCI5dNI8cMCN02Fnt4agbzL9Q+j9KOGt95jkOBTU91XsouCjO7HHQ31LxN+AwLacAC
bErB5kfHubSVLnLqaymyVpg87xJwotChblodCxkyIZRAf6EcRG5idQMsmEJXjopxkcsAlJW2
4awnrdaFX8NFmuD8J/+xLcMaGs/31FeLprvnGLQtOf24E0x6sp1krjjl4pIQ/vybd93Z6Sk7
BpDOf1okvQx7BcOdelr03cWZb5wIrW4arNUM3ER5JXmPiyiYNmFluBFmE2Wcxk8m4OmBA3z6
9Sy0j42keuTQ5owRdIoehhdHZpB6GWYWShHDLOfBJEMSsb+yQuwB63LTxTnLmDJNpEFNolSe
fh1n6c1I71pOEbzx7XsM3G05x9xnCjSii3jvMsMVZCEoSfcxQg0gccyy6ImkZUYBQ1g4BzgB
w2Dut8hsNyuoJitdAIzUUVn+oEbw4yxUa3FQrrd9oUH2gphmKKNxQJDwgcrGONvDX4fHFfgc
1x8Onw73zxRpQ5C5eviMHwk+uerl/tG7VAPnXnlaQ/eBksCpKLGyCIvaskXjBDwuqzz2uvzV
eR9eKcMRgJ36yRHCyf29kYiYKULsn16J38L1iQ/sorM0GgRuygIscwshb8l4nw1OPgHy0tbW
rLvkxtJp00US61aq1Xw0DFPkZtEBI55G7rp6BzZRZdL/Ei0cCRRPb/aXxhHxthNhAaTv49bW
2tBGUfMOZudki4i5mHfI+NA80Sia00i4+6BSZTgRF7gZ/VaerLLZEadapyBgyVKf2RqVLjnb
Q7QFhRWtQqzXDTxBPu9MvOgGlD4uYPw7t/rW2BoEy4DuoMqjk5O5hqARSRu0GgBwFh9BTGMe
L6vW3LZShaVcS6JHuXGhwlSFf1SqjoMnTiQS3vC7vgvlwP6RlOBL1UfYAC22qHawOuQScG5X
VwUXIZp0gNByVhU0tPdlJ+EUSGAXkGmbz+XX04oKy3rhjQAGOrJR+jMru2jWQW9GMUaTq4vp
u5NV/nj475fD/c3fq6eb6zDZOchaGMwk6VvXO/xCDWOkdoE8fhHhF7U7cgzv5xyD94QDeUXP
/49OeK4Gbuffd8FcFZWr//sudZWBC1ItfDPA9QBa/yXYjoV6XB+Ck61VxcJJh1XhLMdwGpMb
FtDHrfvhsYCD2yl/69P+FibztzM+w/fxM1zdPt79GRS2Ti6CnsUl6amnlH7AeZZzV70NOcoE
OEZmYNdd0L5RFWe9aMZXLkkD0A32Snt5+v368XDr4SN2XLQ0n6bNq9uPh1DsehMV3AX5rniA
BaA9/nsSn6uUVWB+3NHFn7HRGpIvT8OKV9+BKl8dnm9++N6LLaeeykNVn6lG+gWD2FaW7kfE
SR9RBqET/ANmZM5ONwEKBO60Ss5PC0xAq9Bt9rkkoqukXUi04UoMZ5qRQuOaeNYjmUI0a7bl
vrVFEt59gVWR486DnqreLY6qG94oEE0YxeJonDIuDB4sKF7bLGcAbTcP98+PDx8/ApCfJMq9
vOvbA2YTgOvgseEHk58/Pzw+D3zZ4enuw/0lvGsaMH2AP5iQBdvl/e3nh7v75+DZYI5oqPkM
9ji0s/Yr5NT57Gv4cdKnv+6eb37nNxne4iX8q8B5sgseeF9FtUjD6l7AKBzAwXB84j97DJn6
v8tUCV+zuhYqx+lSxX7lBSO4iGO/1Rc314+3q98e724/HILN7TGvyB9e9vrN+c/8ht6en/68
8EUTbDJTSxoPP65JhlXJr4ebL8/Xv3080N83s6L81PPT6seV/PTl43WkARNV5aXFSr4ojGtZ
EvwI01dUVoJBkNE2YlHgRgJa9at0+rFM2ig/YdM3l8p4oUgcMgyrKPHyPEhDTUeGFFG3S5Ub
V/5fxTGW0cVNMxbMC7aYusEASynjbCN+voYvr/a/b6zkfBxoK1S1Ba1vTBgHAAro/nXjSvvp
4qrD818Pj3+glZ0ZKkABWxnUWOBv0PjCjxtU6ir8NTBMse2ChaS5/2UY/qK/UyZqir/6okbT
Jh0W1KQcPicOF9iX0WD05YSxyo9rEUHpPkzoHdRW7n1B7ZuGkflKlpItEso0fRsp/XJRFdyc
0i7tFH73Dq1jMIRSx8FJKKytTrAATrqgMzP1MC6ms1x0Ixjd5aMdh7AbhraTTVL78cGRkhbC
GJUFFF3p+HeXbVIdLRubKWTHrxjJjWii61A6jCO7tjUqAhBS7gscx9HZtgpKNPFM+i1EH2qP
lGi9pX9O40kuLF6Vpux2Z/GWXfM508nsK1hJvVUzSdU7qyYNhU1tNt8Ptud1O2uY9h6gHHx4
neDrwogmDXsvbkWhmFAjCdDskJEyNoYTOAHF8KJLetXsN/gxKzfBRE4kiNOngBiqKbegVHPN
eKrUHA7QiEuuGZvgzRnb1F7UC4eGP65HiQ0U4EBMFKcgRnLaJn4tydh+CbNd1jU/5gb+dGzQ
jbGpZgbd7BO/Bn9s38m1MEx7tfPV4diM4WmUh2NLKPR0ht48Vc1uaC/D5xnTVQHmrVaGXU6W
/sNxpNma2VySNP5wA6ygC+EjNsNfAISnyGYaHH04zVlH3P7RkYdLP8oEuzlKbyTrsQ7kYf8X
J38ePlw/nYQHWmY/RaXZo0LbvfakAn719gkLI3JfoQ4U+muxIoL7Th3NcZeJLJRJcM83odxR
xZB/R2NjV+d5XKwe8PRqy++L85dKcx+bE00VIp7e13MRiW9l9NwRln8Yoldw0e4nOp1y/+U/
AdalnQU2hVqMsrOzgbbu/yh7suXWcR1/xU9T3Q9dHa+xp6ofqM3SibaI8nZeVO7EPSd1s1WS
c+/03w9AShZBgXbPw1kMgBR3AiCWRcUOKaJzNAZRT0T1oQyteR10BYF4Qw0gPOmQY7HatvHQ
kp+/gLE8c4efwZducUp/4crWzQjXiybdMZfcGRtngj89kEVH6Z3nWjDuHD5do8EAvdbLumwZ
r+hAMKpIGR+Uhhe4wawk9gxAcfbDMxvRRlLs7qyBXK0EfBARQKb7AoHaDgs6qKgXLgaoViq5
gMJQNAYaAyXkubLNIFAV3Mbi3FowVARSksEyGXUYA9qPgInXr2jcjJhUUV066k8q31k3NEyZ
bzg8Zmg7E9YWF0jOoh1hCq1BXKcb4GxrMja5qEmjcyUlhiQEQQu2+4cw7JkNA2m5U/yZ3XCy
xn1D9+dtrZbYXmkNPkcPby9/Pr2eHkcvb48/n6liwyzc2GY0pJav48f/nL4+ubWJ7piiWodK
z5Rzq4EhhVV1pTPW4DJ15BinpLxCE9HFz5CcR/xiRV2/Xi73C673jPp1kGF8OX49/Lg4BzWG
EgyCCs//ayOkqc3dfKlWp2DP0A6U/yDzyJAVJ8pmK+k1BwB1Vruoz9YJBAirV7t1jidt9MNy
K0dfH8fXT1SDoqfg19vD2/Po+e34OPrz+Hx8fUDtSq9JJdWhbVPR1AMZ+YwC4cTZQE0hYsUa
/c3hnAgRuz4ofSqY9538hDWBe/PD7kRVmVc4QnZDUOoPh3+XOjSwChtxrKtGFdtoUL+X+hys
Gn424OQLjZKxXUcWDyuQIc8aIS6/795z1KDJ2D1uMu6X09Iok10ok+kySR6Ee7oGj+/vz08P
6m4e/Tg9vw/LksO9bW2kzvC2lv/+B5d9hNJDJRSfM3PdhRpl3gxaA6YwrjsQI3jsDwMS48Po
aDOsGq9+UTluTUSqMuZNV4UY5mMIV7cd6RaMEsCTktGe4dOVFdxAQ88H9jfrgtTo3PHirbGZ
yNesNK3Rldj10/Xvxf93whbuCaOofroovJ+jhTUL7eQsXLPbjzl34vYztaDbbWGOP1u3VyXB
OkSy0HPyH145ZIA7WLPJHAdC4Pu2ugtBnRJJv4kBYOT7SfDpmoG2ogaJJkObNxM9HZy8qvo2
8FN8fPiXNssYFHYZy+GF6NdE+MXfTeCtm8L75ue801XdP61o3aSSZVAjYLbcSSdjMeY15K4S
tqmkSX+tBZe+bE6d/rjW6PWPXIHDsdyK3dyCRU38KeEnCGQsx46oVOSG6QNCsrIwTbYA4lWT
xXLGwWDy7AMmnZhHOP462+kbfVLw7ZQbT7O43jj27yZZZ7Bo8qKwbfJb/BZ61Z58vNuqDmGD
e0WS6Psa8GIBWuvLASEco/hJP3NjUN2EhqY8BTRzNb2Z8sisvuMRcB4mqTnkJvLeNzqkxmF5
Mxnfm4PUQ5v1tuIdtA2azEUThH7OcrJpSuRM+MmpKEQtzMhL+HgoyjINW7BxfgQsg7mfkH2W
ipK1fIiL3FS8L9JiV4rcXIst6IJdaUeRx/6gJgQqZTtXJeLwYsO30sv1NnFR8nXbF46Jywov
SZOak0VMMtQr4U5x1GIx8AOaNdBgrKA4qLCZFz621rUNO4KIxM/IXc1V3w7kBQoczssUWrnW
80dhGOJKnhOmrIc2edr+R4X7THCuBB8NxCikuY9rVG3zmBGDm+DcKGMbK3Oz7t6+/3n6eYLb
9HepWW3rYm3pG9+759iVFhvXJLbhGRw53Ok7AjjkL9RqezZ3cKW75I3VOpKKlUw6LFpsvAwL
yehSH+vw3npuVFAvGgwuDJbk6l9fblUgh5pOhMO/YTb8SFBVQ9rsvh00u0VxcRdyY3l/sc8+
9SLtwNG9GzNsaBwzQ1Qm4bC0csVgBo7xYtBr9Pn4+fn0VyvtEW0XsCPWOzIA0MnHfFnswLWv
5cgXG6F2+cweN8REO8ewIXIznRgmNRpghdbroIz2TX9ZbllJzkAvhu2N0H3tZVib744nfR6a
kouAbVZscwMIV/on4pij3s4z6pTTw9qAWGZ+FwPp8/EXeoLcO5inroHRQ85VmoUOazCDBqPU
XaMB4eviAAo2MEaHTWz2TO2WJCIHXOBz3EWQY8QuWWA6G7OPHpyeAr1oeZvKAljCrbbwYyrd
DkxxOoj12I/evknB0VMEY93e6eKxQu52Ku0tipBmLYv+6wrCcBYKDjOiXp0cw55LorKK2TAI
airUIOGTCWlNOsVkKygYD1C5Lw3738o0RasilQXCPBz3Jr6NDK+esaz7zUC1ZkWOBleYz0Ae
Ghrb2rsn728Y3Plbwq9ZFfi5rkKR6diXrpHBbd+mZKKGcqOv0yfNwqE6dFfr+I1kcwRVUQIT
mSeWY08/MyKrhGVh2Q8Ky9l4piEjhlwOg4pAqgjXIxmPDtjULC+L1eQhURG0IIyyogU9d7FW
a8xoV2Ays5o/ewEXJ6zcgRhJOmQ6aMFPRsRQRGw2Bq8+R0gmlXTAJvSDmMeQCGFebbjDazv5
55+nr7e3rx+jx9O/nx5OnLEx9sVPvFq6plgTbARrAKWRQZ2ODQm9rXHqD2DpJlS2xi929dvY
50yVAZlV25TUg4AGW2voLCLYdFXpDyFadDJ1IWeECqLcpIVk3Qg7soEirNrfsVYcUOLONxhB
soF7MFpDVhuipd0lVZiSB+kOgvKMAUXphtoYKxBNt9KCki05u6I1ihrjIY/WIV5Pp8fP0dfb
6M/T6PSKD2yPaB89aoWUcX+UdBBkFtBTL1YZXFQWxJu+A5jq8YX8bP2aVfyaP5bGgEZ3CZ+L
CE6nFX2ShN/tzTYAq2QmFo+xYlSOxtGVsFlFwjJu/V160haGqhw4npwBKToydFMmfIGhviev
1LC+knUCsiZVU/twhXHbATGwUWgNMg6UsqW9AI4fo+jp9IyR9l9efr52by2/AOmv7TFgvjxD
BXUV3a5ub4RVbZJRQJnPZzMG1CQT324+IKZTRDg6ocIiqfi2LyyYq1PWkzH8K+xqLaLVPI5Y
dCkF8CWOd+AmiYxtxRnMdDAHKx5g0jGMadLXAvwCLInUZqOAXaHmEZk46BVjIyKRpMV2EDc8
bHmHs25fn+0B9ZZR6RyfHlrwqBg6wG90foA4TEv27oT21FkZWYaBGgYcwyZ3ZDioRR6IlFeV
wwZSH42SKlP+qyq3VNeT6Onj5T/ot4PP0ubLYLRTzifmUGAII3Gux/AgPtPq8Oe6e2YfWAIY
7DT1BOvIrYKMo3LS8L/oL5QUuTAT69CU4uEXwLnscJ9tCcJt5XhB0gTq2tfVwPGSFQ6HUUUm
VHjTllilGGA6ZwRCVLmNHEkQEb3dpJjeVekbiSF4Fa5JYBX9u93EFCbNuAYtbDcegLLM1JN0
9ZlZBdHLROWhDTAzWGQuDURFYe6H57w//SBizgOa/+jsUTg4HOGf3I6fA3ftIP1JVgfkhxp9
omNCILRURdIDjoB1g0CaLuSGoqF1iuq2BbcP9+Xx4+tJne3vx49PY+dv4Mco0wZKKudKjXYf
2r9plB7/thhArLwoSleT8JsJ2mpi1DElcHW7tRLZ71WR/R49Hz9/jB5+PL1z/KXqVsQ7DyLu
WxiEvmtxIoEOPw6C6g74zLgZ02GxsJOL2BnFQrOaZMzAJuaSUXMnMmcHKja+qJoyr42/psYj
O76/G37CirtSg3Z8wODABoNV69Dsabjvgk5ZawGjz2Q0qJYBbl2snA0uWd5CY1rPvwFM5d46
ZCRPCGLXJcaRxEhh1mrX3rtbjN/Hn3eq7lTU1tAa2PRsv9UteXl6/us39J08KiM8ILog2KgP
ZP58zj21IhLTv0Ugyce0w2dws6sS7V1EDFkpTVEPpiHz43IyvZvM2SxhQCCBlZmn9ojJ9NIq
K2P3QMEfQJIWYpihuqgx3hIy5iqMG8XCQS7b5OXjSWvXEzx9/uu34vU3H5flgK0w+1/4a+PN
0tOWc3DlZH+MZ0No/cfMOm/yMHeFIUC8jVStS0tYCqP/0v9ORrAwRy+nl7ePv4eu92r5IBmd
tnuV97q74ejoY6QSNrQJYjdeQhcJAJpdqrIfyBgDyFkjrAi80GvVM33Wyw4XwVFK7swOgaax
6mu9qpDjN+14PzpPSkmSfXcA05NXgxpXyucWLfbL5e2Kt5LpaGDVcBZQxL1O+dYpvsXw8+xC
oisLRNOTMy/bsEdalNlmoe23nT19PgzvaRHMJ3OQL8uChh3qwQ5RxKQgjAmwcdmh5Tf6Rz0v
A5aK36JlDDxiwePkGl3rfd6irE6iTHGO/DuiL1fTiZzd8IYqwOOkhcSI8BjDInElroyBdUp5
5Y4oA7kCcV6w3q+JTCerm5speTVVsAkfgQ7uO1lUsqmBaO6IUtfRePH49vYyiWrd6obNXJb5
i+nceMgJ5HixNH5vpNeqjptIitVseWOYpIi6htFqgPGY9rEQuo/rs7SfWtP735HGzJ/Qnad/
wzKCukTVTMbzm25Zh2GJHMPA0lbDG1FPDCG7B84NyUcDW4sUY2paRCb2i+XtnGlmS7Ca+vsF
U3A13e9n3KXV4oGHaparuAzlnmhHvNvxzWAN64zWp/89fo6S18+vj58vKgdgG2+kN0V+hqt8
9Aj7+ukd/2ve4DUGs7i4QNJEDtQMqgaBxobHUVSuxeivTqp8fPvPqzJ41tb7o18whsvTB3DJ
UIURPkSglligIFuSW7qL98gzs2cs/LlCUO95iq2WibcZExsjef06PY+yxIcb8OME3DyMohX4
oidBcUZf3MQMr82m4NuBIzRz5SeRoyCi2DLbonQUAQxbom9j/Pb51Re0kD5Gj6BI1T4n/dv7
OceG/ILBAXb7HAXwF7+Q2a+2ggTbPmw3yLu7e04UCf24ICwbOpeBOLZ38NM6XVRwTu4ufZl0
3Opg8yMSXeSImmIjLQ853ecwDEfj6Wo2+iWCtbuDP78aFfbFkypEPTK70DoksDzywFJkwofl
UmAcT6U/cLjL6KizREWkHshcFxqwLbzBGBoUtl8idziC8TJ2FEGfhBdKnopc8DsUsWHuxuGo
aLW9k+S7ZRNDkHmCgfx4cQfxcH7e3k7mfBwTJBCZJ4BNChwiE5LERZV8d8VXw2/wr+mqe5gk
4+bGMTFYtxslC2A0hq8HqELvj3IrXg9IE18fT3/+xJNK6rg34gMk3q/TA6a+GXLt3nxqvPTM
p4op14uCwrMApE4WgeIvh4BL3esR9AEUrTsL1qatQ2f17Xxq8A9n+Ha5DBc3ixt6MGDI/zgp
mzvJp9Omxfd7V1wIpLn3xfJu+GWZwenT2Y5exA5U6RxNxkfQUYHdczMGSBbYTy9b4I2Kqpn6
hcU1KbXB1J/f8oxvT7DkY/5sgYMK+eDL9aGMC9Z72GiRCERZhzRGowapGMRRwqZ3NitYhxWR
E8N6PB27JqsrlAof1QY+cV2SaeLzD42kaB3a4UjhuOIltZZHqeW1TmTiO3FCNVHkvoGfy/F4
jJPumDAoO+UPr3Yy88xPheNsyoJmv2aVfGaT7jcgRyUkBLy4d3iKm+Uqn+8iLuDCulFS1wGc
8lIWIlwnYzp2Tc+1dbKpior2U0Ga3Fsu2SDeRmGvKkRgbThvxu8zL9/z/fVdS6tO1kU+dVbG
b0nAuAys+kb7VqRWL+eiUigGAihzqroHjoSzvzK+4IttsiGDUsebHB96oKtNyT8LmiTb6yTe
2nEkGTTVmpt83Tr0jifPisn9xhG/zOxZHKbSMkfSoKbmF+0ZzU/kGc0vmh69ddkddi0DNpi0
yz6xmCKYNTqnaR72wF87VNYBzzAaFQb0lM9VVB/e38Us1Xr69x9KJ3wMRwlTa0dzHdaHUdjC
PVne4eRq28PvyCqwh1e0+ZbUcsPcqlG2/TZeXjlhYppRoBxfO1XijdiZsYINVLKczPd7HtXm
FOsXAP+hkGYgUD8NY1H9u4l3JP7Y2jOM+NceoC0jRgA6Nm0Ctw2n0sJLyKgUfzLVzm6uzfZe
0JQ3E4f51Ha/5i+Pb9mVT2Si2oY0KWu2tTm1vgF3ju/IuwPne2N+CL4i8oKs3Szdz5qQv8sB
N3eLeICVu4top3V21x7goOmaupPL5Yy/xhA1589AjYIv8q4cwJ5DrS753WpP0W5TU/c6WX5b
8ApMQO4nM8DyaBjt29n0yv5VX5UhjdANTLvfFH6YFp1h7JVKDhUtD7/HN46VEoUiza+0Khe1
3aYWxIs6cjldTq4cPPDfqsiLLGQPmJw/kpbT1Q1zNIp97vDJycPJnT3XdunSoZ0wm7OF65pc
XipXcWCxzcOCxR0ZNQz07roo2xiWYb620rHGwM7DQmS7cAjREiVKrrDK92mxppHr71MxtYRQ
A+dkE+9TxzKCj+3DvHGWc7rZdC3ciNQ2D74HAJr681VW2dVpqwLS52pxM7uyKqsQZSzCIQiH
pfByPF35blRd8Ed2tRwvVtcakYdSSHYHVGjaTy4hDblcoxQZ8DPEpFWqS/DqApahGVrfRBQp
yNPwh6xVGfGTBXA0tvKvyXQySWmuDemvJjdT7jWflCLSHvxcOQ5hQI1XV9YAKkmYQ0Zm/mrs
OwISh2Xiu5I3YX2r8Zjfawo5u3ZYysJHYxzTMNjE1uraIENQZ+hzfn16Nzk9asrykIUON0hc
QiGvCfXRN8KhZc2TzZVGHPKilAdqc7jzm326tjb/sGwdxpuanLEacqUULYHR9oF9EanDri5l
HR6M+rb0coCfTRUnjhRLiN1iDivegdeodpd814q4c1kNaXZz12I7E/BJwYzK90nFq+8QMSn5
V+UoCPhJBkapdEw/uvN4yOkz7dFKXZ3F7oUAMbC4BUlqT+RrC4rGSBaImCAqiOKgskRZN/ds
EWJaEZ5pWhkfqGWuAhiyidwBxLAfDgMMeYzJkxqN0NYLSTKCn0ObpfPJaFi7q2y18cEAtLqx
FtpfSjLZI8yhoVreTAfoFun52S1c/PQzAFzeMkDNmHT97mXcVhXl+ISf+CIQtLJW/qfAQMDE
62oMYInc42QIrP3leMzQzpYMcHFLgVGyDwN7FBO/TDfSOY766XS/EwdHR1OZoH74Zjz27arT
fe2st5XxruKBZ3d8WAtLtIf9E4QDXI/tRp6lDWdTchWxUwza2nFoXWHT5FdxUDZQcTQWEBiX
YXvVEwWF1OH4Zk+e/FANDksz8QeTdz5j61Bi3jja4X0CW3rfrGFTTir82z22IEeuVnOamLTk
9UtlSYRE+Nl4EveHgxidp1MSAx6BQz81hGZlyd8iCole93hI8d8pdEgYA2AcsvizjdlC6lT2
484vKuNyy1mv5w/44ZFpfHZVwff/3z6fHk+jjfS6F2xV5nR6bL2PENP5NIrH4ztGkBo8nu8s
PvHsPbVzRM3BAv0rUQZLlGkqITLDzsOPoVcYApWxuTITciQBq+P5QAJlv5ZR7YeJ7M7bK3V0
alkG1SnsHKhKJla+FrSD4VdBlchszhkBmpUyaiyCDkGcvj4FlaCBWQluKKkRNJtex6QwHS9N
OOUNTcz3QyC45zyTRt3XYU413S1jVYmDP3xP3z1lYj9Ck47n0+fnyPt4Oz7+iTkse5NHbUOm
HPTIvvl6g2pObQ2IGHAXO7pL0GuM6QBATTvIFNMTif0fy/MO9kx9DP46Hz00xmUfAYUxIOkZ
4Az1NfwbRav/blyhWoFXlJSNU07RrdMUp/uVAdXywu8mmXG+hwrli5IsAPytdznPI3Rl1F9U
jmvNJYAv/nH8eNTWaPYEqaJimw2aGFRbhHvjxhu7FFgMIS60f0Jb/9NKHSasqt0hcG+8tvhc
yTpZC+lQzsUHoGJvYD1n5s8mkNTmXgHTcUGvHDXkL4jjxtwqHUe+axDOBGqdXyCBQYqqpOZt
PjSJyqgWCV7+1yQJ/D8PHWOpSXaLhUP3oPGwDb6Fw3gsyev7zy+nCVqSl2YuZPVTeayT5aig
UYQJevGKdfDKSITRD2CHXqCQyjf6LnPcLpooEyBI7W2is5/TM56OT6/AF/x1fKCxgNvyxUaG
l9vxrThcJgi31/CWP7Ax3C4vCl3yLjx4hU6+1T9LtDBgTcr5fLnk3y4oEadF7EnqO4//wj0I
LA4TbINmMna8cpxpgjaQSLVYzi9TpnfQlsskKMVfp1Dry5FQ9UxY+2IxG/NuDCbRcja+Msx6
GV7pW7acTvirjNBMr9DAfXs7nfNGUT2Rz2++nqCsxhPHu1hHk4e72nHSnGkwUA0+5l35XKtW
vjJxRRpEiYxbD8orNdbFToDAfYVqk19dUXU2aepi48cAuUy5r69WhmJy48jJ1w9+fafy4XKc
RX8sGfdaoTKbywkDakRqRqjp4d4h4MD4vgP/liWHBKFNlDS3WI/0DyVNjGBUmkShVxR3HE4F
5x0kTezxYYp8sM9blRlNC1EwSfiRNb6mJjLhnnt6oqjwUSSgRng9epv9H2VXthw3jmx/RY8z
EdPR3JeHeWCRrBJbJIsmWKWSXyrUUs204mpxWPJM9/36mwlwwZKgfB1hS8Y5xL4kgMwE/30l
JVb2leXoWxCEn0rMywppkzdhatF/FIz8LutoIU3gWHdWhweCcmSn0ylbi8Q6o45lnfrEJwkt
PNxfrK6n+F4OrUsjKNwDssV1oiBgzbK8Ly0qCOMoqiweDPumCmiLlOtJFKx+3V+hBCSfv5aK
dz7CxE5j8P+eq8QJPD0Q/h1NgpYzEQ7kQ+LlsWszfEIKyEW2aWgk5DjCqfMVDtfVRkwl2md9
drsS6ahRqkWsp8y8RvP1p0fT55/EIZZvC+XAOSS0y5pSf4dNCHwg398/4NmQYRo4DHfKbQw1
beBzkGly7oY7aeoT1lXWQOhcB5jvvDBSS5fV6CRauMDo6SZs91/3Nm2J885iX8h3nWemne8t
VTMtrLTzLBBfQWBX7tTK402jXuCNFtbfn+6fiasJUbYy6+u7XNYnHoHECx0yEFKCRSXPhrLg
b2nt5beVZZ6wG9Urk0NbPJeiDohkEgSxveyGS8lEk1lSlU87ZMDQ75KToiUXmdKULYholAKa
zGr784G7dAgotIceVjXlTCETKk9D2RYWQVipAvvYnxMcvITUKpRJIIxYWrCpCluNNfuT6XOj
fXv9BVEI4Z2On2MRlkxjRCAW+9Z7dZliuV0XFKzMuhoo1buRoXrYkgKlLqbH+ptl2I4wy/P2
RO9yZ4YbVSy2aOGMpHGG/m3Idro7Ngv1M1q1PUUny+5uiqm3qHEIuO/sUz3AW1ZDj/ksGzha
vro+ZbI6MtC/jrgGXqZEmIW7HqYG8sqj52fZkslvZ84QXSce4lqWB+E0cyRSwjsI9SAMtEVd
Kk/HQGiBf0t0vKscmCDUZagVzvc8tDDDv+c33+IIfpuRysacxyotYXxnTQu6Rc8ZxV7xySly
gn5i91taY/b6FiSEtiDvFtojWkXLLxL4aUQLtigZV9oNhTD5FyeSD8RqvXSIuzbnhwmWORa9
B6Jb1cCxzAQLgdTvApHSC05qvUz3RbToe5tZXCxdd7azzKzd5ddlfsPfuaMOoocc/naSfzUe
UDEx9+ihJg19FRiBILyPV0ckNJ0rKkNIwtvDcW87DEBey+hXYXdzogp99RgTCXlPrY6IHKFq
zvwFF6Lkg+9/7WQTeR3R7d0MnFmUU2Dzmdd70gEYjE1dmD9VdX1HGjjDHso8XJXVULC2+THB
+Nzo0hUBMH33yOA1fCW/HYiBzeE0+cdpfjx/PH17vvwJgwvzwf24UJnBjzR1mSm0HvLAdyIT
6PIsDQPXBvxpAn25MwOb+pR3daECow829D8mHUEDwBpF+Yf38Xq331SDGQj5mCoCCz/v9NBA
XbOU7/IriBnC/0AjdPQo9P3t+RmnJPOCQERfuaFPn23OeESf6834aQVvijikzylHGE3zrDjs
QFdAZjmjEGBjWZMA7KrqRM/xfMLges/06s+brmJhmNrrDPDIpyfxEU4jWhxC+Gi72xIYTB/G
yETnMrYGZnlDuFzAofzX+8fl5ep39A83Ou762wt0mue/ri4vv18eUVPh15H1Cwi06NHr7+pY
y6ELE4OtKFm1a7nDB3Xa10B0kgVV3VgJrIYlSp9H5Ahst3tAK5uSfjwWMDPLfOcunkUS7nP3
vZ7u3jgrljtUnsnF0dq7GUrywBRAoawzje7yT5AeXmHHANCvYhzfj8ohxsaVJzv7QTIDzzUe
8OiZGTI85D2aMsz+4w8xt47pSv1C71LjRGebysUx8vK4sFoZw4E0XkJobG09aHTSosckvC/Z
HQzNFJxBP6Foy90kUqmX5Nxm3+IgF7HZh6DyBXkWAcO1uX8fX42bZmjjJg0/F9sdSU8Mw04V
/zlbUUjYpD+q5WJzGFD6rqkzFMbv9YVV6ote3GmsWb7jI0nJQN3EsJWWn5zH0D30h6q90+Pv
TplHOglAcFKd08sCO8oEZliHPCYE/MRNLJTk51GmRPT1rv3SdOfdF01wmttocuU1NpYqz3e8
EbT7U7ki9vsO3a5yz0pqdoa6jLyTo+eH93Z6N9lZztWuSQ2grlPutuG/K96i26FDhrmpgbCH
5yfh28g8u8BIYUODLm9vjN0AxaqLihS0JYoxnUnYOGfPWfs3egG+/3j7bopAQwcZf3v4H1NA
xAe83TBJzlwelrSBusSPAkdVyVTJ55ujrGdYtfnQ12oA/LYETO5lDUDMOEsES12JIJSJqGoa
0SbvPJ85iaLSOGKb7I6/n0Y3xUiCDVzf3x2rkj42m+OCbYpt1zRHlbXtvq2zG4v25kQri6yH
lZE+4Z1YMAEdy/6zJHdlU7XVp0nW5W3FNoee7vITix3avmJCs5GocuxyqBT+lxbAXRx2qBgp
fCCGriczzqOvP+2jqv+iz2aiK1gvsXhk7I6Rz7ZxcOxkamLimt1Z9k7CleTL/bdvINLx1IiF
XeS8KTpbTZyL26xTntvioXic/En2FslI/7iyCPAcrO/a01rTnJtNErFYmdZFeNl+db3YHnMD
49nyLBHHj6ckDM0JEaaSX8ZaxDu21Zp0neCMphdBQnfUmYQuEs4u5ZtOpkA8RjG3sUsfaou6
5wWV1kFR4UMSGxEx0tZ2gnzXNav4tmo3+5aapwTM3CjnWZ63G7y2Ln9+u399VISc0c8uVwjS
Miv6sWO2L4ZbvHWIKzjct5NWyCO8TcL4pKU2dFXuJa4zD5tt8Ummub+qzOjUmyINY7e5pQSD
MSUWhU4SGQXjQOrSO0/OOOQbNyCNjES9N0maBvMyCdsjowTGgLfuv0VhhsRydC+aoj5X+5Ux
jC4miR5ukErB8uhNOWf1Re57qoHhLKitthO/O0mJTiz6F2V2KeDc95PE0SbXrmJ71huNfuoz
aBjqzVfuA34m37p4CG8Uwv3lv0/jgQ4ha8JH44tQqK21p9tjIRXMCxK6E8kk95bUtZ8Zo2wv
54893/9HvoQGstiioTciZYc2I0zbAOk4ZtYJl7GoAgkZp4BQO76wPWwgU11fawEpFrpbKhyP
btWFkVjz77s2wLcCsIGWH71RwIQG4siho4sTx1b0OKE6vlKs0glsXyelS6+v/B7mnB0pkUVg
fclUc08pGP8d6PeYBIsduq6W7BHl0Nl2ZcLQPG98PlA6C2eDCCWzv8lwn3w3ViqRDZmgVq6C
0DOqQqEH6ERhG6oG8ZgcTS+Z+tBnk7XZGLyS5c0XD40iFRtHFbI4k9ZZ18UXKpIiS91wrc5g
vnVjJ5D6qoZ4FgSmfcVaYawFWMdDJ7IonU4kiCBJnXVO3SWxKi9qBPXAcImaV/vS4+b4htyP
QtcEsDRBGMdUXKc4jlLfRKDWAzc8WYDUoQEvVOQ8GYrJ62iJESapQ33Mmo0f0MN+aq5ddtiV
WH4vDaj5ZeaNaj1LFU1IP4SO71PJ90MahFTWJydH8n/PR1VnQwSOZ4bXhD1Fe/8BkjylHzR6
7N5Uw2F36A/SUY4OKevMjBax71KmZBIhcAMiWgxPqPDGdTzXBoTKsZIC0YudyqG1sxWOT89u
Eif16DvqmTHEJ9ehMzpAdX32ceA6VPERIOsFgMizALE1HwHpanxmsDyOeDMYH98kQ2l5LWmm
uM6nnG3WuOH1ymq1eJPv6pI11Ny95Ba9ExBVwA13yBoYTh01hCe8YJFHRIje6qnOWaCxN1N9
30xYFd6gh+CVxHCv64RbM1q+Cfa2spf7GQn9OGTEJ7CpbQoifACx9zBkICKY4K4O3YQ1JOA5
JAACREYGe1R1X1fXkeuvdfxq02QlkRCEd+WJirMKQ3KvOOF4eYK90Kw8/ZxgCv8tD2jtXAFD
V+1dzyNHFNpRZjtaPW1k8GUjNEvIgZTobHil74ZEb0PAc8mpkEOeTbdL4gRro58zIkuWvIjI
Eq798MesawQiJyLKzRE3pUrBoShZySEy0piM1AeRiuyE+MBC5K2Nes7wUzLaKAqISZYDIVFT
HLDnkGrvJu98cukb8igMyBKV7dZzN00uJIDVdSU/najZqW4iage4wLFjNiqE+kTnaGKqezcx
UQsQSiz+dZPQo6tJ1jOZ0IOhSSi5d4HJUQfrOxlKljgNPZ+QbjgQUEOXA0Q1dXkS+9SQQyDw
iCpsh1ycTFQML/RNPB9gDPlm6yEQxyEJwLaPHDsIpc6aoMfPHVNFYugay9Xz+Am7HlyiKiCY
ljwA8P9cndqAka/Lb2vqLfNq3pRu7NN7gYlTNrnlSExieK5D9BoAolvPoYvYsDyIm7VJaqJQ
3VRgG5+aeEAwCCPY4I5PytM41dE44EcEMAwsphYokIQiasqHWcj1kiKhBX/mOlR3ACBOPPqL
OImJNSeDCk6oibRqM88hVxxE6Lv6heB7dLcccout2Ey4bvJPXlUams511pdtTlnrcJxA1BOE
B3RvQ8RibDpR0NVZ3h0+FeeBFyURrdw1cwbXsxzHL5TEI30FToTbxI9jf0eVBqHEpa5tZEbq
khsCDnk2ewyJs9YCnEAuRQKBTQ+/m12Poo6TUH2HVAWjllTSWTgwiq+35rAQSMkhI+oTXmca
5wY23bt5pOVd9TNbuOHGccl9L1/AMkVTYAzC1x6GCi0SqSVkIpVN2UPO0bpr1JHHvVh2d27Y
8qz5RDb8RU8AvhiJpo3o/Y18UXUiFqVQo9vtj+jUqjvfVqykYpSJ26zqxZu3ZCVRn/AXjlln
c1lCfTKeTdf1Ps8Gy0s003f2XBHE1XIiAVWy+D+fpvmTxfr/FgdduGf6axMzS/iA4/HldWaZ
xgSJ7fNzMbApYno4ANUPnNMVqhS+KEZ3cmxIoeLRs5VfU6yRMxuE/KWHaOZOc3C7v83u9gfV
4+QECguYM3/OuGyxw9Pz3fyBoZ4h3B3dfzz88fj2b6uTDLbfDnLel/lABvBRcdStgtwSRV+2
NpRVzG2RQUQF9eHoIM6suq9V1eMFjxTfiIz6gcQ3xS1Bx62df6KSyPIvB3yeC3KmeBkrjsKU
Xs/ywqirBjXVVwkxyEeWQpeb/Jz7ScBTluqJnywlpTVa1qEbUpBgqIcsGES6rYYu98g2KA/9
frVQ1SaGuOkM43EP6+UOvIXhrtVbFfmOU7KNPQV8hsmOQrFWQBAdva0te4Dqubnu5mqgKgsk
W1Fa6Y4Ot26urzdKe9QrfIYiZ6U8IIbZOwh3ujgqtKyS/HgTi8KRFJT36DqZBAu9OBCexLFR
kzKeEvg8mPLrr2q1Yb8rO9io+OQk0lYp+ka1JddWeey4iS25sj1nnjuWYVIk+eX3+/fL4zKx
4TOGyoSOlvs51frSjDR0xPOPc5Td98vH08vl7cfH1e4NpsvXN9XJmzEn4ipITPASQV792/2+
I+d8C7/L6PdeLBn5qfjX4mUwirs9Y9VGM8Rl1MH4Jm8yko6AUcfcfOpfP14fPp7eXq1eeptt
oS2aGMJdfTgn6QKSh05KTmpwduo850SFaQ6Lt7O/GeUiewm2u+yQOJriNsFYDMuUCIosdULP
ajE3USKLM7IJpnY6I+iGjp5ok7v4HMFqqhOHvom/HtC8g1W5r8ctZKUvh6y/mQ1ayETqLreq
XSJmtamaxT90/wP1OhSo028tiOCjTT3fAv0Mz+qnDmi/Ze3Xc97sbY/EIOcGduC15el1gJOk
axKLce2CU4f+vGGMq/sxVLu2H0OT1NGpQ6QcOvGwSYRbgsuv3O5Q9QMIVJhEKA/zCE16EEsk
UwgeJxGhqjrDqFM42WqpqZpKdzI63dVLYawK4uikGX5xoAkdlwjSbEh4+M1dApWtHLNmm1Po
mI8xy1/dsVzWA8CwoTpnje+HsNFguagMpXx156eBbRQPaM0i3fejeqbrhMpVm9DlpDfuHIq1
2ZBS/pwS65KY1Fqdv0tdj4gNQs3ZdUYUk2pEbmvXi32yuevGDy36NAgbetHyLD9rw5qBZu4m
QDOx4jM3C+LaogjKs9+ELmn7M4Guo0fJ1WKpe44ZTIhPfNeYqvXPlCsnvnVina2L9uUO9+B7
SaSfg3TVtQUQLt2P+3rIdso6v1DQt8OBe/Jo2cFmiLPQ8YSBHzD87AcwL+4Si8HqwsryIUki
qndInCL0U0WlU8Ja+EF51pYoY6epi700kZg4rE+oEUhSNPlkQUwxR8IkYYfIOqz2HjkDaBSX
/nybtbCvJQfWQlInySW8YnXqOyEdM4CwH3GppygXEox52KvTEeD0GNPH0RqJGpAyJYk9smoR
CUMSGXI/TFIbFMURBZnLtIqF6syrgEkUUO5GNY76JrIKwqL/aQSpuq4pIJclPqlulCMsVwQq
idRbVikpWU9c/CDDdTlDwraHr6WiYSRhxyRxIjuUWGqUgyktsC0sIYSsFpWSJxYUVsrQjSzv
/yo0vvqvpoQkz6fLKlZ+z7fmgksLn0avCw8a6vrrQ5GT0FMMMZlIMgYRvVjx6FrKrYIZOsHn
CtrCzciyHX25PD7dXz28fSdcNouv8qxBV0/Lx8sKzXFYMmrYXw/HiWJNv6h21QBL5EI1Y+sz
tED5LCZW9FIUanZxQ2qB9u3Qo1vf3o6ci6NkanisipI/GqQ4+eOBx6AGqe6wQc9RGSmfLLyl
H4qwrDjqsoYAhJzRVC1/kaDdlZIrNJ7g9rZFD1BzfJBbTcjHEHymXrFwhDD6BTvOzk7jy+U9
+6cbyVBx12a4z+Q5YnqURYkOV1iZ45XGud7D5rEmzxyRfKjLucyjQST2PMpjOm8StFkiusHS
CkE9WzSuPwEQoAOwxoO/n/K4XcIaCUvyU6liN/wpInblNaKwrhJD8/J41TT5rwy336NHCvW2
s2Fnxp+56imzN97HNoetp3WZJZzorDwc6m7fMfKLhl99/fNFbtT714en5+f7738tPk0+frzC
z39Adl7f3/CXJ+8B/vft6R9X//r+9vpxeX18/7vZC3CA4fsAh2HPyhp6mnVKyIYh4/54Z1vH
8vXh7ZEn+niZfhuTv0K37m/c18Yfl+dv8AP9qszvX2Q/Hp/epK++fX97uLzPH748/amc2Imx
OxyzQ8F39NpMMRRZHJDrwYynSeAQH5boXjykjqAkgqz+K4Ib1vmBQ0SYM993KG3FCQ59WeVr
Ca19LyPyVx99z8mq3PNpf72Cdigy1ycVVgUOK1och2b0GO5TouA4sXZezJrupOeX7du782bY
ngXGG7Qv2NyceruxLIuE1SunHp8eL29WMszcsZv4ZmY3Q+La8wpoGOkZhcAoMmO6YY7NbHps
3jqJjnEUUULulMsw8Yj2h6LGrsU1sMygxJ+pk3ehGxh1zoNDoyNCcOw4xvI33HqJExD96Ta1
2QhJBNp8YiGslu/YnXyPeDpFtDoO7ntl7BOdJXZjo/z5yQvFEJZiu7yuxOHFluaxvHAgdb+Y
2uTKuDGEMdgPfDI4NYNvkkS10x0r95pBryKenbl/uXy/H6dW00Wy+Hh/9CJqjsPw0D5wEE6M
8uyPoy6zEVkYpdQOfoJjsf81Posj0lJmgWOjb2NkgRF6ZFHkEV27GdJGs/DW8cFVRf4ZODor
H7Le8Z0u9+e+t32+f/+Dcn05tXnnRiG1URM4nj1GRrHwdCKI1O799ALL4n8uL5fXj3n11Gf+
roCK9V1a207mqGrTyyL8q0jr4Q0SgxUY780saeE0HofeNSE8Ff0VFz/mTyXRC4RfT4wYIb88
vT9cQHR5vbyh9z5VNjDHQ+yTio5j04Weoj4vQsUh7OgMWwgjP/BOF0r2/vZwfhCDSchNkzyC
55+UnCKkLUQzQhrMT4UHW3fhQooUCIXkNBxa7m1WfPvj/ePt5el/L1fDUdQaIZvzL9CjWmd5
xlamgXjjcjfMq+kjLfHk6jJA5QzfSCB2rWiaJLEFLLMwjpQTQRMmj6wlVsMqx7Gk3gyeoxr7
6ihp32yQfGv0XhRZMde3Fg2f5iFPS2XSKfccWaFZxULHsTTXKQ+sWHOq4cOQWeuE4zG96VOI
eRCwhBx/Cg0HeBRam5h3HpcSimXaNocmtlYmRy2X1Drts/yOGfJsaZVW18RqUiCQfNqzkqRn
EUQ3WEbHIUsdx1pqVnlu+NngqIbU9a0DoAeB4ida+lT7jtvTXqWVTt24hQuVHHzeFpy6gbIH
pjwjpsD3yxXs9q+20+50nnTx2Oz9A2TF+++PV397v/+ABePp4/L3ZSO7LDH/R9mV9ThuK+u/
0sjDRYKLINotX+A80JJsK61tRNltz4swmXSSxulMD3p6cDL//lRRi0mqSsl9mMX1FRdxLZK1
4H2B7HZOvDW0+Udy5JKGgQN6draO5vR2JpoWuyM5ArH+Lz6ryNUtctWlD0wzc2FS1DhOpW9p
71Nf/VEFiPzfO9hzYF9+Q//67Pen7eXeLmhasxMvpfTgVbXzcd7q9aviONh4FNGfdjAg/SjZ
fjFqAWJ7QKt7z6jnW4V1vjk3kfi+gI70Ke9RN3RrdWV4dAOP6kpYcanVaBoyjkMn2lJCtDY6
iJHkWETcZZ3YXxCh+nG0ZDXsK5F4zqR72drpx2UgdYmaD+DQDdTCeCtqMVRhcbKnD9G3XJ8M
6Mas6tDhy+aFgUia3KhqSNgirXaEKeTYbYte0oS7bEX4BCW5zEO3u/v+n0wq2YBQY3cq0hYN
BV/lbdh1ZkA9YnD6FhGmcWpSiijYxC41tWFZpV+q1U30pYsctkIwwUKrZJxAfujbBaX5DtuZ
tFjX8cT6DqXu65QktSEK2fKVHb81NvMS+y3s8yYtS1x64voRfdczdA5I8J5DqwbMDIFLBgFA
vO0KL/YX5Q5k6kZuXnhjO8371IVNGO/8a27FHg8c+mhOxq2CHce4ZsT2BBqa1XNJqtWww+K3
mQoVnYQyq5fXtz/uBBylnj5++PTT/cvr44dPd91tXv2UqA0s7c5szWCYeo6upYDEug1dS4Vg
ItNPfojuEjhU2ytwcUg7f/APaWQ10qlbDA2OhJ0bRtFcjC+cxw63MYhTHHrWVBtoPbSLndeI
nMlwxnNh7ryW5TL954vZ1ls0KUy8eGWVwOXUc6RRmrnr/8//qwpdgqqo3jx2n35/evvwrMs3
cEJ//jYeiX9qisIWJoDEztNhn4NPcrh4qBbXdnnNJrNkiiQwXe+oGPZK3rErA4u1v71cf+ZG
UbU7epZsBbTGnnKKZg0RVGcxfMXNRDv1QLTmK57yF0t5cZDxoeDHPKBLYVV0O5BXGRf/44IR
RSFtiK3qd/FCJ6Qj747ScAvb+4qQgSs9o6mH8LFuT9Knb79UcpnUnUc92KvUWZFV2Xwx8/Ln
ny+f7vIpFvHd91kVOp7n/kDHl7DWZWdrC6DNPNi7l5fnLxjhHYbV4/PL57tPj/9hhflTWV77
/Vytw+uHz388fSSdU4sDpUl2PohetPoj+0BQ79CH5qTeoG9XbQDKh7xDf8k1rXSctkvf7iJp
7r4fnvGSl2Z6vvsBHb3/9vT719cPqII/P/eV6V3x9MsrPli+vnx9e/r0OJ/29q8f/ny8++Xr
b7+hb3j7bnu/0wflPm9LFREBzpnUHrmHrijTwvAWD7Sq7vL91SAl8GefF0WbJdrZfASSurlC
KWIB5KU4ZLsiN5PIq6TzQoDMCwE9r9sHQq3qNssPVZ9VcJamHHlMJQ7vxXpSEByyMRILZboK
HF1eqDK7vJrVBIwOWAu0jo2Qt+2JfmYHtCnpawFMeN1lrT3Tb7BoE+tbYFgyvlQBPIFQQ096
7O2AURsD7HiglAQBmIMkm/3kpspMwapbdc5TJnoJoG1+ZrF8E9BrHWBFFjvhhg5jjZ3Lu0TF
QkXKxWrC5u2ursfmLDo6qDI2AL30IiLOlpcjA83ZQcLFfcF2zWqYFDltDwP4/bWlFyjA/HTP
Ns65rtO6ZgfFuYsjJuw3Tpk2T7m4b2rk0u7e1XRgM01EW+YVtS9h440WBMbA2ZX94dIFIbNX
Asvka5BveKU/zY6vDMZXVZdsn6JE6DFOkgHetbVI5TFjYqqp79q4lASPvm1VEJe+SNKlahkS
k0JIOUbYu81QRIpgD0eWwOt0/yoKKCUcwQ57U2lYId3ZD5131HsNwnmRbz1di3ci+ubNBZK7
tPYCyu8vgufDwYNDvgjMrJbhgNRnR1nkl4sCinRLx8FDUJTSj7b7gxMtkpUSxtD9nry8R4bj
JfbDjVmFuit9zwu1rerWM0YHfFvik4d+w1/qBCq/fasd35TxNnD7hyJLqdylOIrW8ECuZZ42
ccz4sDV4TAeIWtlr7lW1sYn649RJT6smoX+rNZFlqrYs4Rx6zkYPKXPDdmnk6pZW2re1ySWp
jKiARX0grbjrU6X7A7R+DMEOTVKTlCYhLcUQjmcJyezdYoYivRUPJeyXJvFnocclmShjVHBL
HRTRWkr07UD20VjRZbBGg+PYruOmJibVfNW8OPWw1KJOql3Lpq2Tngxjgeg5a3c1BrBXMU/t
tGzIJUw5x1wyu6KXh91pb5KhG07ow6AlegePFksy9s4Q3JTGllTYSpZA2ZwCx1URa01AJNtN
j3FVE2ssDbqYi0ZMJHWqUSmWHyAw/pBJomvXNeJsk2QU2B83xBh2o9Bw5Td/njU9YCyUovIu
AfHFo89uI9gXAU7G2DcnNUMjLAaXSN04ZtzWqobAS/EVOA+DkHG5hLjMj4z5qoK7POcCIM+w
OoAwcZSR6RTHjO7YBHvrMHMVoeAHxmcWYu8732fkX8R3Xbxh4jYDmgjHZXTiFFzmnEGvWrgu
V9gb+dQy8Bgv6iMccSGlEe4ue77oVLSFWGnRg3KCxsKFuK4mH7Jn/J1N2fPwkD2Pl3XF+BBD
kDlEIJYlx9qnXTMgnMO5mgmUd4MZ6+sbQ/rz3+bAd9uUBc8Be53r3PPjYsRXMqik6zM3oTd8
pQDpbn1+xiAc8fC+5OKZqp04lfxKgiC/hIBw4W4YRZAZXxlUygo/vvDtMjHwVbiv24PrrdSh
qAt+cBaXKIiCjLFUwJEtMgkHMVoaHYb+hQ3GDnBVekwc2mFbuRx5EajNmw4OuzxeZoz52Ihu
+ZIVGvKpZcaY3iqwrvLknO9W2m3tmD4IBSLmTq8a/jdbmDpD15JfHc4X1ucyoNdyT7mGOaY/
qptUw9JEzQUxDEhGHEK8aTNlH9LL/H32rygwpBlCQh1CuDPSbW1JaOgGQ4krGMP5m41MYc/M
M8GCTZQo8xjvvjqUvIedZOO52/KyxTOp8gO0MhLmVG0XRkG4zq4im2Mifhe7hdnNPUK19SUZ
jVXwJWj/+vj45eOH58e7pDnNN9jjw8GN9eUzXn5/IZL8n6YbO37NXhYgfLVEyyMihS1+T4DM
qRZVUJPme76LFU9GZpyXF5Cz0iEgubkueui6PfJcx26mRRXykt98FT54WJFd39VNAeeOpXc9
2ZVPH19fHp8fP769vnzC1w+JlxN32JOD/cDClnLK/tLtmwO6YjBux99f+i6lLmrmWmGU7nHO
TA9CeGQhImXoE4M41igsFaf+1OWFpDF3Yx8lbsiFRaIVZFR7Xk6WCaddPOhsoyXJMov7wKUd
Pt8YgjAm6nYfhJa78hsSkfpIOkPA1Cb0Y36fGVnCkPQZPzEUSRiZFsoTtEs9+zbY5uh6mdRU
2kT6YUEqKZgcZMEDtNbMA0e4bGc8RBR0aykodFkvUybfyvY881AKXwaH4RBeAyKm5huHoROj
faCbflYsbJjAZOUvl5hxOKVx+a5PV8gPthQdbfccqsQ0r0FMJIMrjByZ3Li+fQOh6LGva7Lp
dI+YZwOdbpURY1rl0JURGRnwtlhXdd/e+45P1KcUsGWHDjnDFUZq9hscW8PNuI741DgaciX6
p5RlvHWj/iFJJyv4JROIJ24UE8MKgU1MdO8I0E2rwO2FBbgleYLXV2TkiiMmdwD4OiFoeEPS
QBhXseARNtMB5XINXe8vFmDzVCCZZVvAEkz0E4p81MRAOsUvD11hGlHMSH4oBRw1eYSu9oy2
2aEUZPJ23ys7ZU42UOIZQZal5zvEGolApCuQWgDdhBNIf4UsgzAiZp7shO8RYw7p9oXoQM9B
RCWEnE5ILwyJSgMQGsrOOrBxibIV4BGFAwAyArn6KItwl78sVTx7sY031IvOzHEzvyZKv4Hc
RNdZ1if7zOm7F6oJZni4auZLQoa/2eNMXnLw3FioykhfeN4mI+shh312rXhkoaXChzIO6Zho
GgPVF4rOZhnz1z0jy4a0/9QZvJjJfcNFidNZmAAiGgsZRVBnoGafotPNsaGkKkUnph7SY2Ku
An0wIyfp9NIyYoy8gb516MgVGkNEilMKWRdQkYULwKGzrB0NkCEmVuH36mS8jQxtTV0s2YSE
/IDOp0JiY6pQ2TcguqgaHkkYgFnsGoEh1cRK4yhDUtQ6YcJaAM8lpiT7+fZnPBMf83R59D5a
MSjz9BbftWuz6tDRNzTA2IoHEjodSQU/zHpSNRjV1+Tnx4+oPIwJCKU1TCEC9E7OVQG+sT3R
F4MKtZUXTFQy6nAKPOHlHAvvsuI+p5+GEEaFzJbWzBrgHH7xeNPWaX6fXfnqJcpcj4evTZtJ
Pjn03aGu2lzyrZOVst/TVoUKLrKkpi9bFfweqs+ih6zc5cx4Vvi+5bOGjLv6tDIm7q/8Vz2I
wnLhaBZ8bfkQFMiQY5QBHu147Gexa/kO6x7y6ij4cu+zSuYwGVeqViR8CBeFM3EiBqyqz/TN
uIJrOJWtTUOl+lfWp5XxVIrrvhCMihsytNkwKvkccvSYXe/phwLFUVewcq0MvPJUdPn66KkY
h9GI1W2X0SqDataKCoOAFPXKyG4yON1eK37JamBlKJKVDAqB3tgqK6COtXzksKuxsBT52mdI
UcoTEwZG4RiNtcirlRy6TPDzF9CsQGUN5kVI8ZyqplhZnduS76RDm2WVkCuroyxF2/1cX1eL
6PKVCQFriMxW5lN3hMnKN0F3bE+yGxSDWKYTbrB9w6jxqsUsz8t6Zcm55FXJf8P7rK1XW+D9
NYXtdWVCDoGh+uOJdnClttGiWT7M4BnHFEbmNHiVb4kPQ5JPb4/Pd6ghyyVULxPAYCefhBK5
6+tjkveoQQ/y1KCif3vxQnyhvopE0SaQp5D9MTEkpRMZ8wBTDPo/qnLIhDXVpJuZ3vzx7cvT
R5B+ig/fDOOUuYiqblSGlyTLaUMcRFE3sT/vmI5UHCI9MKq93bXJ6NtlTAhbBj7O0msBMpyK
Ju/p8JCnh53RXA+7/uGYkK6qy8R46sT7lxP3Tg7MyhHhYoQMvv8G93/Hly9vaM0yGf6khB9F
yIdT20NMpkdTjWsm8jEAZg4+msAtk6Lb0wuE+sJ8XwIji6/qi6tCVisAInh97JkdBFmS3YbR
9kL0rJyMlmQwb8RP8Il51NaFYzdg8u640nhdLY/5TtgNrHGU3f3teFWCiNrlCUGxfWn++fL6
Tb49ffw3EVBkSnKqpNhnIIWgv3Eq6T8ZVFNmqv9Kpn0npp+VQFP1fkzv1TNjG26ph6kqe8AZ
qr3u469B3Zui9Ur+urWWQnYtaiJXcFjojw8YiqQ6KD1u9VkoMi5aTCUTzUnv24Em/SgIKQUF
BSvH/Y5VvPKd5RFER79OVNTBX7R+iFbkJhHbkHy4U7AZR2LIHgMqBAQxXFSkCUM91qpZMqJk
IOob6hMZmrHVR3IcMkpXY/dl5xok6JzSJrm1ghn2QadzCuwzj+VeXdFh93e9QDox9Q6mOG7x
AqxBlXpWBGJFnrQHAo+0JRuaovPDrW8N3y4R6Hh6kWFXJOGWdj8xD7nwL3scaQFNrFGutD5+
eX769O/v3R/UJt0ednfjwenrp1+Bg7iyuPv+JvL9YM2THQrKpV2D4pI0Rbr4HKBDi3Ifg0ER
FkkwTla8uyx2Q6xz9/r0++/LqYsb+mHQ3SbIoyUBjdWwThzrbtkPI152lOhlsBwz2Nl3megW
y8fEMZtH/F1WiVqDKEQkIL3n3ZWBxzWBLn6Kr2XKvapRnz6/oWOEL3dvQ8veRkX1+Pbb0/Mb
uqBTNrR332MHvH14/f3xzXDcazZ1K+BUb2m+kV+qvIyzLdbY4bpotirr0oyynBJJkmGUrrww
2iyHvyvYj3VbkxttCANaCmMY2/CQM1GkxijSdGwKqmgN7gdwb1gdaJxld0zoQx9MrEDjJHm0
jCrmZKqx1EmblnRhGlfe1Dl1StAzakR/rkzrKw3GUs60JIxQ314o46wMlu4e1mW0iZFJe9Ls
yRW0OOi0XQIHo51JwNjoUezGS2QSMW51AeIxAfntSnU2ooB0cP4y8xmJk+nRd69vH53vdIZJ
jjMKqs5ltjRqB+TuabL/19Y8TAEbz34Ig2rnpRA0/aGbeOKg542qYXtW5xHdtzZWhTjOTexi
twvfZ5J6SrmxXGIjBsxIT6Xr66ZkJn0ZGtnCE1hrTua9NMG4CegCNoEdTFNDIzq8ysiAwVa3
posfDbJjkix4Whkm/moBuSxcTw+bbgL6w8+EXIAeLslNsh8fKhfVUJAVUY9m8v8JExmaz+DQ
3Y3N7RW4XexwdDMG54Tt3vnePfVFEkTyrUOvYxPPvkS1qvX+gdFKRxe6MYS68o6e0CM6ISt9
x3QCPafAgCtLD3x43jWnHdE8ulxp0IMlXc0Yj6qBQshISBpDQA4ghZDhdzSGrUPUEuePGy2B
dmtoo97aNcD2JqZqe4k4J+fGbAuoh1ZzOhNzCkatZ3gFnFMkzWYbmvUn1HaxG9HP+HIVXTQU
nAWJCgz0eSEkq0esn+0ZOnubEBkOyJzhEGv2+cMbnBT+XK9iUtaL7WbsY49RgtVYQi5+ksZC
eqrW1+Q47PeizIsruaCj73BmMWdsFTWWjcf4Ytd5gn/AE5PHS8UxfIEyzIVz0bIxB1zt64ph
vTU2ATlevMBUgpyXxu7e3XRidRoEcRdHVBsi4q9/O7KQvt1nBllGXkAuQbt3QUzGF5xHbRMm
1LqAg5nchSlDens8z7Fw1SR4+fQjHMDWp8C+g/85LrFbjeFD7U+e4n3N+gqDF3C6FJB/B8HR
jL0zU5f3u4P3MpDbF76KUJYeDGG0sPFAmwMXHkVVZYU0Ubzn1eLGFx3GgirlATBTnldvE0CN
aA2XkaEWnXWoGPF3SV3iuwYUWR5KzUT7BhjR7uF3YoVJHql6tSZG+rr1KE/9kO/casnz0+On
N63VhLxWSd9dRka9D8g7eqDvTvvJxkYzy8Bs9rkVVPpB0ckGE6dLmsumEJQsC8fhTNMgVj/h
71YdeRyL3Naq3NAkD/egfQmH1yGmpYHu6rqbse/mAwvGcS4S4zx8Im/d8vZdv7s2eCVbigoy
ac0IWi0ZZkmD9TiLw2+81TrZuQCZe6sY4R3anzEvfCOLcuuwxlCW5keOoQI+vr58efnt7e74
7fPj64/nu9+/Pn55o17ujtcmIx3wy04cBl9XUwPXqPVi/7aDhc3U4R4HBpyyr+vvd//ynCBe
YQOxRud0bnUcmctcJitdM3LlUmj+EUysSYqN65JkL6DJhoMYDfApgfuGx65H5RfrOtg6OSaL
KX3LJNdkEGVTDNYSjoPfrY9Ag6VJPD9Cjr/LCxgjX2Vl1xIGW+w4i29SZG/BnYqEpILMULpE
NQFx4vUKqsRUlrGupa4xM/QooGrWeXCGWo5iILtkfRFY6RmFh0SfKoA6g2i4d6FKLEvfE9Rd
5ciwL0LT+/fUsbBIwB/X62mrc40tz9u6Z3zHTbNLPcB6zj31+jjyJNEFDUnqRXOWTRIR80yk
71xvtyBXgHS98IzgTSZWE9+roJJc+S0ON0qJhga0ELsmWR+NMDdFSszwMhXucngBvSTaA8gn
/X1saiZUk3rnE98mQ2+1dzAw4Wrkv7ncJBd/v5TGXrjsLSCGRLMhuWdcC44s98O/BXkpSyxp
pmhfWOlmaPCPFrLe3S6Hpd24/Pz44d9fP+N7wZeX58e7L58fHz/+YViRD9tfv9D0HNxyfvr1
9eXpV8OjqDxaF6OTvKGfhTEaJd67ZiW+xTQmkIj2nNWnjoKOp+reok9qCP0iuF96qKj5eZA9
WviiAGUMrvbadHUv77Oc8pp5qnKosQQRTu8Q9O+3J0Me1lKPbgq/+mRwS6WTqkwP7IEUy8eW
oqmwRBbN0J2/lxvHjOZ+aLOrpRJz0/l5+Y/ylPqMR5lv6qqjA/noR/K+uMkD8kBWdvdKZ0YP
GwIkkYHkkp5KWrt1TNSjE7u6oN6RL3GkxdpcHqxEkrX9Q95mBadZjBzHlNYZRmVrWNYaOoB6
mhUFzKFdXmv2SP9t7Ml6I8dx/ivBPO0C38zm7CQP/eBDLnvKV3zUkRcjk65NF7qTNCoJdvrf
fyQl2zqo6gFmkC6SknVSvERpQPhTGAoGotzaTHxbVDc3vpyL/Z9ZBxrOkTpGki4Ic0/01KLG
0YyWosMX0lmStCYnmCeSvD4+oKBuBJQ/41g70fG8rIPYH3Uk4/RazDlR+zxbqICCDpFXfEw/
Td8vJr/OhrUnLhPjJbugOdoNFfwTdkOTLDNPvvCRKvX1hJoRwTl/pJ9R2uG/Li4SPnZSqeNl
d3p6ej6s7NgJi47C3Ve+/CWSZhV2/PJQnzo6LXXhPl09k4QFHk38vMtI3mOjPpLceWzCdINi
WBSeSxaygU17rO8UbQuQ0nqgdl7lK78Dex6BzDOlbd8kwHhQk78ALa6zQuTNeuAk6bAmIy4t
30x870gbur4JK0rDzfFkbCE6XI2DYDwd+QDJCV1ntZZ2MUobEESmFukqJGGqkY3aRQABm0y+
XTyfrCOqC9lwPWXUG6IuNw9kCc7rY4VgyLvKkMQQsQzprsHROI4C+HNQVvPAWxPSCGCOVVfn
bHxmlC/xYfG8qpa9Jo2kmJEPcJhXB2QFYQiOBYow+XI0Z6m8L9H318dvMov2/14P34wHAqcy
Q5tdXXjS75lUl7x5TyOK4khcezLS6WSUWX+IPDdV1m2dAauOjBB82XjqUPv6cXjcuRZTqFqs
YAOAqKy5wujngNVpI5Yvwzy2KTECLaw2mj0sMrbSaAENKy4kK4P+9VrsgUyRv3vBd0hOCHlS
PzztKMZmfNTbkG+LWNbh+v53z6/vO3yImrFFC4yRRyfCaFdufjy/PTGEddFqZiT6STY9Qwsg
KJldFxjahQDOZk5ktqmOBEw8RKf7b68fL1/W+8NOM0jPjG2kdvNIycJVdPKv9ufb++75pIKl
/HX/49+oRjzu/wvjGZsB58Hz99cnAGOiIysWPTy8Pnx5fH3mcPs/ig0Hv/t4+A5F7DJa2zGG
2WnyZv99//K3VWgUP0EtKzfDKup1RlSTKJo04o4ZZbHBc2UcTPH3OyhTaiS56FxJPgRNdu/L
TziSbGr+nTGFpwCyn06xSW64uLzlLmQqMjhDzi6vrg339oy6uLjiHUczyfX1p1vuEFIUTXdz
e32hGdAUvC2urkyXtkKMtwiOfRZoopHxswy9qJqtEZjlqa/sPM+hw6Hnu8RQr914n6y5o/de
3SutAegvi4xu9g5l8/ls4j81pimWF2KnqsMqaOKhI5OS5665zCubgaDfeW6ENqIFFQB+dA3o
VuyDU4l5yQF+gsqwFHxgEWK7JlvBd2fugcB1k3ViEMjOCrs6ZFVWddJbnW6Bm/71RpxiHqUx
Axyg52+EUTEsYXPgdJ8TanajpNuh3gTD+U1ZDGmbRR4UljR2MF5KjAJO6ysi44oI/PSF/gMm
r6drw/XugO73hxfY53CK799fD5xjoQn41dSlwFgxn3Pueqhms8q4mMq4qcw70go0hBlW4xVM
44A7BCl4bexIuj55Pzw87l+emJxonZ6juyumBMqagajAQ6IB4RcgbcXmadeI5tBbvpKka0CQ
9grPXer6NLvU62GaCGy11MYvOu1OwgRtPZ8DdeVYZXWXscUcV/C8deoFfxZIqxMc4qA7+xhT
m7GSTptnhUy7OFMCSMoNUde4h3myPzzT2y2xfS6KWLNJwY+hSrSs4dOrOrCqCt00RxYQaLdm
ToniUE/3EhdZphmQ4acKkXw2QFFQUp5GzBFZwkEgkgw4V56HMgv8PNRt1GagjiYdNKpkX/hZ
D1GymD4yz4AGH98AYvWlagG66NhjU9MiFCrJ5Jslk43fHqLIYcjUviHbVy4WQbR1ZqbbPR0e
Tv47zo/59niyR9MtcVY9mCCC8RLDumpiFQGtTRhoaVWbbQCh8XaxQZnYDE8dYUOIovlQ1ZwS
ic5rEt0NR2kBLAqvZWw9eKhUlGR0zeheywSeXluauZgEsXuOMPJegn4WBd4id33VGT5CAqAp
lmRp3K2kzPNCAKbeVyVgAZSZ546ypPDd7ZPYrhGaeniXFN2wOrMBmv+USqGO7EBQa6sDzd4c
9F2VtJeDvpEkbLCWPQyc9eDAhKtWosmDrYWWh9vD41fjla2WVps+i3L5tV3QGQtPgtOs7apF
E5jyg0IeYZOKogr/FFE35BkT3lG/7T6+vMJe+b5z9oR6XkH/KIGWtmVLR64KM4hFAyoLNZ6K
tUUAjMSYKgLWAcZzVGWGt5VMFPC2PG6E5iNZiqZM9Ky5KnR8FCCK2vnJ7WqJ2ARdp30y7Rew
3EO9AgWiNmqbWBRJDCI3HNgadLqOvMgWQdllkVVK/nEWG0UuIDOQrh9+1cE+BJ619NGNVHoU
FPyYHkH4bf/2enNzdfv72W86GlOp0ehfXmiRlwbm2o+5NnzYBu7G43GziNirkybJlefrN1fX
ZldnjJ7I0MKc+Vv86deN+XSh7xELxzn8LZIrb4s/eTG33k/esg93myRXvqG4vTj3fPJWz8dp
Nub60m4MCGC4rAZOITfKnp1fnXrHHpDcXU2kCdooy8yWjt88M5s5gs99beTUch1/yX/miv/M
Jx58zVdyy1OfXXi6dumht1bQsspuhsakJVhv0mEoIailelKFERyJvNMVxhkOJ37fVAymqYIO
EzS4mG2T5bl5YWrELQKRZ5x5YiKAc3/ptg8OkhyvubmIss86TzfZ1nV9s8za1G5c3yXss/V5
YTjN88ITs7rcHV5230++Pjx+A2VxPlVJY8N4wiQPFq1tW/1x2L+8fyMv85fn3duTG3gpnzOi
O5/GEUJCcY5S8gr0p5HBX89HE8U+uhSXumEFBHFVPygjAZ+UZ3y5ie929Pr8A4SJ39/3z7sT
EHsev71Rbx4l/OB2iOrBC3Sa2XWGYY6hPhKGNq9h2zrPeBeVRhSD7JlwfHgRh3jZLqt1qUuU
pIqgvAqV1I2I4DSPHXzRY5BCKnQTfAIymixpxC22HXwCWBao7dvCjIkXQSwVn5Z3ZPUliJwx
lgur3Odxhmmt1iX/aDqNgiG5wCdF09pNl4QtCIoYOQKyRxF0UWqowxZOjlBV5pzaAJIsKECr
IM9iys5lfyip0HyxFsFyqO17wZSZCgW45o4FTgGgciY+n/59xlFJI6D9YZQTRf7ZSBZxEu/+
+nh6MrYpjarYdJjEy20+YukdCC9iXCbjNvtpTVhdZRgmUHIKz1wVLJDEXflNBYMaODlVLCop
9vNrRs12HnBRVal8JotGCyTaHCbJbcOI8TZfroBeBWNbpVecB2aSkxWNjONnCh95WVNSSNM2
bP6M82Sq4ZXLDpZMre+Oue/UAdTqkrxaOxuFR1Jx6scyaAPjXicBjvUa1Cot4CmKCAhlAKwO
jVpbbop6rh7JshJYTV/AET0EbMCQanya0daSAf649k/y18dvHz8kq04fXp70DARVtOxrKNrB
ctI1Mczr5kXiWVIHwA91Mgoa+Cc0yDl6MfsB0E5ufQonMNFHfqIgzkYHJMxSUbM0xxqskXkb
bNPYDZb1g5pYLjBxssFoJfOaUNTSqu8+n52fMh+ayPxtMUmmpkxrY30HvBo4dlzxhgJZDFh7
xVusDLyq/tREjn2YX9WDWYjtOH8JNI96go2Gj/mwIUrJQ0QZyzn1Lmj8+lKI2rCYqW0O4mNR
T/IVrvOZ3Z/86+3H/gX972//d/L88b77ewf/2L0//vHHH/82d4CsjqI7nav4dQOcwDXZUTHs
md2mpgPpoRMb0TpsRQUJ2HAP+XotMcDJq3UddKnzpXUrCqcYNcw6vhAG0o7LbRXCO/ZjzoJc
+ErjmAV1BgdynuCZxS0xahLsRxDGhbycrwnZczdVDUwFplitLS9cQoTUG0eiC4wAppASIhb4
bGoZe5KjqgNPnqfecYD/1YujzChkbJvVCs0I75Zq/bIBmWsz47aKREQgLgP7B8GnHZd8E/Ws
gEOLFpCa8Usff11KjXrito7EoeGtshoGD1mYBRjskUmcnxkl7clBoLhj7gKaa/9OCZHNKD7O
UTnwRRWKRPtPjH5e3vakxnIQTQPHSlb+KQVdznTfl1IGtkhNWzpyd7aWiSaHNpXRlg+spSws
87J12Q3mGCSUbqJEwWNq3nHsognqlKcZdbtknBQ/clhnXTpe8jW+I9FFVPUgh4D6VDWxRYLm
XloQSAmScNk5lcAibrYWMFK1yaq1dUtdoeABq92yKZHJUhtkSGGfJHr3KRyU6K37ayUwnm5o
obeRO2haVcRQ10Cou/Sc+kYXvl2RInQn254Jd4417wQzwaydno5EvNJIvTaT8zR3IIwlTGnN
CUDlj5HI4/sIQbqGPXCMQK0itVK4I0PNeluCAI8ZruzlMCImSd+dGjGEwPdhXuWdUjlTszlE
x5En1eP1IHRQAiNBS4EqJ2zHiaSCVT/iPX2iJTVXYTbGXjdSQrKhS/hcKObZHTkLDw7rxIFZ
lI7xxw08cJeh6jM/v/hR1UxUoxrfQ5jjOugCOF9qv86Ld6V8wRDjqBrednSqMYnVZpY0hMCj
0yJoeNZhoOezSyP4ZZtl1wQI1Ng08uEcab2cDCeQDc9xGDzKlHt2cXtJt9xtzXeeP7wCX2fe
s7UBxgqnNLVZ3mQqdQEBoCSsgMKmMymCmyA5t6TAZt3WESnC+XgDmc4/RE2Ifl+f4EHeZxy+
iUhbwaLBTW/LklJc/XR5VJbE7qRiQ45KrazsZkdznIq89t2YI7olEHZsqAmhycyaOLWHWVew
gVeE7Xs9/INArg2CwE0atCnFVFgIhNsTqmc7lN9BESSq6q3bvpp76hKjR7Dp2p4wK+QiQORo
kuPX21+yQtvrDLgscCB8a8Fwl4rCu4rIHFYOZDUDAaLpa69o1uJlQpY3a7adRWxEweHvY5ad
PoRdIHcC3lWHM0DjyaFlJ3KJecMwkQV5tigLPh2hpCj7PHdGnVDHLXAY8zZkrZRqTPM77oCo
UzRMLRiZo1QhslLoAf8iaPKt8jHoderwIQ4XfBS9QUVptuOQ8x3RvbgOt6+VUmNGOKq0FiIf
Vz1sHMduq2wNeZjkvZnHWV8h00HkynL49Vige7OZ2M+MzSrpdKEE38Pp5uZ0tqbYOJiQMx6n
tsw5j0UZ5vOFJu2NWPwcHxM4U3iS508UveMzsino844lzGii3jqlWJNXCi1dnvvJNRM6NIfl
wFYvcCNlJch3vgAk+SXSOfw6d5ExsybnlFwaphIqLy7hcXOkdX25lhGpoMkeJ5CuJRJMWKF+
Ilz0MnhNXjjYPX4c9u8/Xa8bsc+f+q85LGruA5xwcNqjZgQUeO7xUxCqKljppW9RKFbsetzI
MpRths+8VGyHOIVpE/JZF08Qp4j6BuWKuBAtBXMTT+IcUYpSE5kVxIgWGutT8TSaGIFeGBmc
mLVVHtjq/lSSz1XqqX/YJE3BfN604RE/oRDxUsjsrHgmS8tdYBivHaIjKD0U1EuD3W5r82RK
gJlh9KCMPeadfngyYyX4rrsUkQxdxUXLLv/2n7e/9i//+XjbHZ5fv+x+/7r7/mN3+I0ZZtiB
Wem52jgTFUHEv3UykcC+rLZcvoeJIqiB6RSGw8NGaUZ4x+juEqcBe2q4hE4KVQ/JELQwlh4X
n6+MCgT4RaFt4E2V24kFkrB8UjJ0bgg1VmsRxQF3hNtkn397+PHjAVbHYU7eRCkIRlYXHX7+
eH89eXw97E5eDydyBWn36GS+giBfBHoCMAN87sKFkbBjBrqkYb6MsjrVF7yNcQuZ0rgGdEkb
wyw1wVhCzetsNd3bksDX+mVdu9QAdGvA84NpThs4sNjttIgY4Jxqi4W7H1OBzSz1EGct8XHy
QThUi+Ts/KbotSxkCqEkaBdoRJQpeE1/mfWs8Mj873rRC6dG+uMutsIDD/ouhVOUScnhUWrH
hB1Z4Va2AN6lNFoUaNzJGdPsyQs3H+9fdy/v+8eH992XE/HyiDsPpIuT/+3fv54Eb2+vj3tC
xQ/vD84OjKKCafQi4n0vY6E0gP/OT+sq33pSuU6bc5Fhtk5m10qEO5eEOb/65Mz8WAT+0ZYg
/LXi3EuT/5IIvnCMBthkj3mmmEU1oqjgsWEiQmgMm2bMIqFJd5fbhKZG+tHBauP2oRV32YrZ
2mkAotFqvMwb0oVnPOff3NURcks6StjsPwrZuVs+Yja4iEIHljdr5nN1xGqVCrth6gapdd3Q
+9TyktjD21dfBzGjo8PxOeBGjoUJXElKGbmxf9q9vbtfaKKLc7ekBMvrVTySh2KqOY4tArI7
OzXe1h73cmq8WTMOqtq63HgrFClTbMD0uPziS3ffxFcuLIMlh9lRsojZTk0RwxI+to+Q4tOR
TQR4jl8A+OL81JnINg3OWCDssVZcuLsIOB3wCi/y6ux8Qtotp2oL/rquWX1xZEupjxTuhpGF
OfDVmcsuAMz0oLhgJqVbNGe3R5nbuoZP+NtMq26gtYrp2MZ1LmXD/Y+vZlaFkS+7WxlgQ5cx
LLxVy5NFaV+0kGUfZsxXmujSAYZ5tU4yZu+MCOZZI5viV1sI3yXJ8yxw97NCjL10WOqIl2cY
8P9/TnnuG7oowCBa2Sm3mrbjuAXBte8f62vbuWuVoHr77UbFouVgF4OIha9MQn/dcyEN7hkN
og3yNmA4xSjmcL1WqF92GuNZmIO5qUXJJnCTGDru/0HdkvjI4Gkk3llvCwZWC/1ZuEmWdZWH
bl3RJvHAfctpRHvaZKKHi3Ww9dIY3Z+i3g+7tzeQgh0mA7pYLu+D2WOf3/P5FhT65vIIu8vv
3T4ALHUP/vu2m16Hax5evrw+n5Qfz3/tDjKRy8M712h85WiIalQ6na3QhLZfUMcoWcbujMT5
HhPWiUCe83cbKZzv/pnh6+dovTUsX5pOOHBK/4gYtXC7NRO+Vbqxv1kTaWOGENhoNB34a6ET
zIyOHDFrd7DFaqiD2MoB5ODYM07HwxnNTRdQRJ5cRhrJXdCBMn9ze/V3xNuvLdroYrPhbXc2
4afzf0Q3fnzFpzDkPv8PSaEBK87XqdHZyYKCdlsUAi3RZMYmdwaHrPswVzRtH5pkm6vT2yES
aGnN8OIJej4Mo0a9jNrr6TrPhJVsaHd4x1RCoH2/0cN4b/unl4f3j4O6imMEAKqMopqBvjFC
lVx8i5nTZ1uhxItN1wR6i32GxaqMg2Zrf48ziMqKw5yykbWdt2kzBe0ciqKcc7uT9Xy50szs
IwSDnKI0s/OQKUxiR6sp+NBUfWc0Y8JSaIZeDoFm9l6EyNz7dcLUULQZA8UAhkbkwUZGOkRC
FzGQYJXY3xgDzGJYm9u8kleMKO2biKzC9jV4o7My2f2MVJcusnvrOo8xwFSYxGCz34Umkcih
6Sn/rPbxVTpmeLVAq9bgcATUGZakwjRHrXohmkkLoWjDrMQlqGIvxpDw/V+Hh8PPk8Prx/v+
RVfZw6xrBGY71van9Erp94rGEW+7pozQvdJUhWWI1ElyUXqw0PkBVph+V3tEUYBFkjUyQsTF
Yw7nrDLim0aUBSYXP6YxiIp6E6Uy8lreMtIpMAggQeGc8krXeWbaVSM4HODQNUBnxrMqSCPt
AywPhXZ1/dDpwkV0YRlU0fjARenYJMBLRbj1KfQaiSfVnyQJmrXFvAy8HHa9kLc2LlN7noWu
XSbSHj/bbExfgIxH10ZgRt1DZSgm5EaWAYLOsub43ftL2ucNOoWfNWga8XAKUFDwuW4QIQcP
mKPf3CNY1zYkBKVmdtQUmhJPsfkrFUEWfDLumitw4EkDOqO7tGcNHooCE1VHdvuHMPrTgal4
MgWcOz8s7jMjqGRCoKTu7ErGhxtGqfGDLvWOkQ8zxoh508UL4JMZMCcKUmoCwwPcIhcQhQ3C
6BQrKBJjf/SXaUqB13Bk3CBwroXuniYcPXAT1DLO3mIiFGxIb4GCqmTwLcTACYVXpCr9+l27
zqou18xO7SKfbqro8f0FXneqkoTiX7lNiyenmV3pTufZeRWav+Z9pl0QN9OARPk9RgJogKqJ
TQsjdJaLf4HzFDN4zyWLOjNe6MTcZA06CYyg94kTy6yWWcmgaozTMrSbOexMJjIaKFxJZpzx
ExURvqWuDbwMc9RG5f8B9P+Lho/cAQA=

--azLHFNyN32YCQGCU--
