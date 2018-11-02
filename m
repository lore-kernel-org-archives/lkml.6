Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14E21C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 937442084A
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="hC2+tfQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 937442084A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729592AbeKCDth (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:49:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728699AbeKCDth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:49:37 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E8C42084A;
        Fri,  2 Nov 2018 18:41:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184085;
        bh=BJS3jJhoUfL1HsO0gIvV2lgLk5K5TSNSSIuJBdC+04o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hC2+tfQ0kJkaNxwtEggrevFGpvVauGtMlN/VN5nUiI0pQ/+CeM1MWmQHdnxCY0MRL
         +LIqfYBwWTfuGQPl74W8DEO6HI45L22T/sLoSLvbHGXIY5MVaE7vVSZcZ62Wh1YNvT
         SZjD0Wc2CnC35mXO/4Zw3kczLrV70xl/16p1RbUQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anders Roxell <anders.roxell@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 074/150] clk: mvebu: armada-37xx-periph: Remove unused var num_parents
Date:   Fri,  2 Nov 2018 19:33:56 +0100
Message-Id: <20181102182908.745071073@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



