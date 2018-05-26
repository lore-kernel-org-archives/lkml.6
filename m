Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031782AbeEZNqR (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 09:46:17 -0400
Received: from mga17.intel.com ([192.55.52.151]:15738 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1031721AbeEZNqP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 09:46:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,444,1520924400";
   d="scan'208";a="202695215"
Date: Sat, 26 May 2018 21:45:31 +0800
From: kbuild test robot <lkp@intel.com>
To: Michel Pollet <michel.pollet@bp.renesas.com>
Cc: kbuild-all@01.org, linux-renesas-soc@vger.kernel.org,
        Simon Horman <horms@verge.net.au>, phil.edworthy@renesas.com,
        Michel Pollet <buserror+upstream@gmail.com>,
        Michel Pollet <michel.pollet@bp.renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 5/5] clk: renesas: Renesas R9A06G032 clock driver
Message-ID: <201805261954.tlXfbMbi%fengguang.wu@intel.com>
References: <1527154169-32380-6-git-send-email-michel.pollet@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527154169-32380-6-git-send-email-michel.pollet@bp.renesas.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on renesas-drivers/clk-renesas]
[also build test WARNING on v4.17-rc6]
[cannot apply to robh/for-next]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Michel-Pollet/dt-bindings-Add-the-r9a06g032-sysctrl-h-file/20180526-154235
base:   https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git clk-renesas
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/renesas/r9a06g032-clocks.c:430:22: sparse: cast removes address space of expression
>> drivers/clk/renesas/r9a06g032-clocks.c:431:30: sparse: incorrect type in argument 1 (different address spaces) @@    expected unsigned int [noderef] [usertype] <asn:2>*reg @@    got eref] [usertype] <asn:2>*reg @@
   drivers/clk/renesas/r9a06g032-clocks.c:431:30:    expected unsigned int [noderef] [usertype] <asn:2>*reg
   drivers/clk/renesas/r9a06g032-clocks.c:431:30:    got unsigned int [usertype] *reg
   drivers/clk/renesas/r9a06g032-clocks.c:516:22: sparse: cast removes address space of expression
   drivers/clk/renesas/r9a06g032-clocks.c:528:38: sparse: incorrect type in argument 2 (different address spaces) @@    expected unsigned int [noderef] [usertype] <asn:2>*reg @@    got eref] [usertype] <asn:2>*reg @@
   drivers/clk/renesas/r9a06g032-clocks.c:528:38:    expected unsigned int [noderef] [usertype] <asn:2>*reg
   drivers/clk/renesas/r9a06g032-clocks.c:528:38:    got unsigned int [usertype] *reg

vim +430 drivers/clk/renesas/r9a06g032-clocks.c

   421	
   422	#define to_r9a06g032_divider(_hw) \
   423			container_of(_hw, struct r9a06g032_clk_div, hw)
   424	
   425	static unsigned long r9a06g032_divider_recalc_rate(
   426		struct clk_hw *hw,
   427		unsigned long parent_rate)
   428	{
   429		struct r9a06g032_clk_div *clk = to_r9a06g032_divider(hw);
 > 430		u32 *reg = ((u32 *)clk->clocks->reg) + clk->reg;
 > 431		long div = clk_readl(reg);
   432	
   433		if (div < clk->min)
   434			div = clk->min;
   435		else if (div > clk->max)
   436			div = clk->max;
   437		return DIV_ROUND_UP(parent_rate, div);
   438	}
   439	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
