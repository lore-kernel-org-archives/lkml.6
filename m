Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751558AbeCQGQI (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 02:16:08 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:25599 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750778AbeCQGQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 02:16:07 -0400
X-IronPort-AV: E=Sophos;i="5.48,319,1517871600";
   d="scan'208";a="318519758"
Date: Sat, 17 Mar 2018 07:16:06 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Daniel Schultz <d.schultz@phytec.de>
cc: lee.jones@linaro.org, zhangqing@rock-chips.com, xsf@rock-chips.com,
        tony.xie@rock-chips.com, w.egorov@phytec.de,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
Subject: Re: [PATCH v3] mfd: rk808: Add restart functionality (fwd)
Message-ID: <alpine.DEB.2.20.1803170714550.2543@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not possible to do the dereferences on line 381 on a null rk808
value.

julia

---------- Forwarded message ----------
Date: Sat, 17 Mar 2018 14:05:31 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [PATCH v3] mfd: rk808: Add restart functionality

CC: kbuild-all@01.org
In-Reply-To: <1521188783-14985-1-git-send-email-d.schultz@phytec.de>
References: <1521188783-14985-1-git-send-email-d.schultz@phytec.de>
TO: Daniel Schultz <d.schultz@phytec.de>
CC: lee.jones@linaro.org, zhangqing@rock-chips.com, xsf@rock-chips.com, tony.xie@rock-chips.com, w.egorov@phytec.de, linux-kernel@vger.kernel.org
CC: zhangqing@rock-chips.com, xsf@rock-chips.com, tony.xie@rock-chips.com, w.egorov@phytec.de, linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on v4.16-rc4]
[also build test WARNING on next-20180316]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Daniel-Schultz/mfd-rk808-Add-restart-functionality/20180317-110140
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/mfd/rk808.c:381:11-26: ERROR: rk808 is NULL but dereferenced.

# https://github.com/0day-ci/linux/commit/91c5d1a0547a025c6b1f1204aee5b1681e0145fe
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 91c5d1a0547a025c6b1f1204aee5b1681e0145fe
vim +381 drivers/mfd/rk808.c

990f05f6 Elaine Zhang   2017-08-21  372
91c5d1a0 Daniel Schultz 2018-03-16  373  static void rk808_update_bits(unsigned int reg, unsigned int bit_mask)
990f05f6 Elaine Zhang   2017-08-21  374  {
990f05f6 Elaine Zhang   2017-08-21  375  	int ret;
990f05f6 Elaine Zhang   2017-08-21  376  	struct rk808 *rk808 = i2c_get_clientdata(rk808_i2c_client);
990f05f6 Elaine Zhang   2017-08-21  377
990f05f6 Elaine Zhang   2017-08-21  378  	if (!rk808) {
990f05f6 Elaine Zhang   2017-08-21  379  		dev_warn(&rk808_i2c_client->dev,
91c5d1a0 Daniel Schultz 2018-03-16  380  			 "have no %s, so do nothing here\n",
91c5d1a0 Daniel Schultz 2018-03-16 @381  			 rk808->regmap_irq_chip->name);
990f05f6 Elaine Zhang   2017-08-21  382  		return;
990f05f6 Elaine Zhang   2017-08-21  383  	}
990f05f6 Elaine Zhang   2017-08-21  384
990f05f6 Elaine Zhang   2017-08-21  385  	ret = regmap_update_bits(rk808->regmap,
91c5d1a0 Daniel Schultz 2018-03-16  386  				 reg,
91c5d1a0 Daniel Schultz 2018-03-16  387  				 bit_mask, bit_mask);
990f05f6 Elaine Zhang   2017-08-21  388  	if (ret)
91c5d1a0 Daniel Schultz 2018-03-16  389  		dev_err(&rk808_i2c_client->dev, "can't write to DEVCTRL: %x!\n",
91c5d1a0 Daniel Schultz 2018-03-16  390  			ret);
990f05f6 Elaine Zhang   2017-08-21  391  }
990f05f6 Elaine Zhang   2017-08-21  392

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
