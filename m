Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43F1C43144
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77E0D25AA9
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77E0D25AA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755568AbeFYNka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:40:30 -0400
Received: from mga18.intel.com ([134.134.136.126]:58017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933935AbeFYNk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:40:26 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2018 06:40:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,270,1526367600"; 
   d="scan'208";a="67062416"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga001.fm.intel.com with ESMTP; 25 Jun 2018 06:40:24 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fXRjE-000Lgp-3Q; Mon, 25 Jun 2018 21:40:24 +0800
Date:   Mon, 25 Jun 2018 21:39:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     kbuild-all@01.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: dpcm: improve runtime update predictability
Message-ID: <201806251940.hnjUV4rz%fengguang.wu@intel.com>
References: <20180625082923.25636-1-jbrunet@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180625082923.25636-1-jbrunet@baylibre.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

I love your patch! Perhaps something to improve:

[auto build test WARNING on asoc/for-next]
[also build test WARNING on v4.18-rc2 next-20180625]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jerome-Brunet/ASoC-dpcm-improve-runtime-update-predictability/20180625-172002
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   sound/soc/soc-pcm.c:357:32: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:357:32: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:367:32: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:367:32: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:417:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:417:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:418:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:418:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:419:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:419:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:420:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:420:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:435:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:435:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:436:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:436:28: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:445:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:445:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:446:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:446:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:447:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:447:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:448:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:448:24: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1194:39: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1194:39: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1750:41: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1750:41: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1752:41: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1752:41: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1774:36: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1774:36: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1775:36: sparse: expression using sizeof(void)
   sound/soc/soc-pcm.c:1775:36: sparse: expression using sizeof(void)
>> sound/soc/soc-pcm.c:2600:5: sparse: symbol 'soc_dpcm_fe_runtime_update' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
