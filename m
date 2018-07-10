Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8D17C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4EF92089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4EF92089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933127AbeGJJm5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:42:57 -0400
Received: from mga05.intel.com ([192.55.52.43]:51928 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeGJJm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:42:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 02:42:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="gz'50?scan'50,208,50";a="214800509"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga004.jf.intel.com with ESMTP; 10 Jul 2018 02:41:58 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fcp9h-000Da1-Vx; Tue, 10 Jul 2018 17:41:58 +0800
Date:   Tue, 10 Jul 2018 17:41:01 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc:     kbuild-all@01.org, kbuild test robot <lkp@intel.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH] locking/rwsem: Convert the other sem->count to
 'atomic_long_t'
Message-ID: <201807101528.V7paNfVB%fengguang.wu@intel.com>
References: <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
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

Hi Tetsuo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on v4.18-rc4 next-20180709]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tetsuo-Handa/locking-rwsem-Convert-the-other-sem-count-to-atomic_long_t/20180710-141553
config: m68k-m5475evb_defconfig (attached as .config)
compiler: m68k-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=m68k 

All warnings (new ones prefixed by >>):

   In file included from include/linux/notifier.h:15:0,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:777,
                    from include/linux/gfp.h:6,
                    from include/linux/idr.h:16,
                    from include/linux/kernfs.h:14,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:29,
                    from drivers//pci/search.c:11:
   include/linux/rwsem.h:87:2: warning: missing braces around initializer [-Wmissing-braces]
     { __RWSEM_INIT_COUNT(name),    \
     ^
   include/linux/rwsem.h:94:29: note: in expansion of macro '__RWSEM_INITIALIZER'
     struct rw_semaphore name = __RWSEM_INITIALIZER(name)
                                ^~~~~~~~~~~~~~~~~~~
>> drivers//pci/search.c:17:1: note: in expansion of macro 'DECLARE_RWSEM'
    DECLARE_RWSEM(pci_bus_sem);
    ^~~~~~~~~~~~~

vim +/DECLARE_RWSEM +17 drivers//pci/search.c

^1da177e Linus Torvalds 2005-04-16 @11  #include <linux/pci.h>
5a0e3ad6 Tejun Heo      2010-03-24  12  #include <linux/slab.h>
^1da177e Linus Torvalds 2005-04-16  13  #include <linux/module.h>
^1da177e Linus Torvalds 2005-04-16  14  #include <linux/interrupt.h>
^1da177e Linus Torvalds 2005-04-16  15  #include "pci.h"
^1da177e Linus Torvalds 2005-04-16  16  
d71374da Zhang Yanmin   2006-06-02 @17  DECLARE_RWSEM(pci_bus_sem);
ce29ca3e Amos Kong      2012-05-23  18  EXPORT_SYMBOL_GPL(pci_bus_sem);
ce29ca3e Amos Kong      2012-05-23  19  

:::::: The code at line 17 was first introduced by commit
:::::: d71374dafbba7ec3f67371d3b7e9f6310a588808 [PATCH] PCI: fix race with pci_walk_bus and pci_destroy_dev

:::::: TO: Zhang Yanmin <yanmin.zhang@intel.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
c2IjJ3H3C7A/4Gj5VQAA

--C7zPtVaVf+AK4Oqc--
