Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754029AbeA3Xg4 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 18:36:56 -0500
Received: from mga07.intel.com ([134.134.136.100]:5423 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753965AbeA3Xgz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 18:36:55 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,436,1511856000";
   d="scan'208";a="30748102"
Date: Wed, 31 Jan 2018 07:49:04 +0800
From: kbuild test robot <lkp@intel.com>
To: Mike Kravetz <mike.kravetz@oracle.com>
Cc: kbuild-all@01.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Michal Hocko <mhocko@kernel.org>,
        =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>,
        David Herrmann <dh.herrmann@gmail.com>,
        Khalid Aziz <khalid.aziz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH 3/3] mm: memfd: remove memfd code from shmem files and
 use new memfd files
Message-ID: <201801310705.HNIeJce6%fengguang.wu@intel.com>
References: <20180130000101.7329-4-mike.kravetz@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180130000101.7329-4-mike.kravetz@oracle.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on mmotm/master]
[also build test WARNING on next-20180126]
[cannot apply to linus/master v4.15]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mike-Kravetz/restructure-memfd-code/20180131-023405
base:   git://git.cmpxchg.org/linux-mmotm.git master
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> mm/memfd.c:40:9: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:40:9: expected void
   mm/memfd.c:40:9: got void
>> mm/memfd.c:40:9: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:40:9: expected void
   mm/memfd.c:40:9: got void
>> mm/memfd.c:41:46: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got @@
   mm/memfd.c:41:46: expected void
   mm/memfd.c:41:46: got void
   mm/memfd.c:44:38: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:44:38: expected void
   mm/memfd.c:44:38: got void
   mm/memfd.c:55:55: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got @@
   mm/memfd.c:55:55: expected void
   mm/memfd.c:55:55: got void
   mm/memfd.c:55:30: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:55:30: expected void
   mm/memfd.c:55:30: got void
   mm/memfd.c:40:9: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got @@
   mm/memfd.c:40:9: expected void
   mm/memfd.c:40:9: got void
>> mm/memfd.c:40:9: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:40:9: expected void
   mm/memfd.c:40:9: got void
   mm/memfd.c:93:17: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:93:17: expected void
   mm/memfd.c:93:17: got void
   mm/memfd.c:93:17: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:93:17: expected void
   mm/memfd.c:93:17: got void
   mm/memfd.c:96:54: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got @@
   mm/memfd.c:96:54: expected void
   mm/memfd.c:96:54: got void
   mm/memfd.c:99:46: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:99:46: expected void
   mm/memfd.c:99:46: got void
   mm/memfd.c:125:63: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got @@
   mm/memfd.c:125:63: expected void
   mm/memfd.c:125:63: got void
   mm/memfd.c:125:38: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:125:38: expected void
   mm/memfd.c:125:38: got void
   mm/memfd.c:93:17: sparse: incorrect type in argument 1 (different address spaces) @@ expected void @@ got @@
   mm/memfd.c:93:17: expected void
   mm/memfd.c:93:17: got void
   mm/memfd.c:93:17: sparse: incorrect type in assignment (different address spaces) @@ expected void @@ got void <avoid @@
   mm/memfd.c:93:17: expected void
   mm/memfd.c:93:17: got void

vim +40 mm/memfd.c

6df4ed2a41 Mike Kravetz 2018-01-29  28  
6df4ed2a41 Mike Kravetz 2018-01-29  29  static void shmem_tag_pins(struct address_space *mapping)
6df4ed2a41 Mike Kravetz 2018-01-29  30  {
6df4ed2a41 Mike Kravetz 2018-01-29  31  	struct radix_tree_iter iter;
6df4ed2a41 Mike Kravetz 2018-01-29  32  	void **slot;
6df4ed2a41 Mike Kravetz 2018-01-29  33  	pgoff_t start;
6df4ed2a41 Mike Kravetz 2018-01-29  34  	struct page *page;
6df4ed2a41 Mike Kravetz 2018-01-29  35  
6df4ed2a41 Mike Kravetz 2018-01-29  36  	lru_add_drain();
6df4ed2a41 Mike Kravetz 2018-01-29  37  	start = 0;
6df4ed2a41 Mike Kravetz 2018-01-29  38  	rcu_read_lock();
6df4ed2a41 Mike Kravetz 2018-01-29  39  
6df4ed2a41 Mike Kravetz 2018-01-29 @40  	radix_tree_for_each_slot(slot, &mapping->page_tree, &iter, start) {
6df4ed2a41 Mike Kravetz 2018-01-29 @41  		page = radix_tree_deref_slot(slot);
6df4ed2a41 Mike Kravetz 2018-01-29  42  		if (!page || radix_tree_exception(page)) {
6df4ed2a41 Mike Kravetz 2018-01-29  43  			if (radix_tree_deref_retry(page)) {
6df4ed2a41 Mike Kravetz 2018-01-29  44  				slot = radix_tree_iter_retry(&iter);
6df4ed2a41 Mike Kravetz 2018-01-29  45  				continue;
6df4ed2a41 Mike Kravetz 2018-01-29  46  			}
6df4ed2a41 Mike Kravetz 2018-01-29  47  		} else if (page_count(page) - page_mapcount(page) > 1) {
6df4ed2a41 Mike Kravetz 2018-01-29  48  			spin_lock_irq(&mapping->tree_lock);
6df4ed2a41 Mike Kravetz 2018-01-29  49  			radix_tree_tag_set(&mapping->page_tree, iter.index,
6df4ed2a41 Mike Kravetz 2018-01-29  50  					   SHMEM_TAG_PINNED);
6df4ed2a41 Mike Kravetz 2018-01-29  51  			spin_unlock_irq(&mapping->tree_lock);
6df4ed2a41 Mike Kravetz 2018-01-29  52  		}
6df4ed2a41 Mike Kravetz 2018-01-29  53  
6df4ed2a41 Mike Kravetz 2018-01-29  54  		if (need_resched()) {
6df4ed2a41 Mike Kravetz 2018-01-29  55  			slot = radix_tree_iter_resume(slot, &iter);
6df4ed2a41 Mike Kravetz 2018-01-29  56  			cond_resched_rcu();
6df4ed2a41 Mike Kravetz 2018-01-29  57  		}
6df4ed2a41 Mike Kravetz 2018-01-29  58  	}
6df4ed2a41 Mike Kravetz 2018-01-29  59  	rcu_read_unlock();
6df4ed2a41 Mike Kravetz 2018-01-29  60  }
6df4ed2a41 Mike Kravetz 2018-01-29  61  

:::::: The code at line 40 was first introduced by commit
:::::: 6df4ed2a410bc04f1ec04dce16ccd236707f7f32 mm: memfd: split out memfd for use by multiple filesystems

:::::: TO: Mike Kravetz <mike.kravetz@oracle.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
