Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49166C5CFE7
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBE4208E5
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 11:54:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFBE4208E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933285AbeGJLyE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 07:54:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:23412 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932620AbeGJLyC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 07:54:02 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 04:54:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="gz'50?scan'50,208,50";a="65797956"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga003.jf.intel.com with ESMTP; 10 Jul 2018 04:53:59 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fcrDS-0009kW-GR; Tue, 10 Jul 2018 19:53:58 +0800
Date:   Tue, 10 Jul 2018 19:53:36 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Petr Mladek <pmladek@suse.com>
Cc:     kbuild-all@01.org, Maninder Singh <maninder1.s@samsung.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vaneet Narang <v.narang@samsung.com>,
        PANKAJ MISHRA <pankaj.m@samsung.com>
Subject: Re: [PATCH] printk: Fix warning about unused
 suppress_message_printing
Message-ID: <201807101928.55g4DgyB%fengguang.wu@intel.com>
References: <20180710091909.rwgtahcew6grhd6n@pathway.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
In-Reply-To: <20180710091909.rwgtahcew6grhd6n@pathway.suse.cz>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Petr,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc4 next-20180709]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Petr-Mladek/printk-Fix-warning-about-unused-suppress_message_printing/20180710-174802
config: ia64-allnoconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

   kernel/printk/printk.c: In function 'console_unlock':
