Return-Path: <SRS0=G629=LR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A659C43334
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29C4620658
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Sep 2018 17:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29C4620658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731939AbeICWAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Sep 2018 18:00:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49230 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728885AbeICWAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Sep 2018 18:00:37 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C5C12BAE;
        Mon,  3 Sep 2018 17:39:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alberto Panizzo <alberto@amarulasolutions.com>,
        Anthony Brandon <anthony@amarulasolutions.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.18 115/123] clk: rockchip: fix clk_i2sout parent selection bits on rk3399
Date:   Mon,  3 Sep 2018 18:57:39 +0200
Message-Id: <20180903165724.365725254@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180903165719.499675257@linuxfoundation.org>
References: <20180903165719.499675257@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alberto Panizzo <alberto@amarulasolutions.com>

commit a64ad008980c65d38e6cf6858429c78e6b740c41 upstream.

Register, shift and mask were wrong according to datasheet.

Fixes: 115510053e5e ("clk: rockchip: add clock controller for the RK3399")
Cc: stable@vger.kernel.org
Signed-off-by: Alberto Panizzo <alberto@amarulasolutions.com>
Signed-off-by: Anthony Brandon <anthony@amarulasolutions.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/clk/rockchip/clk-rk3399.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/clk/rockchip/clk-rk3399.c
+++ b/drivers/clk/rockchip/clk-rk3399.c
@@ -631,7 +631,7 @@ static struct rockchip_clk_branch rk3399
 	MUX(0, "clk_i2sout_src", mux_i2sch_p, CLK_SET_RATE_PARENT,
 			RK3399_CLKSEL_CON(31), 0, 2, MFLAGS),
 	COMPOSITE_NODIV(SCLK_I2S_8CH_OUT, "clk_i2sout", mux_i2sout_p, CLK_SET_RATE_PARENT,
-			RK3399_CLKSEL_CON(30), 8, 2, MFLAGS,
+			RK3399_CLKSEL_CON(31), 2, 1, MFLAGS,
 			RK3399_CLKGATE_CON(8), 12, GFLAGS),
 
 	/* uart */


