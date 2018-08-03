Return-Path: <SRS0=+aXO=KS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 658E7C28CF6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE95F216F6
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Aug 2018 06:45:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE95F216F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729245AbeHCIjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Aug 2018 04:39:51 -0400
Received: from mga09.intel.com ([134.134.136.24]:61107 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727594AbeHCIjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Aug 2018 04:39:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 23:45:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,437,1526367600"; 
   d="gz'50?scan'50,208,50";a="62048636"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2018 23:43:46 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1flToO-0005LM-VR; Fri, 03 Aug 2018 14:43:44 +0800
Date:   Fri, 3 Aug 2018 14:42:56 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Alan Kao <alankao@andestech.com>
Cc:     kbuild-all@01.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <albert@sifive.com>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Waterman <andrew@sifive.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Darius Rad <darius@bluespec.com>,
        Alan Kao <alankao@andestech.com>,
        Greentime Hu <greentime@andestech.com>,
        Vincent Chen <vincentc@andestech.com>,
        Zong Li <zong@andestech.com>, Nick Hu <nickhu@andestech.com>
Subject: Re: [PATCH v3 2/4] Refactor FPU codes in signal setup/return
 procedures
Message-ID: <201808031430.WGz9wpcD%fengguang.wu@intel.com>
References: <1533188391-5932-3-git-send-email-alankao@andestech.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PEIAKu/WMn1b1Hv9"
Content-Disposition: inline
In-Reply-To: <1533188391-5932-3-git-send-email-alankao@andestech.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PEIAKu/WMn1b1Hv9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Alan,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v4.18-rc7 next-20180802]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Alan-Kao/Extract-FPU-context-operations-from-entry-S/20180803-064749
config: riscv-defconfig (attached as .config)
compiler: riscv64-linux-gcc (GCC) 8.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=8.1.0 make.cross ARCH=riscv 

All errors (new ones prefixed by >>):

   In file included from include/asm-generic/bug.h:18,
                    from arch/riscv/include/asm/bug.h:75,
                    from include/linux/bug.h:5,
                    from include/linux/signal.h:5,
                    from arch/riscv/kernel/signal.c:22:
   arch/riscv/kernel/signal.c: In function 'save_fp_state':
