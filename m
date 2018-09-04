Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5712AC43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:36:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1CEBC20867
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:36:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1CEBC20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727789AbeIDUCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 16:02:15 -0400
Received: from mga11.intel.com ([192.55.52.93]:21798 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726961AbeIDUCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 16:02:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 08:36:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="82914239"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by fmsmga002.fm.intel.com with ESMTP; 04 Sep 2018 08:36:34 -0700
Date:   Tue, 4 Sep 2018 23:49:09 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     kbuild-all@01.org, robh+dt@kernel.org, maxime.ripard@bootlin.com,
        wens@csie.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@kernel.org, airlied@linux.ie, architt@codeaurora.org,
        a.hajda@samsung.com, jernej.skrabec@siol.net,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-sunxi@googlegroups.com
Subject: Re: [PATCH 06/27] clk: sunxi-ng: h6: Set video PLLs limits
Message-ID: <20180904154909.GR17047@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180902072643.4917-7-jernej.skrabec@siol.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jernej,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on sunxi/sunxi/for-next]
[also build test WARNING on v4.19-rc2 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jernej-Skrabec/Allwinner-H6-DE3-and-HDMI-support/20180903-082543
base:   https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git sunxi/for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__
:::::: branch date: 6 hours ago
:::::: commit date: 6 hours ago

>> drivers/clk/sunxi-ng/ccu-sun50i-h6.c:124:27: sparse: constant 2400000000 is so big it is long
   drivers/clk/sunxi-ng/ccu-sun50i-h6.c:142:27: sparse: constant 2400000000 is so big it is long

# https://github.com/0day-ci/linux/commit/752a88510f0bcada69753fccb31adb187f80f29a
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 752a88510f0bcada69753fccb31adb187f80f29a
vim +124 drivers/clk/sunxi-ng/ccu-sun50i-h6.c

524353ea4 Icenowy Zheng  2018-03-16  111  
524353ea4 Icenowy Zheng  2018-03-16  112  /*
524353ea4 Icenowy Zheng  2018-03-16  113   * For Video PLLs, the output divider is described as "used for testing"
524353ea4 Icenowy Zheng  2018-03-16  114   * in the user manual. So it's not modelled and forced to 0.
524353ea4 Icenowy Zheng  2018-03-16  115   */
524353ea4 Icenowy Zheng  2018-03-16  116  #define SUN50I_H6_PLL_VIDEO0_REG	0x040
524353ea4 Icenowy Zheng  2018-03-16  117  static struct ccu_nm pll_video0_clk = {
524353ea4 Icenowy Zheng  2018-03-16  118  	.enable		= BIT(31),
524353ea4 Icenowy Zheng  2018-03-16  119  	.lock		= BIT(28),
524353ea4 Icenowy Zheng  2018-03-16  120  	.n		= _SUNXI_CCU_MULT_MIN(8, 8, 12),
524353ea4 Icenowy Zheng  2018-03-16  121  	.m		= _SUNXI_CCU_DIV(1, 1), /* input divider */
524353ea4 Icenowy Zheng  2018-03-16  122  	.fixed_post_div	= 4,
752a88510 Jernej Skrabec 2018-09-02  123  	.min_rate	= 288000000,
752a88510 Jernej Skrabec 2018-09-02 @124  	.max_rate	= 2400000000,
524353ea4 Icenowy Zheng  2018-03-16  125  	.common		= {
524353ea4 Icenowy Zheng  2018-03-16  126  		.reg		= 0x040,
524353ea4 Icenowy Zheng  2018-03-16  127  		.features	= CCU_FEATURE_FIXED_POSTDIV,
524353ea4 Icenowy Zheng  2018-03-16  128  		.hw.init	= CLK_HW_INIT("pll-video0", "osc24M",
524353ea4 Icenowy Zheng  2018-03-16  129  					      &ccu_nm_ops,
524353ea4 Icenowy Zheng  2018-03-16  130  					      CLK_SET_RATE_UNGATE),
524353ea4 Icenowy Zheng  2018-03-16  131  	},
524353ea4 Icenowy Zheng  2018-03-16  132  };
524353ea4 Icenowy Zheng  2018-03-16  133  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
