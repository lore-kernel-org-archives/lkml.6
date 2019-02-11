Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25966C282CE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:42:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9E3D222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899769;
	bh=ozqv1oCIuI/YFFRE1pOkxy6CKQ4xhI95uDEo3wc5Gp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QzfbMqkEvbL8O7APi022udRoV91d+lCE35Rd44xFpbOdilx0zOkZL86t+MApNuIzt
	 iuJAyIpSSO8Xfr0jsmIZuC+w9nM/0BN3vqzBbmO1qNjg/2NjJae/NWp+aZDAXZsRrW
	 Kh/VWg/2gJNa5gmhk5/wcuEzn71dk/hJrMNQ6qZs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733182AbfBKOqM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:46:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:59300 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732501AbfBKOqK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:46:10 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A45820700;
        Mon, 11 Feb 2019 14:46:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896369;
        bh=ozqv1oCIuI/YFFRE1pOkxy6CKQ4xhI95uDEo3wc5Gp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rBTUEE1Pk/b0/MEBThU2AUHYV2QWDjO/nwvh2Fb4WxBtZYmLDYyqbatx/sJc/+K/P
         3/BaLzSuYf6XyUOCkjNiwD3T/k5iyB31PZy/XXgkoMKqlHtKKlX+HjxctKWpqzL/+e
         wOrsT+3bLO7ZccLYRSzahk1IxZ147G/d6nIT5xBQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Fabrizio Castro <fabrizio.castro@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Simon Horman <horms+renesas@verge.net.au>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 162/313] i2c: sh_mobile: Add support for r8a774c0 (RZ/G2E)
Date:   Mon, 11 Feb 2019 15:17:22 +0100
Message-Id: <20190211141904.290561956@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 51243b73455f2d12cb82abffa7bc9028aec656e0 ]

Similarly to R-Car E3, RZ/G2E doesn't come with automatic
transmission registers, as such it is not considered compatible
with the existing fallback bindings.

Add SoC specific binding compatibility to allow for later
support for automatic transmission.

Signed-off-by: Fabrizio Castro <fabrizio.castro@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-sh_mobile.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/i2c/busses/i2c-sh_mobile.c b/drivers/i2c/busses/i2c-sh_mobile.c
index b3ed14f4eae9..ddcfb6d349d1 100644
--- a/drivers/i2c/busses/i2c-sh_mobile.c
+++ b/drivers/i2c/busses/i2c-sh_mobile.c
@@ -800,6 +800,7 @@ static const struct sh_mobile_dt_config r8a7740_dt_config = {
 static const struct of_device_id sh_mobile_i2c_dt_ids[] = {
 	{ .compatible = "renesas,iic-r8a73a4", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7740", .data = &r8a7740_dt_config },
+	{ .compatible = "renesas,iic-r8a774c0", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7790", .data = &v2_freq_calc_dt_config },
 	{ .compatible = "renesas,iic-r8a7791", .data = &fast_clock_dt_config },
 	{ .compatible = "renesas,iic-r8a7792", .data = &fast_clock_dt_config },
-- 
2.19.1