>> arch/riscv/kernel/signal.c:80:38: error: 'sc_fpregs' is a pointer; did you mean to use '->'?
     for (i = 0; i < ARRAY_SIZE(sc_fpregs.q.reserved); i++) {
                                         ^
   include/linux/kernel.h:72:33: note: in definition of macro 'ARRAY_SIZE'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                    ^~~
>> arch/riscv/kernel/signal.c:80:38: error: 'sc_fpregs' is a pointer; did you mean to use '->'?
     for (i = 0; i < ARRAY_SIZE(sc_fpregs.q.reserved); i++) {
                                         ^
   include/linux/kernel.h:72:48: note: in definition of macro 'ARRAY_SIZE'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                   ^~~
   In file included from include/linux/kernel.h:15,
                    from include/asm-generic/bug.h:18,
                    from arch/riscv/include/asm/bug.h:75,
                    from include/linux/bug.h:5,
                    from include/linux/signal.h:5,
                    from arch/riscv/kernel/signal.c:22:
>> arch/riscv/kernel/signal.c:80:38: error: 'sc_fpregs' is a pointer; did you mean to use '->'?
     for (i = 0; i < ARRAY_SIZE(sc_fpregs.q.reserved); i++) {
                                         ^
   include/linux/build_bug.h:29:56: note: in definition of macro 'BUILD_BUG_ON_ZERO'
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                           ^
   include/linux/compiler-gcc.h:65:46: note: in expansion of macro '__same_type'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                                                 ^~~~~~~~~~~
   include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c:80:18: note: in expansion of macro 'ARRAY_SIZE'
     for (i = 0; i < ARRAY_SIZE(sc_fpregs.q.reserved); i++) {
                     ^~~~~~~~~~
>> arch/riscv/kernel/signal.c:80:38: error: 'sc_fpregs' is a pointer; did you mean to use '->'?
     for (i = 0; i < ARRAY_SIZE(sc_fpregs.q.reserved); i++) {
                                         ^
   include/linux/build_bug.h:29:56: note: in definition of macro 'BUILD_BUG_ON_ZERO'
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                           ^
   include/linux/compiler-gcc.h:65:46: note: in expansion of macro '__same_type'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                                                 ^~~~~~~~~~~
   include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c:80:18: note: in expansion of macro 'ARRAY_SIZE'
     for (i = 0; i < ARRAY_SIZE(sc_fpregs.q.reserved); i++) {
                     ^~~~~~~~~~
   include/linux/build_bug.h:29:45: error: bit-field '<anonymous>' width not an integer constant
    #define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:(-!!(e)); }))
                                                ^
   include/linux/compiler-gcc.h:65:28: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
    #define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
                               ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:72:59: note: in expansion of macro '__must_be_array'
    #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                                              ^~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c:80:18: note: in expansion of macro 'ARRAY_SIZE'
     for (i = 0; i < ARRAY_SIZE(sc_fpregs.q.reserved); i++) {
                     ^~~~~~~~~~
   In file included from include/linux/uaccess.h:14,
                    from arch/riscv/kernel/signal.c:23:
   arch/riscv/kernel/signal.c:81:33: error: 'sc_fpregs' is a pointer; did you mean to use '->'?
      err = __put_user(0, &sc_fpregs.q.reserved[i]);
                                    ^
   arch/riscv/include/asm/uaccess.h:348:15: note: in definition of macro '__put_user'
     __typeof__(*(ptr)) __user *__gu_ptr = (ptr);  \
                  ^~~
   arch/riscv/kernel/signal.c:81:33: error: 'sc_fpregs' is a pointer; did you mean to use '->'?
      err = __put_user(0, &sc_fpregs.q.reserved[i]);
                                    ^
   arch/riscv/include/asm/uaccess.h:348:41: note: in definition of macro '__put_user'
     __typeof__(*(ptr)) __user *__gu_ptr = (ptr);  \
                                            ^~~

vim +80 arch/riscv/kernel/signal.c

  > 22	#include <linux/signal.h>
    23	#include <linux/uaccess.h>
    24	#include <linux/syscalls.h>
    25	#include <linux/tracehook.h>
    26	#include <linux/linkage.h>
    27	
    28	#include <asm/ucontext.h>
    29	#include <asm/vdso.h>
    30	#include <asm/switch_to.h>
    31	#include <asm/csr.h>
    32	
    33	#define DEBUG_SIG 0
    34	
    35	struct rt_sigframe {
    36		struct siginfo info;
    37		struct ucontext uc;
    38	};
    39	
    40	static long restore_fp_state(struct pt_regs *regs,
    41		union __riscv_fp_state *sc_fpregs)
    42	{
    43		long err;
    44		struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
    45		size_t i;
    46	
    47		err = __copy_from_user(&current->thread.fstate, state, sizeof(*state));
    48		if (unlikely(err))
    49			return err;
    50	
    51		fstate_restore(current, regs);
    52	
    53		/* We support no other extension state at this time. */
    54		for (i = 0; i < ARRAY_SIZE(sc_fpregs->q.reserved); i++) {
    55			u32 value;
    56	
    57			err = __get_user(value, &sc_fpregs->q.reserved[i]);
    58			if (unlikely(err))
    59				break;
    60			if (value != 0)
    61				return -EINVAL;
    62		}
    63	
    64		return err;
    65	}
    66	
    67	static long save_fp_state(struct pt_regs *regs,
    68		union __riscv_fp_state *sc_fpregs)
    69	{
    70		long err;
    71		struct __riscv_d_ext_state __user *state = &sc_fpregs->d;
    72		size_t i;
    73	
    74		fstate_save(current, regs);
    75		err = __copy_to_user(state, &current->thread.fstate, sizeof(*state));
    76		if (unlikely(err))
    77			return err;
    78	
    79		/* We support no other extension state at this time. */
  > 80		for (i = 0; i < ARRAY_SIZE(sc_fpregs.q.reserved); i++) {
    81			err = __put_user(0, &sc_fpregs.q.reserved[i]);
    82			if (unlikely(err))
    83				break;
    84		}
    85	
    86		return err;
    87	}
    88	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--PEIAKu/WMn1b1Hv9
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
+j/EC1Lf+QsBAA==

--PEIAKu/WMn1b1Hv9--
