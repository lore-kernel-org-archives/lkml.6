Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38901ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F19E62075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 14:53:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F19E62075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731164AbeGRPb1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 11:31:27 -0400
Received: from mail2-relais-roc.national.inria.fr ([192.134.164.83]:13776 "EHLO
        mail2-relais-roc.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730288AbeGRPb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 11:31:27 -0400
X-IronPort-AV: E=Sophos;i="5.51,370,1526335200"; 
   d="scan'208";a="339416353"
Received: from unknown (HELO [132.227.125.40]) ([132.227.125.40])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 16:53:08 +0200
Date:   Wed, 18 Jul 2018 16:53:08 +0200 (CEST)
From:   Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To:     matthias.bgg@kernel.org
cc:     ulrich.hecht+renesas@gmail.com, laurent.pinchart@ideasonboard.com,
        ck.hu@mediatek.com, p.zabel@pengutronix.de, airlied@linux.ie,
        robh+dt@kernel.org, mark.rutland@arm.com, mturquette@baylibre.com,
        sboyd@codeaurora.org, lee.jones@linaro.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, mchehab@kernel.org,
        rdunlap@infradead.org, pi-cheng.chen@linaro.org,
        sean.wang@mediatek.com, linux-clk@vger.kernel.org,
        linux@armlinux.org.uk, matthias.bgg@gmail.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <mbrugger@suse.com>, kbuild-all@01.org
Subject: Re: [resend PATCH v4 3/5] clk: mediatek: mt8173: switch mmsys to
 platform device probing (fwd)
Message-ID: <alpine.DEB.2.20.1807181651360.3113@hadrien>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Please check on whether the kfree in the remove function is still needed.
Also the platform_driver structure has two probe fields.

julia

---------- Forwarded message ----------
Date: Wed, 18 Jul 2018 22:31:13 +0800
From: kbuild test robot <lkp@intel.com>
To: kbuild@01.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Subject: Re: [resend PATCH v4 3/5] clk: mediatek: mt8173: switch mmsys to
    platform device probing

In-Reply-To: <20180717220328.792-4-matthias.bgg@kernel.org>
References: <20180717220328.792-4-matthias.bgg@kernel.org>
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

>> drivers/clk/mediatek/clk-mt8173.c:1195:1-6: WARNING: invalid free of devm_ allocated data
--
>> drivers/clk/mediatek/clk-mt8173.c:1200:48-49: probe: first occurrence line 1201, second occurrence line 1202

# https://github.com/0day-ci/linux/commit/112857d0f58413a87875dfc9e1b43fdfde3b55eb
git remote add linux-review https://github.com/0day-ci/linux
git remote update linux-review
git checkout 112857d0f58413a87875dfc9e1b43fdfde3b55eb
vim +1195 drivers/clk/mediatek/clk-mt8173.c

112857d0 Matthias Brugger 2018-07-18  1189
112857d0 Matthias Brugger 2018-07-18  1190  static int mtk_mmsys_remove(struct platform_device *pdev)
112857d0 Matthias Brugger 2018-07-18  1191  {
112857d0 Matthias Brugger 2018-07-18  1192  	struct mtk_mmsys_priv *private = platform_get_drvdata(pdev);
112857d0 Matthias Brugger 2018-07-18  1193
112857d0 Matthias Brugger 2018-07-18  1194  	kfree(private->clk_data);
112857d0 Matthias Brugger 2018-07-18 @1195  	kfree(private);
112857d0 Matthias Brugger 2018-07-18  1196
112857d0 Matthias Brugger 2018-07-18  1197  	return 0;
29859d93 James Liao       2015-05-20  1198  }
112857d0 Matthias Brugger 2018-07-18  1199
112857d0 Matthias Brugger 2018-07-18 @1200  static struct platform_driver clk_mt8173_mm_drv = {
112857d0 Matthias Brugger 2018-07-18 @1201  	.probe = mtk_mmsys_probe,
112857d0 Matthias Brugger 2018-07-18 @1202  	.probe = mtk_mmsys_remove,
112857d0 Matthias Brugger 2018-07-18  1203  	.driver = {
112857d0 Matthias Brugger 2018-07-18  1204  		.name = "clk-mt8173-mm",
112857d0 Matthias Brugger 2018-07-18  1205  	},
112857d0 Matthias Brugger 2018-07-18  1206  };
112857d0 Matthias Brugger 2018-07-18  1207  module_platform_driver(clk_mt8173_mm_drv);
29859d93 James Liao       2015-05-20  1208

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
