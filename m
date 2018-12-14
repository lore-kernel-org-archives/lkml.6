Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A6EC6786C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC699208E7
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 12:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544790715;
	bh=qNj2XF3LeS1BLT8mOtnwquvHuycJbAkrIJQU4XzcYeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kAb9wdRTec+Q5DqYKmS/uOcU86o06GaAhOhzo2hp2Sm2O6eI0stcFSIfVp+TE51/+
	 jFVmj7BTedfd4fhCgzZHsVsboH2KJrnLsvg8/RxrYZFVS2eXy1edXspEbfOKrckh0S
	 d0tkHh6E16H+zIRLPHTMr7h0W7wHnYQ/eOEituPg=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC699208E7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730843AbeLNMJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 07:09:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731429AbeLNMJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 07:09:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E7D97214AE;
        Fri, 14 Dec 2018 12:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544789359;
        bh=qNj2XF3LeS1BLT8mOtnwquvHuycJbAkrIJQU4XzcYeY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o6qNfBlJcdnMSbjf5+KGz2J+uTRfIks0PCc1Ac3t4E/1GFfH5Y2l74WMdRdShZ/he
         K8GV7J4bKlXpRJqdcI55ISjUS6N8//7UtUWZXMc9f9VbDjjKstESZf3S2iig7Qfxta
         yjHqBAXX7Jef8og48dgXmRfk6Jl9kj/QVbKBa2cM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sean Paul <seanpaul@chromium.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 52/89] drm/meson: add support for 1080p25 mode
Date:   Fri, 14 Dec 2018 13:00:05 +0100
Message-Id: <20181214115732.247716539@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181214115729.658859279@linuxfoundation.org>
References: <20181214115729.658859279@linuxfoundation.org>
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

[ Upstream commit 31e1ab494559fb46de304cc6c2aed1528f94b298 ]

This essential mode for PAL users is missing, so add it.

Fixes: 335e3713afb87 ("drm/meson: Add support for HDMI venc modes and settings")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://patchwork.freedesktop.org/patch/msgid/1542793169-13008-1-git-send-email-christianshewitt@gmail.com
Signed-off-by: Sean Paul <seanpaul@chromium.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/meson/meson_venc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/meson/meson_venc.c b/drivers/gpu/drm/meson/meson_venc.c
index 9509017dbded..d5dfe7045cc6 100644
--- a/drivers/gpu/drm/meson/meson_venc.c
+++ b/drivers/gpu/drm/meson/meson_venc.c
@@ -714,6 +714,7 @@ struct meson_hdmi_venc_vic_mode {
 	{ 5, &meson_hdmi_encp_mode_1080i60 },
 	{ 20, &meson_hdmi_encp_mode_1080i50 },
 	{ 32, &meson_hdmi_encp_mode_1080p24 },
+	{ 33, &meson_hdmi_encp_mode_1080p50 },
 	{ 34, &meson_hdmi_encp_mode_1080p30 },
 	{ 31, &meson_hdmi_encp_mode_1080p50 },
 	{ 16, &meson_hdmi_encp_mode_1080p60 },
-- 
2.19.1



