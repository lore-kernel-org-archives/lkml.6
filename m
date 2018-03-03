Return-Path: <kernel-hardening-return-12082-gregkh=linuxfoundation.org@lists.openwall.com>
X-Google-Smtp-Source: AG47ELtBuDXEl1CpiZX+2q5Xr5Y3wYXCUat9QxGft4CMcmKHsOFau9DbaFEiCsJVjgPAWRoC7Cnc
ARC-Seal: i=1; a=rsa-sha256; t=1520044582; cv=none;
        d=google.com; s=arc-20160816;
        b=bML/tJD35h3xmSIF8XYbtik3RpfIZPjQYWCIxQbxOSaf2hrKH5XAc11N9yccUUCeab
         ScvJ19jyIqzenYPz9vzlzNTb+RyYq3iUCkprMlDyTVm5jUEV299omvvl77+zWkrwBFyl
         sl6GcXeEXhCZrX5zKv3zhNcQeBjrG7VYwzUGzaL9MLdMOhXnVIGNUcG+KBgTV3S9Hdbx
         dIG1wzGEDZdnTyg4gvoOKDPDWGqFPTmjpEm6RyXn/95kbYWa4v9G0NVDNQEbqT9eISde
         cIrYC2XMIJNaO3yDg5hBaDiDm6YnkHP/+s7QDq9swmo4MeaAU/1thQKwOmE5V+23hKv/
         t8xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:delivered-to:list-id
         :list-subscribe:list-unsubscribe:list-help:list-post:precedence
         :mailing-list:arc-authentication-results;
        bh=rHeC+5Qh+4crSVi8nCAdrHuaRZaYr9Y3iFH/1JR3jiM=;
        b=Rgs1NXdAWYDU6s8s0HpF0XtuiAHTXsC4+uranRPUOaQtXZPAu5lotQHca/G1P4S8fb
         RYk2sMgZiqaesLMtv2tobjNP5RtUcbAGXinF7S2xWDOy65oXmDMtb0IN3yXC5+SOC5gQ
         5c8ZOdgbBdYm3hEQUxWMX3KIBxTo9vv7wFpOpoXu9v4G8AZvwbcS7420hq8tHC2gJqee
         APxPIeQp1oQIKthODk0mZGdZpm3vRLviCZe9a5/ZGs6dAqO3cY42fKKwIgJlQxeC1EAr
         rtYJS0hdc2wjKR1sDHzZ6gTvMYcnaWtVHuXCv+p5ihL62LhzeEUiNc4SccwQnLQ5iJE1
         ABoQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12082-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12082-gregkh=linuxfoundation.org@lists.openwall.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of kernel-hardening-return-12082-gregkh=linuxfoundation.org@lists.openwall.com designates 195.42.179.200 as permitted sender) smtp.mailfrom=kernel-hardening-return-12082-gregkh=linuxfoundation.org@lists.openwall.com
Mailing-List: contact kernel-hardening-help@lists.openwall.com; run by ezmlm
List-Post: <mailto:kernel-hardening@lists.openwall.com>
List-Help: <mailto:kernel-hardening-help@lists.openwall.com>
List-Unsubscribe: <mailto:kernel-hardening-unsubscribe@lists.openwall.com>
List-Subscribe: <mailto:kernel-hardening-subscribe@lists.openwall.com>
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,415,1515484800";
   d="scan'208";a="21536339"
Date: Sat, 3 Mar 2018 10:35:22 +0800
From: kbuild test robot <lkp@intel.com>
To: Igor Stoppa <igor.stoppa@huawei.com>
Cc: kbuild-all@01.org, david@fromorbit.com, willy@infradead.org,
	keescook@chromium.org, mhocko@kernel.org, labbott@redhat.com,
	linux-security-module@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com,
	Igor Stoppa <igor.stoppa@huawei.com>
