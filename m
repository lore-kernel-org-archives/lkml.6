Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C2AC43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B12F208A5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 06:50:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B12F208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729653AbeGaI3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 04:29:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:56918 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726591AbeGaI3S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 04:29:18 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 23:50:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,426,1526367600"; 
   d="gz'50?scan'50,208,50";a="77408120"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga001.jf.intel.com with ESMTP; 30 Jul 2018 23:50:26 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fkOUD-000UbF-Ss; Tue, 31 Jul 2018 14:50:25 +0800
Date:   Tue, 31 Jul 2018 14:50:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     kbuild-all@01.org, akpm@linux-foundation.org, mka@chromium.org,
        ghackmann@android.com, ghackmann@google.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        stable@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Wei Wang <wvw@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        NeilBrown <neilb@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel.h: Disable -Wreturn-stack-address for _THIS_IP_
Message-ID: <201807311449.6TXkRCfh%fengguang.wu@intel.com>
References: <20180730170622.99349-1-ndesaulniers@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20180730170622.99349-1-ndesaulniers@google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Nick,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.18-rc7 next-20180727]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Nick-Desaulniers/kernel-h-Disable-Wreturn-stack-address-for-_THIS_IP_/20180731-135818
config: i386-tinyconfig (attached as .config)
compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   In file included from include/linux/spinlock.h:58:0,
                    from include/linux/mmzone.h:8,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:24,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/bottom_half.h: In function 'local_bh_disable':
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h: In function 'local_bh_enable':
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   In file included from include/linux/mmzone.h:8:0,
                    from include/linux/gfp.h:6,
                    from include/linux/slab.h:15,
                    from include/linux/crypto.h:24,
                    from arch/x86/kernel/asm-offsets.c:9:
   include/linux/spinlock.h: In function 'spin_lock_bh':
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_lock_bh(&lock->rlock);
    
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_unlock_bh':
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_unlock_bh(&lock->rlock);
    
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_trylock_bh':
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     return raw_spin_trylock_bh(&lock->rlock);
    
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
--
   In file included from include/linux/rcupdate.h:41:0,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel//sched/sched.h:5,
                    from kernel//sched/core.c:8:
   include/linux/bottom_half.h: In function 'local_bh_disable':
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h: In function 'local_bh_enable':
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   In file included from include/linux/seqlock.h:36:0,
                    from include/linux/time.h:6,
                    from include/linux/ktime.h:24,
                    from include/linux/rcutiny.h:28,
                    from include/linux/rcupdate.h:210,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel//sched/sched.h:5,
                    from kernel//sched/core.c:8:
   include/linux/spinlock.h: In function 'spin_lock_bh':
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_lock_bh(&lock->rlock);
    
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_unlock_bh':
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_unlock_bh(&lock->rlock);
    
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_trylock_bh':
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     return raw_spin_trylock_bh(&lock->rlock);
    
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel//sched/core.c: In function 'prepare_lock_switch':
>> kernel//sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
    
>> kernel//sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> kernel//sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel//sched/core.c: In function 'finish_lock_switch':
   kernel//sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
    
   kernel//sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel//sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
--
   In file included from include/linux/spinlock.h:58:0,
                    from include/linux/irq.h:14,
                    from arch/x86/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from kernel//time/timer.c:22:
   include/linux/bottom_half.h: In function 'local_bh_disable':
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h: In function 'local_bh_enable':
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   In file included from include/linux/irq.h:14:0,
                    from arch/x86/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from kernel//time/timer.c:22:
   include/linux/spinlock.h: In function 'spin_lock_bh':
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_lock_bh(&lock->rlock);
    
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_unlock_bh':
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_unlock_bh(&lock->rlock);
    
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_trylock_bh':
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     return raw_spin_trylock_bh(&lock->rlock);
    
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel//time/timer.c: In function 'call_timer_fn':
>> kernel//time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     lock_map_acquire(&lockdep_map);
    
>> kernel//time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> kernel//time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
--
   In file included from include/linux/rcupdate.h:41:0,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel///sched/sched.h:5,
                    from kernel///sched/core.c:8:
   include/linux/bottom_half.h: In function 'local_bh_disable':
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h: In function 'local_bh_enable':
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   In file included from include/linux/seqlock.h:36:0,
                    from include/linux/time.h:6,
                    from include/linux/ktime.h:24,
                    from include/linux/rcutiny.h:28,
                    from include/linux/rcupdate.h:210,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from kernel///sched/sched.h:5,
                    from kernel///sched/core.c:8:
   include/linux/spinlock.h: In function 'spin_lock_bh':
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_lock_bh(&lock->rlock);
    
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_unlock_bh':
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_unlock_bh(&lock->rlock);
    
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_trylock_bh':
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     return raw_spin_trylock_bh(&lock->rlock);
    
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel///sched/core.c: In function 'prepare_lock_switch':
   kernel///sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     spin_release(&rq->lock.dep_map, 1, _THIS_IP_);
    
   kernel///sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel///sched/core.c:2590:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel///sched/core.c: In function 'finish_lock_switch':
   kernel///sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     spin_acquire(&rq->lock.dep_map, 0, 0, _THIS_IP_);
    
   kernel///sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel///sched/core.c:2604:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
--
   In file included from include/linux/spinlock.h:58:0,
                    from include/linux/irq.h:14,
                    from arch/x86/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from kernel///time/timer.c:22:
   include/linux/bottom_half.h: In function 'local_bh_disable':
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/bottom_half.h:19:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h: In function 'local_bh_enable':
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     __local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
    
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/bottom_half.h:32:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   In file included from include/linux/irq.h:14:0,
                    from arch/x86/include/asm/hardirq.h:6,
                    from include/linux/hardirq.h:9,
                    from include/linux/interrupt.h:11,
                    from include/linux/kernel_stat.h:9,
                    from kernel///time/timer.c:22:
   include/linux/spinlock.h: In function 'spin_lock_bh':
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_lock_bh(&lock->rlock);
    
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
>> include/linux/spinlock.h:315:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_unlock_bh':
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     raw_spin_unlock_bh(&lock->rlock);
    
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:355:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h: In function 'spin_trylock_bh':
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     return raw_spin_trylock_bh(&lock->rlock);
    
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   include/linux/spinlock.h:370:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel///time/timer.c: In function 'call_timer_fn':
   kernel///time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
     lock_map_acquire(&lockdep_map);
    
   kernel///time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]
   kernel///time/timer.c:1323:0: warning: ignoring #pragma clang diagnostic [-Wunknown-pragmas]

vim +19 include/linux/bottom_half.h

0bd3a173 Peter Zijlstra 2013-11-19  16  
0bd3a173 Peter Zijlstra 2013-11-19  17  static inline void local_bh_disable(void)
0bd3a173 Peter Zijlstra 2013-11-19  18  {
0bd3a173 Peter Zijlstra 2013-11-19 @19  	__local_bh_disable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
0bd3a173 Peter Zijlstra 2013-11-19  20  }
0bd3a173 Peter Zijlstra 2013-11-19  21  

:::::: The code at line 19 was first introduced by commit
:::::: 0bd3a173d711857fc9f583eb5825386cc08f3948 sched/preempt, locking: Rework local_bh_{dis,en}able()

:::::: TO: Peter Zijlstra <peterz@infradead.org>
:::::: CC: Ingo Molnar <mingo@kernel.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--C7zPtVaVf+AK4Oqc--
