Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754581AbeBBUBC (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:01:02 -0500
Received: from mga01.intel.com ([192.55.52.88]:49009 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752291AbeBBUA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:00:56 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,450,1511856000";
   d="gz'50?scan'50,208,50";a="24291935"
Date: Sat, 3 Feb 2018 04:00:35 +0800
From: kbuild test robot <lkp@intel.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: kbuild-all@01.org, Stafford Horne <shorne@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        David Howells <dhowells@redhat.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: asm-generic: Disallow no-op mb() for SMP systems
Message-ID: <201802030326.M4zaX4v1%fengguang.wu@intel.com>
References: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="BOKacYhQ+x31HxR3"
Content-Disposition: inline
In-Reply-To: <20180131130034.GR2269@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BOKacYhQ+x31HxR3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peter,

I love your patch! Yet something to improve:

[auto build test ERROR on asm-generic/master]
[also build test ERROR on v4.15 next-20180202]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Zijlstra/asm-generic-Disallow-no-op-mb-for-SMP-systems/20180203-000108
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arnd/asm-generic.git master
config: m32r-usrv_defconfig (attached as .config)
compiler: m32r-linux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=m32r 

All errors (new ones prefixed by >>):

   In file included from arch/m32r/include/asm/barrier.h:14:0,
                    from arch/m32r/include/asm/atomic.h:16,
                    from include/linux/atomic.h:4,
                    from include/linux/filter.h:9,
                    from include/net/sock_reuseport.h:4,
                    from net/core/sock_reuseport.c:8:
   include/asm-generic/atomic-long.h: In function 'atomic_long_read_acquire':
>> include/asm-generic/barrier.h:64:20: error: implicit declaration of function 'mb'; did you mean 'wmb'? [-Werror=implicit-function-declaration]
    #define __smp_mb() mb()
                       ^
   include/asm-generic/barrier.h:143:2: note: in expansion of macro '__smp_mb'
     __smp_mb();       \
     ^~~~~~~~
   include/asm-generic/barrier.h:167:29: note: in expansion of macro '__smp_load_acquire'
    #define smp_load_acquire(p) __smp_load_acquire(p)
                                ^~~~~~~~~~~~~~~~~~
   include/linux/atomic.h:26:34: note: in expansion of macro 'smp_load_acquire'
    #define  atomic_read_acquire(v)  smp_load_acquire(&(v)->counter)
                                     ^~~~~~~~~~~~~~~~
   include/asm-generic/atomic-long.h:33:28: note: in expansion of macro 'atomic_read_acquire'
    #define ATOMIC_LONG_PFX(x) atomic ## x
                               ^~~~~~
   include/asm-generic/atomic-long.h:42:15: note: in expansion of macro 'ATOMIC_LONG_PFX'
     return (long)ATOMIC_LONG_PFX(_read##mo)(v);   \
                  ^~~~~~~~~~~~~~~
   include/asm-generic/atomic-long.h:45:1: note: in expansion of macro 'ATOMIC_LONG_READ_OP'
    ATOMIC_LONG_READ_OP(_acquire)
    ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +64 include/asm-generic/barrier.h

885df91c David Howells      2012-03-28  62  
a9e4252a Michael S. Tsirkin 2015-12-27  63  #ifndef __smp_mb
a9e4252a Michael S. Tsirkin 2015-12-27 @64  #define __smp_mb()	mb()
a9e4252a Michael S. Tsirkin 2015-12-27  65  #endif
a9e4252a Michael S. Tsirkin 2015-12-27  66  

:::::: The code at line 64 was first introduced by commit
:::::: a9e4252a9b147043142282ebb65da94dcb951e2a asm-generic: add __smp_xxx wrappers

:::::: TO: Michael S. Tsirkin <mst@redhat.com>
:::::: CC: Michael S. Tsirkin <mst@redhat.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--BOKacYhQ+x31HxR3
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3/8BtoJXqPSFAAA=

--BOKacYhQ+x31HxR3--
