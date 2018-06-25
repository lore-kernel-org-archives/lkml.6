Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FF5C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6050426048
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 18:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6050426048
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965077AbeFYSy7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 14:54:59 -0400
Received: from mga06.intel.com ([134.134.136.31]:46546 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964891AbeFYSy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 14:54:58 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 11:54:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,271,1526367600"; 
   d="gz'50?scan'50,208,50";a="50458170"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jun 2018 11:54:56 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fXWdb-0001vn-Ak; Tue, 26 Jun 2018 02:54:55 +0800
Date:   Tue, 26 Jun 2018 02:53:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Chris von Recklinghausen <crecklin@redhat.com>
Cc:     kbuild-all@01.org, keescook@chromium.org,
        linux-kernel@vger.kernel.org, linux-mm@vger.kernel.org
Subject: Re: [PATCH] add param that allows bootline control of hardened
 usercopy
Message-ID: <201806260113.t6cmzQXR%fengguang.wu@intel.com>
References: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oyUTqETQ0mS9luUI"
Content-Disposition: inline
In-Reply-To: <1529939300-27461-1-git-send-email-crecklin@redhat.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oyUTqETQ0mS9luUI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Chris,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc2 next-20180625]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Chris-von-Recklinghausen/add-param-that-allows-bootline-control-of-hardened-usercopy/20180625-232835
config: m68k-multi_defconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=m68k 

All errors (new ones prefixed by >>):

   In file included from include/linux/thread_info.h:112:0,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:5,
                    from include/linux/rcupdate.h:38,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/m68k/kernel/asm-offsets.c:15:
   include/linux/jump_label.h: In function 'static_key_count':
>> include/linux/jump_label.h:194:9: error: implicit declaration of function 'atomic_read'; did you mean '__atomic_load'? [-Werror=implicit-function-declaration]
     return atomic_read(&key->enabled);
            ^~~~~~~~~~~
            __atomic_load
   include/linux/jump_label.h: In function 'static_key_slow_inc':
>> include/linux/jump_label.h:221:2: error: implicit declaration of function 'atomic_inc'; did you mean '__atomic_load'? [-Werror=implicit-function-declaration]
     atomic_inc(&key->enabled);
     ^~~~~~~~~~
     __atomic_load
   include/linux/jump_label.h: In function 'static_key_slow_dec':
>> include/linux/jump_label.h:227:2: error: implicit declaration of function 'atomic_dec'; did you mean '__atomic_clear'? [-Werror=implicit-function-declaration]
     atomic_dec(&key->enabled);
     ^~~~~~~~~~
     __atomic_clear
   include/linux/jump_label.h: In function 'static_key_enable':
