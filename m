Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 315F3C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34422147A
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696576;
	bh=Ru2iY6QwaG4AzxIx3U2e7jA9yB0+C7uyLouWhzd/ilw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iQCjtuA6Ueus/nYJjDj0RyygFiLMlUCmw7reKbQWD5FlyTHeU4lybe+Kw4PqQs4qV
	 Y/9dZF3HRs+BXkbsK53Ax/BGlECeAXCqquEub2HEn9E1MUtAiptHfBKRvsa6jZR+dC
	 cJKZgf2RihiK/ksoi6i5Okt5K0Y6wiXTdFmb/OsQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730996AbfA1R3e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:29:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:45054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730622AbfA1P7r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:59:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68E702082E;
        Mon, 28 Jan 2019 15:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691186;
        bh=Ru2iY6QwaG4AzxIx3U2e7jA9yB0+C7uyLouWhzd/ilw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OQMAknXcfeYIGj0suu0xQPZIPY5ctcNAFMMOSbmlESrRRgHggtwDqQMP40nYce1sa
         7EgOf42XIt7foRpxGNKn86LDMPORQuFQB6526m63o7t7tY6vlm0Z3YJZxn9EvlK9dV
         ZYHgKKNGT1nx/eokvJmLUv7wQY4Dk7Aya8o0GyqY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 4.19 007/258] drm/sun4i: Initialize registers in tcon-top driver
Date:   Mon, 28 Jan 2019 10:55:13 -0500
Message-Id: <20190128155924.51521-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
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
index d5240b777a8f..adcdf946c365 100644
--- a/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
+++ b/drivers/gpu/drm/sun4i/sun8i_tcon_top.c
@@ -168,6 +168,13 @@ static int sun8i_tcon_top_bind(struct device *dev, struct device *master,
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

