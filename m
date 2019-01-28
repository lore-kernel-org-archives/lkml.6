Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46641C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:43:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B9AB21741
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690238;
	bh=U4M9yDYUOa8lJ/7byTyDWpZKqlvH2iZlcbAZ3c9Ic88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H0Q65+L1zlTLDvcLYG9G+E9l1dJoI0xoG8znMFcNZJOOEtjstEHgil4aapFwaje8f
	 WnCm1xH9/KBT+xHRcymd99zVlnWOuV/vD71XEN1FUTmzhH2mShAhCAxgzwDr6gehiY
	 0AubGCoIjr/OOzJCSkVWIaL0EjxuR/4H4BU28qJE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbfA1Pn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:43:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727077AbfA1Pnx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:43:53 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AA5EA2147A;
        Mon, 28 Jan 2019 15:43:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690232;
        bh=U4M9yDYUOa8lJ/7byTyDWpZKqlvH2iZlcbAZ3c9Ic88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HlyGjbczmJY9hcNoz/jvYUQvCcSy1i3VuFYSg6tpbO5IigSJWgns0HMNuadjIfYvS
         4dhPMHZOOPXYgCJOiWSnSPin3JxHG7bI4soA7g89IDGWQ5i/nC7C7SamGnOJiWUcOG
         r20B/VgFqTSCNE6HILuIgWl3Q8AFXKlHCi5rMFkA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.20 009/304] drm/sun4i: Initialize registers in tcon-top driver
Date:   Mon, 28 Jan 2019 10:38:46 -0500
Message-Id: <20190128154341.47195-9-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jernej Skrabec <jernej.skrabec@siol.net>

[ Upstream commit c96d62215fb540e2ae61de44cb7caf4db50958e3 ]

It turns out that TCON TOP registers in H6 SoC have non-zero reset
value. This may cause issues if bits are not changed during
configuration.

To prevent that, initialize registers to 0.

Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20181104182705.18047-24-jernej.skrabec@siol.net
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/sun4i/sun8i_tcon_top.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
index 3040a79f298f..37158548b447 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -167,6 +167,13 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
 		goto err_assert_reset;
 	}
 
+	/*
+	 * At least on H6, some registers have some bits set by default
+	 * which may cause issues. Clear them here.
+	 */
+	writel(0, regs + TCON_TOP_PORT_SEL_REG);
+	writel(0, regs + TCON_TOP_GATE_SRC_REG);
+
 	/*
 	 * TCON TOP has two muxes, which select parent clock for each TCON TV
 	 * channel clock. Parent could be either TCON TV or TVE clock. For now
-- 
2.19.1