>> include/linux/jump_label.h:254:2: error: implicit declaration of function 'atomic_set'; did you mean '__atomic_clear'? [-Werror=implicit-function-declaration]
     atomic_set(&key->enabled, 1);
     ^~~~~~~~~~
     __atomic_clear
   In file included from include/linux/atomic.h:5:0,
                    from include/linux/rcupdate.h:38,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/m68k/kernel/asm-offsets.c:15:
   arch/m68k/include/asm/atomic.h: At top level:
   arch/m68k/include/asm/atomic.h:125:20: warning: conflicting types for 'atomic_inc'
    static inline void atomic_inc(atomic_t *v)
                       ^~~~~~~~~~
   arch/m68k/include/asm/atomic.h:125:20: error: static declaration of 'atomic_inc' follows non-static declaration
   In file included from include/linux/thread_info.h:112:0,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:5,
                    from include/linux/rcupdate.h:38,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/m68k/kernel/asm-offsets.c:15:
   include/linux/jump_label.h:221:2: note: previous implicit declaration of 'atomic_inc' was here
     atomic_inc(&key->enabled);
     ^~~~~~~~~~
   In file included from include/linux/atomic.h:5:0,
                    from include/linux/rcupdate.h:38,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/m68k/kernel/asm-offsets.c:15:
   arch/m68k/include/asm/atomic.h:130:20: warning: conflicting types for 'atomic_dec'
    static inline void atomic_dec(atomic_t *v)
                       ^~~~~~~~~~
   arch/m68k/include/asm/atomic.h:130:20: error: static declaration of 'atomic_dec' follows non-static declaration
   In file included from include/linux/thread_info.h:112:0,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:81,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:5,
                    from include/linux/rcupdate.h:38,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from arch/m68k/kernel/asm-offsets.c:15:
   include/linux/jump_label.h:227:2: note: previous implicit declaration of 'atomic_dec' was here
     atomic_dec(&key->enabled);
     ^~~~~~~~~~
   cc1: some warnings being treated as errors
   make[2]: *** [arch/m68k/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [sub-make] Error 2

vim +194 include/linux/jump_label.h

1f69bf9c6 Jason Baron          2016-08-03  191  
4c5ea0a9c Paolo Bonzini        2016-06-21  192  static inline int static_key_count(struct static_key *key)
4c5ea0a9c Paolo Bonzini        2016-06-21  193  {
4c5ea0a9c Paolo Bonzini        2016-06-21 @194  	return atomic_read(&key->enabled);
4c5ea0a9c Paolo Bonzini        2016-06-21  195  }
4c5ea0a9c Paolo Bonzini        2016-06-21  196  
97ce2c88f Jeremy Fitzhardinge  2011-10-12  197  static __always_inline void jump_label_init(void)
97ce2c88f Jeremy Fitzhardinge  2011-10-12  198  {
c4b2c0c5f Hannes Frederic Sowa 2013-10-19  199  	static_key_initialized = true;
97ce2c88f Jeremy Fitzhardinge  2011-10-12  200  }
97ce2c88f Jeremy Fitzhardinge  2011-10-12  201  
578ae447e Josh Poimboeuf       2018-03-19  202  static inline void jump_label_invalidate_initmem(void) {}
333522447 Josh Poimboeuf       2018-02-20  203  
c5905afb0 Ingo Molnar          2012-02-24  204  static __always_inline bool static_key_false(struct static_key *key)
c5905afb0 Ingo Molnar          2012-02-24  205  {
ea5e9539a Mel Gorman           2014-06-04  206  	if (unlikely(static_key_count(key) > 0))
c5905afb0 Ingo Molnar          2012-02-24  207  		return true;
c5905afb0 Ingo Molnar          2012-02-24  208  	return false;
c5905afb0 Ingo Molnar          2012-02-24  209  }
c5905afb0 Ingo Molnar          2012-02-24  210  
c5905afb0 Ingo Molnar          2012-02-24  211  static __always_inline bool static_key_true(struct static_key *key)
d430d3d7e Jason Baron          2011-03-16  212  {
ea5e9539a Mel Gorman           2014-06-04  213  	if (likely(static_key_count(key) > 0))
d430d3d7e Jason Baron          2011-03-16  214  		return true;
d430d3d7e Jason Baron          2011-03-16  215  	return false;
d430d3d7e Jason Baron          2011-03-16  216  }
bf5438fca Jason Baron          2010-09-17  217  
c5905afb0 Ingo Molnar          2012-02-24  218  static inline void static_key_slow_inc(struct static_key *key)
d430d3d7e Jason Baron          2011-03-16  219  {
5cdda5117 Borislav Petkov      2017-10-18  220  	STATIC_KEY_CHECK_USE(key);
d430d3d7e Jason Baron          2011-03-16 @221  	atomic_inc(&key->enabled);
d430d3d7e Jason Baron          2011-03-16  222  }
bf5438fca Jason Baron          2010-09-17  223  
c5905afb0 Ingo Molnar          2012-02-24  224  static inline void static_key_slow_dec(struct static_key *key)
bf5438fca Jason Baron          2010-09-17  225  {
5cdda5117 Borislav Petkov      2017-10-18  226  	STATIC_KEY_CHECK_USE(key);
d430d3d7e Jason Baron          2011-03-16 @227  	atomic_dec(&key->enabled);
bf5438fca Jason Baron          2010-09-17  228  }
bf5438fca Jason Baron          2010-09-17  229  
ce48c1464 Peter Zijlstra       2018-01-22  230  #define static_key_slow_inc_cpuslocked(key) static_key_slow_inc(key)
ce48c1464 Peter Zijlstra       2018-01-22  231  #define static_key_slow_dec_cpuslocked(key) static_key_slow_dec(key)
ce48c1464 Peter Zijlstra       2018-01-22  232  
4c3ef6d79 Jason Baron          2010-09-17  233  static inline int jump_label_text_reserved(void *start, void *end)
4c3ef6d79 Jason Baron          2010-09-17  234  {
4c3ef6d79 Jason Baron          2010-09-17  235  	return 0;
4c3ef6d79 Jason Baron          2010-09-17  236  }
4c3ef6d79 Jason Baron          2010-09-17  237  
91bad2f8d Jason Baron          2010-10-01  238  static inline void jump_label_lock(void) {}
91bad2f8d Jason Baron          2010-10-01  239  static inline void jump_label_unlock(void) {}
91bad2f8d Jason Baron          2010-10-01  240  
d430d3d7e Jason Baron          2011-03-16  241  static inline int jump_label_apply_nops(struct module *mod)
d430d3d7e Jason Baron          2011-03-16  242  {
d430d3d7e Jason Baron          2011-03-16  243  	return 0;
d430d3d7e Jason Baron          2011-03-16  244  }
b20295207 Gleb Natapov         2011-11-27  245  
e33886b38 Peter Zijlstra       2015-07-24  246  static inline void static_key_enable(struct static_key *key)
e33886b38 Peter Zijlstra       2015-07-24  247  {
5cdda5117 Borislav Petkov      2017-10-18  248  	STATIC_KEY_CHECK_USE(key);
e33886b38 Peter Zijlstra       2015-07-24  249  
1dbb6704d Paolo Bonzini        2017-08-01  250  	if (atomic_read(&key->enabled) != 0) {
1dbb6704d Paolo Bonzini        2017-08-01  251  		WARN_ON_ONCE(atomic_read(&key->enabled) != 1);
1dbb6704d Paolo Bonzini        2017-08-01  252  		return;
1dbb6704d Paolo Bonzini        2017-08-01  253  	}
1dbb6704d Paolo Bonzini        2017-08-01 @254  	atomic_set(&key->enabled, 1);
e33886b38 Peter Zijlstra       2015-07-24  255  }
e33886b38 Peter Zijlstra       2015-07-24  256  

:::::: The code at line 194 was first introduced by commit
:::::: 4c5ea0a9cd02d6aa8adc86e100b2a4cff8d614ff locking/static_key: Fix concurrent static_key_slow_inc()

:::::: TO: Paolo Bonzini <pbonzini@redhat.com>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--oyUTqETQ0mS9luUI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
usXLY5V7I8i6wifAuNgdrfw/dWJAOknPAAA=

--oyUTqETQ0mS9luUI--
