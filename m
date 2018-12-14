Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07B91C6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2941204FD
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544791239;
	bh=wMQ8xL0tHEeCC7LoyIRMHeDYSHlOBodryRp3UuUE5z8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XRiYJI+8vKAU0U1aWJCKOnXoXmatYBmXaoGZln1Kccmff2cdKOpKpfnapms3L31Tg
	 plODvkyTl2rpU6adIbNAhW2PjVfoYUxXG3dWVK+qODc3LDl+IkYsDQvE9KhH7y70Nx
	 rIeNxopAIul2EJskBQWXpAoRvaKFGjZteQr2dLcU=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2941204FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730426AbeLNMEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:04:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730412AbeLNMEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:04:00 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E0242146F;
        Fri, 14 Dec 2018 12:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789039;
        bh=wMQ8xL0tHEeCC7LoyIRMHeDYSHlOBodryRp3UuUE5z8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iFBZPfSuRCW+llNAlZ48XlIvvlgKEk/xZm5CYnIpHvGQbIKXIxtoWf3lrnF0cjxMg
         SrHLO0IT0GP1t+voiP9/K522k5NOqUmBfxN7zTw+OQF5e8xWnxhvv4yXiropSDRIm/
         tHBqHC4ZeiHIQHi9wCykQbS2X1KRHz2oKEmGkRjU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>,
        Mark Brown <broonie@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 048/142] ASoC: rockchip: add missing slave_config setting for I2S
Date:   Fri, 14 Dec 2018 12:58:53 +0100
Message-Id: <20181214115748.982491698@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115747.053633987@linuxfoundation.org>
References: <20181214115747.053633987@linuxfoundation.org>
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

[ Upstream commit 16a8ee4c80b45984b6de1f90a49edcf336b7c621 ]

This patch adds missing prepare_sleve_config that is needed for
setup the DMA slave channel for I2S.

Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/soc/rockchip/rockchip_pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/rockchip/rockchip_pcm.c b/sound/soc/rockchip/rockchip_pcm.c
index f77538319221..7029e0b85f9e 100644
--- a/sound/soc/rockchip/rockchip_pcm.c
+++ b/sound/soc/rockchip/rockchip_pcm.c
@@ -32,6 +32,7 @@ static const struct snd_pcm_hardware snd_rockchip_hardware = {
 
 static const struct snd_dmaengine_pcm_config rk_dmaengine_pcm_config = {
 	.pcm_hardware = &snd_rockchip_hardware,
+	.prepare_slave_config = snd_dmaengine_pcm_prepare_slave_config,
 	.prealloc_buffer_size = 32 * 1024,
 };
 
-- 
2.19.1



