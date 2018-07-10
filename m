Return-Path: <SRS0=n7Wc=J2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809F0C3279B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:42:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CAF42089B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Jul 2018 09:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CAF42089B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932910AbeGJJmE (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Jul 2018 05:42:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:51904 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751194AbeGJJmC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jul 2018 05:42:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2018 02:42:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,334,1526367600"; 
   d="gz'50?scan'50,208,50";a="63567368"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Jul 2018 02:41:59 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fcp9i-000DeH-MN; Tue, 10 Jul 2018 17:41:58 +0800
Date:   Tue, 10 Jul 2018 17:41:15 +0800
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
Message-ID: <201807101519.nbGqyF4S%fengguang.wu@intel.com>
References: <201807100610.w6A6Apv4020906@www262.sakura.ne.jp>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
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


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Tetsuo,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/locking/core]
[also build test WARNING on v4.18-rc4 next-20180709]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Tetsuo-Handa/locking-rwsem-Convert-the-other-sem-count-to-atomic_long_t/20180710-141553
config: parisc-c3000_defconfig (attached as .config)
compiler: hppa-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=parisc 

All warnings (new ones prefixed by >>):

   In file included from include/linux/notifier.h:15:0,
                    from include/linux/memory_hotplug.h:7,
                    from include/linux/mmzone.h:777,
                    from include/linux/gfp.h:6,
                    from include/linux/umh.h:4,
                    from include/linux/kmod.h:22,
                    from include/linux/module.h:13,
                    from drivers/usb/core/hcd-pci.c:7:
   include/linux/rwsem.h:87:2: warning: missing braces around initializer [-Wmissing-braces]
     { __RWSEM_INIT_COUNT(name),    \
     ^
   include/linux/rwsem.h:94:29: note: in expansion of macro '__RWSEM_INITIALIZER'
     struct rw_semaphore name = __RWSEM_INITIALIZER(name)
                                ^~~~~~~~~~~~~~~~~~~
>> drivers/usb/core/hcd-pci.c:31:8: note: in expansion of macro 'DECLARE_RWSEM'
    static DECLARE_RWSEM(companions_rwsem);
           ^~~~~~~~~~~~~

vim +/DECLARE_RWSEM +31 drivers/usb/core/hcd-pci.c

^1da177e4 Linus Torvalds 2005-04-16  @7  #include <linux/module.h>
^1da177e4 Linus Torvalds 2005-04-16   8  #include <linux/pci.h>
21b1861fb David Brownell 2005-11-23   9  #include <linux/usb.h>
27729aadd Eric Lescouet  2010-04-24  10  #include <linux/usb/hcd.h>
21b1861fb David Brownell 2005-11-23  11  
^1da177e4 Linus Torvalds 2005-04-16  12  #include <asm/io.h>
^1da177e4 Linus Torvalds 2005-04-16  13  #include <asm/irq.h>
21b1861fb David Brownell 2005-11-23  14  
21b1861fb David Brownell 2005-11-23  15  #ifdef CONFIG_PPC_PMAC
21b1861fb David Brownell 2005-11-23  16  #include <asm/machdep.h>
21b1861fb David Brownell 2005-11-23  17  #include <asm/pmac_feature.h>
21b1861fb David Brownell 2005-11-23  18  #include <asm/prom.h>
21b1861fb David Brownell 2005-11-23  19  #endif
5f827ea3c David Brownell 2005-09-22  20  
5f827ea3c David Brownell 2005-09-22  21  #include "usb.h"
^1da177e4 Linus Torvalds 2005-04-16  22  
^1da177e4 Linus Torvalds 2005-04-16  23  
c6053ecff David Brownell 2005-04-18  24  /* PCI-based HCs are common, but plenty of non-PCI HCs are used too */
^1da177e4 Linus Torvalds 2005-04-16  25  
05768918b Alan Stern     2013-03-28  26  /*
05768918b Alan Stern     2013-03-28  27   * Coordinate handoffs between EHCI and companion controllers
05768918b Alan Stern     2013-03-28  28   * during EHCI probing and system resume.
6d19c009c Alan Stern     2010-02-12  29   */
6d19c009c Alan Stern     2010-02-12  30  
05768918b Alan Stern     2013-03-28 @31  static DECLARE_RWSEM(companions_rwsem);
6d19c009c Alan Stern     2010-02-12  32  

:::::: The code at line 31 was first introduced by commit
:::::: 05768918b9a122ce21bd55950df5054ff6c57f28 USB: improve port transitions when EHCI starts up

:::::: TO: Alan Stern <stern@rowland.harvard.edu>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
uR0olTy1v/4Pdh7+hEzoAAA=

--HlL+5n6rz5pIUxbD--
