Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E85BC46461
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:01:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08CEF20870
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 22:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CEF20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbeG2XdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 19:33:20 -0400
Received: from mga05.intel.com ([192.55.52.43]:22975 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731589AbeG2XdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 19:33:19 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Jul 2018 15:01:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,420,1526367600"; 
   d="scan'208";a="71505140"
Received: from bee.sh.intel.com (HELO bee) ([10.239.97.14])
  by fmsmga002.fm.intel.com with ESMTP; 29 Jul 2018 15:01:16 -0700
Received: from kbuild by bee with local (Exim 4.84_2)
        (envelope-from <lkp@intel.com>)
        id 1fjtkW-000TFR-AJ; Mon, 30 Jul 2018 06:01:12 +0800
Date:   Mon, 30 Jul 2018 06:00:45 +0800
From:   kbuild test robot <fengguang.wu@intel.com>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     kbuild-all@01.org, manivannan.sadhasivam@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, mark.rutland@arm.com,
        afaerber@suse.de, catalin.marinas@arm.com, will.deacon@arm.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        pn@denx.de, mp-cs@actions-semi.com, jeff.chen@actions-semi.com,
        thomas.liau@actions-semi.com, linux@cubietech.com,
        Saravanan Sekar <sravanhome@gmail.com>
Subject: [RFC PATCH] pinctrl: actions: s700_pads[] can be static
Message-ID: <20180729220045.GA5007@lkp-ib03>
References: <20180729200038.11795-5-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729200038.11795-5-sravanhome@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: lkp@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Fixes: e96a1c4b279a ("pinctrl: actions: Add Actions Semi S700 pinctrl driver")
Signed-off-by: kbuild test robot <fengguang.wu@intel.com>
---
 pinctrl-s700.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pinctrl/actions/pinctrl-s700.c b/drivers/pinctrl/actions/pinctrl-s700.c
index 7e9d23a..df69827 100644
--- a/drivers/pinctrl/actions/pinctrl-s700.c
+++ b/drivers/pinctrl/actions/pinctrl-s700.c
@@ -225,7 +225,7 @@
 #define NUM_PADS		(_LASTPAD - _FIRSTPAD + 1)
 
 /* Pad names for the pinmux subsystem */
-const struct pinctrl_pin_desc s700_pads[] = {
+static const struct pinctrl_pin_desc s700_pads[] = {
 	PINCTRL_PIN(ETH_TXD0, "eth_txd0"),
 	PINCTRL_PIN(ETH_TXD1, "eth_txd1"),
 	PINCTRL_PIN(ETH_TXD2, "eth_txd2"),
@@ -1549,7 +1549,7 @@ static const char * const sirq2_groups[] = {
 	"sirq2_dummy",
 };
 
-const struct owl_pinmux_func s700_functions[] = {
+static const struct owl_pinmux_func s700_functions[] = {
 	[S700_MUX_NOR] = FUNCTION(nor),
 	[S700_MUX_ETH_RGMII] = FUNCTION(eth_rmii),
 	[S700_MUX_ETH_SGMII] = FUNCTION(eth_smii),
@@ -1697,7 +1697,7 @@ static PAD_PULLCTL_CONF(I2C2_SCLK, 2, 7, 1);
 /********PAD INFOS*****************************/
 
 /* Pad info table for the pinmux subsystem */
-struct owl_padinfo s700_padinfo[NUM_PADS] = {
+static struct owl_padinfo s700_padinfo[NUM_PADS] = {
 	[ETH_TXD0] = PAD_INFO_ST(ETH_TXD0),
 	[ETH_TXD1] = PAD_INFO_ST(ETH_TXD1),
 	[ETH_TXEN] = PAD_INFO_ST(ETH_TXEN),
