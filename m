Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D5CC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:08:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67ACD20844
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 17:08:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ACD20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbeGXSP3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 14:15:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:39968 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbeGXSP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 14:15:29 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jul 2018 10:08:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,398,1526367600"; 
   d="gz'50?scan'50,208,50";a="59447078"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by orsmga008.jf.intel.com with ESMTP; 24 Jul 2018 10:07:57 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fi0my-000Cme-H5; Wed, 25 Jul 2018 01:07:56 +0800
Date:   Wed, 25 Jul 2018 01:07:50 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     kbuild-all@01.org, ysato@users.sourceforge.jp, dalias@libc.org,
        corbet@lwn.net, baolin.wang@linaro.org, arnd@arndb.de,
        broonie@kernel.org, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 4/4] sh: remove board_time_init() callback
Message-ID: <201807250052.6f8He2LR%fengguang.wu@intel.com>
References: <0ad306a7d410d3695c7869bf081efaa71e956ae4.1531826106.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <0ad306a7d410d3695c7869bf081efaa71e956ae4.1531826106.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Arnd,

I love your patch! Yet something to improve:

[auto build test ERROR on sof-driver-fuweitax/master]
[also build test ERROR on v4.18-rc6 next-20180724]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/sh-dreamcast-rtc-push-down-rtc-class-ops-into-driver/20180719-041209
base:   https://github.com/fuweitax/linux master
config: sh-rsk7264_defconfig (attached as .config)
compiler: sh4-linux-gnu-gcc (Debian 7.2.0-11) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        GCC_VERSION=7.2.0 make.cross ARCH=sh 

All errors (new ones prefixed by >>):

   arch/sh/kernel/time.c: In function 'time_init':
>> arch/sh/kernel/time.c:42:2: error: implicit declaration of function 'timer_init'; did you mean 'time_init'? [-Werror=implicit-function-declaration]
     timer_init();
     ^~~~~~~~~~
     time_init
   cc1: all warnings being treated as errors

vim +42 arch/sh/kernel/time.c

    39	
    40	void __init time_init(void)
    41	{
  > 42		timer_init();

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--lrZ03NoBR/3+SXJZ--
