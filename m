Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751565AbeD3J5L (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 05:57:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:24875 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbeD3J5K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 05:57:10 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,346,1520924400";
   d="scan'208";a="220431407"
Date: Mon, 30 Apr 2018 17:56:08 +0800
From: kbuild test robot <lkp@intel.com>
To: Sultan Alsawaf <sultanxda@gmail.com>
Cc: kbuild-all@01.org, linux-kernel@vger.kernel.org, tytso@mit.edu
Subject: Re: [PATCH] random: remove unused argument from
 add_interrupt_randomness()
Message-ID: <201804301721.JEar9rKK%fengguang.wu@intel.com>
References: <20180430031222.mapajgwprkkr6p36@sultan-box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430031222.mapajgwprkkr6p36@sultan-box>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sultan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v4.17-rc3 next-20180426]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Sultan-Alsawaf/random-remove-unused-argument-from-add_interrupt_randomness/20180430-111445
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/hv/hv.c:118:33: sparse: too many arguments for function add_interrupt_randomness
   drivers/hv/hv.c: In function 'hv_stimer0_isr':
   drivers/hv/hv.c:118:2: error: too many arguments to function 'add_interrupt_randomness'
     add_interrupt_randomness(stimer0_vector, 0);
     ^~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/hv/hv.c:30:0:
   include/linux/random.h:35:13: note: declared here
    extern void add_interrupt_randomness(int irq) __latent_entropy;
                ^~~~~~~~~~~~~~~~~~~~~~~~

vim +118 drivers/hv/hv.c

3e7ee490 drivers/staging/hv/Hv.c Hank Janssen   2009-07-13  105  
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  106  /*
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  107   * ISR for when stimer0 is operating in Direct Mode.  Direct Mode
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  108   * does not use VMbus or any VMbus messages, so process here and not
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  109   * in the VMbus driver code.
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  110   */
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  111  
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  112  static void hv_stimer0_isr(void)
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  113  {
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  114  	struct hv_per_cpu_context *hv_cpu;
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  115  
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  116  	hv_cpu = this_cpu_ptr(hv_context.cpu_context);
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  117  	hv_cpu->clk_evt->event_handler(hv_cpu->clk_evt);
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04 @118  	add_interrupt_randomness(stimer0_vector, 0);
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  119  }
248e742a drivers/hv/hv.c         Michael Kelley 2018-03-04  120  

:::::: The code at line 118 was first introduced by commit
:::::: 248e742a396e7f00b283f1c56e14b1bef6e3ec56 Drivers: hv: vmbus: Implement Direct Mode for stimer0

:::::: TO: Michael Kelley <mhkelley@outlook.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
