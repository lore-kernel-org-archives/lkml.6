Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA09FC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA87421B1C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549901687;
	bh=AHyChqXgiXUbOOjNNajclOtf7nME23hLO8oVW2NRXXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SqPqhP9W/NZ5AaXVssDJyHAWo1sRHJpr6NFnSIFpthGkYukdhIokgZNvDOlzUK52o
	 jGMyge6dolfo2TNgzhl9k/+7bivOqJiO6GaJ6zHHaYRIG+ldipkVjsQ/0wOkn/rkqr
	 XX2N/b7qifEewkmGNoHFFH2H/nNUPzCP1W8rkwik=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729461AbfBKQOp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:14:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:54108 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727867AbfBKOVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:21:16 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4423120838;
        Mon, 11 Feb 2019 14:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549894875;
        bh=AHyChqXgiXUbOOjNNajclOtf7nME23hLO8oVW2NRXXw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=w274ZrSbXp4yc0gtdKc/dB30tscAhc/axDXwlK2rk4HCR31bBP7iY44gUBvrDZqTe
         M1K1+wdjlKNMT3NrFBhlX1sv4VsU/T6J+T7RrXwU6CHjyDR9GTQaRoZ+jawwwjq/6o
         ziXYX54lCc42jS6+tb4DRGUwpqLpZ1jneEIzPd68=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jernej Skrabec <jernej.skrabec@siol.net>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 009/352] drm/sun4i: Initialize registers in tcon-top driver
Date:   Mon, 11 Feb 2019 15:13:56 +0100
Message-Id: <20190211141847.037880151@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



