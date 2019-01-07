Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFF5C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEC962089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866846;
	bh=nv+n/2TelwF20DV0O3+61O/WAq8Zv/LH4IJ5Kp+MRF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Sv+FDh8owYRhiB/dp+iSR8egHPi065VMNoZ5LdB0bVl1foahLkuTVG8uzIKf6rfyG
	 HS0eqX7Y+mUPKBAWsuLxz0lNFUaOZp/6lnmkGey7QfyNdcLevIFoOudUIrAl3M81Uq
	 t3wDLM9nqsUJCfnKMxsQPDY3wMnoNTFjH8xox47U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbfAGNDH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:03:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:50552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730907AbfAGNDE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:03:04 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48A82089F;
        Mon,  7 Jan 2019 13:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866183;
        bh=nv+n/2TelwF20DV0O3+61O/WAq8Zv/LH4IJ5Kp+MRF8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=N8VoELqzauKF9SYiZnaIwba2oAtH4m9QuGJ64wU/1LbSkC5qUtkIpC1f3BHUEX1mR
         x+0zn/7qb6+4BV6stjF7ovkYUC8ACExdd3d7E12B79d3SQBs4Yeh+qcCSJd4Fbak29
         6FqcFC2EYmDlsBlY1A1Ut7wbgMlFBEHxrCskDKOA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Jonker <jbx9999@hotmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.14 072/101] clk: rockchip: fix typo in rk3188 spdif_frac parent
Date:   Mon,  7 Jan 2019 13:33:00 +0100
Message-Id: <20190107105336.927481271@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johan Jonker <jbx9999@hotmail.com>

commit 8b19faf6fae2867e2c177212c541e8ae36aa4d32 upstream.

Fix typo in common_clk_branches.
Make spdif_pre parent of spdif_frac.

Fixes: 667464208989 ("clk: rockchip: include downstream muxes into fractional dividers")
Cc: stable@vger.kernel.org
Signed-off-by: Johan Jonker <jbx9999@hotmail.com>
Acked-by: Elaine Zhang <zhangqing@rock-chips.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/rockchip/clk-rk3188.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/rockchip/clk-rk3188.c
+++ b/drivers/clk/rockchip/clk-rk3188.c
@@ -382,7 +382,7 @@ static struct rockchip_clk_branch common
 	COMPOSITE_NOMUX(0, "spdif_pre", "i2s_src", 0,
 			RK2928_CLKSEL_CON(5), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 13, GFLAGS),
-	COMPOSITE_FRACMUX(0, "spdif_frac", "spdif_pll", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX(0, "spdif_frac", "spdif_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(9), 0,
 			RK2928_CLKGATE_CON(0), 14, GFLAGS,
 			&common_spdif_fracmux),


