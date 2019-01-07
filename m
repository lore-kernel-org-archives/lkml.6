Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B75EEC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F74F21855
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866516;
	bh=x/IPibmxyHdpvNkdK/RlCziDKpap1YPVpPHW3O8sAaY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=O4j6rOqsq7hl1Jcrak7d0AdY3eJBF2ImF1FmCp85JID37YHU9Rs7tj9Acyx/ZeEAO
	 T+wrj47d1xaQtE4ZWEdwseri5YV9PQ1MFAIJVEFg2M4+kr1VxIKthGCd+tRQDyO9Ag
	 q4Rd6hQhxskOUayENojSw6cwEkh8pLktq8mShjEU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731684AbfAGNIf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:08:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730948AbfAGNId (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:08:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9CE42147C;
        Mon,  7 Jan 2019 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866513;
        bh=x/IPibmxyHdpvNkdK/RlCziDKpap1YPVpPHW3O8sAaY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P1wZ9qoNWT3TD6uQcGc1zkHFJNIL02hmN9ma7WsHM+5UROzXSAx9u6p6ByYf3muip
         llFlgrR9kT31s1d77Q+z8TPfsT3zCXYp1l2omomvdMlB6Oftht/fJ8gU5YsNMxbgZt
         Vg3cyrzErTtVLwlJ6ufa5XWhfWIEOhLuK8ITZcCw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johan Jonker <jbx9999@hotmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 4.9 55/71] clk: rockchip: fix typo in rk3188 spdif_frac parent
Date:   Mon,  7 Jan 2019 13:33:24 +0100
Message-Id: <20190107105335.876101338@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -381,7 +381,7 @@ static struct rockchip_clk_branch common
 	COMPOSITE_NOMUX(0, "spdif_pre", "i2s_src", 0,
 			RK2928_CLKSEL_CON(5), 0, 7, DFLAGS,
 			RK2928_CLKGATE_CON(0), 13, GFLAGS),
-	COMPOSITE_FRACMUX(0, "spdif_frac", "spdif_pll", CLK_SET_RATE_PARENT,
+	COMPOSITE_FRACMUX(0, "spdif_frac", "spdif_pre", CLK_SET_RATE_PARENT,
 			RK2928_CLKSEL_CON(9), 0,
 			RK2928_CLKGATE_CON(0), 14, GFLAGS,
 			&common_spdif_fracmux),


