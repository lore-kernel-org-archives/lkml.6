Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B37C04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2FBE2145D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:14:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="0bKwKJUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2FBE2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728975AbeJPMCZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:50246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728877AbeJPMCU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B6E52147E;
        Tue, 16 Oct 2018 04:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663237;
        bh=icBnnG8mNzghWrTrXuCBXd4S8RTha6Mg06jqC6h7gyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0bKwKJUwPuwmpeVSHpr3O4hkoaDewJttJeRfipmmMsgGsVwsxu30F7wbd0o1PO+ZC
         87iQ4HR+UTzxxlxjaPK7or4OpKjJKElacqjdy5R1PBZDqg0rPtv+eW94h9z5S2ebIy
         +lHrqwWYy4R706bA5hzfrLwuqwP9UiDizIV0Laoc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Anders Roxell <anders.roxell@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 100/100] clk: mvebu: armada-37xx-periph: Remove unused var num_parents
Date:   Tue, 16 Oct 2018 00:12:21 -0400
Message-Id: <20181016041221.135528-100-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>

[ Upstream commit 8927c27b32703e28041ae19bf25ea53461be83a1 ]

When building armada-37xx-periph, num_parents isn't used in function
clk_pm_cpu_get_parent:
drivers/clk/mvebu/armada-37xx-periph.c: In function ‘clk_pm_cpu_get_parent’:
drivers/clk/mvebu/armada-37xx-periph.c:419:6: warning: unused variable ‘num_parents’ [-Wunused-variable]
  int num_parents = clk_hw_get_num_parents(hw);
      ^~~~~~~~~~~
Remove the declaration of num_parents to dispose the warning.

Fixes: 616bf80d381d ("clk: mvebu: armada-37xx-periph: Fix wrong return value in get_parent")
Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index 6f7637b19738..e764dfdea53f 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -419,7 +419,6 @@ static unsigned int armada_3700_pm_dvfs_get_cpu_parent(struct regmap *base)
 static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
 {
 	struct clk_pm_cpu *pm_cpu = to_clk_pm_cpu(hw);
-	int num_parents = clk_hw_get_num_parents(hw);
 	u32 val;
 
 	if (armada_3700_pm_dvfs_is_enabled(pm_cpu->nb_pm_base)) {
-- 
2.17.1