>> kernel/printk/printk.c:2351:7: error: implicit declaration of function 'suppress_message_printing' [-Werror=implicit-function-declaration]
      if (suppress_message_printing(msg->level)) {
          ^~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/suppress_message_printing +2351 kernel/printk/printk.c

a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2273  
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2274  /**
ac751efa6 kernel/printk.c        Torben Hohn             2011-01-25  2275   * console_unlock - unlock the console system
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2276   *
ac751efa6 kernel/printk.c        Torben Hohn             2011-01-25  2277   * Releases the console_lock which the caller holds on the console system
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2278   * and the console driver list.
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2279   *
ac751efa6 kernel/printk.c        Torben Hohn             2011-01-25  2280   * While the console_lock was held, console output may have been buffered
ac751efa6 kernel/printk.c        Torben Hohn             2011-01-25  2281   * by printk().  If this is the case, console_unlock(); emits
ac751efa6 kernel/printk.c        Torben Hohn             2011-01-25  2282   * the output prior to releasing the lock.
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2283   *
7f3a781d6 kernel/printk.c        Kay Sievers             2012-05-09  2284   * If there is output waiting, we wake /dev/kmsg and syslog() users.
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2285   *
ac751efa6 kernel/printk.c        Torben Hohn             2011-01-25  2286   * console_unlock(); may be called from any context.
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2287   */
ac751efa6 kernel/printk.c        Torben Hohn             2011-01-25  2288  void console_unlock(void)
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2289  {
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2290  	static char ext_text[CONSOLE_EXT_LOG_MAX];
704982531 kernel/printk.c        Kay Sievers             2012-07-16  2291  	static char text[LOG_LINE_MAX + PREFIX_MAX];
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2292  	unsigned long flags;
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2293  	bool do_cond_resched, retry;
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2294  
557240b48 kernel/printk.c        Linus Torvalds          2006-06-19  2295  	if (console_suspended) {
bd8d7cf5b kernel/printk/printk.c Jan Kara                2014-06-04  2296  		up_console_sem();
557240b48 kernel/printk.c        Linus Torvalds          2006-06-19  2297  		return;
557240b48 kernel/printk.c        Linus Torvalds          2006-06-19  2298  	}
78944e549 kernel/printk.c        Antonino A. Daplas      2006-08-05  2299  
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2300  	/*
257ab4431 kernel/printk/printk.c Petr Mladek             2017-03-24  2301  	 * Console drivers are called with interrupts disabled, so
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2302  	 * @console_may_schedule should be cleared before; however, we may
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2303  	 * end up dumping a lot of lines, for example, if called from
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2304  	 * console registration path, and should invoke cond_resched()
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2305  	 * between lines if allowable.  Not doing so can cause a very long
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2306  	 * scheduling stall on a slow console leading to RCU stall and
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2307  	 * softlockup warnings which exacerbate the issue with more
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2308  	 * messages practically incapacitating the system.
257ab4431 kernel/printk/printk.c Petr Mladek             2017-03-24  2309  	 *
257ab4431 kernel/printk/printk.c Petr Mladek             2017-03-24  2310  	 * console_trylock() is not able to detect the preemptive
257ab4431 kernel/printk/printk.c Petr Mladek             2017-03-24  2311  	 * context reliably. Therefore the value must be stored before
257ab4431 kernel/printk/printk.c Petr Mladek             2017-03-24  2312  	 * and cleared after the the "again" goto label.
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2313  	 */
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2314  	do_cond_resched = console_may_schedule;
257ab4431 kernel/printk/printk.c Petr Mladek             2017-03-24  2315  again:
78944e549 kernel/printk.c        Antonino A. Daplas      2006-08-05  2316  	console_may_schedule = 0;
78944e549 kernel/printk.c        Antonino A. Daplas      2006-08-05  2317  
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2318  	/*
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2319  	 * We released the console_sem lock, so we need to recheck if
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2320  	 * cpu is online and (if not) is there at least one CON_ANYTIME
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2321  	 * console.
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2322  	 */
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2323  	if (!can_use_console()) {
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2324  		console_locked = 0;
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2325  		up_console_sem();
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2326  		return;
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2327  	}
a8199371a kernel/printk/printk.c Sergey Senozhatsky      2016-03-17  2328  
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2329  	for (;;) {
62e32ac35 kernel/printk/printk.c Joe Perches             2013-07-31  2330  		struct printk_log *msg;
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2331  		size_t ext_len = 0;
3ce9a7c0a kernel/printk.c        Kay Sievers             2012-05-13  2332  		size_t len;
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2333  
f975237b7 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2334  		printk_safe_enter_irqsave(flags);
f975237b7 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2335  		raw_spin_lock(&logbuf_lock);
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2336  		if (console_seq < log_first_seq) {
9afe77ed8 kernel/printk/printk.c Maxim Akristiniy        2017-10-23  2337  			len = sprintf(text, "** %u printk messages dropped **\n",
84b5ec8a9 kernel/printk/printk.c Will Deacon             2014-06-04  2338  				      (unsigned)(log_first_seq - console_seq));
84b5ec8a9 kernel/printk/printk.c Will Deacon             2014-06-04  2339  
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2340  			/* messages are gone, move to first one */
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2341  			console_seq = log_first_seq;
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2342  			console_idx = log_first_idx;
84b5ec8a9 kernel/printk/printk.c Will Deacon             2014-06-04  2343  		} else {
84b5ec8a9 kernel/printk/printk.c Will Deacon             2014-06-04  2344  			len = 0;
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2345  		}
084681d14 kernel/printk.c        Kay Sievers             2012-06-28  2346  skip:
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2347  		if (console_seq == log_next_seq)
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2348  			break;
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2349  
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2350  		msg = log_from_idx(console_idx);
d9c23523e kernel/printk/printk.c Sergey Senozhatsky      2016-12-24 @2351  		if (suppress_message_printing(msg->level)) {
084681d14 kernel/printk.c        Kay Sievers             2012-06-28  2352  			/*
084681d14 kernel/printk.c        Kay Sievers             2012-06-28  2353  			 * Skip record we have buffered and already printed
cf7754441 kernel/printk/printk.c Sergey Senozhatsky      2016-08-02  2354  			 * directly to the console when we received it, and
cf7754441 kernel/printk/printk.c Sergey Senozhatsky      2016-08-02  2355  			 * record that has level above the console loglevel.
084681d14 kernel/printk.c        Kay Sievers             2012-06-28  2356  			 */
084681d14 kernel/printk.c        Kay Sievers             2012-06-28  2357  			console_idx = log_next(console_idx);
084681d14 kernel/printk.c        Kay Sievers             2012-06-28  2358  			console_seq++;
084681d14 kernel/printk.c        Kay Sievers             2012-06-28  2359  			goto skip;
084681d14 kernel/printk.c        Kay Sievers             2012-06-28  2360  		}
649e6ee33 kernel/printk.c        Kay Sievers             2012-05-10  2361  
cca10d58d kernel/printk/printk.c Sergey Senozhatsky      2017-12-21  2362  		len += msg_print_text(msg,
cca10d58d kernel/printk/printk.c Sergey Senozhatsky      2017-12-21  2363  				console_msg_format & MSG_FORMAT_SYSLOG,
cca10d58d kernel/printk/printk.c Sergey Senozhatsky      2017-12-21  2364  				text + len,
cca10d58d kernel/printk/printk.c Sergey Senozhatsky      2017-12-21  2365  				sizeof(text) - len);
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2366  		if (nr_ext_console_drivers) {
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2367  			ext_len = msg_print_ext_header(ext_text,
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2368  						sizeof(ext_text),
5aa068ea4 kernel/printk/printk.c Linus Torvalds          2016-10-25  2369  						msg, console_seq);
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2370  			ext_len += msg_print_ext_body(ext_text + ext_len,
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2371  						sizeof(ext_text) - ext_len,
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2372  						log_dict(msg), msg->dict_len,
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2373  						log_text(msg), msg->text_len);
6fe29354b kernel/printk/printk.c Tejun Heo               2015-06-25  2374  		}
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2375  		console_idx = log_next(console_idx);
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2376  		console_seq++;
07354eb1a kernel/printk.c        Thomas Gleixner         2009-07-25  2377  		raw_spin_unlock(&logbuf_lock);
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2378  
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2379) 		/*
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2380) 		 * While actively printing out messages, if another printk()
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2381) 		 * were to occur on another CPU, it may wait for this one to
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2382) 		 * finish. This task can not be preempted if there is a
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2383) 		 * waiter waiting to take over.
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2384) 		 */
c162d5b43 kernel/printk/printk.c Petr Mladek             2018-01-12  2385  		console_lock_spinning_enable();
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2386) 
81d68a96a kernel/printk.c        Steven Rostedt          2008-05-12  2387  		stop_critical_timings();	/* don't trace print latency */
d9c23523e kernel/printk/printk.c Sergey Senozhatsky      2016-12-24  2388  		call_console_drivers(ext_text, ext_len, text, len);
81d68a96a kernel/printk.c        Steven Rostedt          2008-05-12  2389  		start_critical_timings();
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2390) 
c162d5b43 kernel/printk/printk.c Petr Mladek             2018-01-12  2391  		if (console_lock_spinning_disable_and_check()) {
c162d5b43 kernel/printk/printk.c Petr Mladek             2018-01-12  2392  			printk_safe_exit_irqrestore(flags);
43a17111c kernel/printk/printk.c Sergey Senozhatsky      2018-04-19  2393  			return;
c162d5b43 kernel/printk/printk.c Petr Mladek             2018-01-12  2394  		}
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2395) 
f975237b7 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2396  		printk_safe_exit_irqrestore(flags);
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2397  
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2398  		if (do_cond_resched)
8d91f8b15 kernel/printk/printk.c Tejun Heo               2016-01-15  2399  			cond_resched();
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2400  	}
dbdda842f kernel/printk/printk.c Steven Rostedt (VMware  2018-01-10  2401) 
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2402  	console_locked = 0;
fe3d8ad31 kernel/printk.c        Feng Tang               2011-03-22  2403  
fe3d8ad31 kernel/printk.c        Feng Tang               2011-03-22  2404  	/* Release the exclusive_console once it is used */
fe3d8ad31 kernel/printk.c        Feng Tang               2011-03-22  2405  	if (unlikely(exclusive_console))
fe3d8ad31 kernel/printk.c        Feng Tang               2011-03-22  2406  		exclusive_console = NULL;
fe3d8ad31 kernel/printk.c        Feng Tang               2011-03-22  2407  
07354eb1a kernel/printk.c        Thomas Gleixner         2009-07-25  2408  	raw_spin_unlock(&logbuf_lock);
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2409  
bd8d7cf5b kernel/printk/printk.c Jan Kara                2014-06-04  2410  	up_console_sem();
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2411  
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2412  	/*
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2413  	 * Someone could have filled up the buffer again, so re-check if there's
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2414  	 * something to flush. In case we cannot trylock the console_sem again,
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2415  	 * there's a new owner and the console_unlock() from them will do the
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2416  	 * flush, no worries.
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2417  	 */
07354eb1a kernel/printk.c        Thomas Gleixner         2009-07-25  2418  	raw_spin_lock(&logbuf_lock);
7ff9554bb kernel/printk.c        Kay Sievers             2012-05-03  2419  	retry = console_seq != log_next_seq;
f975237b7 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2420  	raw_spin_unlock(&logbuf_lock);
f975237b7 kernel/printk/printk.c Sergey Senozhatsky      2016-12-27  2421  	printk_safe_exit_irqrestore(flags);
09dc3cf93 kernel/printk.c        Peter Zijlstra          2011-12-08  2422  
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2423  	if (retry && console_trylock())
4f2a8d3cf kernel/printk.c        Peter Zijlstra          2011-06-22  2424  		goto again;
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2425  }
ac751efa6 kernel/printk.c        Torben Hohn             2011-01-25  2426  EXPORT_SYMBOL(console_unlock);
^1da177e4 kernel/printk.c        Linus Torvalds          2005-04-16  2427  

:::::: The code at line 2351 was first introduced by commit
:::::: d9c23523ed98a3acaa0bfd8fef143595d6aa631d printk: drop call_console_drivers() unused param

:::::: TO: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
:::::: CC: Petr Mladek <pmladek@suse.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--XsQoSWH+UP9D9v3l
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
JRomG88BHTMp+v8Hhr12dJVNAAA=

--XsQoSWH+UP9D9v3l--
