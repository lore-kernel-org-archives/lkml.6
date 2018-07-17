Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE553ECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89A252075E
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 18:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89A252075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeGQSyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 14:54:20 -0400
Received: from mga01.intel.com ([192.55.52.88]:41012 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbeGQSyU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 14:54:20 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 11:20:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="246014759"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga005.fm.intel.com with ESMTP; 17 Jul 2018 11:20:26 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1ffUaE-000Cj4-OM; Wed, 18 Jul 2018 02:20:22 +0800
Date:   Wed, 18 Jul 2018 02:19:29 +0800
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
Subject: [RFC PATCH] soc: mediatek: bus_ctrl_set_release() can be static
Message-ID: <20180717181929.GA13851@lkp-hsx02>
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


Fixes: 4666e05d0237 ("soc: mediatek: add new flow for mtcmos power.")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 mtk-scpsys-ext.c |   28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-scpsys-ext.c b/drivers/soc/mediatek/mtk-scpsys-ext.c
index 965e64d..e4ceb38 100644
--- a/drivers/soc/mediatek/mtk-scpsys-ext.c
+++ b/drivers/soc/mediatek/mtk-scpsys-ext.c
@@ -80,7 +80,7 @@ static struct scpsys_ext_attr *__get_attr_parent(const char *parent_n)
 	return ERR_PTR(-EINVAL);
 }
 
-int bus_ctrl_set_release(struct scpsys_ext_attr *attr, bool set)
+static int bus_ctrl_set_release(struct scpsys_ext_attr *attr, bool set)
 {
 	int i;
 	int ret = 0;
@@ -111,17 +111,17 @@ int bus_ctrl_set_release(struct scpsys_ext_attr *attr, bool set)
 	return ret;
 }
 
-int bus_ctrl_set(struct scpsys_ext_attr *attr)
+static int bus_ctrl_set(struct scpsys_ext_attr *attr)
 {
 	return bus_ctrl_set_release(attr, CMD_ENABLE);
 }
 
-int bus_ctrl_release(struct scpsys_ext_attr *attr)
+static int bus_ctrl_release(struct scpsys_ext_attr *attr)
 {
 	return bus_ctrl_set_release(attr, CMD_DISABLE);
 }
 
-int bus_clk_enable_disable(struct scpsys_ext_attr *attr, bool enable)
+static int bus_clk_enable_disable(struct scpsys_ext_attr *attr, bool enable)
 {
 	int i = 0;
 	int ret = 0;
@@ -158,7 +158,7 @@ int bus_clk_enable_disable(struct scpsys_ext_attr *attr, bool enable)
 	return ret;
 }
 
-int bus_clk_enable(struct scpsys_ext_attr *attr)
+static int bus_clk_enable(struct scpsys_ext_attr *attr)
 {
 	struct scpsys_ext_attr *attr_p;
 	int ret = 0;
@@ -189,17 +189,17 @@ int bus_clk_disable(struct scpsys_ext_attr *attr)
 	return ret;
 }
 
-const struct bus_mask_ops bus_mask_set_clr_ctrl = {
+static const struct bus_mask_ops bus_mask_set_clr_ctrl = {
 	.set = &mtk_generic_set_cmd,
 	.release = &mtk_generic_clr_cmd,
 };
 
-const struct bus_ext_ops ext_bus_ctrl = {
+static const struct bus_ext_ops ext_bus_ctrl = {
 	.enable = &bus_ctrl_set,
 	.disable = &bus_ctrl_release,
 };
 
-const struct bus_ext_ops ext_cg_ctrl = {
+static const struct bus_ext_ops ext_cg_ctrl = {
 	.enable = &bus_clk_enable,
 	.disable = &bus_clk_disable,
 };
@@ -207,9 +207,9 @@ const struct bus_ext_ops ext_cg_ctrl = {
 /*
  * scpsys bus driver init
  */
-struct regmap *syscon_regmap_lookup_by_phandle_idx(struct device_node *np,
-						   const char *property,
-						   int index)
+static struct regmap *syscon_regmap_lookup_by_phandle_idx(struct device_node *np,
+							  const char *property,
+							  int index)
 {
 	struct device_node *syscon_np;
 	struct regmap *regmap;
@@ -228,7 +228,7 @@ struct regmap *syscon_regmap_lookup_by_phandle_idx(struct device_node *np,
 	return regmap;
 }
 
-int scpsys_ext_regmap_init(struct platform_device *pdev)
+static int scpsys_ext_regmap_init(struct platform_device *pdev)
 {
 	infracfg = syscon_regmap_lookup_by_phandle(pdev->dev.of_node,
 						   INFRA);
@@ -321,7 +321,7 @@ static int add_cg_to_list(struct platform_device *pdev)
 	return 0;
 }
 
-int scpsys_ext_clk_init(struct platform_device *pdev)
+static int scpsys_ext_clk_init(struct platform_device *pdev)
 {
 	int ret = 0;
 
@@ -333,7 +333,7 @@ int scpsys_ext_clk_init(struct platform_device *pdev)
 	return ret;
 }
 
-int scpsys_ext_attr_init(const struct scpsys_ext_data *data)
+static int scpsys_ext_attr_init(const struct scpsys_ext_data *data)
 {
 	int i, count = 0;
 
