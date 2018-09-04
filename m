Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FAKE_REPLY_C,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36621C433F5
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:15:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAA1020843
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 15:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAA1020843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbeIDTlT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 15:41:19 -0400
Received: from mga05.intel.com ([192.55.52.43]:39423 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726206AbeIDTlT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 15:41:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Sep 2018 08:15:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,329,1531810800"; 
   d="scan'208";a="85917137"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.13.138])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2018 08:15:42 -0700
Date:   Tue, 4 Sep 2018 23:28:18 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc:     kbuild-all@01.org, Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Peter Korsgaard <peter.korsgaard@barco.com>,
        Peter Rosin <peda@axentia.se>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jiri Slaby <jslaby@suse.com>, Willy Tarreau <w@1wt.eu>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-doc@vger.kernel.org, linux-i2c@vger.kernel.org,
        linux-mmc@vger.kernel.org, netdev@vger.kernel.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-serial@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: Re: [PATCH v6 1/4] gpiolib: Pass bitmaps, not integer arrays, to
 get/set array
Message-ID: <20180904152817.GC17047@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180831225616.29221-2-jmkrzyszt@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Janusz,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on gpio/for-next]
[also build test WARNING on v4.19-rc2 next-20180831]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Janusz-Krzysztofik/gpiolib-speed-up-GPIO-array-processing/20180903-174241
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__
:::::: branch date: 9 hours ago
:::::: commit date: 9 hours ago

>> drivers/mux/gpio.c:25:9: sparse: Variable length array is used.
--
>> drivers/i2c/muxes/i2c-mux-gpio.c:29:9: sparse: Variable length array is used.
   include/linux/device.h:685:13: sparse: undefined identifier '__builtin_mul_overflow'
   include/linux/device.h:685:13: sparse: not a function <noident>
   include/linux/device.h:685:13: sparse: call with no type!

# https://github.com/0day-ci/linux/commit/00db98568b73a7b04c5120e5b87934c7355cc015
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 00db98568b73a7b04c5120e5b87934c7355cc015
vim +25 drivers/mux/gpio.c

2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  21  
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  22  static int mux_gpio_set(struct mux_control *mux, int state)
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  23  {
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  24  	struct mux_gpio *mux_gpio = mux_chip_priv(mux->chip);
00db98568 drivers/mux/gpio.c     Janusz Krzysztofik 2018-09-01 @25  	DECLARE_BITMAP(value_bitmap, mux_gpio->gpios->ndescs);
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  26  	
00db98568 drivers/mux/gpio.c     Janusz Krzysztofik 2018-09-01  27  	*value_bitmap = state;
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  28  
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  29  	gpiod_set_array_value_cansleep(mux_gpio->gpios->ndescs,
00db98568 drivers/mux/gpio.c     Janusz Krzysztofik 2018-09-01  30  				       mux_gpio->gpios->desc, value_bitmap);
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  31  
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  32  	return 0;
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  33  }
2c089f08e drivers/mux/mux-gpio.c Peter Rosin        2017-05-14  34  

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
