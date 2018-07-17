Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEF1ECDFB3
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BACBC20693
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BACBC20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeGQT1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 15:27:31 -0400
Received: from mga18.intel.com ([134.134.136.126]:64772 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbeGQT1b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 15:27:31 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 11:53:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="246022756"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2018 11:53:28 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1ffV6F-0003TH-Ca; Wed, 18 Jul 2018 02:53:27 +0800
Date:   Wed, 18 Jul 2018 02:52:49 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
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
Subject: [RFC PATCH] clk: mediatek: cksys_base can be static
Message-ID: <20180717185249.GA144124@lkp-hsx02>
References: <1531817552-17221-11-git-send-email-mars.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531817552-17221-11-git-send-email-mars.cheng@mediatek.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 3cff52bad99d ("clk: mediatek: Add MT6765 clock support")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 clk-mt6765.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/mediatek/clk-mt6765.c b/drivers/clk/mediatek/clk-mt6765.c
index 7b360b9..2f90511 100644
--- a/drivers/clk/mediatek/clk-mt6765.c
+++ b/drivers/clk/mediatek/clk-mt6765.c
@@ -33,8 +33,8 @@
 static DEFINE_SPINLOCK(mt6765_clk_lock);
 
 /* Total 12 subsys */
-void __iomem *cksys_base;
-void __iomem *apmixed_base;
+static void __iomem *cksys_base;
+static void __iomem *apmixed_base;
 
 /* CKSYS */
 #define CLK_SCP_CFG_0		(cksys_base + 0x200)
