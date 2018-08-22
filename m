Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D63F0C04E83
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:33:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97B152174D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 01:33:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97B152174D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727408AbeHVEzn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 00:55:43 -0400
Received: from mga18.intel.com ([134.134.136.126]:49474 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbeHVEzn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 00:55:43 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2018 18:33:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,271,1531810800"; 
   d="scan'208";a="82342415"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by fmsmga004.fm.intel.com with ESMTP; 21 Aug 2018 18:33:07 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fsI13-0001jm-VG; Wed, 22 Aug 2018 09:32:57 +0800
Date:   Wed, 22 Aug 2018 09:30:24 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     kbuild-all@01.org, Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, od@zcrc.me,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 1/3] clk: ingenic: Add proper Kconfig entries
Message-ID: <201808220915.eyVfvvWX%fengguang.wu@intel.com>
References: <20180821123819.25020-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180821123819.25020-1-paul@crapouillou.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on v4.18 next-20180821]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Paul-Cercueil/clk-ingenic-Add-proper-Kconfig-entries/20180822-003241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/clk/ingenic/cgu.c:137:13: sparse: expression using sizeof(void)
>> drivers/clk/ingenic/cgu.c:137:13: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:138:13: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:138:13: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:141:13: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:141:13: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:142:13: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:142:13: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:408:15: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:408:15: sparse: expression using sizeof(void)
   drivers/clk/ingenic/cgu.c:409:15: sparse: expression using sizeof(void)
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'

vim +137 drivers/clk/ingenic/cgu.c

b066303f Paul Burton 2015-05-24  120  
b066303f Paul Burton 2015-05-24  121  static unsigned long
b066303f Paul Burton 2015-05-24  122  ingenic_pll_calc(const struct ingenic_cgu_clk_info *clk_info,
b066303f Paul Burton 2015-05-24  123  		 unsigned long rate, unsigned long parent_rate,
b066303f Paul Burton 2015-05-24  124  		 unsigned *pm, unsigned *pn, unsigned *pod)
b066303f Paul Burton 2015-05-24  125  {
b066303f Paul Burton 2015-05-24  126  	const struct ingenic_cgu_pll_info *pll_info;
b066303f Paul Burton 2015-05-24  127  	unsigned m, n, od;
b066303f Paul Burton 2015-05-24  128  
b066303f Paul Burton 2015-05-24  129  	pll_info = &clk_info->pll;
b066303f Paul Burton 2015-05-24  130  	od = 1;
b066303f Paul Burton 2015-05-24  131  
b066303f Paul Burton 2015-05-24  132  	/*
b066303f Paul Burton 2015-05-24  133  	 * The frequency after the input divider must be between 10 and 50 MHz.
b066303f Paul Burton 2015-05-24  134  	 * The highest divider yields the best resolution.
b066303f Paul Burton 2015-05-24  135  	 */
b066303f Paul Burton 2015-05-24  136  	n = parent_rate / (10 * MHZ);
b066303f Paul Burton 2015-05-24 @137  	n = min_t(unsigned, n, 1 << clk_info->pll.n_bits);
b066303f Paul Burton 2015-05-24  138  	n = max_t(unsigned, n, pll_info->n_offset);
b066303f Paul Burton 2015-05-24  139  
b066303f Paul Burton 2015-05-24  140  	m = (rate / MHZ) * od * n / (parent_rate / MHZ);
b066303f Paul Burton 2015-05-24  141  	m = min_t(unsigned, m, 1 << clk_info->pll.m_bits);
b066303f Paul Burton 2015-05-24  142  	m = max_t(unsigned, m, pll_info->m_offset);
b066303f Paul Burton 2015-05-24  143  
b066303f Paul Burton 2015-05-24  144  	if (pm)
b066303f Paul Burton 2015-05-24  145  		*pm = m;
b066303f Paul Burton 2015-05-24  146  	if (pn)
b066303f Paul Burton 2015-05-24  147  		*pn = n;
b066303f Paul Burton 2015-05-24  148  	if (pod)
b066303f Paul Burton 2015-05-24  149  		*pod = od;
b066303f Paul Burton 2015-05-24  150  
b066303f Paul Burton 2015-05-24  151  	return div_u64((u64)parent_rate * m, n * od);
b066303f Paul Burton 2015-05-24  152  }
b066303f Paul Burton 2015-05-24  153  

:::::: The code at line 137 was first introduced by commit
:::::: b066303fb3e72a902a1f94dc06636ce82c3a5577 clk: ingenic: add driver for Ingenic SoC CGU clocks

:::::: TO: Paul Burton <paul.burton@imgtec.com>
:::::: CC: Ralf Baechle <ralf@linux-mips.org>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
