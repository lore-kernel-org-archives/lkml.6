Return-Path: <SRS0=t4yP=K2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F4CC4646D
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17587219F2
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Aug 2018 21:30:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17587219F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727653AbeHLAGR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Aug 2018 20:06:17 -0400
Received: from mga14.intel.com ([192.55.52.115]:21443 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeHLAGR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Aug 2018 20:06:17 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Aug 2018 14:30:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,226,1531810800"; 
   d="scan'208";a="64202346"
Received: from bee.sh.intel.com (HELO lkp-server01) ([10.239.97.14])
  by orsmga007.jf.intel.com with ESMTP; 11 Aug 2018 14:30:41 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1fobSe-000BCG-4s; Sun, 12 Aug 2018 05:30:12 +0800
Date:   Sun, 12 Aug 2018 05:30:06 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     kbuild-all@01.org, ctatlor97@gmail.com,
        linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
Subject: [RFC PATCH] clk: qcom: gcc_sdm660_hws[] can be static
Message-ID: <20180811213006.GA10693@ivb42>
References: <20180810202123.29238-1-ctatlor97@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180810202123.29238-1-ctatlor97@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: 851e534f5d75 ("clk: qcom: Add Global Clock controller (GCC) driver for SDM660")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 gcc-sdm660.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/gcc-sdm660.c b/drivers/clk/qcom/gcc-sdm660.c
index bdb445a..cec8b41 100644
--- a/drivers/clk/qcom/gcc-sdm660.c
+++ b/drivers/clk/qcom/gcc-sdm660.c
@@ -2252,7 +2252,7 @@ static struct gdsc pcie_0_gdsc = {
 	.flags = VOTABLE,
 };
 
-struct clk_hw *gcc_sdm660_hws[] = {
+static struct clk_hw *gcc_sdm660_hws[] = {
 	[GCC_XO] = &xo.hw,
 	[GCC_GPLL0_EARLY_DIV] = &gpll0_early_div.hw,
 	[GCC_GPLL1_EARLY_DIV] = &gpll1_early_div.hw,