Subject: Re: [PATCH 3/7] struct page: add field for vm_struct
Message-ID: <201803031002.5HqxXcrB%fengguang.wu@intel.com>
References: <20180228200620.30026-4-igor.stoppa@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228200620.30026-4-igor.stoppa@huawei.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593676685422778336?=
X-GMAIL-MSGID: =?utf-8?q?1593882267838961271?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Igor,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20180223]
[cannot apply to linus/master mmotm/master char-misc/char-misc-testing v4.16-rc3 v4.16-rc2 v4.16-rc1 v4.16-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Igor-Stoppa/mm-security-ro-protection-for-dynamic-data/20180302-232215
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   lib/genalloc.c:624:29: sparse: undefined identifier 'exit_test'
>> lib/genalloc.c:624:29: sparse: call with no type!
   In file included from arch/x86/include/asm/bug.h:83:0,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from lib/genalloc.c:99:
   lib/genalloc.c: In function 'gen_pool_free':
   lib/genalloc.c:616:10: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct gen_pool *' [-Wformat=]
             "Trying to free unallocated memory"
             ^
   include/asm-generic/bug.h:98:50: note: in definition of macro '__WARN_printf'
    #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                     ^~~
   lib/genalloc.c:615:5: note: in expansion of macro 'WARN'
        WARN(true,
        ^~~~
   lib/genalloc.c:617:23: note: format string is defined here
             " from pool %s", pool);
                         ~^
   In file included from include/asm-generic/bug.h:5:0,
                    from arch/x86/include/asm/bug.h:83,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from lib/genalloc.c:99:
   lib/genalloc.c:624:17: error: implicit declaration of function 'exit_test'; did you mean 'exit_sem'? [-Werror=implicit-function-declaration]
       if (unlikely(exit_test(boundary < 0))) {
                    ^
   include/linux/compiler.h:77:42: note: in definition of macro 'unlikely'
    # define unlikely(x) __builtin_expect(!!(x), 0)
                                             ^
   In file included from arch/x86/include/asm/bug.h:83:0,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from lib/genalloc.c:99:
   lib/genalloc.c:626:16: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct gen_pool *' [-Wformat=]
        WARN(true, "Corrupted pool %s", pool);
                   ^
   include/asm-generic/bug.h:98:50: note: in definition of macro '__WARN_printf'
    #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                     ^~~
   lib/genalloc.c:626:5: note: in expansion of macro 'WARN'
        WARN(true, "Corrupted pool %s", pool);
        ^~~~
   lib/genalloc.c:634:10: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct gen_pool *' [-Wformat=]
             "Size provided differs from size "
             ^
   include/asm-generic/bug.h:98:50: note: in definition of macro '__WARN_printf'
    #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                     ^~~
   lib/genalloc.c:633:5: note: in expansion of macro 'WARN'
        WARN(true,
        ^~~~
   lib/genalloc.c:635:31: note: format string is defined here
             "measured from pool %s", pool);
                                 ~^
   In file included from arch/x86/include/asm/bug.h:83:0,
                    from include/linux/bug.h:5,
                    from include/linux/mmdebug.h:5,
                    from include/linux/gfp.h:5,
                    from include/linux/slab.h:15,
                    from lib/genalloc.c:99:
   lib/genalloc.c:643:10: warning: format '%s' expects argument of type 'char *', but argument 2 has type 'struct gen_pool *' [-Wformat=]
             "Unexpected bitmap collision while"
             ^
   include/asm-generic/bug.h:98:50: note: in definition of macro '__WARN_printf'
    #define __WARN_printf(arg...) do { __warn_printk(arg); __WARN(); } while (0)
                                                     ^~~
   lib/genalloc.c:642:5: note: in expansion of macro 'WARN'
        WARN(true,
        ^~~~
   lib/genalloc.c:644:36: note: format string is defined here
             " freeing memory in pool %s", pool);
                                      ~^
   cc1: some warnings being treated as errors

vim +624 lib/genalloc.c

929f9727 Dean Nelson    2006-06-23  609  
7f184275 Huang Ying     2011-07-13  610  	rcu_read_lock();
7f184275 Huang Ying     2011-07-13  611  	list_for_each_entry_rcu(chunk, &pool->chunks, next_chunk) {
674470d9 Joonyoung Shim 2013-09-11  612  		if (addr >= chunk->start_addr && addr <= chunk->end_addr) {
3406f868 Igor Stoppa    2018-02-28  613  			if (unlikely(addr + size - 1 > chunk->end_addr)) {
7f184275 Huang Ying     2011-07-13  614  				rcu_read_unlock();
3406f868 Igor Stoppa    2018-02-28  615  				WARN(true,
3406f868 Igor Stoppa    2018-02-28  616  				     "Trying to free unallocated memory"
3406f868 Igor Stoppa    2018-02-28  617  				     " from pool %s", pool);
7f184275 Huang Ying     2011-07-13  618  				return;
f14f75b8 Jes Sorensen   2005-06-21  619  			}
3406f868 Igor Stoppa    2018-02-28  620  			start_entry = (addr - chunk->start_addr) >> order;
3406f868 Igor Stoppa    2018-02-28  621  			remaining_entries = (chunk->end_addr - addr) >> order;
3406f868 Igor Stoppa    2018-02-28  622  			boundary = get_boundary(chunk->entries, start_entry,
3406f868 Igor Stoppa    2018-02-28  623  						remaining_entries);
3406f868 Igor Stoppa    2018-02-28 @624  			if (unlikely(exit_test(boundary < 0))) {
3406f868 Igor Stoppa    2018-02-28  625  				rcu_read_unlock();
3406f868 Igor Stoppa    2018-02-28  626  				WARN(true, "Corrupted pool %s", pool);
3406f868 Igor Stoppa    2018-02-28  627  				return;
f14f75b8 Jes Sorensen   2005-06-21  628  			}
3406f868 Igor Stoppa    2018-02-28  629  			nentries = boundary - start_entry;
3406f868 Igor Stoppa    2018-02-28  630  			if (unlikely(size && (nentries !=
3406f868 Igor Stoppa    2018-02-28  631  					      mem_to_units(size, order)))) {
7f184275 Huang Ying     2011-07-13  632  				rcu_read_unlock();
3406f868 Igor Stoppa    2018-02-28  633  				WARN(true,
3406f868 Igor Stoppa    2018-02-28  634  				     "Size provided differs from size "
3406f868 Igor Stoppa    2018-02-28  635  				     "measured from pool %s", pool);
3406f868 Igor Stoppa    2018-02-28  636  				return;
3406f868 Igor Stoppa    2018-02-28  637  			}
3406f868 Igor Stoppa    2018-02-28  638  			remain = alter_bitmap_ll(CLEAR_BITS, chunk->entries,
3406f868 Igor Stoppa    2018-02-28  639  						 start_entry, nentries);
3406f868 Igor Stoppa    2018-02-28  640  			if (unlikely(remain)) {
3406f868 Igor Stoppa    2018-02-28  641  				rcu_read_unlock();
3406f868 Igor Stoppa    2018-02-28  642  				WARN(true,
3406f868 Igor Stoppa    2018-02-28  643  				     "Unexpected bitmap collision while"
3406f868 Igor Stoppa    2018-02-28  644  				     " freeing memory in pool %s", pool);
3406f868 Igor Stoppa    2018-02-28  645  				return;
3406f868 Igor Stoppa    2018-02-28  646  			}
3406f868 Igor Stoppa    2018-02-28  647  			atomic_long_add(nentries << order, &chunk->avail);
3406f868 Igor Stoppa    2018-02-28  648  			rcu_read_unlock();
3406f868 Igor Stoppa    2018-02-28  649  			return;
3406f868 Igor Stoppa    2018-02-28  650  		}
3406f868 Igor Stoppa    2018-02-28  651  	}
3406f868 Igor Stoppa    2018-02-28  652  	rcu_read_unlock();
3406f868 Igor Stoppa    2018-02-28  653  	WARN(true, "address not found in pool %s", pool->name);
f14f75b8 Jes Sorensen   2005-06-21  654  }
f14f75b8 Jes Sorensen   2005-06-21  655  EXPORT_SYMBOL(gen_pool_free);
7f184275 Huang Ying     2011-07-13  656  

:::::: The code at line 624 was first introduced by commit
:::::: 3406f8684f722bb52edc94f65976585acb6382ce genalloc: track beginning of allocations

:::::: TO: Igor Stoppa <igor.stoppa@huawei.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
