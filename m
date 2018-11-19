Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34018C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9D2820870
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WaNMMXXJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E9D2820870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731187AbeKTC5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:57:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:56696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730453AbeKTC5v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:57:51 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 915C52089F;
        Mon, 19 Nov 2018 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645224;
        bh=0brB0VVVF9XGzmbputXdQCKbqRxyz8Q+lQksTMmwuyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WaNMMXXJ7GW1XasRPR67HsXJyYsfaGfRTd4NrfkXJDpv1QPgd+gdTRSKmZm/pF4nX
         hc+lpHPzfb4bGVnzDCGcveFlUrd2JGT1LAxleMjVUL/ADVPtXu7gY3VEwubnsc4d/8
         HcEwf3BPXKeFV5TZecRXIP82I82q1l/C80j2GPhk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ziyuan Xu <xzy.xu@rock-chips.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.19 083/205] clk: rockchip: fix wrong mmc sample phase shift for rk3328
Date:   Mon, 19 Nov 2018 17:26:30 +0100
Message-Id: <20181119162631.149043188@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ziyuan Xu <xzy.xu@rock-chips.com>

commit 82f4b67f018c88a7cc9337f0067ed3d6ec352648 upstream.

mmc sample shift is 0 for RK3328 referring to the TRM.
So fix them.

Fixes: fe3511ad8a1c ("clk: rockchip: add clock controller for rk3328")
Cc: stable@vger.kernel.org
Signed-off-by: Ziyuan Xu <xzy.xu@rock-chips.com>
Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/rockchip/clk-rk3328.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

--- a/drivers/clk/rockchip/clk-rk3328.c
+++ b/drivers/clk/rockchip/clk-rk3328.c
@@ -813,22 +813,22 @@ static struct rockchip_clk_branch rk3328
 	MMC(SCLK_SDMMC_DRV, "sdmmc_drv", "clk_sdmmc",
 	    RK3328_SDMMC_CON0, 1),
 	MMC(SCLK_SDMMC_SAMPLE, "sdmmc_sample", "clk_sdmmc",
-	    RK3328_SDMMC_CON1, 1),
+	    RK3328_SDMMC_CON1, 0),
 
 	MMC(SCLK_SDIO_DRV, "sdio_drv", "clk_sdio",
 	    RK3328_SDIO_CON0, 1),
 	MMC(SCLK_SDIO_SAMPLE, "sdio_sample", "clk_sdio",
-	    RK3328_SDIO_CON1, 1),
+	    RK3328_SDIO_CON1, 0),
 
 	MMC(SCLK_EMMC_DRV, "emmc_drv", "clk_emmc",
 	    RK3328_EMMC_CON0, 1),
 	MMC(SCLK_EMMC_SAMPLE, "emmc_sample", "clk_emmc",
-	    RK3328_EMMC_CON1, 1),
+	    RK3328_EMMC_CON1, 0),
 
 	MMC(SCLK_SDMMC_EXT_DRV, "sdmmc_ext_drv", "clk_sdmmc_ext",
 	    RK3328_SDMMC_EXT_CON0, 1),
 	MMC(SCLK_SDMMC_EXT_SAMPLE, "sdmmc_ext_sample", "clk_sdmmc_ext",
-	    RK3328_SDMMC_EXT_CON1, 1),
+	    RK3328_SDMMC_EXT_CON1, 0),
 };
 
 static const char *const rk3328_critical_clocks[] __initconst = {


