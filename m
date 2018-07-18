Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3405ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:55:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D2C02075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:55:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D2C02075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbeGRPdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:33:32 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:20608 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730684AbeGRPdc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:33:32 -0400
X-IronPort-AV: E=Sophos;i="5.51,370,1526335200"; 
   d="scan'208";a="339416605"
Received: from unknown (HELO [132.227.125.40]) ([132.227.125.40])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 16:54:57 +0200
Date:   Wed, 18 Jul 2018 16:54:57 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     matthias.bgg@kernel.org
cc:     ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org, sean.wang@mediatek.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org,
        linux@armlinux.org.uk, dri-devel@lists.freedesktop.org,
        linux-clk@vger.kernel.org, Matthias Brugger <mbrugger@suse.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, matthias.bgg@gmail.com,
        mchehab@kernel.org, pi-cheng.chen@linaro.org, davem@davemloft.net,
        linux-kernel@vger.kernel.org, kbuild-all@01.org
Subject: Re: [resend PATCH v4 2/5] clk: mediatek: mt2701-mmsys: switch to
 platform device probing (fwd)
Message-ID: <alpine.DEB.2.20.1807181654200.3113@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please check on whether the kfree is still needed.

julia

---------- Forwarded message ----------
Date: Wed, 18 Jul 2018 22:03:48 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [resend PATCH v4 2/5] clk: mediatek: mt2701-mmsys: switch to
    platform device probing

In-Reply-To: <20180717220328.792-3-matthias.bgg@kernel.org>
References: <20180717220328.792-3-matthias.bgg@kernel.org>
TO: matthias.bgg@kernel.org

Hi Matthias,

I love your patch! Perhaps something to improve:

[auto build test WARNING on sof-driver-fuweitax/master]
[also build test WARNING on v4.18-rc5 next-20180718]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/matthias-bgg-kernel-org/arm-arm64-mediatek-Fix-mmsys-device-probing/20180718-191916
base:   https://github.com/fuweitax/linux master
:::::: branch date: 3 hours ago
:::::: commit date: 3 hours ago

>> drivers/clk/mediatek/clk-mt2701-mm.c:128:1-6: WARNING: invalid free of devm_ allocated data

# https://github.com/0day-ci/linux/commit/555e11caac5f7729e8927939046adbfa2264f9f5
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 555e11caac5f7729e8927939046adbfa2264f9f5
vim +128 drivers/clk/mediatek/clk-mt2701-mm.c

e98621182 Shunli Wang      2016-11-04  122
555e11caa Matthias Brugger 2018-07-18  123  static int clk_mt2701_mm_remove(struct platform_device *pdev)
555e11caa Matthias Brugger 2018-07-18  124  {
555e11caa Matthias Brugger 2018-07-18  125  	struct clk_mt2701_mm_priv *private = platform_get_drvdata(pdev);
555e11caa Matthias Brugger 2018-07-18  126
555e11caa Matthias Brugger 2018-07-18  127  	kfree(private->clk_data);
555e11caa Matthias Brugger 2018-07-18 @128  	kfree(private);
555e11caa Matthias Brugger 2018-07-18  129
555e11caa Matthias Brugger 2018-07-18  130  	return 0;
555e11caa Matthias Brugger 2018-07-18  131  }
555e11caa Matthias Brugger 2018-07-18  132

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
