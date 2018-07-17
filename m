Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D636ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:20:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F4B2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48F4B2075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730116AbeGQSyR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:54:17 -0400
Received: from mga06.intel.com ([134.134.136.31]:31228 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbeGQSyQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:54:16 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 11:20:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="246488314"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga006.fm.intel.com with ESMTP; 17 Jul 2018 11:20:23 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1ffUaE-000CiO-Lr; Wed, 18 Jul 2018 02:20:22 +0800
Date:   Wed, 18 Jul 2018 02:19:29 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Mars Cheng <mars.cheng@mediatek.com>
Cc:     kbuild-all@01.org, Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
        devicetree@vger.kernel.org, wsd_upstream@mediatek.com,
        linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, Owen Chen <owen.chen@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>
Subject: Re: [PATCH v5 06/11] soc: mediatek: add new flow for mtcmos power.
Message-ID: <201807180244.Xwu9lTTR%fengguang.wu@intel.com>
References: <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531817552-17221-7-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Owen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.18-rc5 next-20180717]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Mars-Cheng/Add-basic-SoC-support-for-mt6765/20180717-205540
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/soc/mediatek/mtk-scpsys-ext.c:83:5: sparse: symbol 'bus_ctrl_set_release' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:114:5: sparse: symbol 'bus_ctrl_set' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:119:5: sparse: symbol 'bus_ctrl_release' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:124:5: sparse: symbol 'bus_clk_enable_disable' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:161:5: sparse: symbol 'bus_clk_enable' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:192:27: sparse: symbol 'bus_mask_set_clr_ctrl' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:197:26: sparse: symbol 'ext_bus_ctrl' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:202:26: sparse: symbol 'ext_cg_ctrl' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:210:15: sparse: symbol 'syscon_regmap_lookup_by_phandle_idx' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:231:5: sparse: symbol 'scpsys_ext_regmap_init' was not declared. Should it be static?
   include/linux/slab.h:631:13: sparse: undefined identifier '__builtin_mul_overflow'
>> drivers/soc/mediatek/mtk-scpsys-ext.c:324:5: sparse: symbol 'scpsys_ext_clk_init' was not declared. Should it be static?
>> drivers/soc/mediatek/mtk-scpsys-ext.c:336:5: sparse: symbol 'scpsys_ext_attr_init' was not declared. Should it be static?
   include/linux/slab.h:631:13: sparse: call with no type!

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
