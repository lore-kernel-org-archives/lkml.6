Return-Path: <SRS0=4IUq=NH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD90BC46475
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:23:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 76BEE20824
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Oct 2018 06:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76BEE20824
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbeJ0PDF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Oct 2018 11:03:05 -0400
Received: from mail3-relais-sop.national.inria.fr ([192.134.164.104]:40762
        "EHLO mail3-relais-sop.national.inria.fr" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728185AbeJ0PDE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Oct 2018 11:03:04 -0400
X-IronPort-AV: E=Sophos;i="5.54,430,1534802400"; 
   d="scan'208";a="283492154"
Received: from palace.rsr.lip6.fr (HELO palace.lip6.fr) ([132.227.105.202])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/AES128-SHA256; 27 Oct 2018 08:22:58 +0200
From:   Julia Lawall <Julia.Lawall@lip6.fr>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     kernel-janitors@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] clk: pxa: constify clk_ops structures
Date:   Sat, 27 Oct 2018 07:47:39 +0200
Message-Id: <1540619262-22681-6-git-send-email-Julia.Lawall@lip6.fr>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1540619262-22681-1-git-send-email-Julia.Lawall@lip6.fr>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These clk_ops structures are only passed to a call to
clk_register_composite where the corresponding parameters
are const, so the clk_ops structure can be const as well.

Identified and transformed using Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/clk/pxa/clk-pxa.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/pxa/clk-pxa.c b/drivers/clk/pxa/clk-pxa.c
index b80dc9d5855c..42627bf8a09e 100644
--- a/drivers/clk/pxa/clk-pxa.c
+++ b/drivers/clk/pxa/clk-pxa.c
@@ -70,7 +70,7 @@ static unsigned long cken_recalc_rate(struct clk_hw *hw,
 	return clk_fixed_factor_ops.recalc_rate(&fix->hw, parent_rate);
 }
 
-static struct clk_ops cken_rate_ops = {
+static const struct clk_ops cken_rate_ops = {
 	.recalc_rate = cken_recalc_rate,
 };
 
@@ -83,7 +83,7 @@ static u8 cken_get_parent(struct clk_hw *hw)
 	return pclk->is_in_low_power() ? 0 : 1;
 }
 
-static struct clk_ops cken_mux_ops = {
+static const struct clk_ops cken_mux_ops = {
 	.get_parent = cken_get_parent,
 	.set_parent = dummy_clk_set_parent,
 };

