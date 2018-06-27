Return-Path: <SRS0=G4S6=JN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E745C43142
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:17:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB6CE26B0C
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Jun 2018 00:17:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6CE26B0C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755119AbeF0ARF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 20:17:05 -0400
Received: from mga18.intel.com ([134.134.136.126]:23871 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751706AbeF0ARE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 20:17:04 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jun 2018 17:17:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,276,1526367600"; 
   d="gz'50?scan'50,208,50";a="240578398"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jun 2018 17:16:41 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fXy8W-000WJm-Ck; Wed, 27 Jun 2018 08:16:40 +0800
Date:   Wed, 27 Jun 2018 08:16:16 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Robert Jarzmik <robert.jarzmik@free.fr>
Cc:     kbuild-all@01.org, Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 1/2] clk: pxa: export 32kHz PLL
Message-ID: <201806270855.xvEN3vnK%fengguang.wu@intel.com>
References: <20180626200308.16192-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180626200308.16192-1-robert.jarzmik@free.fr>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Robert,

I love your patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on v4.18-rc2 next-20180626]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Robert-Jarzmik/clk-pxa-export-32kHz-PLL/20180627-040726
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-xcep_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=arm 

All errors (new ones prefixed by >>):

   drivers/clk/pxa/clk-pxa25x.c: In function 'pxa25x_register_plls':
>> drivers/clk/pxa/clk-pxa25x.c:298:17: error: expected ')' before ';' token
              32768);
                    ^
>> drivers/clk/pxa/clk-pxa25x.c:304:1: error: expected ';' before '}' token
    }
    ^

vim +298 drivers/clk/pxa/clk-pxa25x.c

   290	
   291	static void __init pxa25x_register_plls(void)
   292	{
   293		clk_register_fixed_rate(NULL, "osc_3_6864mhz", NULL,
   294					CLK_GET_RATE_NOCACHE, 3686400);
   295		clkdev_pxa_register(CLK_OSC32k768, "osc_32_768khz", NULL,
   296				    clk_register_fixed_rate(NULL, "osc_32_768khz", NULL,
   297							    CLK_GET_RATE_NOCACHE,
 > 298							    32768);
   299		clk_register_fixed_rate(NULL, "clk_dummy", NULL, 0, 0);
   300		clk_register_fixed_factor(NULL, "ppll_95_85mhz", "osc_3_6864mhz",
   301					  0, 26, 1);
   302		clk_register_fixed_factor(NULL, "ppll_147_46mhz", "osc_3_6864mhz",
   303					  0, 40, 1);
 > 304	}
   305	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--2oS5YaxWCcQjTEyO
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--2oS5YaxWCcQjTEyO--
