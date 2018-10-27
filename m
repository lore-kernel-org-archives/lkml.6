Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09BD9ECDE47
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CFB6B20824
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:23:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFB6B20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbeJ0PDC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:03:02 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:40762
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726610AbeJ0PDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:02 -0400
X-IronPort-AV: E=Sophos;i="5.54,430,1534802400"; 
   d="scan'208";a="283492153"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 27 Oct 2018 08:22:58 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] clk: pistachio: constify clk_ops structures
Date:   Sat, 27 Oct 2018 07:47:38 +0200
Message-Id: <1540619262-22681-5-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clk_ops structures are only stored in the ops field of a
clk_init_data structure.  This field is const, so the clk_ops
structures can be const as well.

Identified and transformed using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/clk/pistachio/clk-pll.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/pistachio/clk-pll.c b/drivers/clk/pistachio/clk-pll.c
index 7e8daab9025b..312c3580187f 100644
--- a/drivers/clk/pistachio/clk-pll.c
+++ b/drivers/clk/pistachio/clk-pll.c
@@ -298,7 +298,7 @@ static unsigned long pll_gf40lp_frac_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static struct clk_ops pll_gf40lp_frac_ops = {
+static const struct clk_ops pll_gf40lp_frac_ops = {
 	.enable = pll_gf40lp_frac_enable,
 	.disable = pll_gf40lp_frac_disable,
 	.is_enabled = pll_gf40lp_frac_is_enabled,
@@ -307,7 +307,7 @@ static struct clk_ops pll_gf40lp_frac_ops = {
 	.set_rate = pll_gf40lp_frac_set_rate,
 };
 
-static struct clk_ops pll_gf40lp_frac_fixed_ops = {
+static const struct clk_ops pll_gf40lp_frac_fixed_ops = {
 	.enable = pll_gf40lp_frac_enable,
 	.disable = pll_gf40lp_frac_disable,
 	.is_enabled = pll_gf40lp_frac_is_enabled,
@@ -430,7 +430,7 @@ static unsigned long pll_gf40lp_laint_recalc_rate(struct clk_hw *hw,
 	return rate;
 }
 
-static struct clk_ops pll_gf40lp_laint_ops = {
+static const struct clk_ops pll_gf40lp_laint_ops = {
 	.enable = pll_gf40lp_laint_enable,
 	.disable = pll_gf40lp_laint_disable,
 	.is_enabled = pll_gf40lp_laint_is_enabled,
@@ -439,7 +439,7 @@ static struct clk_ops pll_gf40lp_laint_ops = {
 	.set_rate = pll_gf40lp_laint_set_rate,
 };
 
-static struct clk_ops pll_gf40lp_laint_fixed_ops = {
+static const struct clk_ops pll_gf40lp_laint_fixed_ops = {
 	.enable = pll_gf40lp_laint_enable,
 	.disable = pll_gf40lp_laint_disable,
 	.is_enabled = pll_gf40lp_laint_is_enabled,

